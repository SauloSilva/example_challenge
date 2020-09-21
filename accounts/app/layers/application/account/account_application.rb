module Application
  module Account
    class AccountApplication
      attr_accessor :event_model

      def initialize(event_model)
        @event_model = event_model
      end

      def send_request
        Application::Account::Commands::CreateAccount.new(event_model).request
      end
    end
  end
end
