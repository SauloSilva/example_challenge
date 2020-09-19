require 'rails_helper'

RSpec.describe Application::Account::Commands::CreateAccountCommand do
  let(:params_with_transformation) do
    { available_limit: 100, active_card: true }
  end

  let(:params_without_transformation) do
    { availableLimit: 100, activeCard: true }
  end

  let(:instance_of_account_repository) { double }
  let(:instance_of_domain) { double }
  let(:instance_of_serializer) { double }

  before do
    allow(Infra::Events::Responders::AccountCreatorResponder).to receive(:call)

    allow(Infra::Api::Serializers::AccountSerializer).to receive(:new).and_return(instance_of_serializer)
    allow(instance_of_serializer).to receive(:serialized_json)

    allow(Infra::Repositories::AccountRepository).to receive(:new).and_return(instance_of_account_repository)
    allow(instance_of_account_repository).to receive(:new_record).with(params_with_transformation).and_return(instance_of_domain)

    allow(instance_of_domain).to receive(:save)
    allow(instance_of_domain).to receive(:valid?)
  end

  describe '#save' do
    it 'call method save of account repository' do
      described_class.new(params_without_transformation).save
      expect(instance_of_account_repository).to have_received(:new_record).once
      expect(instance_of_domain).to have_received(:save).once
    end
  end

  describe '#response' do
    it 'call method response of api serializer' do
      described_class.new(params_without_transformation).response
      expect(instance_of_serializer).to have_received(:serialized_json).once
    end
  end

  describe '#valid?' do
    it 'call method valid? of account repository' do
      described_class.new(params_without_transformation).valid?
      expect(instance_of_account_repository).to have_received(:new_record).once
      expect(instance_of_domain).to have_received(:valid?).once
    end
  end

  describe '#dispatch_event' do
    it 'call method dispatch_event of account repository' do
      described_class.new(params_without_transformation).dispatch_event
      expect(Infra::Events::Responders::AccountCreatorResponder).to have_received(:call).once
    end
  end
end
