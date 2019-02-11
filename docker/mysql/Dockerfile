# docker build -t tynmarket/mysql .

FROM mysql:8.0

RUN apt-get update \
      && apt-get install -y --no-install-recommends \
        procps \
        ca-certificates \
        curl \
        net-tools \
      && curl -LO https://mackerel.io/file/agent/tgz/mackerel-agent-latest.tar.gz \
      && tar xvzf mackerel-agent-latest.tar.gz \
      && rm -rf /var/lib/apt/lists/*

ENV TZ Asia/Tokyo

COPY imarket.cnf /etc/mysql/conf.d
COPY mackerel-agent.sh .
