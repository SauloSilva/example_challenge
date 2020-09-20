require 'rails_helper'

RSpec.describe Web::Controllers::OperationsController, type: :controller do
  it { expect(described_class).to be < ActionController::API }

  describe 'POST #create' do
    context 'when raise Application::Operation::Errors::ApplicationNotFound' do
      let(:params) {{ operation: { account: { availableLimit: 100, activeCard: true } } }}
      before do
        allow(Application::Operation::OperationApplication).to receive(:new).and_raise(Application::Operation::Errors::ApplicationNotFound)
        post :create, params: params
      end

      it 'response status of 422 with message of error' do
        expect(JSON.parse(response.body).symbolize_keys).to eq({ message: 'Application not found' })
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when operation type is account or transaction' do
      let(:params) {{ operation: { account: { availableLimit: 100, activeCard: true } } }}
      let(:response_body) { { message: 'whatever' } }
      let!(:application_instance) { double }

      before do
        application_operation_instance = double
        allow(Application::Operation::OperationApplication).to receive(:new).and_return(application_operation_instance)
        allow(application_operation_instance).to receive(:application).and_return(application_instance)

        allow(application_instance).to receive(:valid?).and_return(valid)
        allow(application_instance).to receive(:dispatch_event)
        allow(application_instance).to receive(:save)
        allow(application_instance).to receive(:response).and_return(response_body)

        post :create, params: params
      end

      context 'when invalid operation' do
        let(:valid) { false }

        it 'response status of 422 and call valid? and response method of application instance' do
          expect(response).to have_http_status(:unprocessable_entity)
          expect(JSON.parse(response.body).symbolize_keys).to eq(response_body)

          expect(application_instance).to have_received(:valid?).once
          expect(application_instance).to have_received(:response).once
        end
      end

      context 'when valid operation' do
        let(:valid) { true }

        it 'response status of 201 and call valid?, save, dispatch_event and response method of application instance' do
          expect(response).to have_http_status(:created)
          expect(JSON.parse(response.body).symbolize_keys).to eq(response_body)

          expect(application_instance).to have_received(:valid?).once
          expect(application_instance).to have_received(:dispatch_event).once
          expect(application_instance).to have_received(:save).once
          expect(application_instance).to have_received(:response).once
        end
      end
    end
  end
end
