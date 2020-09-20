require 'rails_helper'

RSpec.describe Infra::Api::Serializers::AccountSerializer do
  context 'when transaction' do
    describe '#serialized_json' do
      let(:repository) do
        double({
          account: double({
            available_limit: 100,
            active_card: nil
          }),
          errors: double({
            messages: { active_card: ['is not be blank'] }
          })
        })
      end

      it 'expect return json' do
        serializer = described_class.new(repository)
        expect(serializer.serialized_json).to eq({
          account: {
            availableLimit: 100,
            activeCard: nil
          },
          violations: ["active_card-is-not-be-blank"]
        })
      end
    end
  end

  context 'when account' do
    describe '#serialized_json' do
      let(:repository) do
        double({
          available_limit: 100,
          active_card: nil,
          errors: double({
            messages: { active_card: ['is not be blank'] }
          })
        })
      end

      it 'expect return json' do
        serializer = described_class.new(repository)
        expect(serializer.serialized_json).to eq({
          account: {
            availableLimit: 100,
            activeCard: nil
          },
          violations: ["active_card-is-not-be-blank"]
        })
      end
    end
  end
end
