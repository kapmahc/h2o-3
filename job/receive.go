package job

import (
	"fmt"
	"time"

	"github.com/astaxie/beego"
	"github.com/streadway/amqp"
)

// Receive receive a job
func Receive(consumer string) error {
	return open(func(ch *amqp.Channel) error {
		if err := ch.Qos(1, 0, false); err != nil {
			return err
		}
		qu, err := ch.QueueDeclare(queue, true, false, false, false, nil)
		if err != nil {
			return err
		}
		msgs, err := ch.Consume(qu.Name, consumer, false, false, false, false, nil)
		if err != nil {
			return err
		}
		for d := range msgs {
			d.Ack(false)
			beego.Notice("receive job", d.MessageId+"@"+d.Type)
			now := time.Now()
			hnd, ok := handlers[d.Type]
			if !ok {
				return fmt.Errorf("don't find handler for %s", d.Type)
			}
			if err := hnd(d.MessageId, d.Body); err != nil {
				return err
			}
			beego.Notice("done", d.MessageId, time.Now().Sub(now))
		}
		return nil
	})
}
