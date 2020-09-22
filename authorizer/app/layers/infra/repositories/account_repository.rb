module Infra
  module Repositories
    class AccountRepository
      def new_record(params)
        Domain::Account::Account.new(params)
      end

      def find_last
        Domain::Account::Account.records&.last
      end

      def destroy_all
        Domain::Account::Account.records = []
      end
    end
  end
end
