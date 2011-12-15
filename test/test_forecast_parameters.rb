require File.join(File.dirname(__FILE__), 'test_helper')
class TestForecastParameters < NOAA::TestCase
  XML_DOC = LibXML::XML::Document.file(File.join(File.dirname(__FILE__), 'data', 'forecast_parameters_2_day.xml'))

  def test_starts
    assert_equal forecast.starts, Time.parse('2011-11-30T16:00:00-08:00'), 'forecast starts at 2011-11-30 4pm'
  end

  def test_ends
    assert_equal forecast.ends, Time.parse('2011-12-07T19:00:00-08:00'), 'forecast ends at 2011-12-07 4pm'
  end

  def test_probability_of_precipitation
    pops = forecast.probability_of_precipitation
    assert_equal({:value => 6, :time => Time.parse('2011-11-30T16:00:00-08:00')}, pops[0])
    assert_equal({:value => 0, :time => Time.parse('2011-12-01T04:00:00-08:00')}, pops[1])
    assert_equal({:value => 1, :time => Time.parse('2011-12-01T16:00:00-08:00')}, pops[2])
  end

  def xml
    @xml ||= NOAA::HttpService.new.get_forecast_parameters(2, 40, -120)
  end

  def forecast
    @forecast ||= NOAA::ForecastParameters.from_xml(XML_DOC)
  end
end
