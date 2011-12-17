module NOAA
  # 
  # A Forecast object represents a multi-day forecast for a particular place. The forecast for a given day can
  # be accessed using the [] method; e.g. (assuming +forecast+ is a forecast for 12/20/2008 - 12/24/2008):
  #
  #   forecast[1]     #=> ForecastDay for 12/21/2008
  #   forecast.length #=> 4
  #   
  class ForecastParameters

    class << self
      private :new

      def from_xml(doc) #:nodoc:
        new(doc)
      end
    end

    def initialize(doc) #:noinit:
      @doc = doc
    end

    # 
    # The number of days provided by the forecast
    #
    def length
      @length ||= @doc.find("/dwml/data/time-layout[@summarization='24hourly'][1]/start-valid-time").length
    end

    # 
    # Get the ForecastDay for day i
    #
    #   forecast[1] #=> returns the ForecastDay for the second day
    # 
    def [](i)
      forecast_days[i]
    end

    #private

    def forecast_days
      @forecast_days ||= begin
        days = []
        length.times do |i|
          days << day = NOAA::ForecastDay.new
          day.starts_at = starts[i]
          day.ends_at = ends[i]
          day.high = maxima[i]
          day.low = minima[i]
          day.weather_summary = weather_summaries[i]
          day.weather_type_code = weather_type_codes[i]
          day.image_url = image_urls[i]
          day.daytime_precipitation_probability = precipitation_probabilities[i*2]
          day.evening_precipitation_probability = precipitation_probabilities[i*2+1]
        end
        days
      end
    end

    # datetime of the first reading in the forecast
    def starts
      starts = nil
      @doc.find("/dwml/data/time-layout/start-valid-time/text()").map do |node|
        t = Time.parse(node.to_s)
        starts = t if !starts || t < starts
      end
      @starts = starts
    end

    # datetime of the last reading in the forecast
    def ends
      ends = nil
      @doc.find("/dwml/data/time-layout/end-valid-time/text()").map do |node|
        t = Time.parse(node.to_s)
        ends = t if !ends || t > ends
      end
      @ends = ends
    end

    # TODO remove
    def maxima
      @maxima ||= @doc.find("/dwml/data/parameters[1]/temperature[@type='maximum'][@units='Fahrenheit'][1]/value/text()").map do |node|
        node.to_s.to_i
      end
    end

    # TODO remove
    def minima
      @minima ||= @doc.find("/dwml/data/parameters[1]/temperature[@type='minimum'][@units='Fahrenheit'][1]/value/text()").map do |node|
        node.to_s.to_i
      end
    end

    def probability_of_precipitation
      build('probability-of-precipitation')
    end

    def relative_humidity
      build('humidity')
    end

    def build(parameter)
      values = @doc.find("/dwml/data/parameters[1]/#{parameter}[1]/value/text()").map do |node|
        node.to_s.to_i
      end

      layout_key = @doc.find("/dwml/data/parameters[1]/#{parameter}[1]").first[:'time-layout']

      layout = nil
      @doc.find("/dwml/data/time-layout").each do |node|
        node.each_element do |el|
          # the layout key will always be the first element, check it
          # then go on to the next layout node
          layout = node if el.first.to_s == layout_key
          break
        end
      end

      data = []
      layout.each do |el|
        if el.name == 'start-valid-time'
          data.push({:time => Time.parse(el.first.to_s),
                      :value => values[data.length]})
        end
      end
      data
    end
  end
end
