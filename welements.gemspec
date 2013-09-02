# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'welements/version'

Gem::Specification.new do |spec|
  spec.name          = "welements"
  spec.version       = Welements::VERSION
  spec.authors       = ["Mat Malone"]
  spec.email         = ["m2@innerlogic.org"]
  spec.description   = %q{Ruby API for National Oceanic and Atmospheric Administration weather data}
  spec.summary = %q{Ruby API for the National Weather Service's National Digital Forecast Database (NDFD)}
  spec.homepage      = "http://github.com/matmalone/welements"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"

  spec.add_runtime_dependency('nokogiri', '~> 1.5.0')
  spec.add_runtime_dependency('geokit', '>= 1.6.5')
  spec.add_runtime_dependency('libxml-ruby', '>= 2.2.2')

end
