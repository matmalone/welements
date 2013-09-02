# -*- ruby -*-

ENV['RUBYOPT'] = '-W1'

require 'rubygems'
# gem 'echoe', '~>4.6'
require 'echoe'
require './lib/welements.rb'

# Echoe.new('welements', Welements::VERSION) do |p|
#   p.runtime_dependencies = [Gem::Dependency.new(),
#                             Gem::Dependency.new(),
#                             Gem::Dependency.new('nokogiri', '>= 1.6.0')]
#   p.development_dependencies = [Gem::Dependency.new('ruby-debug', '~> 0.10')]
# end

Gem::Specification.new do |s|
  s.name        = 'welements'
  s.version     = '0.1.3'
  s.description = 'Ruby API for National Weather Service National
  Digital Forecast Database'
  s.authors     = ["Mat Malone"]
  s.email       = 'm2@innnerlogic.org'
  # s.files       = ["lib/example.rb"]
  s.homepage    = 'http://github.com/matmalone/welements'
  s.add_runtime_dependency 'libxml-ruby', '>= 2.2.2'
  s.add_runtime_dependency 'geokit', '>= 1.6.5'
  s.add_runtime_dependency 'nokogiri', '>= 1.6.0'
  s.add_development_dependency 'ruby-debug', '~> 0.10'
end


desc 'Create gemspec and copy it into project root'
task :gemspec => :package do
  File.copy(File.join(File.dirname(__FILE__), 'pkg', "welements-#{Welements::VERSION}", 'welements.gemspec'), File.join(File.dirname(__FILE__), 'welements.gemspec'))
end

# vim: syntax=Ruby
