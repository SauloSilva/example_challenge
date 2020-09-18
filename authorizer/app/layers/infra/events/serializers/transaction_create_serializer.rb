module Infra
  module Events
    module Serializers
      class TransactionCreateSerializer < Infra::Events::Serializer
        def schema_name
          'transaction_create'
        end

        def attributes(params)
          Infra::Events::Models::TransactionCreate.new(params.deep_symbolize_keys).to_h
        end
      end
    end
  end
end
