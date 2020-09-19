require File.join(Core.root, 'lib', 'core', 'layers', 'infra', 'events', 'adapters', 'avro_client')

module Infra
  module Events
    class Serializer
      def initialize(adapter = Infra::Events::Adapters::AvroClient)
        @adapter = adapter
      end

      def call(object)
        attrs = attributes(object)
        attrs = attrs.is_a?(Hash) ? stringify_keys(attrs) : attrs
        @adapter.encode(attrs, schema_name: schema_name)
      end

      def attributes(object)
        object
      end

      def schema_name
        raise NotImplementedError
      end

      private

      def stringify_keys(hash)
        hash.inject({}) do |options, (key, value)|
          if value.is_a?(Array)
            options[key.to_s] = value.map { |v| stringify_keys(v) }
          elsif value.is_a?(Hash)
            options[key.to_s] = stringify_keys(value)
          else
            options[key.to_s] = value
          end
          options
        end
      end
    end
  end
end
