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
              availableLimit: available_limit,
              activeCard: active_card
            },
            violations: violations
          }
        end

        private

        def available_limit
          if repository.methods.include?(:account)
            repository.account&.available_limit
          else
            repository.available_limit
          end
        end

        def active_card
          if repository.methods.include?(:account)
            repository.account&.active_card
          else
            repository.active_card
          end
        end
      end
    end
  end
end
