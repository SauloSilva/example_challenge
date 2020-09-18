FROM ruby:2.7.1

LABEL maintainer="saulodasilvasantiago@gmail.com"

WORKDIR /app


RUN gem install bundler:2.1.4

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

RUN echo "--------" && ls -la karafka.rb

RUN bundle install

COPY . /app
