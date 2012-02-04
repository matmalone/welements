require File.join(File.dirname(__FILE__), 'test_helper')

class TestHttpService < Welements::TestCase
  def setup
    HTTP.reset
  end

  def test_should_get_parseable_results_for_elements
    doc = Welements::HttpService.new.get_welements(40.72, -73.99)
    assert doc.find("/dwml/data/parameters[1]/humidity[1]/value").map.count > 1
  end

  private

  def http_service
    Welements::HttpService.new(HTTP)
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
