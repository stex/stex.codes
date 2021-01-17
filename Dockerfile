FROM ruby:2slim as jekyll
RUN apt-get update && \
        apt-get install -y make libssl-dev g++
WORKDIR /app
COPY ./Gemfile* ./
COPY ./vendor ./vendor

RUN bundle config set deployment 'true'
RUN bundle install --without=test
COPY ./ ./
ENV JEKYLL_ENV=production
RUN bundle exec jekyll build

FROM nginx
COPY --from=jekyll /app/_site /usr/share/nginx/html
