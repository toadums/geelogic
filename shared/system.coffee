# NPM Includes
fs    = require 'fs'
child = require 'child_process'

class System
  constructor: () ->

  @output = ""

  @run: (job, cb) =>

    fs.writeFile job.name, job.data, (err) =>
      if err then console.log "Error in System.run:\n#{err}"
      else

        type = job.name.substr(job.name.indexOf('.') + 1)
        switch type
          when 'js'
            runningJob = child.spawn "node", [job.name]
          when 'coffee'
            runningJob = child.spawn "coffee", [job.name]
          when 'py'
            runningJob = child.spawn "python", [job.name]

        runningJob.on "exit", () =>
          console.log "\n\n\n", job, "\n\n\n"
          job.output = @output
          @output = ""
          cb()

        runningJob.stdout.on "data", (data) =>
          @output = "#{@output}#{data.toString()}"

        runningJob.stderr.on "data", (data) =>
          console.log "from stderr:\n#{data.toString()}"


module.exports = System