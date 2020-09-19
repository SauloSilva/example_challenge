module Application
  module Account
    class AccountApplication

      def initialize(params = {})
        @params = params
      end

      def dispatch_event
        account_command.dispatch_event
      end

      def response
        account_command.response
      end

      def save
        account_command.save
      end

      def valid?
        account_command.valid?
      end

      private

      attr_accessor :params

      def account_command
        Application::Account::Commands::CreateAccountCommand.new(params)
      end
    end
  end
end
