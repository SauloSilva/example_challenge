module Infra
  module Repositories
    class AccountRepository
      def new_record(params)
        Domain::Account::Account.new(params)
      end

      def find_last
        Domain::Account::Account.records&.last
      end
    end
  end
end
