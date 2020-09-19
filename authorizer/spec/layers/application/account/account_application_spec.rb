require 'rails_helper'

RSpec.describe Application::Account::AccountApplication do
  let(:instance_of_command) { double }
  let(:params) {{ availableLimit: 100, activeCard: true }}
  let(:account_application) { described_class.new(params) }

  before do
    allow(Application::Account::Commands::CreateAccountCommand).to receive(:new).with(params).and_return(instance_of_command)

    allow(instance_of_command).to receive(:dispatch_event)
    allow(instance_of_command).to receive(:valid?)
    allow(instance_of_command).to receive(:save)
    allow(instance_of_command).to receive(:response)
  end

  describe '#dispatch_event' do
    it 'call instance of Application::Account::Commands::CreateAccountCommand#dispatch_event' do
      account_application.dispatch_event
      expect(instance_of_command).to have_received(:dispatch_event).once
    end
  end

  describe '#valid?' do
    it 'call instance of Application::Account::Commands::CreateAccountCommand#valid?' do
      account_application.valid?
      expect(instance_of_command).to have_received(:valid?)
    end
  end

  describe '#save' do
    it 'call instance of Application::Account::Commands::CreateAccountCommand#save' do
      account_application.save
      expect(instance_of_command).to have_received(:save)
    end
  end

  describe '#response' do
    it 'call instance of Application::Account::Commands::CreateAccountCommand#response' do
      account_application.response
      expect(instance_of_command).to have_received(:response)
    end
  end
end
