require 'rails_helper'

RSpec.describe Application::Transaction::Commands::CreateTransactionCommand do
  let(:account) { double(availableLimit: 100, activeCard: true, id: 1) }
  let(:params_without) {{ account: account, account_id: 1, merchant: 'foo', amount: 1, time: '2019-02-13T10:00:00.000Z' }}
  let(:params_with_transformation) {{ account: account, account_id: 1, merchant: 'foo', amount: 1, time: Time.parse('2019-02-13T10:00:00.000Z') }}

  let(:instance_of_transaction_repository) { double }
  let(:instance_of_domain) { double }
  let(:instance_of_serializer) { double }

  before do
    allow(Infra::Events::Responders::TransactionCreatorResponder).to receive(:call)

    allow(Infra::Api::Serializers::TransactionSerializer).to receive(:new).and_return(instance_of_serializer)
    allow(instance_of_serializer).to receive(:serialized_json)

    allow(Infra::Repositories::TransactionRepository).to receive(:new).and_return(instance_of_transaction_repository)
    allow(instance_of_transaction_repository).to receive(:new_record).with(params_with_transformation).and_return(instance_of_domain)

    allow(Infra::Repositories::AccountRepository).to receive(:new).and_return(double(find_last: account))

    allow(instance_of_domain).to receive(:save)
    allow(instance_of_domain).to receive(:valid?)
  end

  describe '#save' do
    it 'call method save of transaction repository' do
      described_class.new(params_without).save
      expect(instance_of_transaction_repository).to have_received(:new_record).once
      expect(instance_of_domain).to have_received(:save).once
    end
  end

  describe '#response' do
    it 'call method response of api serializer' do
      described_class.new(params_without).response
      expect(instance_of_serializer).to have_received(:serialized_json).once
    end
  end

  describe '#valid?' do
    it 'call method valid? of transaction repository' do
      described_class.new(params_without).valid?
      expect(instance_of_transaction_repository).to have_received(:new_record).once
      expect(instance_of_domain).to have_received(:valid?).once
    end
  end

  describe '#dispatch_event' do
    it 'call method dispatch_event of transaction repository' do
      described_class.new(params_without).dispatch_event
      expect(Infra::Events::Responders::TransactionCreatorResponder).to have_received(:call).once
    end
  end
end
