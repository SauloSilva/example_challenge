module Application
  module Transaction
    class TransactionApplication
      attr_accessor :account_responder, :transaction_repository

      def initialize(repositories = {})
        @transaction_repository = repositories.fetch(:transaction_repository) { Domain::Transaction::Transaction }
      end

      def save(transaction_command)
        @transaction_repository.new(transaction_command.params).save
      end
    end
  end
end
