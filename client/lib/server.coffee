# NPM Includes
express = require 'express'
http = require 'http'
async = require 'async'
needle = require 'needle'
_ = require 'underscore'

# Our Includes
Routes = require './routes'
Queue = require '../../shared/queue'

if (args = process.argv).length isnt 3
  throw new Error "Must pass in the port!\nUsage: $ <coffee, nodemon> server.coffee <port>"

if isNaN(port = process.argv[2])
  throw new Error "Port must be a number"

class Server
  constructor: (app) ->
    @app = app
    @server = http.createServer @app

    @ids = [1..5]

    @queue = new Queue

    @routes = new Routes @

port = port
app = express()
app.use express.bodyParser()
app.listen port

server = new Server app