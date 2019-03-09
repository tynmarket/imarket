FUNCTION = mysql-backup
TOPIC = mysql-backup

all: deploy clean

deploy:
	mkdir deploy && \
	cp index.js package.json deploy && \
	cd deploy && \
	gcloud functions deploy $(FUNCTION) \
		--runtime nodejs8 \
		--entry-point run \
		--trigger-topic $(TOPIC) \
		--region asia-northeast1

clean:
	rm -rf deploy
