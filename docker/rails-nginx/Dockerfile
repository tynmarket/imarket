FROM ruby:2.5.3-alpine3.8

WORKDIR /app

RUN apk upgrade --no-cache && \
    apk add --update --no-cache \
      mysql-client \
      mariadb-connector-c-dev \
      nodejs \
      yarn \
      nginx \
      logrotate \
      tzdata \
      bash \
      git && \
    mkdir -p /app/tmp/cache && \
    mkdir -p /app/tmp/pids && \
    mkdir -p /app/tmp/sockets && \
    mkdir -p /app/log && \
    mkdir /run/nginx

COPY Gemfile Gemfile.lock /app/

RUN apk add --update --no-cache --virtual=build-dependencies \
      build-base \
      curl \
      tar \
      linux-headers \
      libxml2-dev \
      libxslt-dev \
      ruby-dev \
      yaml-dev \
      zlib-dev && \
    gem install bundler && \
    bundle install -j4 --deployment --path /usr/local/bundle --without development test && \
    curl -LO https://mackerel.io/file/agent/tgz/mackerel-agent-latest.tar.gz && \
    tar xvzf mackerel-agent-latest.tar.gz && \
    apk del build-dependencies
