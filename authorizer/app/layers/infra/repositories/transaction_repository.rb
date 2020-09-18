module Infra
  module Repositories
    class TransactionRepository
      def new_record(account_command)
        Domain::Transaction::Transaction.new(account_command.params)
      end
    end
  end
end
