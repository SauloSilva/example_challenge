require 'json'
require 'net/http'

class RequestBinCaller
  attr_reader :uri, :req

  def initialize(params = {})
    url = params.fetch(:url) { 'https://eny44nhjua6vj5d.m.pipedream.net' }
    attrs = params.fetch(:attrs) { {} }

    @uri = URI(url)
    @req = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
    @req.body = attrs.to_json
  end

  def post
    Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https') do |http|
      http.request(req)
    end
  end
end
