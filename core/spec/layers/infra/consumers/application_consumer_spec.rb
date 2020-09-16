require 'spec_helper'

class FakeClass < Infra::Consumers::ApplicationConsumer
  def consume; end
end

RSpec.describe Infra::Consumers::ApplicationConsumer do
  subject(:consumer) { FakeClass.new(double(backend: :inline, name: 'foo', batch_consuming: false, batch_fetching: false, responder: false)) }

  describe '#call' do
    it 'when skip_event? is false, returns ok' do
      allow(consumer).to receive(:params).and_return(double(headers: { 'target_consumer' => 'bar' }))
      allow(consumer).to receive(:respond_to?).with(:params).and_return(false)
      allow(consumer).to receive(:topic).and_return(double(id: 'bar'))
      allow(consumer).to receive(:process).and_return('ok')

      expect(consumer.call).to eq('ok')
    end

    it 'when skip_event? is true, nothings returns' do
      allow(consumer).to receive(:params).and_return(double(headers: { 'target_consumer' => 'bar' }))
      allow(consumer).to receive(:respond_to?).with(:params).and_return(true)
      allow(consumer).to receive(:topic).and_return(double(id: 'foo'))
      allow(consumer).to receive(:process).and_return('ok')

      expect(consumer.call).to be_nil
    end
  end
end
