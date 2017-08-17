package nut

import (
	"crypto/x509/pkix"
	"fmt"
	"html/template"
	"os"
	"path"
	"path/filepath"
	"time"

	"github.com/astaxie/beego"
	"github.com/astaxie/beego/toolbox"
	"github.com/kapmahc/h2o/job"
	"github.com/steinbacher/goose"
	"github.com/urfave/cli"
	"golang.org/x/text/language"
)

func runServer(c *cli.Context) error {

	toolbox.StartTask()
	defer toolbox.StopTask()

	beego.Notice("waiting for messages, to exit press CTRL+C")
	host, err := os.Hostname()
	if err != nil {
		return err
	}

	go func() {
		if err := job.Receive(host); err != nil {
			beego.Error(err)
		}
	}()
	beego.Run()
	return nil
}

func generateNginxConf(*cli.Context) error {
	pwd, err := os.Getwd()
	if err != nil {
		return err
	}

	port, err := beego.AppConfig.Int("httpport")
	if err != nil {
		return err
	}
	ssl, err := beego.AppConfig.Bool("httpsecure")
	if err != nil {
		return err
	}

	name := beego.AppConfig.String("httpdomain")
	fn := path.Join("tmp", "etc", "nginx", "sites-enabled", name+".conf")
	if err = os.MkdirAll(path.Dir(fn), 0700); err != nil {
		return err
	}
	beego.Notice("generate file", fn)
	fd, err := os.OpenFile(fn, os.O_WRONLY|os.O_CREATE|os.O_EXCL, 0600)
	if err != nil {
		return err
	}
	defer fd.Close()

	tpl, err := template.ParseFiles(path.Join("templates", "nginx.conf"))
	if err != nil {
		return err
	}

	return tpl.Execute(fd, struct {
		Port   int
		Root   string
		Name   string
		Secure bool
	}{
		Name:   name,
		Port:   port,
		Root:   pwd,
		Secure: ssl,
	})
}

func generateSsl(c *cli.Context) error {
	name := c.String("name")
	if len(name) == 0 {
		cli.ShowCommandHelp(c, "openssl")
		return nil
	}
	root := path.Join("tmp", "etc", "ssl", name)

	key, crt, err := CreateCertificate(
		true,
		pkix.Name{
			Country:      []string{c.String("country")},
			Organization: []string{c.String("organization")},
		},
		c.Int("years"),
	)
	if err != nil {
		return err
	}

	fnk := path.Join(root, "key.pem")
	fnc := path.Join(root, "crt.pem")

	beego.Notice("generate pem file", fnk)
	err = WritePemFile(fnk, "RSA PRIVATE KEY", key, 0400)
	fmt.Printf("test: openssl rsa -noout -text -in %s\n", fnk)

	if err == nil {
		beego.Notice("generate pem file", fnc)
		err = WritePemFile(fnc, "CERTIFICATE", crt, 0444)
		beego.Notice("test: openssl x509 -noout -text -in", fnc)
	}
	if err == nil {
		beego.Notice(
			"verify: diff <(openssl rsa -noout -modulus -in" +
				fnk +
				") <(openssl x509 -noout -modulus -in " +
				fnc +
				")",
		)
	}
	return err
}

func generateMigration(c *cli.Context) error {
	name := c.String("name")
	if len(name) == 0 {
		cli.ShowCommandHelp(c, "migration")
		return nil
	}
	cfg, err := dbConf()
	if err != nil {
		return err
	}
	if err = os.MkdirAll(cfg.MigrationsDir, 0700); err != nil {
		return err
	}
	file, err := goose.CreateMigration(name, "sql", cfg.MigrationsDir, time.Now())
	if err != nil {
		return err
	}

	beego.Notice("generate file ", file)
	return nil
}

func generateLocale(c *cli.Context) error {
	name := c.String("name")
	if len(name) == 0 {
		cli.ShowCommandHelp(c, "locale")
		return nil
	}
	lng, err := language.Parse(name)
	if err != nil {
		return err
	}
	const root = "locales"
	if err = os.MkdirAll(root, 0700); err != nil {
		return err
	}
	file := path.Join(root, fmt.Sprintf("%s.ini", lng.String()))
	beego.Notice("generate file", file)
	fd, err := os.OpenFile(file, os.O_WRONLY|os.O_CREATE|os.O_EXCL, 0644)
	if err != nil {
		return err
	}
	defer fd.Close()
	return err
}

func migrateDatabase(*cli.Context) error {
	conf, err := dbConf()
	if err != nil {
		return err
	}

	target, err := goose.GetMostRecentDBVersion(conf.MigrationsDir)
	if err != nil {
		return err
	}

	return goose.RunMigrations(conf, conf.MigrationsDir, target)
}

func rollbackDatabase(*cli.Context) error {
	conf, err := dbConf()
	if err != nil {
		return err
	}

	current, err := goose.GetDBVersion(conf)
	if err != nil {
		return err
	}

	previous, err := goose.GetPreviousDBVersion(conf.MigrationsDir, current)
	if err != nil {
		return err
	}

	return goose.RunMigrations(conf, conf.MigrationsDir, previous)
}

func databaseVersion(*cli.Context) error {
	conf, err := dbConf()
	if err != nil {
		return err
	}

	// collect all migrations
	migrations, err := goose.CollectMigrations(conf.MigrationsDir)
	if err != nil {
		return err
	}

	db, err := goose.OpenDBFromDBConf(conf)
	if err != nil {
		return err
	}
	defer db.Close()

	// must ensure that the version table exists if we're running on a pristine DB
	if _, err = goose.EnsureDBVersion(conf, db); err != nil {
		return err
	}

	fmt.Println("    Applied At                  Migration")
	fmt.Println("    =======================================")
	for _, m := range migrations {
		if err = printMigrationStatus(db, m.Version, filepath.Base(m.Source)); err != nil {
			return err
		}
	}
	return nil
}

func runWorker(c *cli.Context) error {
	name := c.String("name")
	if name == "" {
		cli.ShowSubcommandHelp(c)
		return nil
	}

	toolbox.StartTask()
	defer toolbox.StopTask()

	beego.Notice("waiting for messages, to exit press CTRL+C")
	return job.Receive(name)
}

func runTodo(c *cli.Context) error {
	beego.Notice("TODO")
	return nil
}
