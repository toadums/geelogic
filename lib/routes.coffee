async = require 'async'

class Routes
  constructor: (@app) ->

    @app.get "/jobs", (req, res) =>
      res.send JSON.stringify root.items

    @app.get "/queue", (req, res) =>
      res.send "Q_Q"

    @app.get "/queue/:id", (req, res) =>
      res.send req.params.id

module.exports = Routes