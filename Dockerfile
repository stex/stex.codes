FROM ruby:2-slim as jekyll
RUN apt-get update && \
        apt-get install -y make libssl-dev g++
WORKDIR /app

RUN gem install bundler:2.2.0

COPY ./Gemfile* ./
COPY ./vendor ./vendor

RUN bundle config set deployment 'true'
RUN bundle install --without=test
COPY ./ ./
ENV JEKYLL_ENV=production
RUN bundle exec jekyll build

FROM nginx
COPY ./nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=jekyll /app/_site /usr/share/nginx/html
