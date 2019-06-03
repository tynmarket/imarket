FUNCTION = cloud-build
TOPIC = cloud-builds
SLACK_WEBHOOK_URL = $SLACK_WEBHOOK_URL_BUILD

all: deploy clean

deploy:
	cd ~/git/imarket/imarket/function/cloud_build && \
	mkdir deploy && \
	cp index.js package.json deploy && \
	cd deploy && \
	gcloud functions deploy $(FUNCTION) \
		--runtime nodejs8 \
		--entry-point run \
		--trigger-topic $(TOPIC) \
		--region asia-northeast1 \
		--set-env-vars SLACK_WEBHOOK_URL=$(SLACK_WEBHOOK_URL_BUILD)

clean:
	cd ~/git/imarket/imarket/function/cloud_build && \
	rm -rf deploy

pubsub:
	gcloud pubsub topics publish $(TOPIC) --message {}
