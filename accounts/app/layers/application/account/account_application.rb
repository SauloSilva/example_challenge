module Application
  module Account
    class AccountApplication
      attr_accessor :domain

      def initialize(repositories = {})
        @domain = repositories.fetch(:domain) { Domain::Account::Account }
      end

      def save(account_command)
        @domain.new(account_command.params).save
      end
    end
  end
end
