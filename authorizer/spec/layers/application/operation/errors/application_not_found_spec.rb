require 'rails_helper'

RSpec.describe Application::Operation::Errors::ApplicationNotFound do
  describe '#message' do
    it { expect(described_class).to be < StandardError }

    it 'return string' do
      expect(described_class.new.message).to eq('Application not found')
    end
  end
end
