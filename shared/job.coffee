class Job
  constructor: (data) ->
    @name = data.name
    @owner = data.owner
    @data = data.data
    @output = ""

module.exports = Job