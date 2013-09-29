class Job
  constructor: (data) ->
    @id = data.name or 0
    @name = data.name
    @owner = data.owner
    @data = data.data
    @output = ""

module.exports = Job