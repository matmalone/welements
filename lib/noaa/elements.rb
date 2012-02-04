module NOAA
  # 
  #   
  class ForecastParameters

    private_class_method :new
    
    def self.from_xml(doc) #:nodoc:
      new(doc)
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

    def temperature_maximum
      build('temperature', {'type' => 'maximum'})
    end

    def temperature_minimum
      build('temperature', {'type' => 'minimum'})
    end

    def temperature_hourly
      build('temperature', {'type' => 'hourly'})
    end

    def temperature_dew_point
      build('temperature', {'type' => 'dew point'})
    end

    def temperature_apparent
      build('temperature', {'type' => 'apparent'})
    end

    def precipitation_liquid
      build('precipitation', {'type' => 'liquid'})
    end

    def precipitation_snow
      build('precipitation', {'type' => 'snow'})
    end

    def wind_speed_sustained
      build('wind-speed', {'type' => 'sustained'})
    end

    def wind_speed_gust
      build('wind-speed', {'type' => 'gust'})
    end

    def wind_direction
      build('direction', {'type' => 'wind'})
    end

    def cloud_cover
      build('cloud-amount')
    end

    def fire_outlook_from_dry_thunderstorms
      build('fire-weather', {'type' => 'risk from dry thunderstorms'},
      :string)
    end

    #private

    def build(parameter, attributes={}, value_type=:integer)
      attributes_filter = ''
      attributes.each {|k, v| attributes_filter += "[@#{k}='#{v}']" }
      
      values = @doc.find("/dwml/data/parameters[1]/#{parameter}#{attributes_filter}[1]/value/text()").map do |node|
        value_type == :integer ? node.to_s.to_i : node.to_s
      end

      layout_key = @doc.find("/dwml/data/parameters[1]/#{parameter}#{attributes_filter}[1]").first[:'time-layout']

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
