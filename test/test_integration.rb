require File.join(File.dirname(__FILE__), 'test_helper')
class TestIntegration < NOAA::TestCase
  def test_integration
    forecast = NOAA.forecast_parameters(34.5, -120)
    assert(forecast.probability_of_precipitation.length > 3, "make
sure we get some number of days of results")
    assert(forecast.temperature_hourly[0][:value] > -10, "temperature in Santa
Barbara should be at least 10 C")
  end
end
