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

  describe 'request' do
    it 'call RequestBinCaller#post' do
      event_model = Infra::Events::Models::TransactionCreate.new(params)
      account_command = described_class.new(event_model)
      instance_of_lib = double

      allow(RequestBinCaller).to receive(:new).with(attrs: params).and_return(instance_of_lib)
      allow(instance_of_lib).to receive(:post)

      account_command.request
      expect(instance_of_lib).to have_received(:post)
    end
  end
end
