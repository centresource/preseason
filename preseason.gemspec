# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'preseason/version'

Gem::Specification.new do |spec|
  spec.required_ruby_version = '>= 1.9.2'
  spec.name          = "preseason"
  spec.version       = Preseason::VERSION
  spec.authors       = ["Centresource Interactive Agency"]
  spec.email         = ["dev@centresource.com"]
  spec.description   = %q{An opinionated Rails application starter kit}
  spec.summary       = %q{We start a lot of new Rails projects; this gem is intended to reduce that spin up time by bringing in the tools we use in one fell swoop.}
  spec.homepage      = "https://github.com/centresource/preseason"
  spec.license       = "MIT"

  spec.add_dependency "rails"
  spec.add_development_dependency "pry"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = ["preseason"]
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
