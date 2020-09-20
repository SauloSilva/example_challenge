module Application
  module Operation
    module Errors
      class ApplicationNotFound < StandardError
        def message
          'Application not found'
        end
      end
    end
  end
end
