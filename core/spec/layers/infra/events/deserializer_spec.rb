require 'spec_helper'

RSpec.describe Infra::Events::Deserializer do
  subject(:deserializer) { described_class.new(adapter) }
  let(:adapter) { Infra::Events::Adapters::AvroClient }
  let(:decoded_params) do
    {
      account: { available_limit: 100, active_card: true },
      account_id: 1,
      merchant: 'le-merchant',
      amount: 1,
      time: Time.parse('2019-02-13T11:00:00.000Z')
    }
  end

  describe '#call' do
    context 'without kafka_prefix' do
      it 'returns a builded model', :aggregate_failures do
        message = double(topic: 'test', payload: 'avroencodepayload')

        allow(adapter).to receive(:decode).with(message.payload, schema_name: 'test').and_return(decoded_params)
        allow(Infra::Events::ModelMapper).to receive(:call).with('test').and_return(Infra::Events::Models::TransactionCreate)

        result = deserializer.call(message)

        expect(result).to be_a(Infra::Events::Models::TransactionCreate)
        expect(result.account_id).to eq(decoded_params.fetch(:account_id))
        expect(result.merchant).to eq(decoded_params.fetch(:merchant))
        expect(result.amount).to eq(decoded_params.fetch(:amount))
        expect(result.time).to eq(decoded_params.fetch(:time))
      end
    end

    context 'with kafka_prefix' do
      it 'returns a builded model', :aggregate_failures do
        message = double(topic: 'nubank.test', payload: 'avroencodepayload')

        allow(ENV).to receive(:fetch).with('KAFKA_PREFIX', nil).and_return('nubank.')
        allow(adapter).to receive(:decode).with(message.payload, schema_name: 'test').and_return(decoded_params)
        allow(Infra::Events::ModelMapper).to receive(:call).with('test').and_return(Infra::Events::Models::TransactionCreate)

        result = deserializer.call(message)

        expect(result).to be_a(Infra::Events::Models::TransactionCreate)
        expect(result.account_id).to eq(decoded_params.fetch(:account_id))
        expect(result.merchant).to eq(decoded_params.fetch(:merchant))
        expect(result.amount).to eq(decoded_params.fetch(:amount))
        expect(result.time).to eq(decoded_params.fetch(:time))
      end
    end
  end
end
