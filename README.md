# Tea Time

## About

*A RESTful API built to serve roadtrippers with endpoints returning JSON info relevant for trips like destination weather and photos

## Local Setup
**Version Requirements**
* ruby 2.5.3
* rails 5.2

1. `git clone git@github.com:jakejakearell/whether_sweater.git`
2. `cd tea_time`
3. `bundle install`
4. `rails db:{create,migrate}`
5. run `rails s` and explore the endpoints below!
6. run the test suite: `bundle exec rspec`

### Forecast: retrieves weather for a city
Returns location info and current weather, as well as forecast info for the upcoming 8 hours and upcoming 5 days.

Request: `GET https://road-trip-restful-api-rails.herokuapp.com/api/v1/forecast?location=<city,state>`  

#### Example:
Request: `GET https://road-trip-restful-api-rails.herokuapp.com/api/v1/forecast?location=denver,co`  
Response body:
```
{
    "data": {
        "id": null,
        "type": "forecast",
        "attributes": {
            "location": {
                "city": "Denver",
                "state": "CO",
                "country": "US",
                "coordinates": {
                    "lat": 39.738453,
                    "lng": -104.984853
                }
            },
            "current": {
                "datetime": "2021-04-28T00:07:11.000Z",
                "sunrise": "2021-04-27T12:05:00.000Z",
                "sunset": "2021-04-28T01:49:46.000Z",
                "temperature": 47.1,
                "feels_like": 41.45,
                "humidity": 82,
                "uvi": 0.5,
                "visibility": 10000,
                "conditions": "moderate rain",
                "icon": "10d"
            },
            "hourly": [
                {
                    "time": "2021-04-28T00:00:00.000Z",
                    "temperature": 47.1,
                    "conditions": "light rain",
                    "icon": "10d"
                },
                {
                    "time": "2021-04-28T01:00:00.000Z",
                    "temperature": 47.19,
                    "conditions": "moderate rain",
                    "icon": "10d"
                },
                {
                    "time": "2021-04-28T02:00:00.000Z",
                    "temperature": 46.18,
                    "conditions": "overcast clouds",
                    "icon": "04n"
                },
                {
                    "time": "2021-04-28T03:00:00.000Z",
                    "temperature": 45.39,
                    "conditions": "light rain",
                    "icon": "10n"
                },
                {
                    "time": "2021-04-28T04:00:00.000Z",
                    "temperature": 43.03,
                    "conditions": "moderate rain",
                    "icon": "10n"
                },
                {
                    "time": "2021-04-28T05:00:00.000Z",
                    "temperature": 39.45,
                    "conditions": "heavy intensity rain",
                    "icon": "10n"
                },
                {
                    "time": "2021-04-28T06:00:00.000Z",
                    "temperature": 38.93,
                    "conditions": "moderate rain",
                    "icon": "10n"
                },
                {
                    "time": "2021-04-28T07:00:00.000Z",
                    "temperature": 38.61,
                    "conditions": "moderate rain",
                    "icon": "10n"
                }
            ],
            "daily": [
                {
                    "date": "2021-04-27T18:00:00.000Z",
                    "sunrise": "2021-04-27T12:05:00.000Z",
                    "sunset": "2021-04-28T01:49:46.000Z",
                    "max_temp": 59.68,
                    "min_temp": 39.45,
                    "conditions": "heavy intensity rain",
                    "icon": "10d"
                },
                {
                    "date": "2021-04-28T18:00:00.000Z",
                    "sunrise": "2021-04-28T12:03:43.000Z",
                    "sunset": "2021-04-29T01:50:47.000Z",
                    "max_temp": 59.86,
                    "min_temp": 38.61,
                    "conditions": "moderate rain",
                    "icon": "10d"
                },
                {
                    "date": "2021-04-29T18:00:00.000Z",
                    "sunrise": "2021-04-29T12:02:27.000Z",
                    "sunset": "2021-04-30T01:51:48.000Z",
                    "max_temp": 66.02,
                    "min_temp": 44.44,
                    "conditions": "clear sky",
                    "icon": "01d"
                },
                {
                    "date": "2021-04-30T18:00:00.000Z",
                    "sunrise": "2021-04-30T12:01:12.000Z",
                    "sunset": "2021-05-01T01:52:49.000Z",
                    "max_temp": 77.95,
                    "min_temp": 50.83,
                    "conditions": "clear sky",
                    "icon": "01d"
                },
                {
                    "date": "2021-05-01T18:00:00.000Z",
                    "sunrise": "2021-05-01T11:59:59.000Z",
                    "sunset": "2021-05-02T01:53:49.000Z",
                    "max_temp": 81.55,
                    "min_temp": 56.98,
                    "conditions": "broken clouds",
                    "icon": "04d"
                }
            ]
        }
    }
}
```

