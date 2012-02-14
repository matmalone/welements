# -*- encoding: utf-8 -*-

$: << File.expand_path(File.join(File.dirname(__FILE__), 'lib'))
require 'welements/version'

Gem::Specification.new do |s|
  s.name = %q{welements}
  s.version = Welements::VERSION

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Mat Malone"]
  s.date = Date.today
  s.description = %q{Ruby API for National Oceanic and Atmospheric Administration weather data}
  s.email = %q{m2@innerlogic.org}
  s.files = Dir.glob('{lib,test}/**/*') + %w(CHANGELOG README.md)
  s.has_rdoc = true
  s.homepage = %q{http://github.com/matmalone/welements}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Welements", "--main", "README"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{welements}
  s.rubygems_version = %q{1.8.15}
  s.summary = %q{Ruby API for the National Weather Service's National Digital Forecast Database (NDFD)}
  s.test_files = ["test/test_helper.rb", "test/test_http_service.rb", "test/test_welements.rb", "test/test_integration.rb"]
  s.add_runtime_dependency('nokogiri', '>= 1.5.0')
  s.add_runtime_dependency('geokit', '>= 1.6.5')
  s.add_runtime_dependency('libxml-ruby', '>= 2.2.2')
end
