module Application
  module Account
    module Commands
      class CreateAccountCommand
        def initialize(attrs)
          @attrs = attrs
        end

        def save
          new_account_repository.save
        end

        def valid?
          new_account_repository.valid?
        end

        def dispatch_event
          Infra::Events::Responders::AccountCreatorResponder.call(params)
        end

        def response
          Infra::Api::Serializers::AccountSerializer.new(new_account_repository).serialized_json
        end

        def destroy_all
          account_repository.destroy_all
        end

        private

        attr_accessor :attrs

        def account_repository
          Infra::Repositories::AccountRepository.new
        end

        def new_account_repository
          @new_account_repository ||= account_repository.new_record(params)
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
