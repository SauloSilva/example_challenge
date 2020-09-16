FactoryBot.define do
  factory :transaction_create, class: ::Infra::Events::Models::TransactionCreate do
    account
    merchant { 'le merchant' }
    amount { 20 }
    time { 3.days.ago }
  end
end
