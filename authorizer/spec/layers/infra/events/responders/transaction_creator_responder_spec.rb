require 'rails_helper'

RSpec.describe Infra::Events::Responders::TransactionCreatorResponder, type: :responder do
  subject(:responder) { described_class.new }

  describe '#topics' do
    context 'transaction_create' do
      subject(:topic) { described_class.topics['transaction_create'] }

      it { expect(topic.name).to eq 'transaction_create' }
      it { expect(topic.required?).to be_truthy }
      it { expect(topic.serializer).to be_a(Infra::Events::Serializers::TransactionCreateSerializer) }
    end
  end

  describe '#call' do
    context 'when calls only required topics' do
      subject(:topic) { described_class.topics['transaction_create'] }

      it 'expect add only required messages to buffer' do
        responder.call({
          account: {
            available_limit: 100,
            active_card: true
          },
          account_id: 1,
          merchant: 'foo',
          amount: 1,
          time: Time.now
        })
        expect(responder.messages_buffer.keys).to eq(%w[transaction_create])
      end
    end
  end
end
