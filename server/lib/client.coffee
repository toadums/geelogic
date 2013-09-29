# NPM INCLUDES
needle = require 'needle'

# Our Includes
Queue = require '../../shared/queue'
Job = require '../../shared/job'

class Client
  constructor: (data) ->

    # Will want to be smart eventually and make sure there are no duplicates
    @address  = data.address
    @name     = data.name
    @tasks    = new Queue

  ready: (data, cb) =>
    needle.get "#{@address}/job/count", (err, res, body) =>

      if not res or res.statusCode isnt 200 then console.log "There was an error in Client.ready"
      else if body.jobs < 5
        @start data # do not continue the loop
      else
        cb() #continue on with the loop

  start: (data) =>
    job = new Job(data)
    @tasks.enqueue job
    needle.post "#{@address}/job/new", job, (err, response, body) =>
      console.log body

  getJobs: (owner) =>
    [@tasks.peek()]

module.exports = Client