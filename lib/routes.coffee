async = require 'async'

class Routes
  constructor: (@delegate) ->
    {
      # Variables
      @app
      @queue
      @clients
      # Methods
      # NONE

    } = @delegate

    @app.get "/jobs", (req, res) =>

      res.send JSON.stringify @queue.peek()
      res.send JSON.stringify @queue.peek()

    @app.get "/queue", (req, res) =>
      res.send "Q_Q"

    @app.get "/queue/:id", (req, res) =>
      res.send req.params.id

module.exports = Routes