require 'rails_helper'

RSpec.describe Infra::Repositories::AccountRepository do
  describe '#new_record' do
    it 'expect Domain::Account::Account#new has been called' do
      params = double(params: 0)

      allow(Domain::Account::Account).to receive(:new)
      described_class.new.new_record(params)

      expect(Domain::Account::Account).to have_received(:new)
    end
  end

  describe '#find_last' do
    it 'expect Domain::Account::Account#find_last has been called' do
      params = double(params: 0)

      allow(Domain::Account::Account).to receive(:records).and_return([1, 2, 3, 4])
      described_class.new.find_last

      expect(Domain::Account::Account).to have_received(:records)
    end
  end

  describe '#destroy_all' do
    it 'array empty assing of Domain::Account::Account#records' do
      Domain::Account::Account.records = ['1']
      expect(Domain::Account::Account.records).to be_present

      described_class.new.destroy_all

      expect(Domain::Account::Account.records).to be_blank
    end
  end
end
