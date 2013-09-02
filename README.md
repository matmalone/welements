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
- echoe ~> 4.6

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
