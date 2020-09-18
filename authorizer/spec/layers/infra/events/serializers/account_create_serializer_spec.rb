require 'rails_helper'

RSpec.describe Infra::Events::Serializers::AccountCreateSerializer do
  describe '#schema_name' do
    it 'return schema name' do
      expect(described_class.new.schema_name).to eq('account_create')
    end
  end

  describe '#attributes' do
    it 'expect Infra::Events::Models::AccountCreate#new has been called' do
      params = double(params: 0)

      allow(Infra::Events::Models::AccountCreate).to receive(:new)
      described_class.new.attributes({})

      expect(Infra::Events::Models::AccountCreate).to have_received(:new)
    end
  end
end
