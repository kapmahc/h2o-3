package nut

import (
	"errors"
	"fmt"
	"net/http"
	"strings"

	"golang.org/x/text/language"

	"github.com/astaxie/beego"
	"github.com/astaxie/beego/validation"
	"github.com/beego/i18n"
)

// Controller base controller
type Controller struct {
	beego.Controller

	Locale string
}

// Check check error
func (p *Controller) Check(e error) {
	if e != nil {
		p.CustomAbort(http.StatusInternalServerError, e.Error())
	}
}

// JSON render json
func (p *Controller) JSON(v interface{}) {
	p.Data["json"] = v
	p.ServeJSON()
}

// Prepare prepare
func (p *Controller) Prepare() {
	p.detectLocale()
}

// LayoutApplication set application layout
func (p *Controller) LayoutApplication() {
	// TODO
}

// Bind bind params to form and valid it
func (p *Controller) Bind(fm interface{}) error {
	if err := p.ParseForm(fm); err != nil {
		return err
	}
	var va validation.Validation
	ok, err := va.Valid(fm)
	var msg []string
	if err != nil {
		return err
	}
	if !ok {
		for _, err := range va.Errors {
			msg = append(msg, fmt.Sprintf("%s: %s", err.Field, err.Message))
		}
		return errors.New(strings.Join(msg, "</li><li>"))
	}
	return nil
}

func (p *Controller) detectLocale() {
	const key = "locale"
	write := false

	// 1. Check URL arguments.
	lang := p.Input().Get(key)

	// 2. Get language information from cookies.
	if len(lang) == 0 {
		lang = p.Ctx.GetCookie(key)
	} else {
		write = true
	}

	// 3. Get language information from 'Accept-Language'.
	if len(lang) == 0 {
		al := p.Ctx.Request.Header.Get("Accept-Language")
		if len(al) > 4 {
			lang = al[:5] // Only compare first 5 letters.
		}
		write = true
	}

	// 4. Default language is English.
	tag, err := language.Parse(lang)
	if err != nil {
		beego.Error(err)
	}
	lang = tag.String()
	if !i18n.IsExist(lang) {
		lang = language.AmericanEnglish.String()
		write = true
	}

	// Save language information in cookies.
	if write {
		p.Ctx.SetCookie(key, lang, 1<<31-1, "/")
	}

	// Set language properties.
	p.Locale = lang
	p.Data[key] = lang
	p.Data["languages"] = i18n.ListLangs()
}
