require 'active_support/core_ext'
require 'active_support/json'
require 'active_record'

require 'dotenv'
Dotenv.load

require 'karafka'
require 'dry-struct'
require 'types'
require 'core/version'
require 'nulldb/rails'

module Core
  def self.root
    File.expand_path '../..', __FILE__
  end

  def self.schemas_path
    File.join(root, 'lib', 'core', 'layers', 'infra', 'events', 'schemas')
  end
end

Dir[File.join(Core.root, 'lib', 'core', '**', '*.rb')].each { |file| p file; require file }
ActiveRecord::Base.establish_connection(adapter: :nulldb, schema: File.join(Core.root, 'db', 'schema.rb'))
