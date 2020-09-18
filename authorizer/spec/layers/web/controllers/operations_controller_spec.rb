require 'rails_helper'

RSpec.describe Web::Controllers::OperationsController, type: :controller do
  describe 'POST #create' do
    context 'when invalid operation' do
      let(:params) {{ operation: { account: { availableLimit: 100, activeCard: true } } }}
      let(:response_body) { { message: 'ok' } }
      let!(:advancement_requests) { double }
      let(:response_body) { { message: 'fail' } }

      before do
        allow(Application::Operation::OperationApplication).to receive(:new).and_return(advancement_requests)
        allow(advancement_requests).to receive(:valid?).and_return(false)
        allow(advancement_requests).to receive(:response).and_return(response_body)

        post :create, params: params
      end

      it 'return the json' do
        expect(response_body).to include JSON.parse(response.body).symbolize_keys

        expect(advancement_requests).to have_received(:valid?).once
        expect(advancement_requests).to have_received(:response).once
      end
    end

    context 'when valid operation' do
      let(:params) do
        {
          'operation' => {
            'account' => {
              'availableLimit' => 100,
              'activeCard' => true
            }
          }
        }
      end
      let(:response_body) { { message: 'ok' } }
      let!(:advancement_requests) { double }

      before do
        allow(Application::Operation::OperationApplication).to receive(:new).and_return(advancement_requests)
        allow(advancement_requests).to receive(:valid?).and_return(true)
        allow(advancement_requests).to receive(:dispatch_event)
        allow(advancement_requests).to receive(:save)
        allow(advancement_requests).to receive(:response).and_return(response_body)

        post :create, params: params
      end

      it 'return the json and call dispatch_event and save methods' do
        expect(response_body).to include JSON.parse(response.body).symbolize_keys

        expect(advancement_requests).to have_received(:valid?).once
        expect(advancement_requests).to have_received(:dispatch_event).once
        expect(advancement_requests).to have_received(:save).once
        expect(advancement_requests).to have_received(:response).once
      end
    end
  end
end
