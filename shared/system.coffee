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
            job = child.spawn "node", [job.name]
          when 'coffee'
            job = child.spawn "coffee", [job.name]
          when 'py'
            job = child.spawn "python", [job.name]

        job.on "exit", () =>
          job.output = @output
          @output = ""
          cb()

        job.stdout.on "data", (data) =>
          @output = "#{@output}#{data.toString()}"

        job.stderr.on "data", (data) =>
          console.log "from stderr:\n#{data.toString()}"


module.exports = System