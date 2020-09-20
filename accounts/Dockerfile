FROM ruby:2.7.1

LABEL maintainer="saulodasilvasantiago@gmail.com"

ADD accounts/Gemfile /app/Gemfile
ADD accounts/Gemfile.lock /app/Gemfile.lock
ADD accounts/.env.production.sample /app/.env
COPY core /app/vendor/gems/core

WORKDIR /app

RUN gem install bundler:2.1.4
RUN DOCKER=true bundle install

COPY accounts /app

CMD ["bundle", "exec", "karafka", "server"]
