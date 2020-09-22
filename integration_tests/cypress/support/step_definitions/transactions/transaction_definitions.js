import { Given, When, Then } from "cypress-cucumber-preprocessor/steps"
import { addTransaction } from './transaction_definitions-obj'

let transactionResponse = {}

Given('que eu vou cadastrar uma nova transação feita no {string} as {string} no valor de {int}', async (merchant, time, amount) => {
  transactionResponse = await addTransaction(merchant, time, amount);
});

When('o retorno não possuir erros', () => {
  expect(transactionResponse.violations).to.have.length(0)
})

When('o retorno possuir o erro {string}', (error) => {
  expect(transactionResponse.violations).to.include(error)
})

Then('o saldo disponível da conta deve ser {int}', (availableLimit) => {
  expect(transactionResponse.account.availableLimit).to.equal(availableLimit)
})
