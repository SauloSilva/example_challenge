module Application
  module Operation
    module Commands
      class CreateOperationCommand
        def initialize(attrs)
          @attrs = attrs
        end

        def application
          case
            when account? then Application::Account::AccountApplication.new(attrs[:account])
            when transaction? then Application::Transaction::TransactionApplication.new(attrs[:transaction])
            else raise Application::Operation::Errors::ApplicationNotFound
          end
        end

        private

        attr_accessor :attrs

        def account?
          attrs[:account].present?
        end

        def transaction?
          attrs[:transaction].present?
        end
      end
    end
  end
end
