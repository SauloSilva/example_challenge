require 'spec_helper'

RSpec.describe RequestBinCaller do
  describe 'post' do
    it 'call Net::HTTP#request' do
      expect(described_class.new(attrs: {}).post.response.body).to eq('ok')
    end
  end
end
