# Nubank Challenge

A docker wrapper to run microservices with base infrastructure.
Services are composed by:

* [authorizer](https://github.com/SauloSilva/nubank_challenge/tree/master/authorizer): micro service resposible to presentation layer and logic layer
* [core](https://github.com/SauloSilva/nubank_challenge/tree/master/core): library resposible to data layer and data storage layer
* [accounts](https://github.com/SauloSilva/nubank_challenge/tree/master/accounts): micro service responsible to consumer events of account creation and send to https://pipedream.com/@SauloSilva/nubank-challenge-p_JZC9j6
* [transactions](https://github.com/SauloSilva/nubank_challenge/tree/master/transactions): micro service responsible to consumer events of transaction creation and send to https://pipedream.com/@SauloSilva/nubank-challenge-p_JZC9j6

*OBSERVATION* Accounts and Transactions APPs these are the extra things I did to add to this challenge.

## Table of Contents

<!-- TOC depthFrom:1 depthTo:6 withLinks:1 orderedList:0 -->

- [Information](#information)
  - [Infrastructure](#infrastructure)
  - [Ruby Applications](#ruby-applications)
  - [Tests](#tests)
- [Getting started](#getting-started)
  - [Application Architecture Diagram](#application-architecture-diagram)
  - [Environment Variables](#environment-variables)
  - [Running microservices with docker](#running-microservices-with-docker)
  - [Running microservices without docker](#running-microservices-without-docker)
- [Kafka Connectors](#kafka-connectors)

<!-- /TOC -->

## Information

### Infrastructure

The base infrastructure to run services is composed by the following components:

* Kafka: message broker used by microservices
  * Broker
  * Zookeeper
  * Schema registry
  * Kafka Connector

The `infra.yml` it's a docker-compose file that provides all these components and can be used to run micro services with or without docker.

Run infrastructure with:

```
$ docker-compose -f infra.yml up
```

### Ruby Applications

All micro services (authorizer, accounts and transactions) are Ruby based applications and running with docker environment:

```
$ docker-compose -f docker-compose.yml up
```

### Tests

To run individual micro services tests, first choose application.

For authorizer service, execute this:

```
$ docker-compose run authorizer bundle exec rspec
```

For accounts service, execute this:

```
$ docker-compose run accounts bundle exec rspec
```

For transactions service, execute this:

```
$ docker-compose run transactions bundle exec rspec
```

## Getting started

### Application Architecture Diagram

![img](https://github.com/SauloSilva/nubank_challenge/raw/master/doc/Application%20Architecture%20Diagram.png)

### Environment Variables

If you choose run micro services with docker, remove any file `.env` for all services into root folder(accounts, transactions or authorizer), to avoid conflict with docker-compose up. Eg.

```
rm -rf accounts/.env transactions/.env authorizer/.env
```

If you choose run services outside docker, you need copy `.env.sample` to `.env` files inside each application.

```
cp authorizer/.env.sample authorizer/.env
cp accounts/.env.sample accounts/.env
cp transactions/.env.sample transactions/.env
```

### Running microservices with docker

First, you need to run infrastructure:

```
$ docker-compose -f infra.yml up
```

And then, with all infra running, you can run services using default docker-compose.yml:

```
$ docker-compose -f docker-compose.yml up
```

All application commands like rails console, rspec and other can be executed using docker-compose:

```
$ docker-compose run app-name bundle exec rails console
```

### Running microservices without docker

Once you have the base infrastructure running in docker (infra.yml), you can run authorizer, accounts or transactions services without docker, using your Ruby installed via RVM, Rbenv, or directly in OS.

Run infrastructure:

```
$ docker-compose -f infra.yml up
```

Run commands individually in desired applications:

**Authorizer service**

```
$ cd authorizer
$ cp .env.sample .env
$ gem install bundler
$ bundle install
$ rails s
```

**Accounts service**

```
$ cd authorizer
$ cp .env.sample .env
$ gem install bundler
$ bundle install
$ bundle exec karafka server
```

**Transactions service**

```
$ cd authorizer
$ cp .env.sample .env
$ gem install bundler
$ bundle install
$ bundle exec karafka server
```

The services will run in your OS, but using infrastructure components from docker: Kafka.

After execute this, to need remove all `.env` to applications, to avoid conflict with docker-compose run.
In this case, execute:

```
rm -rf accounts/.env transactions/.env authorizer/.env
```

### API Doc

For the API to work it is necessary to have all infrastructure and services running.

Host: localhost
Port: 3000
Endpoint: /operations
Verb: POST

**Body examples**

For account:

`{ "account": { "activeCard": true, "availableLimit": 100 } }`

For transaction:

`{ "transaction": { "merchant": "Burger King", "amount": 20, "time": "2019-02-13T10:00:00.000Z" } }`

Eg. with curl:

```
curl --location --request POST 'localhost:3000/operations' \
  --header ': ' \
  --header 'Content-Type: application/json' \
  --data-raw '{ "account": { "activeCard": true, "availableLimit": 100 } }'
```

See [json collection](https://github.com/SauloSilva/nubank_challenge/blob/master/doc/Nubank%20Challenge.postman_collection.json) of Postman.

## Kafka Connectors

We use kafka connectors to sync data between services.
The connectors files are placed in connectors/ directory.

You can use the available bin scripts to manage connectors:

Registering all connectors

```
$ ./bin/register-connectors.sh
```

Listing all registered connectors

```
$ ./bin/list-connectors.sh
```

Unregister some registered connector passing his name as parameter:

```
$ ./bin/unregister-connector.sh connectornamegoeshere
```

## Kafka Schemas
We use kafka schemas to use them on events
You can use the available bin scripts to manage schemas:

Listing all registered schemas

```
$ ./bin/list-schemas.sh
```
Unregister some registered schema passing his name as parameter:

```
$ ./bin/unregister-schema.sh schemanamegoeshere
```

