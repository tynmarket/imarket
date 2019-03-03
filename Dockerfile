FROM gcr.io/tynmarket-195002/github-tynmarket-imarket-rails-nginx

COPY . /app
COPY docker/default.conf /etc/nginx/conf.d
COPY docker/nginx.conf /etc/nginx
COPY docker/nginx /etc/logrotate.d
COPY docker/mackerel-agent.sh /app

ARG rails_master_key

ENV TZ Asia/Tokyo
ENV RAILS_MASTER_KEY $rails_master_key

RUN bundle exec rails assets:precompile RAILS_ENV=production && \
    yarn build && \
    rm -rf node_modules

EXPOSE 80

ENTRYPOINT bundle exec rails db:migrate && \
           nginx && \
           ./mackerel-agent.sh && \
           crond && \
           bundle exec puma -b unix:///var/run/puma.sock
