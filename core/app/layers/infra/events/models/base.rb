module Infra
  module Events
    module Models
      class Base < Dry::Struct
        attribute? :raw_message, Types::String

        def initialize(attributes, raw_message = nil)
          # Prevent raw_message to be exposed in model attributes comparison
          @raw_message = attributes.delete(:raw_message)

          super(attributes)
        end

        def raw_message
          @raw_message
        end
      end
    end
  end
end
