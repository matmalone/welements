require File.join(File.dirname(__FILE__), 'test_helper')
class TestIntegration < Welements::TestCase
  def test_integration
    forecast = Welements.welements(34.5, -120)
    assert(forecast.probability_of_precipitation.length > 3, "make
sure we get some number of days of results")
    assert(forecast.temperature_hourly[0][:value] > 1, "temperature in Santa
Barbara should be greater than 1 C")
  end
end
