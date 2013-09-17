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
    @routes = new Routes @
    @server = http.createServer @app

    # Store the IP and Name of all clients
    @clients = []
    @clients.push new Client('1.1.1.1', "test")


port = 3000
app = express()
app.use express.bodyParser()
app.listen port

server = new Server app