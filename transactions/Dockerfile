FROM ruby:2.7.1

LABEL maintainer="saulodasilvasantiago@gmail.com"

ADD transactions/Gemfile /app/Gemfile
ADD transactions/Gemfile.lock /app/Gemfile.lock
ADD transactions/.env.production.sample /app/.env
COPY core /app/vendor/gems/core

WORKDIR /app

RUN gem install bundler:2.1.4
RUN DOCKER=true bundle install

COPY transactions /app

CMD ["bundle", "exec", "karafka", "server"]
