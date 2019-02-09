package main

import (
	"check_response_time"
	"context"
	"fmt"
)

func main() {
	ctx := context.Background()
	check_response_time.Function(ctx, check_response_time.PubSubMessage{})
	fmt.Println("main")
}
