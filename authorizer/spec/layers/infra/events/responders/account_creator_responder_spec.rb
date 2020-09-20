require 'rails_helper'

RSpec.describe Infra::Events::Responders::AccountCreatorResponder, type: :responder do
  subject(:responder) { described_class.new }

  it { expect(described_class).to be < Karafka::BaseResponder }

  describe '#topics' do
    context 'account_create' do
      subject(:topic) { described_class.topics['account_create'] }

      it { expect(topic.name).to eq 'account_create' }
      it { expect(topic.required?).to be_truthy }
      it { expect(topic.serializer).to be_a(Infra::Events::Serializers::AccountCreateSerializer) }
    end
  end

  describe '#call' do
    context 'when calls only required topics' do
      it 'expect add only required messages to buffer' do
        responder.call({
          available_limit: 100,
          active_card: true
        })

        expect(responder.messages_buffer.keys).to eq(%w[account_create])
      end
    end
  end
end
