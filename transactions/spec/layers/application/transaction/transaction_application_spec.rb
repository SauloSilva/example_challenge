require 'spec_helper'

RSpec.describe Application::Transaction::TransactionApplication do
  subject(:application) { described_class }
  let(:params) do
    {
      account: { available_limit: 100, active_card: true },
      account_id: 1,
      merchant: 'foo',
      amount: 1,
      time: Time.parse('2019-02-13T10:00:00.000Z')
    }
  end

  describe '#save(transaction_command)' do
    it 'calls repository save' do
      repository_instance = double
      allow(Domain::Transaction::Transaction).to receive(:new).with(params.except(:account)).and_return(repository_instance)
      allow(repository_instance).to receive(:save)

      event_model = Infra::Events::Models::TransactionCreate.new(params)
      transaction_command = Application::Transaction::Commands::CreateTransaction.new(event_model)

      described_class.new.save(transaction_command)

      expect(repository_instance).to have_received(:save).once
    end
  end
end
