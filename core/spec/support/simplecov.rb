require 'simplecov'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new(
  SimpleCov::Formatter::HTMLFormatter
)

SimpleCov.start do
  add_filter '/spec/'

  add_group 'Domains', 'app/layers/domain'
  add_group 'Infra/Events', 'app/layers/infra/events'
  add_group 'Infra/Consumers', 'app/layers/infra/consumers'
  add_group 'Lib', 'lib'
  add_group 'DB', 'db'
end
