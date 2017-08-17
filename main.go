package main

import (
	"log"
	"path"

	"github.com/astaxie/beego/logs"
	"github.com/kapmahc/h2o/nut"
	_ "github.com/kapmahc/h2o/routers"
	_ "github.com/lib/pq"
)

func main() {
	logs.SetLogger(logs.AdapterFile, `{"filename":"`+path.Join("tmp", "h2o.log")+`", "maxdays":180, "perm":"0600"}`)
	if err := nut.Main(); err != nil {
		log.Fatal(err)
	}
}
