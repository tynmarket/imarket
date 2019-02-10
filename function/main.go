package main

import (
	"check_response_time"
	"context"
	"log"
)

func main() {
	ctx := context.Background()
	err := check_response_time.Function(ctx, check_response_time.PubSubMessage{})
	if err != nil {
		log.Printf("err: %s", err)
		return
	}
	log.Println("succeess")
}
