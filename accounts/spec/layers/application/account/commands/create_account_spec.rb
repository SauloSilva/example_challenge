require 'spec_helper'

RSpec.describe Application::Account::Commands::CreateAccount do
  let(:params) do
    {
      available_limit: 100,
      active_card: true,
    }
  end

  describe 'params' do
    it 'returns all params' do
      event_model = Infra::Events::Models::AccountCreate.new(params)
      account_command = Application::Account::Commands::CreateAccount.new(event_model)

      expect(account_command.params).to eq(params)
    end
  end
end
