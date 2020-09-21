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

  describe '#send_request' do
    it 'calls transaction command' do
      event_model = Infra::Events::Models::TransactionCreate.new(params)

      account_command_instance = double
      allow(Application::Transaction::Commands::CreateTransaction).to receive(:new).with(event_model).and_return(account_command_instance)
      allow(account_command_instance).to receive(:request)

      described_class.new(event_model).send_request

      expect(account_command_instance).to have_received(:request).once
    end
  end
end
