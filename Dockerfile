FROM ruby:2-slim as jekyll

ARG THUMBOR_URL
ENV THUMBOR_URL=$THUMBOR_URL
ARG THUMBOR_SECURITY_KEY
ENV THUMBOR_SECURITY_KEY=$THUMBOR_SECURITY_KEY

RUN apt-get update && \
        apt-get install -y make libssl-dev g++ \
        git
WORKDIR /app

RUN gem install bundler:2.2.0

COPY ./Gemfile* ./
COPY ./vendor ./vendor

RUN bundle config set deployment 'true'
RUN bundle install --without=test
COPY ./ ./
ENV JEKYLL_ENV=production
RUN bundle exec bin/sync_hey_world_posts
RUN bundle exec jekyll build -V

FROM nginx
COPY ./nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=jekyll /app/_site /usr/share/nginx/html
