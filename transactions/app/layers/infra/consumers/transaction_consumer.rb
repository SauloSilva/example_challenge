module Infra
  module Consumers
    class TransactionConsumer < Infra::Consumers::ApplicationConsumer
      def consume
        account_command = Application::Transaction::Commands::CreateTransaction.new(event_model)
        Application::Transaction::TransactionApplication.new.save(account_command)
      end

      private

      def event_model
        params.payload
      end
    end
  end
end
