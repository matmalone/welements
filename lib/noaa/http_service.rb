module NOAA
  class HttpService #:nodoc:
    def initialize(http = Net::HTTP)
      @HTTP = http
    end

    def get_current_conditions(station_id)
      LibXML::XML::Document.string(@HTTP.get(URI.parse("http://www.weather.gov/xml/current_obs/#{station_id}.xml")))
    end

    def get_forecast(num_days, lat, lng)
      LibXML::XML::Document.string(@HTTP.get(URI.parse("http://graphical.weather.gov/xml/sample_products/browser_interface/ndfdBrowserClientByDay.php?lat=#{lat}&lon=#{lng}&format=24+hourly&numDays=#{num_days}")))
    end

    def get_forecast_parameters(num_days, lat, lng)
      LibXML::XML::Document.string(@HTTP.get(URI.parse("http://graphical.weather.gov/xml/SOAP_server/ndfdXMLclient.php?whichClient=NDFDgen&lat=#{lat}&lon=#{lng}&format=24+hourly&numDays=#{num_days}&product=time-series&begin=2004-01-01T00%3A00%3A00&end=2015-11-19T00%3A00%3A00&Unit=e&maxt=maxt&rh=rh&pop12=pop12&mint=mint&icons=icons&wx=wx&wwa=waa")))
    end

    def get_station_list
      LibXML::XML::Document.string(@HTTP.get(URI.parse("http://www.weather.gov/xml/current_obs/index.xml")))
    end
  end
end
