require 'spec_helper'

RSpec.describe Infra::Events::Models::AccountCreate do
  let(:model) { described_class.new(attrs) }

  describe '#incorrect keys' do
    let(:attrs) do
      {
        available_limit: '1',
        active_card: nil
      }
    end

    it 'returns error of parser attrs' do
      expect { model }.to raise_error(Dry::Struct::Error)
    end
  end

  describe '#correct keys' do
    let(:attrs) do
      {
        available_limit: 1,
        active_card: true
      }
    end

    it 'returns methods of available_limit and active_card' do
      expect(model.available_limit).to eq(1)
      expect(model.active_card).to be_truthy
    end
  end
end
