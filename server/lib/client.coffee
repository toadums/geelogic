# NPM INCLUDES
needle = require 'needle'
_      = require 'underscore'
# Our Includes
Queue = require '../../shared/queue'
Job = require '../../shared/job'

class Client
  constructor: (data) ->

    # Will want to be smart eventually and make sure there are no duplicates
    @address  = data.address
    @name     = data.name

    @tasks    = []

  ready: (data) =>
    if @tasks.length < 5
      @start data
      true
    else false

  start: (data) =>
    job = new Job(data)

    @tasks.push job.name

    needle.post "#{@address}/job/new", job, (err, response, body) =>
      console.log body

  getJobs: (owner) =>
    [@tasks.peek()]

  getJobOutput: (name, res) =>

    child = _.find @tasks, (task) => task is name
    if child
      needle.get "#{@address}/job/output/#{name}", (err, response, body) =>
        res.send body
        res.end()
      true
    else false

  getQueue: () =>
    log = "=======\n"
    _.each @tasks, (task) =>
      log += (task + '\n')

    log

  stopJob: (name, res) =>
    child = _.find @tasks, (task) => task is name
    if child
      needle.post "#{@address}/job/stop/#{name}", name, (err, response, body) =>
        @tasks = @tasks.splice @tasks.indexOf(name, 1)
        res.send body
        res.end()
      true
    else false


module.exports = Client