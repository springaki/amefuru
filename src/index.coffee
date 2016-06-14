dotenv = require('dotenv').config()
request = require 'requestretry'

appid = process.env.APPID

exports.handler = (event, context)->
  console.log(JSON.stringify({event: event, context: context}, null, 2))

  options =
    url: "http://weather.olp.yahooapis.jp/v1/place?coordinates=#{event.coordinates}&appid=#{appid}&output=#{event.output}"
    timeout: 2000
    headers: {'user-agent': 'node title fetcher'}
    maxAttempts: 5
    retryDelay: 1000

  request options, (error, response, body) ->
    if body
      console.log body
      jsonbody = JSON.parse(body)
      console.log jsonbody.Feature[0].Name
      console.log jsonbody.Feature[0].Property.WeatherAreaCode
      #実測値
      console.log jsonbody.Feature[0].Property.WeatherList.Weather[0]
      #予報値
      for i in [1..6]
        console.log jsonbody.Feature[0].Property.WeatherList.Weather[i]

      # console.log response

  lat = 34.727794
  lon = 135.270593
  width = 800
  height = 800
  options2 =
    url: "http://map.olp.yahooapis.jp/OpenLocalPlatform/V1/static?appid=#{appid}&lat=#{lat}&lon=#{lon}&z=12&width=#{width}&height=#{height}&overlay=type:rainfall|datelabel:off"
    timeout: 2000
    headers: {'user-agent': 'node title fetcher'}
    maxAttempts: 5
    retryDelay: 1000

  request options2, (error, response, body) ->
    if body
      console.log body


  context.succeed(event: event, context: context)
