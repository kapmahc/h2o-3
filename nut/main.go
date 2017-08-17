package nut

import (
	"os"

	"github.com/urfave/cli"
)

// Main entry
func Main() error {
	host, err := os.Hostname()
	if err != nil {
		return err
	}

	app := cli.NewApp()
	app.Name = "h2o"
	app.Usage = "A complete open source e-commerce solution by Go language."
	app.Version = "0.1.0"
	app.Action = runServer
	app.Commands = []cli.Command{
		{
			Name:    "worker",
			Aliases: []string{"w"},
			Usage:   "start the worker progress",
			Flags: []cli.Flag{
				cli.StringFlag{
					Name:  "name, n",
					Value: host,
					Usage: "worker's name",
				},
			},
			Action: runWorker,
		},
		{
			Name:    "database",
			Aliases: []string{"db"},
			Usage:   "database operations",
			Subcommands: []cli.Command{
				{
					Name:    "migrate",
					Usage:   "migrate the DB to the most recent version available",
					Aliases: []string{"m"},
					Action:  migrateDatabase,
				},
				{
					Name:    "rollback",
					Usage:   "roll back the version by 1",
					Aliases: []string{"r"},
					Action:  rollbackDatabase,
				},
				{
					Name:    "version",
					Usage:   "dump the migration status for the current DB",
					Aliases: []string{"v"},
					Action:  databaseVersion,
				},
			},
		},
		{
			Name:    "generate",
			Aliases: []string{"g"},
			Usage:   "generate file template",
			Subcommands: []cli.Command{
				{
					Name:    "nginx",
					Aliases: []string{"ng"},
					Usage:   "generate nginx.conf",
					Action:  generateNginxConf,
				},
				{
					Name:    "openssl",
					Aliases: []string{"ssl"},
					Usage:   "generate ssl certificates",
					Flags: []cli.Flag{
						cli.StringFlag{
							Name:  "name, n",
							Usage: "name",
						},
						cli.StringFlag{
							Name:  "country, c",
							Value: "Earth",
							Usage: "country",
						},
						cli.StringFlag{
							Name:  "organization, o",
							Value: "Mother Nature",
							Usage: "organization",
						},
						cli.IntFlag{
							Name:  "years, y",
							Value: 1,
							Usage: "years",
						},
					},
					Action: generateSsl,
				},
				{
					Name:    "migration",
					Usage:   "generate migration file",
					Aliases: []string{"m"},
					Flags: []cli.Flag{
						cli.StringFlag{
							Name:  "name, n",
							Usage: "name",
						},
					},
					Action: generateMigration,
				},
				{
					Name:    "locale",
					Usage:   "generate locale file",
					Aliases: []string{"l"},
					Flags: []cli.Flag{
						cli.StringFlag{
							Name:  "name, n",
							Usage: "locale name",
						},
					},
					Action: generateLocale,
				},
			},
		},
	}

	return app.Run(os.Args)
}
