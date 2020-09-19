module Application
  module Account
    module Commands
      class CreateAccountCommand
        def initialize(attrs)
          @attrs = attrs
        end

        def save
          account_repository.save
        end

        def valid?
          account_repository.valid?
        end

        def dispatch_event
          Infra::Events::Responders::AccountCreatorResponder.call(params)
        end

        def response
          Infra::Api::Serializers::AccountSerializer.new(account_repository).serialized_json
        end

        private

        attr_accessor :attrs

        def account_repository
          @account_repository ||= Infra::Repositories::AccountRepository.new.new_record(params)
        end

        def params
          {
            available_limit: attrs[:availableLimit],
            active_card: attrs[:activeCard]
          }
        end
      end
    end
  end
end
