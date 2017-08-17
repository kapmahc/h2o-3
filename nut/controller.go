package nut

import "github.com/astaxie/beego"

// Controller base controller
type Controller struct {
	beego.Controller
}

// LayoutApplication set application layout
func (p *Controller) LayoutApplication() {
	// TODO
}
