require 'rails_helper'

RSpec.describe Application::Operation::OperationApplication do
  let(:instance_of_operation_command) { double }

  describe '#application' do
    it 'call instance of Application::Operation::Commands::CreateOperationCommand#application' do
      allow(Application::Operation::Commands::CreateOperationCommand).to receive(:new).and_return(instance_of_operation_command)
      allow(instance_of_operation_command).to receive(:application)

      described_class.new.application

      expect(instance_of_operation_command).to have_received(:application)
    end
  end
end
