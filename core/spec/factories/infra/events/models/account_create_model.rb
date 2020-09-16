FactoryBot.define do
  factory :account_create, class: ::Infra::Events::Models::AccountCreate do
    available_limit { 100 }
    active_card { true }
  end
end
