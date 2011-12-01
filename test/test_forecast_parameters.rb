require File.join(File.dirname(__FILE__), 'test_helper')

class TestForecastParameters < NOAA::TestCase
  XML_DOC = LibXML::XML::Document.file(File.join(File.dirname(__FILE__), 'data', 'forecast_parameters_2_day.xml'))

  def test_forecast_parameters
    puts forecast.maxima_info
  end

  def xml
    @xml ||= NOAA::HttpService.new.get_forecast_parameters(2, 40, -120)
  end

  def forecast
    @forecast ||= NOAA::ForecastParameters.from_xml(XML_DOC)
  end
end
