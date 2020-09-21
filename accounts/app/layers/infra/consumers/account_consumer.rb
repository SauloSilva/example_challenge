module Infra
  module Consumers
    class AccountConsumer < Infra::Consumers::ApplicationConsumer
      def consume
        Application::Account::AccountApplication.new(event_model).send_request
      end

      private

      def event_model
        params.payload
      end
    end
  end
end
