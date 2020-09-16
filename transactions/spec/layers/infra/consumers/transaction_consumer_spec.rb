require 'spec_helper'

RSpec.describe Infra::Consumers::TransactionConsumer, type: :consumer do
  subject(:consumer) { karafka_consumer_for(:transaction_create) }

  let(:params) do
    {
      account: { available_limit: 100, active_card: true },
      account_id: 1,
      merchant: 'foo',
      amount: 1,
      time: Time.parse('2019-02-13T10:00:00.000Z')
    }
  end

  before do
    adapter = Infra::Events::Adapters::AvroClient.encode(params.with_indifferent_access, schema_name: 'transaction_create')
    publish_for_karafka(adapter)
  end

  it 'calls application account' do
    application_instance = double

    event_model = Infra::Events::Models::TransactionCreate.new(params)
    transaction_command = double

    allow(Application::Transaction::Commands::CreateTransaction).to receive(:new).with(event_model).and_return(transaction_command)
    expect(Application::Transaction::TransactionApplication).to receive(:new).and_return(application_instance)
    expect(application_instance).to receive(:save).with(transaction_command)

    consumer.consume
  end
end
