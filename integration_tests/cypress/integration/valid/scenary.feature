# language: pt

Funcionalidade: Cria conta com todas as transações autorizadas

    Eu como usuário desejo realizar uma criação de conta e lançar transações para esta conta

    Contexto:
    Analisa a criação de conta e transações

    Esquema do Cenário: Cadastrar uma conta válida
        Dado que eu não tenho nenhuma conta cadastrada
        Quando eu cadastrar uma nova conta com limite de <availableLimit> e com o status de "<activeCard>"
        Então o retorno não deve possuir erros

    Exemplos:
        | availableLimit | activeCard |
        | 100            | true       |

    Esquema do Cenário: Cadastrar uma transação válida
        Dado que eu vou cadastrar uma nova transação feita no "<merchant>" as "<time>" no valor de <amount>
        Quando o retorno não possuir erros
        Então o saldo disponível da conta deve ser <availableLimit>

    Exemplos:
        | merchant | amount | time                     | availableLimit |
        | Habbibs  | 20     | 2019-02-13T11:00:00.000Z | 80             |

    Esquema do Cenário: Cadastrar uma transação válida
        Dado que eu vou cadastrar uma nova transação feita no "<merchant>" as "<time>" no valor de <amount>
        Quando o retorno não possuir erros
        Então o saldo disponível da conta deve ser <availableLimit>

    Exemplos:
        | merchant | amount | time                     | availableLimit |
        | Bobs     | 43     | 2019-02-13T11:01:00.000Z | 37             |
