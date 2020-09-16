require 'spec_helper'

RSpec.describe Infra::Events::Models::TransactionCreate do
  let(:model) { described_class.new(attrs) }

  describe '#incorrect keys' do
    let(:attrs) do
      {
        account: {
          available_limit: '1',
          active_card: nil
        },
        account_id: nil,
        merchant: 1,
        amount: 1,
        time: Time.parse('2019-02-13T11:00:00.000Z')
      }
    end

    it 'returns error of parser attrs' do
      expect { model }.to raise_error(Dry::Struct::Error)
    end
  end

  describe '#correct keys' do
    let(:attrs) do
      {
        account: {
          available_limit: 100,
          active_card: true
        },
        account_id: 1,
        merchant: 'foo',
        amount: 1,
        time: Time.parse('2019-02-13T11:00:00.000Z')
      }
    end


    it 'returns methods of account_id, merchant, amount and time' do
      expect(model.account_id).to eq(1)
      expect(model.merchant).to eq('foo')
      expect(model.amount).to eq(1)
      expect(model.time).to eq(Time.parse('2019-02-13T11:00:00.000Z'))
    end
  end
end
