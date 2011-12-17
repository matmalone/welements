require File.join(File.dirname(__FILE__), 'test_helper')

class TestHttpService < NOAA::TestCase
  def setup
    HTTP.reset
  end

  def test_should_send_properly_formed_URL_for_current_conditions
    http_service.get_current_conditions('KNYC')
    assert_equal HTTP.requests, [URI.parse('http://www.weather.gov/xml/current_obs/KNYC.xml')]
  end

  def test_should_send_properly_formed_URL_for_forecast
    http_service.get_forecast(4, 40.72, -73.99)
    assert_equal HTTP.requests, [URI.parse('http://graphical.weather.gov/xml/sample_products/browser_interface/ndfdBrowserClientByDay.php?lat=40.72&lon=-73.99&format=24+hourly&numDays=4')]
  end

  def test_should_get_parseable_results_for_forecast
    doc = NOAA::HttpService.new.get_forecast(4, 40.72, -73.99)
    assert doc.find(%q{/dwml/data/parameters[1]/temperature[1]/value}).map.count == 4
  end

  def test_should_get_parseable_results_for_forecast_parameters
    doc = NOAA::HttpService.new.get_forecast_parameters(40.72, -73.99)
    assert doc.find("/dwml/data/parameters[1]/humidity[1]/value").map.count > 1
  end

  def test_should_return_XML_document_for_forecast
    assert_equal http_service.get_forecast(4, 40.72, -73.99).to_s, %Q{<?xml version="1.0" encoding="UTF-8"?>\n<test/>\n}
  end

  def test_should_send_properly_formed_URL_for_station_list
    http_service.get_station_list
    assert_equal HTTP.requests, [URI.parse('http://www.weather.gov/xml/current_obs/index.xml')]
  end

  def test_should_return_XML_document_for_station_list
    assert_equal http_service.get_station_list.to_s, %Q{<?xml version="1.0" encoding="UTF-8"?>\n<test/>\n}
  end

  private

  def http_service
    NOAA::HttpService.new(HTTP)
  end

  module HTTP
    class << self
      def reset
        requests.clear
      end

      def requests
        @requests ||= []
      end

      def get(uri)
        requests << uri
        "<test/>"
      end
    end
  end
end
