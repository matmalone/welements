require File.join(File.dirname(__FILE__), 'test_helper')
class TestForecastParameters < Welements::TestCase
  XML_DOC = LibXML::XML::Document.file(File.join(File.dirname(__FILE__), 'data', 'welements.xml'))

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

  def test_temperature_maximum
    vals = forecast.temperature_maximum
    assert_equal({:value => 6, :time => Time.parse('2011-12-17T07:00:00-05:00')}, vals[0])
    assert_equal({:value => 8, :time => Time.parse('2011-12-23T07:00:00-05:00')}, vals[6])
    assert_equal 7, vals.length, "7 max values"
  end
  
  def test_temperature_minimum
    vals = forecast.temperature_minimum
    assert_equal({:value => 2, :time => Time.parse('2011-12-16T19:00:00-05:00')}, vals[0])
    assert_equal({:value => 3, :time => Time.parse('2011-12-22T19:00:00-05:00')}, vals[6])
    assert_equal 7, vals.length, "7 min values"
  end
  
  def test_temperature_hourly
    vals = forecast.temperature_hourly
    assert_equal({:value => 3, :time => Time.parse('2011-12-17T04:00:00-05:00')}, vals[0])
    assert_equal 38, vals.length, "38 values"
  end
  
  def test_temperature_dew_point
    vals = forecast.temperature_dew_point
    assert_equal({:value => -3, :time => Time.parse('2011-12-17T04:00:00-05:00')}, vals[0])
    assert_equal 38, vals.length, "38 values"
  end
  
  def test_temperature_apparent
    vals = forecast.temperature_apparent
    assert_equal({:value => 0, :time => Time.parse('2011-12-17T04:00:00-05:00')}, vals[0])
    assert_equal 38, vals.length, "38 values"
  end
  
  def test_precipitation_liquid
    vals = forecast.precipitation_liquid
    assert_equal({:value => 0.00, :time => Time.parse('2011-12-17T01:00:00-05:00')}, vals[0])
    assert_equal 11, vals.length, "11 values"
  end
  
  def test_precipitation_snow
    vals = forecast.precipitation_snow
    assert_equal({:value => 0.00, :time => Time.parse('2011-12-17T01:00:00-05:00')}, vals[0])
    assert_equal 7, vals.length, "7 values"
  end
  
  def test_wind_speed_sustained
    vals = forecast.wind_speed_sustained
    assert_equal({:value => 3, :time => Time.parse('2011-12-17T04:00:00-05:00')}, vals[0])
    assert_equal 38, vals.length, "38 values"
  end
  
  def test_wind_speed_gust
    vals = forecast.wind_speed_gust
    assert_equal({:value => 4, :time => Time.parse('2011-12-17T04:00:00-05:00')}, vals[0])
    assert_equal 22, vals.length, "22 values"
  end
  
  def test_wind_direction
    vals = forecast.wind_direction
    assert_equal({:value => 300, :time => Time.parse('2011-12-17T04:00:00-05:00')}, vals[0])
    assert_equal 38, vals.length, "38 values"
  end
  
  def test_cloud_cover
    vals = forecast.cloud_cover
    assert_equal({:value => 59, :time => Time.parse('2011-12-17T04:00:00-05:00')}, vals[0])
    assert_equal 38, vals.length, "38 values"
  end
  
  def test_fire_outlook_from_dry_thunderstorms
    vals = forecast.fire_outlook_from_dry_thunderstorms
    assert_equal({:value => 'No Areas', :time => Time.parse('2011-12-16T16:00:00-05:00')}, vals[0])
    assert_equal 3, vals.length, "3 values"
  end
  
  def xml
    @xml ||= Welements::HttpService.new.get_welements(2, 40, -120)
  end

  def forecast
    @forecast ||= Welements::ForecastParameters.from_xml(XML_DOC)
  end
end
