require 'simplecov'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new(
  SimpleCov::Formatter::HTMLFormatter
)

SimpleCov.start do
  add_filter '/spec/'

  add_group 'Controllers', 'app/layers/web/controllers'
  add_group 'Domains', 'app/layers/domain'
  add_group 'Application', 'app/layers/application'
  add_group 'Infra/Events', 'app/layers/infra/events'
  add_group 'Infra/Consumers', 'app/layers/infra/consumers'
  add_group 'Infra/Repositories', 'app/layers/infra/repositories'
  add_group 'Infra/API/serializers', 'app/layers/infra/api/serializers'
  add_group 'Lib', 'lib'
  add_group 'DB', 'db'
end
