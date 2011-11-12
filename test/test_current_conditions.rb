require File.join(File.dirname(__FILE__), 'test_helper')

class TestCurrentConditions < NOAA::TestCase
  XML_DOC = LibXML::XML::Document.file(File.join(File.dirname(__FILE__), 'data', 'KVAY.xml'))

  def test_should_return_observation_time
    assert_equal conditions.observed_at, Time.parse('2008-12-23 10:54:00 -0500')
  end

  def test_should_return_weather_description
    assert_equal conditions.weather_description, 'Fair'
  end

  def test_should_return_weather_description_from_weather_summary
    assert_equal conditions.weather_summary, 'Fair'
  end

  def test_should_return_weather_type_code
    assert_equal conditions.weather_type_code, :skc
  end

  def test_should_return_image_URL
    assert_equal conditions.image_url, 'http://weather.gov/weather/images/fcicons/skc.jpg'
  end

  def test_should_return_temperature_in_fahrenheit_by_default
    assert_equal conditions.temperature, 24
  end

  def test_should_return_temperature_in_fahrenheit_when_specified
    assert_equal conditions.temperature(:f), 24
  end

  def test_should_return_temperature_in_celsius_when_specified
    assert_equal conditions.temperature(:c), -4
  end

  def test_should_raise_ArgumentError_if_unknown_unit_specified_for_temperature
    assert_raise(ArgumentError){ conditions.temperature(:kelvin) }
  end

  def test_should_return_relative_humidity
    assert_equal conditions.relative_humidity, 52
  end

  def test_should_return_wind_direction
    assert_equal conditions.wind_direction, 'Northwest'
  end

  def test_should_return_wind_degrees
    assert_equal conditions.wind_degrees, 330
  end

  def test_should_return_wind_speed_in_MPH
    assert_equal conditions.wind_speed, 3.45
  end

  def test_should_return_wind_gust_in_MPH
    assert_equal conditions.wind_gust, 10.25
  end

  #TODO wind gust can be NA
  
  def test_should_return_pressure_in_inches_by_default
    assert_equal conditions.pressure, 30.7
  end

  def test_should_return_pressure_in_inches_when_specified
    assert_equal conditions.pressure(:in), 30.7
  end

  def test_should_return_pressure_in_millibars_when_specified
    assert_equal conditions.pressure(:mb), 1039.5
  end

  def test_should_throw_ArgumentError_when_unrecognized_pressure_specified_for_pressure
    assert_raise(ArgumentError){ conditions.pressure(:psi) }
  end

  def test_should_return_dew_point_in_fahrenheit_by_default
    assert_equal conditions.dew_point, 9
  end

  def test_should_return_dew_point_in_fahrenheit_when_specified
    assert_equal conditions.dew_point(:f), 9
  end

  def test_should_return_dew_point_in_celsius_when_specified
    assert_equal conditions.dew_point(:c), -13
  end

  def test_should_throw_ArgumentError_when_unrecognized_unit_specified_for_dew_point
    assert_raise(ArgumentError){ conditions.dew_point(:kelvin) }
  end

  #TODO heat index can be NA

  def test_should_return_heat_index_in_fahrenheit_by_default
    assert_equal conditions.heat_index, 105
  end

  def test_should_return_heat_index_in_fahrenheit_when_specified
    assert_equal conditions.heat_index(:f), 105
  end

  def test_should_return_heat_index_in_celsius_when_specified
    assert_equal conditions.heat_index(:c), 41
  end

  def test_should_throw_ArgumentError_when_unrecognized_unit_specified_for_heat_index
    assert_raise(ArgumentError){ conditions.heat_index(:kelvin) }
  end

  #TODO wind chill can be NA

  def test_should_return_wind_chill_in_fahrenheit_by_default
    assert_equal conditions.wind_chill, 19
  end

  def test_should_return_wind_chill_in_fahrenheit_when_specified
    assert_equal conditions.wind_chill(:f), 19
  end

  def test_should_return_wind_chill_in_celsius_when_specified
    assert_equal conditions.wind_chill(:c), -7
  end

  def test_hould_throw_ArgumentError_when_unrecognized_unit_specified_for_wind_c
    assert_raise(ArgumentError){ conditions.wind_chill(:kelvin) }
  end

  def test_should_return_visibility_in_miles
    assert_equal conditions.visibility, 10.0
  end

  private

  def conditions
    @conditions ||= NOAA::CurrentConditions.from_xml(XML_DOC)
  end
end
