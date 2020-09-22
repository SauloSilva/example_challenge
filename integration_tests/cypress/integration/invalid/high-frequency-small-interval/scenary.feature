# language: pt

Funcionalidade: Não autoriza mais que 3 transações criadas em um intervalo menor que 2 minutos

    Contexto:
    Não autoriza mais que 3 transações criadas em intervalos menores que 2 minutos

    Esquema do Cenário: Cadastrar uma conta válida
        Dado que eu não tenho nenhuma conta cadastrada
        Quando eu cadastrar uma nova conta com limite de <availableLimit> e com o status de "<activeCard>"
        Então o retorno não deve possuir erros

    Exemplos:
        | availableLimit | activeCard |
        | 100            | true       |

    Esquema do Cenário: Cadastrar a primeira transação válida
        Dado que eu vou cadastrar uma nova transação feita no "<merchant>" as "<time>" no valor de <amount>
        Quando o retorno não possuir erros
        Então o saldo disponível da conta deve ser <availableLimit>

    Exemplos:
        | merchant | amount | time                     | availableLimit |
        | Habbibs  | 20     | 2019-02-13T11:00:00.000Z | 80             |

    Esquema do Cenário: Cadastrar a segunda transação válida com diferença de 1 minuto
        Dado que eu vou cadastrar uma nova transação feita no "<merchant>" as "<time>" no valor de <amount>
        Quando o retorno não possuir erros
        Então o saldo disponível da conta deve ser <availableLimit>

    Exemplos:
        | merchant | amount | time                     | availableLimit |
        | Habbibs  | 5      | 2019-02-13T11:01:00.000Z | 75             |

    Esquema do Cenário: Cadastrar a terceira transação válida com diferença de meio segundo
        Dado que eu vou cadastrar uma nova transação feita no "<merchant>" as "<time>" no valor de <amount>
        Quando o retorno não possuir erros
        Então o saldo disponível da conta deve ser <availableLimit>

    Exemplos:
        | merchant | amount | time                     | availableLimit |
        | Habbibs  | 10     | 2019-02-13T11:01:30.000Z | 65             |

    Esquema do Cenário: Cadastro inválido da quarta transação em menos e 2 minutos
        Dado que eu vou cadastrar uma nova transação feita no "<merchant>" as "<time>" no valor de <amount>
        Quando o retorno possuir o erro "<error>"
        Então o saldo disponível da conta deve ser <availableLimit>

    Exemplos:
        | merchant | amount | time                     | availableLimit | error |
        | Habbibs  | 12     | 2019-02-13T11:01:40.000Z | 65             | transaction-high-frequency-small-interval |
