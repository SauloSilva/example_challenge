require 'rails_helper'

RSpec.describe Infra::Api::Serializers::TransactionSerializer do
  describe '#serialized_json' do
    let(:repository) do
      double({
        merchant: 100,
        amount: nil,
        time: '2020-09-18 15:09:33',
        errors: double({
          messages: { amount: ['is not be blank'] }
        })
      })
    end

    it 'expect return json' do
      serializer = described_class.new(repository)
      expect(serializer.serialized_json).to eq({
        transaction: {
          merchant: 100,
          amount: nil,
          time: '2020-09-18 15:09:33',
        },
        violations: ["amount-is-not-be-blank"]
      })
    end
  end
end
