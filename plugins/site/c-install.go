package site

import (
	"net/http"

	"github.com/astaxie/beego/orm"
	"github.com/astaxie/beego/validation"
	"github.com/kapmahc/h2o/nut"
	"github.com/kapmahc/h2o/plugins/auth"
)

type fmInstall struct {
	Title                string `form:"title" valid:"Required"`
	SubTitle             string `form:"subTitle" valid:"Required"`
	Name                 string `form:"name" valid:"Required;MaxSize(32)"`
	Email                string `form:"email" valid:"Email;MaxSize(255)"`
	Password             string `form:"password" valid:"MinSize(6)"`
	PasswordConfirmation string `form:"passwordConfirmation" `
}

func (p *fmInstall) Valid(v *validation.Validation) {
	if p.Password != p.PasswordConfirmation {
		v.SetError("PasswordConfirmation", "Passwords not match")
		return
	}

}

// PostInstall init database
// @router /install [post]
func (p *Controller) PostInstall() {
	var fm fmInstall
	p.Check(p.Bind(&fm))

	o := orm.NewOrm()
	count, err := o.QueryTable(new(auth.User)).Count()
	p.Check(err)

	if count > 0 {
		p.CustomAbort(http.StatusForbidden, "")
	}

	p.Check(nut.SetMessage(p.Locale, "site.title", fm.Title))
	p.Check(nut.SetMessage(p.Locale, "site.sub-title", fm.SubTitle))

	ip := p.Ctx.Input.IP()
	user, err := auth.AddEmailUser(fm.Name, fm.Email, fm.Password, ip, p.Locale)
	p.Check(err)
	p.Check(auth.ConfirmUser(user.ID, ip, p.Locale))

	for _, role := range []string{"root", "admin"} {
		p.Check(auth.Allow(user.ID, role, auth.DefaultResourceType, auth.DefaultResourceID, 10, 0, 0))
	}

	p.JSON(nut.H{})
}
