package routers

import (
	"github.com/astaxie/beego"
	"github.com/kapmahc/h2o/plugins/auth"
	"github.com/kapmahc/h2o/plugins/erp"
	"github.com/kapmahc/h2o/plugins/forum"
	"github.com/kapmahc/h2o/plugins/mall"
	"github.com/kapmahc/h2o/plugins/ops/mail"
	"github.com/kapmahc/h2o/plugins/ops/vpn"
	"github.com/kapmahc/h2o/plugins/pos"
	"github.com/kapmahc/h2o/plugins/reading"
	"github.com/kapmahc/h2o/plugins/site"
	"github.com/kapmahc/h2o/plugins/survey"
)

func init() {
	beego.Include(
		&site.Controller{},
		&auth.Controller{},
	)
	for k, v := range map[string]beego.ControllerInterface{
		"/forum":    &forum.Controller{},
		"/reading":  &reading.Controller{},
		"/survey":   &survey.Controller{},
		"/mall":     &mall.Controller{},
		"/erp":      &erp.Controller{},
		"/pos":      &pos.Controller{},
		"/ops/vpn":  &vpn.Controller{},
		"/ops/mail": &mail.Controller{},
	} {
		beego.AddNamespace(beego.NewNamespace(k, beego.NSInclude(v)))
	}
}
