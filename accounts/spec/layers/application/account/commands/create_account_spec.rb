require 'spec_helper'

RSpec.describe Application::Account::Commands::CreateAccount do
  let(:params) do
    {
      available_limit: 100,
      active_card: true,
    }
  end

  describe 'request' do
    it 'call RequestBinCaller#post' do
      event_model = Infra::Events::Models::AccountCreate.new(params)
      account_command = described_class.new(event_model)
      instance_of_lib = double

      allow(RequestBinCaller).to receive(:new).with(attrs: params).and_return(instance_of_lib)
      allow(instance_of_lib).to receive(:post)

      account_command.request
      expect(instance_of_lib).to have_received(:post)
    end
  end
end
