require 'rails_helper'

RSpec.describe Infra::Api::Serializers::BaseSerializer do
  describe '#violations' do
    let(:repository) do
      double({
        errors: double({
          messages: { amount: ['is not be blank'] }
        })
      })
    end

    let(:serializer) do
      class FakeClass < Infra::Api::Serializers::BaseSerializer
        attr_reader :repository

        def initialize(repository)
          @repository = repository
        end
      end

      FakeClass
    end

    it 'expect return json' do
      serializer_instance = serializer.new(repository)
      expect(serializer_instance.violations).to eq(["amount-is-not-be-blank"])
    end
  end
end
