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

    @maxJobs = 5

    # Store the IP and Name of all clients
    @clients = []
    hostfile = hostlist.getHosts '../../hosts.txt'

    for h in hostfile
      @clients.push new Client(address: h)

    @overflowTasks = []
    @checkOverflow()

    @routes = new Routes @

  newJob: (data) =>
    min = @clients[0]

    async.each(
      @clients
      (client, cb) =>
        if client.tasks.length < min.tasks.length
          min = client
        cb()
      (err) =>
        if err then console.log "Error in newJob: #{err}"
        else
          if min.tasks.length >= @maxJobs
            @overflowTasks.push data
            console.log "here"
          else min.start data
    )


  checkOverflow: () =>
    if @overflowTasks.length > 0
      min = @clients[0]

      async.each(
        @clients
        (client, cb) =>
          if client.tasks.length < min.tasks.length
            min = client
          cb()
        (err) =>
          if err then console.log "Error in newJob: #{err}"
          else
            return if min.tasks.length >= @maxJobs
            min.start @overflowTasks[0]
            @overflowTasks.splice(0,1)
      )

    setTimeout @checkOverflow, 2000

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