ENV['KAFKA_REGISTRY'] ||= 'http://schema-registry:8081/'

WaterDrop.setup do |config|
  config.deliver = false
  config.kafka.seed_brokers = %w[kafka://localhost:9092]
end