### Backgrounds: retrieves background image for a city's forecast show page
Returns location parameter, image url, and image credit info.

Request: `GET https://road-trip-restful-api-rails.herokuapp.com/api/v1/backgrounds?location=<city,state>`  

#### Example:
Request: `GET https://road-trip-restful-api-rails.herokuapp.com/api/v1/backgrounds?location=denver,co`  
Response body:
```
{
    "data": {
        "id": "null",
        "type": "image",
        "attributes": {
            "title": "Denver Zoo",
            "url": "https://www.flickr.com/photos/chante-etan/51230534829/",
            "location": "Colorado, Vine Street Houses",
            "photographer": "Chante Etan",
            "profile": "https://www.flickr.com/photos/79129236@N00",
            "source": "flickr.com"
        }
    }
}
```

### User registration
Returns new user's id, email, and api key.

Request: `POST https://road-trip-restful-api-rails.herokuapp.com/api/v1/users`
* body must include `email`, `password`, and `password_confirmation` params
* you will receive a 400 bad request error if an email is already in use, if there are any missing fields, and/or if the password fields do not match

#### Example:
Request: `POST https://road-trip-restful-api-rails.herokuapp.com/api/v1/users`  
Request body:
```
{"email": "whatever123@example.com",
  "password": "password",
   "password_confirmation": "password"}
```
Response body:
```
{
    "data": {
        "id": "2",
        "type": "user",
        "attributes": {
            "email": "sample1@email.com",
            "api_key": "624c179c-60a8-4cb8-abf1-01f608b2c7b1"
        }
    }
}
```

### User login: logs in with a user's credentials
Returns authorized user's id, email, and api key.

Request: `POST https://road-trip-restful-api-rails.herokuapp.com/api/v1/sessions`
* body must include `email` and `password` params
* you will receive a 401 unauthorized error if bad credentials are submitted

#### Example:
Request: `POST https://road-trip-restful-api-rails.herokuapp.com/api/v1/sessions`  
Request body:
```
{"email": "whatever@example.com",
  "password": "password"}
```
Response body:
```
{
    "data": {
        "id": "1",
        "type": "user",
        "attributes": {
            "email": "sample@email.com",
            "api_key": "ed50e6e5-5034-4976-aff6-30218b6c466e"
        }
    }
}
```

### Road trip: allows user to plan a road trip
Returns road trip info: origin, destination, travel time, forecast temperature, forecast description, and user that road trip was created by

Request: `POST https://road-trip-restful-api-rails.herokuapp.com/api/v1/road_trip`
* body must include `origin`, `destination`, and `api_key` params
* you will receive a 401 unauthorized error if bad credentials are submitted

#### Example:
Request: `POST https://road-trip-restful-api-rails.herokuapp.com/api/v1/road_trip`  
Request body:
```
{"origin": "Salt Lake City, UT",
   "destination": "Denver, CO",
   "api_key": "9167e13a-9fb2-49c9-8165-c64c2ff335b1"}
```
Response body:
```
{
    "data": {
        "id": "null",
        "type": "road_trip",
        "attributes": {
            "start_city": "salt lake city, UT",
            "end_city": "denver, CO",
            "travel_time": "07 hours, 19 minutes",
            "weather_at_eta": {
                "temperature": 38.61,
                "conditions": "moderate rain"
            }
        }
    }
}
```
## Tools
Tea Time is written in Ruby with Ruby on Rails and uses a postgresql database.

**Language and Framework Versions**
* ruby 2.5.3
* rails 5.2

**Gems**
* Faraday
* Figaro
* BCrypt
* FastJSON

**Testing**
* SimpleCov
* RSpec
* WebMock
* VCR
* ShouldaMatchers
* FactoryBot

**Third Party APIs
* Tea API
   * [Teas API - GET route](https://tea-api-vic-lo.herokuapp.com/)
