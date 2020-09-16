require 'spec_helper'

RSpec.describe Infra::Events::TopicMapper do
  subject(:mapper) { described_class.new(prefix) }

  let(:prefix) { 'nubank_topics.' }

  describe '#incoming' do
    it 'removes prefix from topic' do
      expect(mapper.incoming("#{prefix}account")).to eq('account')
    end
  end

  describe '#outgoing' do
    it 'adds prefix to topic' do
      expect(mapper.outgoing('account')).to eq("#{prefix}account")
    end
  end
end
