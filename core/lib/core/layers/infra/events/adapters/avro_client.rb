require 'avro_turf/messaging'

module Infra
  module Events
    module Adapters
      class AvroClient
        def self.avro
          @avro ||= AvroTurf::Messaging.new(registry_url: ENV.fetch('KAFKA_REGISTRY'), schemas_path: Core.schemas_path)
        end

        def self.encode(object, schema_name:)
          avro.encode(object, schema_name: schema_name)
        end

        def self.decode(payload, schema_name:)
          avro.decode(payload, schema_name: schema_name)
        end
      end
    end
  end
end
