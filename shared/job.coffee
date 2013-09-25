class Job
  constructor: (data) ->
    @name = data.name
    @owner = data.owner
    @data = data.data

module.exports = Job