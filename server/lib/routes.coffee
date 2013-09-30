# NPM Includes
async = require 'async'
needle = require 'needle'

class Routes
  constructor: (@delegate) ->
    {
      # Variables
      @app
      @clients

      # Methods
      @newJob
      @getJobOutput
      @stopJob
      @printJobs

    } = @delegate

    @app.get "/queue/:id", (req, res) =>
      @printJobs res

    @app.get "/job/output/:name", (req, res) =>
      @getJobOutput req.params.name, res

    @app.post "/job/new", (req, res) =>
      @newJob req.body
      res.end()

    @app.post "/job/stop/:name", (req, res) =>
      @stopJob req.params.name, res

module.exports = Routes