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
end
