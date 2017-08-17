package job

import "github.com/astaxie/beego"

// Handler handler
type Handler func(id string, body []byte) error

var handlers = make(map[string]Handler)

// Register register job handler
func Register(n string, h Handler) {
	if _, ok := handlers[n]; ok {
		beego.Warn("ovveride job handler", n)
	}
	handlers[n] = h
}
