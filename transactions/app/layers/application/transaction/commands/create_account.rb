module Application
  module Transaction
    module Commands
      class CreateTransaction
        attr_accessor :event_model

        def initialize(event_model)
          @event_model = event_model
        end

        def params
          {
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
