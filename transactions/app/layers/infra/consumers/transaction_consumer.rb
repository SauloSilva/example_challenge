module Infra
  module Consumers
    class TransactionConsumer < Infra::Consumers::ApplicationConsumer
      def consume
        Application::Transaction::TransactionApplication.new(event_model).send_request
      end

      private

      def event_model
        params.payload
      end
    end
  end
end
