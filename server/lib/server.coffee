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
hostlist = require '../../shared/hostlist'
#console.log hostlist.getHosts '../../hosts.txt'

class Server
  constructor: (app, hostfile) ->
    @app = app
    @server = http.createServer @app

    # Store the IP and Name of all clients
    @clients = []
    hostfile = hostlist.getHosts '../../hosts.txt'
    for h in hostfile
      @clients.push new Client(address: h)
    #@clients.push new Client({address: 'localhost:3001', name: "test"})
    #@clients.push new Client({address: 'localhost:3002', name: "test"})
    console.log @clients[0].address
    @routes = new Routes @

  newJob: (data) =>

    client = _.find @clients, (client) => client.ready data

  getJobOutput: (name, res) =>

    client = _.find @clients, (client) => client.getJobOutput name, res

  stopJob: (name, res) =>
    client = _.find @clients, (client) => client.stopJob name, res

  printJobs: (res) =>
    log = ""
    _.each @clients, (client) =>
      log += client.getQueue()

    res.send log
    res.end()

port = 3000
app = express()
app.use express.bodyParser()
app.listen port

server = new Server app