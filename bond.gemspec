# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bond/version'

Gem::Specification.new do |spec|
  spec.name          = 'bond-ruby'
  spec.version       = Bond::VERSION
  spec.authors       = ['John Gerhardt']
  spec.email         = ['jgerhardt@contactually.com']

  spec.summary       = %q{Bond API Ruby Wrapper}
  spec.description   = %q{This gem helps wrap Bond's API in a easy-to-use ruby gem.}
  spec.homepage      = 'https://hellobond.com'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  else
    raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.'
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'codeclimate-test-reporter'
  spec.add_development_dependency 'vcr'
  spec.add_development_dependency 'webmock'
  spec.add_development_dependency 'byebug'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'faraday'
  spec.add_development_dependency 'json'
end
