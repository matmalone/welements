# welements

http://github.com/matmalone/welements

## Description

welements is a library that provides an API for the National Weather
Service's National Digital Forecast Database (NDFD). This provides a
broad array of different forecast elements that can be queried.

## Features

- Find detailed forecasts using lat/lng.
- Access all relevant data the NDFD feed.

## Requirements

- libxml-ruby >= 0.9.7
- geokit >= 1.5.0

## Installation

  gem install welements

## Usage

### Get current conditions
    forecast = Welements.welements(lat, lng)
    puts "The next hourly forecast temperature is #{forecast.temperature_hourly[0][:value]} Celcius at #{forecast.temperature_hourly[0][:time]}."
  
## Contact

Mat Malone (m2@innerlogic.org)

## Fork
welements is originally based on Mat Brown's outoftime-noaa project:
http://github.com/outoftime/noaa. outoftime-noaa Copyright 2008 Mat Brown.

## License

(The MIT License)

Copyright (c) 2012 Mat Malone

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
