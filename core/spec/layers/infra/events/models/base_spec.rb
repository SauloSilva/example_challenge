require 'spec_helper'

RSpec.describe Infra::Events::Models::Base do
  let(:model) { described_class.new(attrs) }

  describe '#incorrect keys' do
    let(:attrs) do
      {
        raw_message: 'foo'
      }
    end

    it 'remove raw_message of attributes and add to method of class' do
      expect(model.attributes).not_to include(:raw_message)
      expect(model.raw_message).to eq('foo')
    end
  end
end
