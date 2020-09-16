require 'spec_helper'

RSpec.describe Domain::Transaction::Transaction, type: :model do
  after { described_class.records = [] }

  describe 'validations' do
    it { is_expected.to validate_presence_of :merchant }
    it { is_expected.to validate_presence_of :amount }
    it { is_expected.to validate_presence_of :time }
    it { is_expected.to validate_numericality_of(:amount).only_integer.is_greater_than_or_equal_to(0) }

    it 'reached credit limit' do
      account = create(:account, available_limit: 20)
      model = build(:transaction, account: account, amount: 100)
      model.save

      expect(model).not_to be_valid
      expect(model.errors.messages[:transaction]).to eq(["insufficient limit"])
    end

    it 'card not active' do
      account = create(:account, available_limit: 200, active_card: false)
      model = build(:transaction, account: account, amount: 100)
      model.save

      expect(model).not_to be_valid
      expect(model.errors.messages[:transaction]).to eq(["card not active"])
    end

    it 'high frequency' do
      account = create(:account)
      model_1 = build(:transaction, account: account, amount: 1, time: Time.parse('2019-02-13T10:59:00.000Z'))
      model_2 = build(:transaction, account: account, amount: 2, time: Time.parse('2019-02-13T11:00:00.000Z'))
      model_3 = build(:transaction, account: account, amount: 3, time: Time.parse('2019-02-13T11:01:00.000Z'))
      model_4 = build(:transaction, account: account, amount: 4, time: Time.parse('2019-02-13T11:01:00.000Z'))

      expect(model_1).to be_valid
      model_1.save

      expect(model_2).to be_valid
      model_2.save

      expect(model_3).to be_valid
      model_3.save

      expect(model_4).not_to be_valid
      model_4.save

      expect(model_4.errors.messages[:transaction]).to eq(["high frequency small interval"])
    end

    it 'double transaction' do
      account = create(:account, available_limit: 200, active_card: true)
      model_1 = build(:transaction, account: account, amount: 20, time: Time.parse('2019-02-13T11:00:00.000Z'))
      model_2 = build(:transaction, account: account, amount: 20, time: Time.parse('2019-02-13T11:01:00.000Z'))

      expect(model_1).to be_valid
      model_1.save

      expect(model_2).not_to be_valid
      model_2.save

      expect(model_2.errors.messages[:transaction]).to eq(["double transaction"])
    end
  end

  describe '.same_account(account_id)' do
    it 'return only tranasctions of same account' do
      account = create(:account, available_limit: 200, active_card: true)
      model = build(:transaction, account: account, amount: 20, time: Time.parse('2019-02-13T11:00:00.000Z'))
      model.save

      expect(described_class.same_account(account.id)).to eq([model])
    end
  end

  describe '#save' do
    it 'add model to records' do
      model = build(:transaction)
      model.save

      expect(model.records).to eq([model])
    end
  end
end
