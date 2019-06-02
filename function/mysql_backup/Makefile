FUNCTION = mysql-backup
TOPIC = mysql-backup
DISK = mysql

all: deploy clean

deploy:
	cd ~/git/imarket/imarket/function/mysql_backup && \
	mkdir deploy && \
	cp index.js package.json deploy && \
	cd deploy && \
	gcloud functions deploy $(FUNCTION) \
		--runtime nodejs8 \
		--entry-point run \
		--trigger-topic $(TOPIC) \
		--region asia-northeast1

clean:
	cd ~/git/imarket/imarket/function/mysql_backup && \
	rm -rf deploy

pubsub:
	gcloud pubsub topics publish $(TOPIC) --message '{"disk": "$(DISK)"}'

scheduler:
	gcloud beta scheduler jobs delete $(FUNCTION) -q || true
	gcloud beta scheduler jobs create pubsub $(FUNCTION) \
		--schedule "15 0 * * *" \
		--time-zone Asia/Tokyo \
		--topic $(TOPIC) \
		--message-body '{"disk": "$(DISK)"}'
