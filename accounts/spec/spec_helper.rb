require File.join(File.expand_path('../..', __FILE__), 'spec', 'support', 'simplecov')

require "bundler/setup"
require File.join(File.expand_path('../..', __FILE__), 'karafka')

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"
  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
