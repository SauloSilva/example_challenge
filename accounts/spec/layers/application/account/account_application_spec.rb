require 'spec_helper'

RSpec.describe Application::Account::AccountApplication do
  subject(:application) { described_class }
  let(:params) do
    {
      available_limit: 100,
      active_card: true,
    }
  end

  describe '#save(account_command)' do
    it 'calls repository save' do
      repository_instance = double
      allow(Domain::Account::Account).to receive(:new).with(params).and_return(repository_instance)
      allow(repository_instance).to receive(:save)

      event_model = Infra::Events::Models::AccountCreate.new(params)
      account_command = Application::Account::Commands::CreateAccount.new(event_model)

      described_class.new.save(account_command)

      expect(repository_instance).to have_received(:save).once
    end
  end
end
