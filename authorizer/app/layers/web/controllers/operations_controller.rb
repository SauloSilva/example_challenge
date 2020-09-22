module Web
  module Controllers
    class OperationsController < ::ActionController::API
      def create
        operation_application = Application::Operation::OperationApplication.new(operation_param).application

        if operation_application.valid?
          operation_application.save
          operation_application.dispatch_event

          render status: :created, json: operation_application.response
        else
          render status: :unprocessable_entity, json: operation_application.response
        end
      rescue Application::Operation::Errors::ApplicationNotFound => e
        render status: :unprocessable_entity, json: { message: e.message }
      end

      def destroy
        account_application = Application::Account::AccountApplication.new
        transaction_application = Application::Transaction::TransactionApplication.new

        account_application.destroy_all
        transaction_application.destroy_all
        render status: :ok, json: { message: 'ok' }
      end

      private

      def operation_param
        params.require(:operation).permit(
          account: [:availableLimit, :activeCard],
          transaction: [:merchant, :amount, :time]
        )
      end
    end
  end
end
