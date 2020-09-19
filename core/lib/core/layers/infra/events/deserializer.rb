module Infra
  module Events
    class Deserializer
      def initialize(adapter = Infra::Events::Adapters::AvroClient)
        @adapter = adapter
      end

      def call(message)
        topic_name = topic_mapper.incoming(message.topic)
        payload_decoded = @adapter.decode(message.payload, schema_name: topic_name)

        model_class = Infra::Events::ModelMapper.call(topic_name)
        model_class.new(payload_decoded.deep_symbolize_keys.merge(raw_message: message.payload))
      end

      def topic_mapper
        @topic_mapper ||= Infra::Events::TopicMapper.new(ENV.fetch('KAFKA_PREFIX', nil))
      end
    end
  end
end
