TOPIC = check-response-time

all: deploy

deploy:
	cd src/check_response_time && \
	gcloud functions deploy check-response-time \
		--runtime go111 \
		--entry-point Function \
		--trigger-topic $(TOPIC) \
		--region asia-northeast1

pubsub:
	gcloud beta pubsub topics publish $(TOPIC) --message test
