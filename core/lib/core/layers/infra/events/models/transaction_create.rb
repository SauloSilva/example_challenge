require File.join(File.expand_path('../..', __FILE__), 'models', 'account_create')

module Infra
  module Events
    module Models
      class TransactionCreate < Base
        attribute :account, Infra::Events::Models::AccountCreate
        attribute :account_id, Types::Integer
        attribute :merchant, Types::String
        attribute :amount, Types::Integer
        attribute :time, Types::Time
      end
    end
  end
end
