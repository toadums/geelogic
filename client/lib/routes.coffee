# NPM Includes
async = require 'async'

# Our Includes
System = require '../../shared/system'
class Routes
  constructor: (@delegate) ->
    {
      # Variables
      @app
      @queue
      @clients

      # Methods
      @newJob

    } = @delegate

    @app.get "/jobs", (req, res) =>

    @app.get "/queue", (req, res) =>

    @app.get "/queue/:id", (req, res) =>
      res.send req.params.id

    @app.post "/job/new", (req, res) =>

      try
        job = req.body
        @queue.enqueue job

        System.run job, () => @queue.dequeue job

        console.log "Added job:", job

        res.send "Job successfully added"
        res.end()
      catch e
        console.log e

    @app.get "/job/output/:name", (req, res) =>
      res.send @queue.peek().output
      @queue.dequeue(@queue.peek())
      res.end()

    @app.get "/job/count", (req, res) =>
      res.send {jobs: 0}
      res.end()

module.exports = Routes