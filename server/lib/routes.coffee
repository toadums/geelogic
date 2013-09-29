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

    } = @delegate

    @app.get "/jobs", (req, res) =>

      myJobs = []
      async.each(
        @clients
        (client, cb) =>
          console.log client.getJobs("diddy")
          myJobs = myJobs.concat client.getJobs("diddy")
          cb()
        (err) =>
          if err
            console.log "There was an error getting jobs: \n#{err}"
            return
          res.send JSON.stringify myJobs
        )

    @app.get "/queue/:name", (req, res) =>
      needle.get "#{@clients[0].address}/queue", (err, response, body) =>
        res.send body
        res.end()

    @app.get "/job/output/:name", (req, res) =>

      needle.get "#{@clients[0].address}/job/output/#{req.params.name}", (err, response, body) =>
        res.send body
        res.end()

    @app.post "/job/new", (req, res) =>
      @newJob req.body
      res.end()

    @app.post "/job/stop/:name", (req, res) =>
      needle.post "#{@clients[0].address}/job/stop/#{req.params.name}", req.params.name, (err, response, body) =>
        res.send body
        res.end()

module.exports = Routes