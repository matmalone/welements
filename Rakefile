# -*- ruby -*-

ENV['RUBYOPT'] = '-W1'

require 'rubygems'
gem 'echoe', '~>4.6'
require 'echoe'
require './lib/welements.rb'

Echoe.new('welements', Welements::VERSION) do |p|
  p.name = 'welements'
  p.author = 'Mat Malone'
  p.description = 'Ruby API for National Weather Service National
  Digital Forecast Database'
  p.email = 'm2@innerlogic.org'
  p.url = 'http://github.com/matmalone/welements'
  p.install_message = ""
  p.runtime_dependencies = [Gem::Dependency.new('libxml-ruby', '>= 0.9.7'),
                            Gem::Dependency.new('geokit', '>= 1.5.0')]
  p.development_dependencies = [Gem::Dependency.new('ruby-debug', '~> 0.10')]
end

desc 'Create gemspec and copy it into project root'
task :gemspec => :package do
  File.copy(File.join(File.dirname(__FILE__), 'pkg', "welements-#{Welements::VERSION}", 'welements.gemspec'), File.join(File.dirname(__FILE__), 'welements.gemspec'))
end

# vim: syntax=Ruby
