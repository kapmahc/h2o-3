package job

import (
	"github.com/astaxie/beego"
	"github.com/streadway/amqp"
)

var (
	url   = beego.AppConfig.String("rabbitmqurl")
	queue = beego.AppConfig.String("httpdomain")
)

func open(f func(*amqp.Channel) error) error {
	conn, err := amqp.Dial(url)
	if err != nil {
		return err
	}
	defer conn.Close()
	ch, err := conn.Channel()
	if err != nil {
		return err
	}
	defer ch.Close()

	return f(ch)
}
