require 'rails_helper'

RSpec.describe Infra::Repositories::TransactionRepository do
  describe '#new_record' do
    it 'expect Domain::Transaction::Transaction#new has been called' do
      params = double(params: 0)

      allow(Domain::Transaction::Transaction).to receive(:new)
      described_class.new.new_record(params)

      expect(Domain::Transaction::Transaction).to have_received(:new)
    end
  end

  describe '#destroy_all' do
    it 'array empty assing of Domain::Transaction::Transaction#records' do
      Domain::Transaction::Transaction.records = ['1']
      expect(Domain::Transaction::Transaction.records).to be_present

      described_class.new.destroy_all

      expect(Domain::Transaction::Transaction.records).to be_blank
    end
  end
end
