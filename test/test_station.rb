require File.join(File.dirname(__FILE__), 'test_helper')

class TestStation < NOAA::TestCase
  def setup
    NOAA::Station.stations_file = File.join(File.dirname(__FILE__), 'data', 'stations.yml')
  end

  def teardown 
    NOAA::Station.stations_file = nil
  end

  def test_should_load_station_by_id
    assert_equal NOAA::Station.find('KNYC').id, 'KNYC'
  end

  def test_should_find_closest_to_coordinates
    assert_equal NOAA::Station.closest_to(GeoKit::LatLng.new(40.8, -73.96)).id, 'KNYC'
  end

  def test_should_find_closest_to_lat_lng
    assert_equal NOAA::Station.closest_to(40.8, -73.96).id, 'KNYC'
  end

  def test_should_find_closest_to_lat_lng_passed_as_array
    assert_equal NOAA::Station.closest_to([40.8, -73.96]).id, 'KNYC'
  end

  def test_should_throw_ArgumentError_if_bad_argument_passed_into_closest_to
    assert_raise(ArgumentError){ NOAA::Station.closest_to('hey') }
  end

  def test_should_throw_ArgumentError_if_more_than_two_arguments_passed_into_closest_to
    assert_raise(ArgumentError){ NOAA::Station.closest_to(1, 2, 3) }
  end

  def test_should_return_name
    assert_equal station.name, 'New York City, Central Park'
  end

  def test_should_return_state
    assert_equal station.state, 'NY'
  end

  def test_should_return_XML_URL
    assert_equal station.xml_url, 'http://weather.gov/xml/current_obs/KNYC.xml'
  end

  def test_should_return_latitude
    assert_equal station.latitude, 40.783
  end

  def test_should_return_longitude
    assert_equal station.longitude, -73.967
  end

  def test_should_return_coordinates
    assert_equal station.coordinates, GeoKit::LatLng.new(40.783, -73.967)
  end

  private

  def station
    NOAA::Station.find('KNYC')
  end
end
