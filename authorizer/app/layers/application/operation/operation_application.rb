module Application
  module Operation
    class OperationApplication
      attr_accessor :params

      def initialize(params = {})
        @params = params
      end

      def application
        @application ||= Application::Operation::Commands::CreateOperationCommand.new(params).application
      end
    end
  end
end
