require File.join(File.dirname(__FILE__), 'test_helper')
class TestForecastParameters < NOAA::TestCase
  XML_DOC = LibXML::XML::Document.file(File.join(File.dirname(__FILE__), 'data', 'forecast_parameters.xml'))

  def test_starts
    assert_equal Time.parse('2011-12-16T13:00:00-08:00'), forecast.starts, 'forecast starts at 2011-12-16 1pm'
  end

  def test_ends
    assert_equal Time.parse('2011-12-23T16:00:00-08:00'), forecast.ends, 'forecast ends at 2011-12-07 4pm'
  end

  def test_probability_of_precipitation
    pops = forecast.probability_of_precipitation
    assert_equal({:value => 14, :time => Time.parse('2011-12-16T16:00:00-08:00')}, pops[0])
    assert_equal({:value => 14, :time => Time.parse('2011-12-17T04:00:00-08:00')}, pops[1])
    assert_equal({:value => 14, :time => Time.parse('2011-12-17T16:00:00-08:00')}, pops[2])
    assert_equal({:value => 25, :time => Time.parse('2011-12-23T04:00:00-08:00')}, pops[13])
    assert_equal 14, pops.length, "14 pop metrics"
  end

  def test_relative_humidity
    rh = forecast.relative_humidity
    assert_equal({:value => 64, :time => Time.parse('2011-12-17T01:00:00-08:00')}, rh[0])
    assert_equal({:value => 64, :time => Time.parse('2011-12-17T04:00:00-08:00')}, rh[1])
    assert_equal({:value => 53, :time => Time.parse('2011-12-17T07:00:00-08:00')}, rh[2])
    assert_equal({:value => 65, :time => Time.parse('2011-12-23T16:00:00-08:00')}, rh[37])
    assert_equal 38, rh.length, "38 RH values"
  end

  def xml
    @xml ||= NOAA::HttpService.new.get_forecast_parameters(2, 40, -120)
  end

  def forecast
    @forecast ||= NOAA::ForecastParameters.from_xml(XML_DOC)
  end
end
