require 'spec_helper'

RSpec.describe Infra::Events::ConsumerMapper do
  subject(:mapper) { described_class.new(prefix) }

  let(:prefix) { 'nubank_topics.' }
  let(:client_id) { 'myapp' }

  describe '#call' do
    it 'adds prefix to client_id and raw_consumer_group_name' do
      allow(Karafka::App.config).to receive(:client_id).and_return(client_id)
      expect(mapper.call('test')).to eq("#{prefix}#{client_id}_test")
    end
  end
end
