package job

import (
	"time"

	"github.com/google/uuid"
	"github.com/streadway/amqp"
)

// Send send job
func Send(typ string, priority uint8, body []byte) error {
	return open(func(ch *amqp.Channel) error {
		qu, err := ch.QueueDeclare(queue, true, false, false, false, nil)
		if err != nil {
			return err
		}

		return ch.Publish("", qu.Name, false, false, amqp.Publishing{
			DeliveryMode: amqp.Persistent,
			ContentType:  "text/plain",
			MessageId:    uuid.New().String(),
			Priority:     priority,
			Body:         body,
			Timestamp:    time.Now(),
			Type:         typ,
		})
	})
}
