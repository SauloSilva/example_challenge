module Application
  module Transaction
    module Commands
      class CreateTransaction
        attr_accessor :event_model

        def initialize(event_model)
          @event_model = event_model
        end

        def request
          RequestBinCaller.new(attrs: params).post
        end

        private

        def params
          {
            account: {
              active_card: event_model.account.active_card,
              available_limit: event_model.account.available_limit
            },
            account_id: event_model.account_id,
            merchant: event_model.merchant,
            amount: event_model.amount,
            time: event_model.time
          }
        end
      end
    end
  end
end
