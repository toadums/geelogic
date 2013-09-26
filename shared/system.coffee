# NPM Includes
fs    = require 'fs'
child = require 'child_process'

class System
  constructor: () ->


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
            job = child.spawn "py", [job.name]

        job.on "exit", cb
        job.stdout.on "data", (data) =>
          console.log data.toString()
        job.stderr.on "data", (data) =>
          console.log data.toString()


module.exports = System