module Web
  module Controllers
    class OperationsController < ::ActionController::API
      def create
        operation_application = Application::Operation::OperationApplication.new(operation_param).application

        if operation_application.valid?
          operation_application.dispatch_event
          operation_application.save

          render status: :created, json: operation_application.response
        else
          render status: :unprocessable_entity, json: operation_application.response
        end
      rescue => e
        render status: :unprocessable_entity, json: { message: e.message }
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
