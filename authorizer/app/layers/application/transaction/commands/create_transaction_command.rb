module Application
  module Transaction
    module Commands
      class CreateTransactionCommand

        def initialize(attrs)
          @attrs = attrs
        end

        def save
          new_transaction_repository.save
        end

        def valid?
          new_transaction_repository.valid?
        end

        def dispatch_event
          Infra::Events::Responders::TransactionCreatorResponder.call(params_to_responders)
        end

        def response
          Infra::Api::Serializers::AccountSerializer.new(new_transaction_repository).serialized_json
        end

        def destroy_all
          transaction_repository.destroy_all
        end

        private

        attr_accessor :attrs

        def transaction_repository
          Infra::Repositories::TransactionRepository.new
        end

        def new_transaction_repository
          @new_transaction_repository ||= transaction_repository.new_record(params)
        end

        def params_to_responders
          params.merge(account: {
            available_limit: account.available_limit,
            active_card: account.active_card
          })
        end

        def params
          {
            account: account,
            account_id: account&.id,
            amount: attrs[:amount],
            merchant: attrs[:merchant],
            time: parse_time
          }
        end

        def parse_time
          Time.zone.parse attrs[:time]
        end

        def account
          Infra::Repositories::AccountRepository.new.find_last
        end
      end
    end
  end
end
