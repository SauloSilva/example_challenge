module Application
  module Transaction
    class TransactionApplication
      def initialize(params = {})
        @params = params
      end

      def dispatch_event
        transaction_command.dispatch_event
      end

      def response
        transaction_command.response
      end

      def save
        transaction_command.save
      end

      def valid?
        transaction_command.valid?
      end

      private

      attr_accessor :params

      def transaction_command
        @transaction_command ||= Application::Transaction::Commands::CreateTransactionCommand.new(params)
      end
    end
  end
end
