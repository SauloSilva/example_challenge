# Integration tests

The base infrastructure to run integration test is composed by the following components:

- [Cypress.io](https://www.cypress.io/)
- Cucumber

The integration tests are javascript based cypress framework and running with yarn, to execute this project,  step follow:

- Install yarn[(more details click here)](https://classic.yarnpkg.com/pt-BR/docs/install#mac-stable)

Before running test, start all micro services:

```
$ docker-compose -f infra.yml up
```

Wait for infraestructure to be provisioned

```
$ docker-compose -f docker-compose.yml up
```

Wait for all services to be provisioned, go to folder of `intregation_tests`, and instal dependencies:

```
$ yarn install
```

Run tests with mode headless

```
$ yarn run cypress:run
```

Run tests on browser

```
$ yarn run cypress:open
```
