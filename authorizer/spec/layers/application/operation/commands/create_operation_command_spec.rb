require 'rails_helper'

RSpec.describe Application::Operation::Commands::CreateOperationCommand do
  describe '#application' do
    it 'call Application::Account::AccountApplication#new when params contain account' do
      command_instance = described_class.new({ account: { ok: :ok }})
      allow(Application::Account::AccountApplication).to receive(:new)

      command_instance.application
      expect(Application::Account::AccountApplication).to have_received(:new)
    end

    it 'call Application::Account::TransactionApplication#new when params contain transaction' do
      command_instance = described_class.new({ transaction: { ok: :ok }})
      allow(Application::Transaction::TransactionApplication).to receive(:new)

      command_instance.application
      expect(Application::Transaction::TransactionApplication).to have_received(:new)
    end

    it 'raise error when params contain unknow params' do
      command_instance = described_class.new({ whatever: { ok: :ok }})
      expect { command_instance.application }.to raise_error(Application::Operation::Errors::ApplicationNotFound)
    end
  end
end
