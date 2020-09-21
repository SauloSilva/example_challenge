# Accounts service

### Infrastructure

The base infrastructure to run services is composed by the following components:

* Kafka: message broker used by microservices
  * Broker
  * Zookeeper
  * Schema registry
  * Kafka Connector

The `infra.yml` it's a docker-compose file that provides all these components and can be used to run micro services with or without docker.

Run infrastructure in root folder with:

```
$ docker-compose -f infra.yml up
```

### Tests

To run tests, got to root folder, execute this:

```
$ docker-compose run accounts bundle exec rspec

```

### Running microservices with docker

In root folder, execute:

```
docker-compose up accounts
```
