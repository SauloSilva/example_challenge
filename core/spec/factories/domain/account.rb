FactoryBot.define do
  factory :account, class: ::Domain::Account::Account do
    available_limit { 100 }
    active_card { true }
  end
end
