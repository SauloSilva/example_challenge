ENV['KARAFKA_ENV'] = ENV['RAILS_ENV']
require './config.rb'

class KarafkaApp < Karafka::App
  setup do |config|
    config.kafka.seed_brokers = ENV.fetch('KAFKA_BROKERS').split

    config.client_id = 'transactions'
    config.batch_fetching = ENV.fetch('BATCH_FETCHING', true)
    config.kafka.fetcher_max_queue_size = ENV.fetch('KAFKA_FETCHER_MAX_QUEUE_SIZE', 10).to_i
    config.kafka.session_timeout = ENV.fetch('KAFKA_SESSION_TIMEOUT', 30).to_i
    config.kafka.max_bytes_per_partition = ENV.fetch('KAFKA_MAX_BYTES_PER_PARTITION', 1_048_576).to_i
    config.kafka.max_bytes = ENV.fetch('KAFKA_MAX_BYTES', 10_485_760).to_i
    config.kafka.max_wait_time = ENV.fetch('KAFKA_MAX_WAIT_TIME', 1).to_i
    config.kafka.heartbeat_interval = ENV.fetch('KAFKA_HEARTBEAT_INTERVAL', 10).to_i

    config.deserializer = ::Infra::Events::Deserializer.new
    config.consumer_mapper = ::Infra::Events::ConsumerMapper.new(ENV.fetch('KAFKA_PREFIX', nil))
    config.topic_mapper = ::Infra::Events::TopicMapper.new(ENV.fetch('KAFKA_PREFIX', nil))
  end

  # Comment out this part if you are not using instrumentation and/or you are not
  # interested in logging events for certain environments. Since instrumentation
  # notifications add extra boilerplate, if you want to achieve max performance,
  # listen to only what you really need for given environment.
  Karafka.monitor.subscribe(WaterDrop::Instrumentation::StdoutListener.new)
  Karafka.monitor.subscribe(Karafka::Instrumentation::StdoutListener.new)
  Karafka.monitor.subscribe(Karafka::Instrumentation::ProctitleListener.new)

  consumer_groups.draw do
    consumer_group :transactions do
      topic :transaction_create do
        consumer Infra::Consumers::TransactionConsumer
      end
    end
  end
end

Karafka.monitor.subscribe('app.initialized')

KarafkaApp.boot!

WaterDrop.setup do |config|
  config.kafka.required_acks = ENV.fetch('KAFKA_REQUIRED_ACKS', -1).to_i
  config.kafka.ack_timeout = ENV.fetch('KAFKA_ACK_TIMEOUT', 5).to_i
  config.kafka.delivery_interval = ENV.fetch('KAFKA_DELIVERY_INTERVAL', 10).to_i
  config.kafka.delivery_threshold = ENV.fetch('KAFKA_DELIVERY_THRESHOLD', 100).to_i
  config.kafka.max_buffer_bytesize = ENV.fetch('KAFKA_MAX_BUFFER_BYTSIZE', 10_000_000).to_i
  config.kafka.max_buffer_size = ENV.fetch('KAFKA_MAX_BUFFER_SIZE', 1000).to_i
  config.kafka.max_queue_size = ENV.fetch('KAFKA_MAX_QUEUE_SIZE', 1000).to_i
end
