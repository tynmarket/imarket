FROM ruby:2.5.1

RUN apt-get update \
      # mysql
      && apt-get install --yes --no-install-recommends mysql-client \
      # nginx
      && wget https://nginx.org/keys/nginx_signing.key \
      && apt-key add nginx_signing.key \
      && echo 'deb http://nginx.org/packages/debian/ stretch nginx' >> /etc/apt/sources.list \
      && echo 'deb-src http://nginx.org/packages/debian/ stretch nginx' >> /etc/apt/sources.list \
      && apt-get update \
      && apt-get install --yes --no-install-recommends nginx \
      # logrotate
      && apt-get install logrotate -y --no-install-recommends \
      # mackerel
      && curl -LO https://mackerel.io/file/agent/deb/mackerel-agent_latest.all.deb \
      && dpkg -i mackerel-agent_latest.all.deb \
      # Node.js
      && curl -sL https://deb.nodesource.com/setup_10.x | bash - \
      && apt-get install -y nodejs \
      && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY Gemfile Gemfile.lock /app/

RUN bundle install --jobs=4 --deployment --path /usr/local/bundle --without development test
