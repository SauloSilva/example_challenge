require 'spec_helper'

RSpec.describe Application::Account::AccountApplication do
  subject(:application) { described_class }
  let(:params) do
    {
      available_limit: 100,
      active_card: true,
    }
  end

  describe '#send_request' do
    it 'calls repository save' do
      event_model = Infra::Events::Models::AccountCreate.new(params)

      account_command_instance = double
      allow(Application::Account::Commands::CreateAccount).to receive(:new).with(event_model).and_return(account_command_instance)
      allow(account_command_instance).to receive(:request)

      described_class.new(event_model).send_request

      expect(account_command_instance).to have_received(:request).once
    end
  end
end
