
index = require("./index")

describe "index", ->
  originalTimeout = null

  beforeEach ->
    originalTimeout = jasmine.DEFAULT_TIMEOUT_INTERVAL
    jasmine.DEFAULT_TIMEOUT_INTERVAL = 1000 * 10

  afterEach ->
    jasmine.DEFAULT_TIMEOUT_INTERVAL = originalTimeout

  describe ".handler", ->
    it "", (done)->
      event = {
        coordinates: "139.732293,35.663613"
        output: "json"
      }
      context = {
        succeed: ->
          done()
        fail: (error)->
          fail(error)
          done()
      }
      index.handler(event, context)
