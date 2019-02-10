package check_response_time

import (
	"context"
	"fmt"
	"log"
	"net/http"
	"net/http/httptrace"
	"net/smtp"
	"os"
	"time"
)

type PubSubMessage struct {
	Data []byte `json:"data"`
}

const ImarketURL = "http://tyn-imarket.com"

func Function(ctx context.Context, m PubSubMessage) error {
	client := &http.Client{Timeout: time.Duration(10) * time.Second}
	req, err := http.NewRequest("GET", ImarketURL, nil)
	if err != nil {
		return err
	}
	start := time.Now()
	var mailErr error
	trace := &httptrace.ClientTrace{
		GotFirstResponseByte: func() {
			sec := time.Since(start)
			fmt.Printf("Time from start to first byte: %v\n", sec)

			if sec.Seconds() >= 2.0 {
				err := sendMail(sec)
				if err != nil {
					mailErr = err
				}
			}
		},
	}
	req = req.WithContext(httptrace.WithClientTrace(ctx, trace))

	resp, err := client.Do(req)
	if err != nil {
		return err
	}
	if mailErr != nil {
		return mailErr
	}
	defer resp.Body.Close()

	return nil
}

func sendMail(sec time.Duration) error {
	auth := smtp.PlainAuth(
		"",
		os.Getenv("GMAIL_USERNAME"),
		os.Getenv("GMAIL_PASSWORD"),
		"smtp.gmail.com",
	)
	from := "tynimarket@gmail.com"
	to := "tynmarket@gmail.com"
	body := "Response time: " + sec.String()
	msg := "From: \"Notifier \"<" + from + ">\n" +
		"To: " + to + "\n" +
		"Subject: check-response-time\n\n" +
		body
	err := smtp.SendMail(
		"smtp.gmail.com:587",
		auth,
		from,
		[]string{to},
		[]byte(msg),
	)
	if err != nil {
		log.Printf("smtp error: %s", err)
	}

	return err
}
