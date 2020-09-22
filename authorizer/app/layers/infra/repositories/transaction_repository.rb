module Infra
  module Repositories
    class TransactionRepository
      def new_record(params)
        Domain::Transaction::Transaction.new(params)
      end

      def destroy_all
        Domain::Transaction::Transaction.records = []
      end
    end
  end
end
