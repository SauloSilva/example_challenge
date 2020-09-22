require_relative 'lib/core/version'

Gem::Specification.new do |spec|
  spec.name          = 'core'
  spec.version       = Core::VERSION
  spec.authors       = ['Saulo Santiago']
  spec.email         = ['saulodasilvasantiago@gmail.com']

  spec.summary       = 'Core configs'
  spec.description   = 'Microservices core funcionalities and patterns'
  spec.homepage      = 'http://core.com'
  spec.required_ruby_version = Gem::Requirement.new(">= 2.7.1")

  spec.metadata["homepage_uri"] = spec.homepage

  spec.add_dependency 'activesupport', '6.0.3.3'
  spec.add_dependency 'activerecord', '6.0.3.3'
  spec.add_dependency 'activerecord-nulldb-adapter', '0.4.0'
  spec.add_dependency 'avro_turf', '1.3.0'
  spec.add_dependency 'dry-struct', '1.3.0'
  spec.add_dependency 'karafka', '1.3.6'
  spec.add_dependency 'dotenv', '2.1.1'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["app/layers", "lib"]
end
