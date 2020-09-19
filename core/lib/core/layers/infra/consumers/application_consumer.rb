module Infra
  module Consumers
    class ApplicationConsumer < Karafka::BaseConsumer
      def call
        return if skip_event?

        super
      end

      private

      def skip_event?
        single_event? && event_target.present? && event_target != consumer_id
      end

      def single_event?
        respond_to?(:params)
      end

      def event_target
        params.headers.dig('target_consumer')
      end

      def consumer_id
        self.topic.id
      end
    end
  end
end
