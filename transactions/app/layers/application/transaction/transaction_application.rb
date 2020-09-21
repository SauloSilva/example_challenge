module Application
  module Transaction
    class TransactionApplication
      attr_accessor :event_model

      def initialize(event_model)
        @event_model = event_model
      end

      def send_request
        Application::Transaction::Commands::CreateTransaction.new(event_model).request
      end
    end
  end
end
