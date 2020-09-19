FROM ruby:2.7.1

LABEL maintainer="saulodasilvasantiago@gmail.com"

ADD authorizer/Gemfile /app/Gemfile
ADD authorizer/Gemfile.lock /app/Gemfile.lock
COPY core /app/vendor/gems/core

WORKDIR /app

RUN gem install bundler:2.1.4
RUN bundle install

COPY authorizer /app

EXPOSE 3000

CMD ["bundle", "exec", "rails", "server", "-p", "3000", "-b", "0.0.0.0"]
