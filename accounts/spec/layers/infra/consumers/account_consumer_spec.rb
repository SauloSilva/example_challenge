require 'spec_helper'

RSpec.describe Infra::Consumers::AccountConsumer, type: :consumer do
  subject(:consumer) { karafka_consumer_for(:account_create) }

  let(:params) do
    {
      available_limit: 100,
      active_card: true,
    }
  end

  before do
    adapter = Infra::Events::Adapters::AvroClient.encode(params.with_indifferent_access, schema_name: 'account_create')
    publish_for_karafka(adapter)
  end

  it 'calls application account' do
    application_instance = double

    event_model = Infra::Events::Models::AccountCreate.new(params)
    account_command = double

    allow(Application::Account::Commands::CreateAccount).to receive(:new).with(event_model).and_return(account_command)
    expect(Application::Account::AccountApplication).to receive(:new).and_return(application_instance)
    expect(application_instance).to receive(:save).with(account_command)

    consumer.consume
  end
end
