# Integration tests

The base infrastructure to run integration test is composed by the following components:

- [Cypress.io](https://www.cypress.io/)
- Cucumber

The integration tests are javascript based cypress framework and running with yarn, to execute this project,  step follow:

- Install yarn[(more details click here)](https://classic.yarnpkg.com/pt-BR/docs/install#mac-stable)

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
