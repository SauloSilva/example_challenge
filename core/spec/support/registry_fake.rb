require 'webmock/rspec'

RSpec.configure do |config|
  config.before(:each) do
    WebMock.stub_request(:post, 'https://4eb16a200c5e4f95ffa4b36d02c58a4b.m.pipedream.net').to_return(body: "ok")
  end
end
