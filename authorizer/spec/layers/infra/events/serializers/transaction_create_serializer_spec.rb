require 'rails_helper'

RSpec.describe Infra::Events::Serializers::TransactionCreateSerializer do
  it { expect(described_class).to be < Infra::Events::Serializer }

  describe '#schema_name' do
    it 'return schema name' do
      expect(described_class.new.schema_name).to eq('transaction_create')
    end
  end

  describe '#attributes' do
    it 'expect Infra::Events::Models::TransactionCreate#new has been called' do
      params = double(params: 0)

      allow(Infra::Events::Models::TransactionCreate).to receive(:new)
      described_class.new.attributes({})

      expect(Infra::Events::Models::TransactionCreate).to have_received(:new)
    end
  end
end
