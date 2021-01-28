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
RUN bundle exec jekyll build -V

FROM node:lts-alpine as node
RUN npm install -g npm
RUN mkdir -p /app
WORKDIR /app
COPY --from=jekyll /app/package.json ./package.json
RUN npm install
COPY --from=jekyll /app/bin/ ./
COPY --from=jekyll /app/_site ./_site
RUN ./prettify_html

FROM nginx
COPY ./nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=node /app/_site /usr/share/nginx/html
