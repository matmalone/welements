require File.join(File.dirname(__FILE__), 'test_helper')

class TestForecast < ::Test::Unit::TestCase #NOAA::TestCase
  XML_DOC = LibXML::XML::Document.file(File.join(File.dirname(__FILE__), 'data', '4-day.xml'))
  
  def test_should_return_number_of_days
    assert_equal forecast.length, 4
  end

  def test_return_correct_start_time_for_day
    ['2008-12-23', '2008-12-24', '2008-12-25', '2008-12-26'].each_with_index do |date, i|
      assert_equal forecast[i].starts_at, Time.parse("#{date} 06:00:00 -05:00"), "return correct start time for day #{i}"
    end
  end

  def test_return_correct_end_time_for_day
    ['2008-12-24', '2008-12-25', '2008-12-26', '2008-12-27'].each_with_index do |date, i|
      assert_equal forecast[i].ends_at, Time.parse("#{date} 06:00:00 -05:00"), "return correct end time for day #{i}"
    end
  end

  def test_return_correct_high_for_day
    [32, 49, 43, 41].each_with_index do |temp, i|
      assert_equal forecast[i].high, temp, "return correct high for day #{i}"
    end
  end

  def test_return_correct_low_for_day
    [31, 41, 33, 39].each_with_index do |temp, i|
      assert_equal forecast[i].low, temp, "return correct low for day #{i}"
    end
  end

  def test_return_correct_weather_summary_for_day
    ['Rain', 'Rain', 'Slight Chance Rain', 'Chance Rain'].each_with_index do |summary, i|
      assert_equal forecast[i].weather_summary, summary, "return correct weather summary for day #{i}"
    end
  end

  def test_return_correct_weather_type_code_for_day
    4.times do |i|
      assert_equal forecast[i].weather_type_code, :ra, "return correct weather type code for day #{i}"
    end
  end

  def test_should_return_correct_image_URL_for_day_#{i}_do
    [80, 90, 20, 50].each_with_index do |probability, i|
      assert_equal forecast[i].image_url, "http://www.nws.noaa.gov/weather/images/fcicons/ra#{probability}.jpg", "return correct image URL for day #{i}"
    end
  end

  def test_return_correct_daytime_probability_of_precipitation_for_day
    [5, 94, 22, 50].each_with_index do |probability, i|
      assert_equal forecast[i].daytime_precipitation_probability, probability, "return correct daytime probability of precipitation for day #{i}"
    end
  end

  def test_return_correct_evening_probability_of_precipitation_for_day
    [77, 84, 19, 50].each_with_index do |probability, i|
      assert_equal forecast[i].evening_precipitation_probability, probability, "return correct evening probability of precipitation for day #{i}"
    end
  end

  private

  def forecast
    @forecast ||= NOAA::Forecast.from_xml(XML_DOC)
  end
end
