# language: pt

Funcionalidade: Não autoriza a transação cujo valores excede o limite da conta

    Contexto:
    Não autoriza a transação que excede os limites da conta

    Esquema do Cenário: Cadastrar uma conta válida
        Dado que eu não tenho nenhuma conta cadastrada
        Quando eu cadastrar uma nova conta com limite de <availableLimit> e com o status de "<activeCard>"
        Então o retorno não deve possuir erros

    Exemplos:
        | availableLimit | activeCard |
        | 100            | true       |

    Esquema do Cenário: Transação não autorizada por exceder o limite da conta
        Dado que eu vou cadastrar uma nova transação feita no "<merchant>" as "<time>" no valor de <amount>
        Quando o retorno possuir o erro "<error>"
        Então o saldo disponível da conta deve ser <availableLimit>

    Exemplos:
        | merchant | amount | time                     | availableLimit | error                          |
        | Habbibs  | 101    | 2019-02-13T11:00:00.000Z | 100            | transaction-insufficient-limit |

