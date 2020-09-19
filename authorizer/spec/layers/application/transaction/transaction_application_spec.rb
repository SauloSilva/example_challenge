require 'rails_helper'

RSpec.describe Application::Transaction::TransactionApplication do
  let(:instance_of_command) { double }
  let(:params) {{ account: { availableLimit: 100, activeCard: true }, account_id: 1, merchant: 'foo', amount: 1, time: '2019-02-13T10:00:00.000Z' }}
  let(:transaction_application) { described_class.new(params) }

  before do
    allow(Application::Transaction::Commands::CreateTransactionCommand).to receive(:new).with(params).and_return(instance_of_command)

    allow(instance_of_command).to receive(:dispatch_event)
    allow(instance_of_command).to receive(:valid?)
    allow(instance_of_command).to receive(:save)
    allow(instance_of_command).to receive(:response)
  end

  describe '#dispatch_event' do
    it 'call instance of Application::Transaction::Commands::CreateTransactionCommand#dispatch_event' do
      transaction_application.dispatch_event
      expect(instance_of_command).to have_received(:dispatch_event).once
    end
  end

  describe '#valid?' do
    it 'call instance of Application::Transaction::Commands::CreateTransactionCommand#valid?' do
      transaction_application.valid?
      expect(instance_of_command).to have_received(:valid?)
    end
  end

  describe '#save' do
    it 'call instance of Application::Transaction::Commands::CreateTransactionCommand#save' do
      transaction_application.save
      expect(instance_of_command).to have_received(:save)
    end
  end

  describe '#response' do
    it 'call instance of Application::Transaction::Commands::CreateTransactionCommand#response' do
      transaction_application.response
      expect(instance_of_command).to have_received(:response)
    end
  end
end
