module Infra
  module Consumers
    class AccountConsumer < Infra::Consumers::ApplicationConsumer
      def consume
        account_command = Application::Account::Commands::CreateAccount.new(event_model)
        Application::Account::AccountApplication.new.save(account_command)
      end

      private

      def event_model
        params.payload
      end
    end
  end
end
