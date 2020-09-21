# Authorizer service

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

To run tests in root folder, execute this:

```
$ docker-compose run authorizer bundle exec rspec

```

### Running microservices with docker

In root folder, execute:

```
docker-compose up authorizer
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

See collection on the Postman.
