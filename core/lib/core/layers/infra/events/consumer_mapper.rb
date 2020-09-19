module Infra
  module Events
    class ConsumerMapper
      def initialize(prefix)
        @prefix = prefix
      end

      def call(raw_consumer_group_name)
        client_name = Karafka::Helpers::Inflector.map(Karafka::App.config.client_id.to_s)
        "#{@prefix}#{client_name}_#{raw_consumer_group_name}"
      end
    end
  end
end
