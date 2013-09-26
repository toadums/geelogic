# NPM Includes
fs    = require 'fs'
child = require 'child_process'

class System
  constructor: () ->


  @run: (job, cb) =>

    fs.writeFile job.name, job.data, (err) =>
      if err then console.log "Error in System.run:\n#{err}"
      else
        job = child.spawn "node", [job.name]
        job.on "exit", cb
        job.stdout.on "data", (data) =>
          console.log data.toString()



module.exports = System