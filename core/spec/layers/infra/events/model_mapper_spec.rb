require 'spec_helper'

RSpec.describe Infra::Events::ModelMapper do
  subject(:mapper) { described_class }

  describe '.call' do
    it 'initializes and calls' do
      mapper_instance = instance_double(described_class)
      topic_name = 'le-topic-name'
      allow(described_class).to receive(:new).with(topic_name).and_return(mapper_instance)

      expect(mapper_instance).to receive(:call)

      described_class.call(topic_name)
    end
  end

  describe '#call' do
    it 'returns a model class when found' do
      mapper = described_class.new('account_create')

      expect(mapper.call).to eq(Infra::Events::Models::AccountCreate)
    end

    it 'raises error when model not found' do
      mapper = described_class.new('account_created_yesterday')

      expect { mapper.call }.to raise_error(
        described_class::ModelNotFoundError,
        "Not found 'Infra::Events::Models::AccountCreatedYesterday' model"
      )
    end
  end
end
