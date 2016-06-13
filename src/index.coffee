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
      # console.log response

  context.succeed(event: event, context: context)
