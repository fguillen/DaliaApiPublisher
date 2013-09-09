# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dalia_api_publisher/version'

Gem::Specification.new do |spec|
  spec.name          = "dalia_api_publisher"
  spec.version       = Dalia::Api::Publisher::VERSION
  spec.authors       = ["Fernando Guillen"]
  spec.email         = ["fguillen.mail@gmail.com"]
  spec.description   = "Ruby wrapper for the Dalia's API"
  spec.summary       = "Ruby wrapper for the Dalia's API"
  spec.homepage      = "https://github.com/DaliaResearch/DaliaApiPublisher"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "httparty", "0.11.0"
  spec.add_dependency "recursive-open-struct", "0.4.3"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "fakeweb"
  spec.add_development_dependency "mocha"
end
