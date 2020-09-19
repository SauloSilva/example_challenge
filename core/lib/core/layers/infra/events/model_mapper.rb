module Infra
  module Events
    class ModelMapper
      class ModelNotFoundError < StandardError; end

      def self.call(topic_name)
        new(topic_name).call
      end

      def initialize(topic_name)
        @topic_name = topic_name
      end

      def call
        model = class_name.safe_constantize
        raise ModelNotFoundError, "Not found '#{class_name}' model" if model.nil?

        model
      end

      private

      attr_reader :topic_name

      def class_name
        "Infra::Events::Models::#{topic_name.camelize}"
      end
    end
  end
end
