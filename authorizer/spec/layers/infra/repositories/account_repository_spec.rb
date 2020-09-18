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
end
