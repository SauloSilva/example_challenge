module Infra
  module Api
    module Serializers
      class TransactionSerializer < BaseSerializer
        attr_accessor :repository

        def initialize(repository)
          @repository = repository
        end

        def serialized_json
          {
            transaction: {
              merchant: repository.merchant,
              amount: repository.amount,
              time: repository.time
            },
            violations: violations
          }
        end
      end
    end
  end
end
