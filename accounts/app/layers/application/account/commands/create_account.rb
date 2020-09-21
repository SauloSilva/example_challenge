module Application
  module Account
    module Commands
      class CreateAccount
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
            active_card: event_model.active_card,
            available_limit: event_model.available_limit
          }
        end
      end
    end
  end
end
