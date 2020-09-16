require 'spec_helper'

RSpec.describe Infra::Events::Adapters::AvroClient do
  let(:attrs) do
    {
      available_limit: 1,
      active_card: true
    }
  end

  describe '.avro' do
    before { allow(AvroTurf::Messaging).to receive(:new) }

    it 'call AvroTurf::Messaging' do
      described_class.avro
      expect(AvroTurf::Messaging).to have_received(:new).once
    end
  end

  describe '.encode' do
    let!(:store) { double }

    before do
      allow(described_class).to receive(:avro).and_return(store)
      allow(store).to receive(:encode)
    end

    it 'call encode methods of AvroTurf::Messaging' do
      described_class.encode(attrs, schema_name: 'account_create')
      expect(store).to have_received(:encode).once
    end
  end

  describe '.decode' do
    let!(:store) { double }

    before do
      allow(described_class).to receive(:avro).and_return(store)
      allow(store).to receive(:decode)
    end

    it 'call decode methods of AvroTurf::Messaging' do
      described_class.decode(attrs, schema_name: 'account_create')
      expect(store).to have_received(:decode).once
    end
  end
end
