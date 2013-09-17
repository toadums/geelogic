Queue = require './queue'

class Client
  constructor: (data) ->

    # Will want to be smart eventually and make sure there are no duplicates
    @address  = data.address
    @name     = data.name
    @tasks    = new Queue

  queueCount: () =>
    @tasks.running

module.exports = Client