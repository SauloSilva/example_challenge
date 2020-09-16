require 'spec_helper'

RSpec.describe Domain::Account::Account, type: :model do
  after { described_class.records = [] }

  describe 'validations' do
    it { is_expected.to validate_presence_of :available_limit }
    it { is_expected.to validate_numericality_of(:available_limit).only_integer.is_greater_than_or_equal_to(0) }
    it { expect(build(:account, active_card: nil)).not_to be_valid }

    it 'already exists' do
      create(:account)
      new_record = build(:account)

      expect(new_record.save).not_to be_valid
    end
  end

  describe 'associations' do
    it { is_expected.to have_many(:transactions).class_name('Domain::Transaction::Transaction') }
  end

  describe '#update_limit' do
    it 'change available limit' do
      model = build(:account, available_limit: 100)
      model.save

      model.update_limit(12)
      model.update_limit(-8)

      expect(model.available_limit).to eq(80)
    end
  end

  describe '#save' do
    it 'add model to records' do
      model = build(:account)
      model.save

      expect(model.records).to eq([model])
    end
  end
end
