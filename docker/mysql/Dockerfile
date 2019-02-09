# docker build -t tynmarket/mysql .

FROM mysql:8.0

RUN apt-get update \
      && apt-get install -y --no-install-recommends procps \
      && rm -rf /var/lib/apt/lists/*

ENV TZ Asia/Tokyo

COPY imarket.cnf /etc/mysql/conf.d
