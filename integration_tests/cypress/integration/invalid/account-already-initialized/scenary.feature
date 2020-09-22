# language: pt

Funcionalidade: Tenta criar a conta duas vezes

    Contexto:
    Não deixa inicializar uma conta já criada

    Esquema do Cenário: Cadastrar uma conta válida
        Dado que eu não tenho nenhuma conta cadastrada
        Quando eu cadastrar uma nova conta com limite de <availableLimit> e com o status de "<activeCard>"
        Então o retorno não deve possuir erros

    Exemplos:
        | availableLimit | activeCard |
        | 100            | true       |

    Esquema do Cenário: A validação não deixar inicializar uma nova conta
        Quando eu cadastrar uma nova conta com limite de <availableLimit> e com o status de "<activeCard>"
        Então devo receber um erros de "<error>"

    Exemplos:
        | availableLimit | activeCard | error                       |
        | 100            | true       | account-already-initialized |

