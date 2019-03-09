TOPIC = check-response-time

all: deploy

deploy:
	cd src/check_response_time && \
	gcloud functions deploy check-response-time \
		--runtime go111 \
		--entry-point Function \
		--trigger-topic $(TOPIC) \
		--region asia-northeast1 \
		--env-vars-file .env.yaml

pubsub:
	gcloud beta pubsub topics publish $(TOPIC) --message test

scheduler:
	gcloud beta scheduler jobs create pubsub check-response-time \
		--schedule "*/5 * * * *" \
		--time-zone Asia/Tokyo \
		--topic $(TOPIC) \
		--message-body test
