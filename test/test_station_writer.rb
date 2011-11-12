require File.join(File.dirname(__FILE__), 'test_helper')

class TestStationWriter < NOAA::TestCase
  XML_DOC = LibXML::XML::Document.file(File.join(File.dirname(__FILE__), 'data', 'stations-abridged.xml'))

  def test_should_write_latitude_for_station
    [40.66, 40.77, 40.783].each_with_index do |latitude, i|
      assert_equal yaml[i]['latitude'], latitude
    end
  end

  def test_should_write_longitude_for_station
    [-73.78, -73.9, -73.967].each_with_index do |longitude, i|
      assert_equal yaml[i]['longitude'], longitude
    end
  end

  def test_should_write_id_for_station
    ['KJFK', 'KLGA', 'KNYC'].each_with_index do |id, i|
      assert_equal yaml[i]['id'], id
    end
  end

  def test_should_write_name_for_station
    ['New York/John F. Kennedy Intl Airport', 'New York, La Guardia Airport', 'New York City, Central Park'].each_with_index do |name, i|
      assert_equal yaml[i]['name'], name
    end
  end

  def test_should_write_state_for_station
    (%w(NY) * 3).each_with_index do |state, i|
      assert_equal yaml[i]['state'], state
    end
  end

  def test_should_write_XML_URL_for_station
    3.times do |i|
      assert_equal yaml[i]['xml_url'], "http://weather.gov/xml/current_obs/#{yaml[i]['id']}.xml"
    end
  end

  def yaml
    @yaml ||= begin
      io = StringIO.new
      NOAA::StationWriter.new(XML_DOC).write(io)
      YAML.load(io.string)
    end
  end
end
