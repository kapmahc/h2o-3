package nut

import (
	"crypto/x509/pkix"
	"fmt"
	"html/template"
	"os"
	"path"
	"time"

	"github.com/astaxie/beego"
	"github.com/steinbacher/goose"
	"github.com/urfave/cli"
)

func runServer(c *cli.Context) error {
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

func runTodo(c *cli.Context) error {
	beego.Notice("TODO")
	return nil
}
