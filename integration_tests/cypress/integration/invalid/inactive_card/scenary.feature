# language: pt

Funcionalidade: Não autoriza a transação porque o cartão esta inativo

    Contexto:
    Não autoriza a transação porque o cartão esta inativo

    Esquema do Cenário: Cadastrar uma conta válida com cartão inativado
        Dado que eu não tenho nenhuma conta cadastrada
        Quando eu cadastrar uma nova conta com limite de <availableLimit> e com o status de "<activeCard>"
        Então o retorno não deve possuir erros

    Exemplos:
        | availableLimit | activeCard |
        | 100            | false      |

    Esquema do Cenário: Transação não autorizada
        Dado que eu vou cadastrar uma nova transação feita no "<merchant>" as "<time>" no valor de <amount>
        Quando o retorno possuir o erro "<error>"
        Então o saldo disponível da conta deve ser <availableLimit>

    Exemplos:
        | merchant | amount | time                     | availableLimit | error                         |
        | Habbibs  | 20     | 2019-02-13T11:00:00.000Z | 100            | transaction-card-not-active   |

