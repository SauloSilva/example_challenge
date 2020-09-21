require 'avro_turf/test/fake_confluent_schema_registry_server'
require 'webmock/rspec'

RSpec.configure do |config|
  config.before(:each) do
    WebMock.stub_request(:post, 'https://eny44nhjua6vj5d.m.pipedream.net').to_return(body: "ok")
  end

  config.before(:each, type: :consumer) do
    WebMock.stub_request(:any, /^#{ENV['KAFKA_REGISTRY']}/).to_rack(FakeConfluentSchemaRegistryServer)
  end
end
