module Application
  module Transaction
    module Commands
      class CreateTransactionCommand

        def initialize(attrs)
          @attrs = attrs
        end

        def save
          transaction_repository.save
        end

        def valid?
          transaction_repository.valid?
        end

        def dispatch_event
          Infra::Events::Responders::TransactionCreatorResponder.call(params)
        end

        def response
          valid?
          Infra::Api::Serializers::TransactionSerializer.new(transaction_repository).serialized_json
        end

        private

        attr_accessor :attrs

        def transaction_repository
          @transaction_repository ||= Infra::Repositories::TransactionRepository.new.new_record(params)
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
