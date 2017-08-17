package main

import (
	"log"

	"github.com/kapmahc/h2o/nut"
	_ "github.com/kapmahc/h2o/routers"
)

func main() {
	if err := nut.Main(); err != nil {
		log.Fatal(err)
	}
}
