require 'webmock/rspec'

RSpec.configure do |config|
  config.before(:each) do
    WebMock.stub_request(:post, 'https://eny44nhjua6vj5d.m.pipedream.net').to_return(body: "ok")
  end
end
