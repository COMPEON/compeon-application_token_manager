lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'compeon/application_token_manager/version'

Gem::Specification.new do |spec|
  spec.name          = 'compeon-application_token_manager'
  spec.version       = Compeon::ApplicationTokenManager::VERSION
  spec.authors       = ['Timo Schilling']
  spec.email         = ['timo@schilling.io']

  spec.summary       = 'COMPEON Application Token Manager'
  spec.description   = 'COMPEON Application Token Manager'
  spec.homepage      = 'https://github.com/COMPEON/compeon-application_token_manager'
  spec.license       = 'MIT'

  spec.metadata['allowed_push_host'] = 'https://rubygems.pkg.github.com/COMPEON'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.require_paths = ['lib']

  spec.add_dependency 'aws-sdk-ssm', '~> 1.0'

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'rake', '~> 10.0'
end
