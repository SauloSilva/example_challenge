module Infra
  module Repositories
    class TransactionRepository
      def new_record(params)
        Domain::Transaction::Transaction.new(params)
      end
    end
  end
end
