import { Given, When, Then } from "cypress-cucumber-preprocessor/steps"
import { deleteOperations, addAccount } from './account_definitions-obj'

let accountResponse = {}

Given('que eu não tenho nenhuma conta cadastrada', async () => {
  let response = await deleteOperations();
  expect(response).to.deep.equal({ 'message': 'ok' })
})

When('eu cadastrar uma nova conta com limite de {int} e com o status de {string}', async (availableLimit, activeCard) => {
  accountResponse = await addAccount(availableLimit, activeCard);
});

Then('o retorno não deve possuir erros', () => {
  expect(accountResponse.violations).to.be.empty
})

Then('devo receber um erros de {string}', (error) => {
  expect(accountResponse.violations).to.include(error)
})
