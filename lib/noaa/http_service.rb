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

    def get_elements(lat, lng)
      LibXML::XML::Document.string(@HTTP.get(URI.parse("http://graphical.weather.gov/xml/SOAP_server/ndfdXMLclient.php?whichClient=NDFDgen&lat=#{lat}&lon=#{lng}&product=time-series&Unit=m&maxt=maxt&mint=mint&temp=temp&qpf=qpf&pop12=pop12&snow=snow&dew=dew&wspd=wspd&wdir=wdir&sky=sky&wx=wx&waveh=waveh&rh=rh&appt=appt&dryfireo=dryfireo&ptornado=ptornado&phail=phail&wgust=wgust")))
    end

    def get_station_list
      LibXML::XML::Document.string(@HTTP.get(URI.parse("http://www.weather.gov/xml/current_obs/index.xml")))
    end
  end
end
