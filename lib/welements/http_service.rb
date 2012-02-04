module Welements
  class HttpService #:nodoc:
    def initialize(http = Net::HTTP)
      @HTTP = http
    end

    def get_welements(lat, lng)
      LibXML::XML::Document.string(@HTTP.get(URI.parse("http://graphical.weather.gov/xml/SOAP_server/ndfdXMLclient.php?whichClient=NDFDgen&lat=#{lat}&lon=#{lng}&product=time-series&Unit=m&maxt=maxt&mint=mint&temp=temp&qpf=qpf&pop12=pop12&snow=snow&dew=dew&wspd=wspd&wdir=wdir&sky=sky&wx=wx&waveh=waveh&rh=rh&appt=appt&dryfireo=dryfireo&ptornado=ptornado&phail=phail&wgust=wgust")))
    end

  end
end
