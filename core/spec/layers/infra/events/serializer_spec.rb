require 'spec_helper'

class FakeSerializer < Infra::Events::Serializer
  def schema_name
    'account_create'
  end
end

RSpec.describe Infra::Events::Serializer do
  subject(:serializer) { FakeSerializer.new }

  before do
    store = AvroTurf.new(schemas_path: Core.schemas_path)
    allow(AvroTurf::Messaging).to receive(:new).and_return(store)
  end

  let(:attrs) do
    {
      'available_limit': 1,
      'active_card': true,
      'foo': [],
      'bar': {}
    }
  end

  describe '#encode' do
    it 'return string with structure' do
      expect(serializer.call(attrs)).to include('account_create')
      expect(serializer.call(attrs)).to include('fields')
      expect(serializer.call(attrs)).to include('available_limit')
      expect(serializer.call(attrs)).to include('active_card')
    end
  end

  describe 'schema_name' do
    it 'raise error' do
      expect do
        described_class.new.schema_name
      end.to raise_error(NotImplementedError)
    end
  end

  describe '#attributes(attrs)' do
    it 'return hash with stringify keys' do
      expect(serializer.attributes(attrs)).to eq({ available_limit: 1, active_card: true, foo: [], bar: {} })
    end
  end
end
