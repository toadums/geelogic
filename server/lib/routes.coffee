async = require 'async'

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
    @app.get "/queue", (req, res) =>
      res.send "Q_Q"

    @app.get "/queue/:id", (req, res) =>
      res.send req.params.id

    @app.post "/job/new", (req, res) =>
      @newJob req.body
      res.end()

module.exports = Routes