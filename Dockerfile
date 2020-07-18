FROM ruby:slim as jekyll
RUN apt-get update && \
        apt-get install -y make libssl-dev g++
WORKDIR /app
COPY ./Gemfile* ./
RUN bundle install
COPY ./ ./
RUN bundle exec jekyll build

FROM nginx
COPY --from=jekyll /app/_site /usr/share/nginx/html
