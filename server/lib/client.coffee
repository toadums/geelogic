Queue = require './queue'
Job = require './job'
class Client
  constructor: (data) ->

    # Will want to be smart eventually and make sure there are no duplicates
    @address  = data.address
    @name     = data.name
    @tasks    = new Queue

  ready: () =>
    @tasks.running is 0

  start: (data) =>
    @tasks.enqueue new Job(data)

  getJobs: (owner) =>
    [@tasks.peek()]

module.exports = Client