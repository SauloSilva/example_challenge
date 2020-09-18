module Infra
  module Api
    module Serializers
      class AccountSerializer < BaseSerializer
        attr_accessor :repository

        def initialize(repository)
          @repository = repository
        end

        def serialized_json
          {
            account: {
              availableLimit: repository.available_limit,
              activeCard: repository.active_card
            },
            violations: violations
          }
        end
      end
    end
  end
end
