FactoryBot.define do
  factory :transaction, class: ::Domain::Transaction::Transaction do
    account
    merchant { 'foo' }
    amount { 100 }
    time { Time.parse('2019-02-13T11:00:00.000Z') }
  end
end
