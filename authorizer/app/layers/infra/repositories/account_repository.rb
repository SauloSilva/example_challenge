module Infra
  module Repositories
    class AccountRepository
      def new_record(account_command)
        Domain::Account::Account.new(account_command.params)
      end

      def find_last
        Domain::Account::Account.records&.last
      end
    end
  end
end
