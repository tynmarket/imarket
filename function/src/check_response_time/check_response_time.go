package check_response_time

import (
	"context"
	"fmt"
	"net/http"
	"net/http/httptrace"
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
	trace := &httptrace.ClientTrace{
		GotFirstResponseByte: func() {
			fmt.Printf("Time from start to first byte: %v\n", time.Since(start))
		},
	}
	req = req.WithContext(httptrace.WithClientTrace(req.Context(), trace))

	resp, err := client.Do(req)
	if err != nil {
		return err
	}
	defer resp.Body.Close()

	return nil
}
