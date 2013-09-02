begin
  require 'time'
  require 'nokogiri'
  require 'geokit'
rescue LoadError => e
  if require 'rubygems' then retry
  else raise(e)
  end
end

%w(welements http_service).each { |file| require File.join(File.dirname(__FILE__), 'welements', file) }

# 
# The Welements singleton provides methods to conveniently access information from the NWS NDFD feed.
module Welements
  autoload :VERSION, File.join(File.dirname(__FILE__), 'welements', 'version')

  class << self
    # Retrieve complex forecast elements
    def welements(lat, lng)
      ForecastParameters.from_xml(HttpService.new.get_welements(lat, lng))
    end
  end
end
