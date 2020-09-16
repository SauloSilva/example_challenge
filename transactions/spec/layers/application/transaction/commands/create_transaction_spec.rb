require 'spec_helper'

RSpec.describe Application::Transaction::Commands::CreateTransaction do
  let(:params) do
    {
      account: { available_limit: 100, active_card: true },
      account_id: 1,
      merchant: 'foo',
      amount: 1,
      time: Time.parse('2019-02-13T10:00:00.000Z')
    }
  end

  describe 'params' do
    it 'returns all params' do
      event_model = Infra::Events::Models::TransactionCreate.new(params)
      account_command = Application::Transaction::Commands::CreateTransaction.new(event_model)

      expect(account_command.params).to eq(params.except(:account))
    end
  end
end
