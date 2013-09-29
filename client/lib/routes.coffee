# NPM Includes
async = require 'async'
_ = require 'underscore'

# Our Includes
System = require '../../shared/system'
class Routes
  constructor: (@delegate) ->
    {
      # Variables
      @app
      @queue
      @clients
      @ids
      # Methods
      @newJob

    } = @delegate

    @app.get "/jobs", (req, res) =>

    @app.get "/queue", (req, res) =>

      cb = (data) =>
        res.send data
        res.end()

      @queue.humanReadable(cb)

    @app.post "/job/new", (req, res) =>

      try
        if @ids.length is 0
          console.log "full"
          res.send "Job queue full"
          res.end()
          return

        job = req.body
        @queue.enqueue job

        System.run job, () =>
          console.log "Job finished: #{job.name}"

        id = @ids.splice(0,1)
        job.id = id

        console.log "Added job..."

        res.send "Job successfully added"
        res.end()
      catch e
        console.log e

    @app.get "/job/output/:name", (req, res) =>
      job = _.find @queue.stack, (item) =>
        item.name is req.params.name

      if job
        res.send job.output
      else res.send "No job with name #{req.params.name}"
      res.end()

    @app.post "/job/stop/:name", (req, res) =>
      job = _.find @queue.stack, (item) =>
        item.name is req.params.name

      if job
        @ids = @ids.concat job.id
        @queue.dequeue job
        res.send "Job Deleted"
      else res.send "No job with name #{req.params.name}"
      res.end()

    @app.get "/job/count", (req, res) =>
      res.send {jobs: 0}
      res.end()

module.exports = Routes




