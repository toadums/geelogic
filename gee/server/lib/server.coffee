# NPM Includes
express = require 'express'
http = require 'http'
readline = require 'readline'
async = require 'async'
needle = require 'needle'
_ = require 'underscore'

# Our Includes
Routes = require './routes'
Client = require './client'

class Server
  constructor: (app) ->
    @app = app
    @server = http.createServer @app

    # Store the IP and Name of all clients
    @clients = []
    @clients.push new Client({address: 'localhost:3001', name: "test"})

    @routes = new Routes @

  newJob: (data) =>

    async.each(
      @clients
      (client, cb) =>
        client.ready data, cb
      (err) =>
        if err then console.log err
      )

port = 3000
app = express()
app.use express.bodyParser()
app.listen port

server = new Server app