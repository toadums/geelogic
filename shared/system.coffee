# NPM Includes
child = require 'child_process'

class System
  constructor: () ->


  @run: (job, cb) =>

    job = child.spawn "ls"
    job.on "exit", cb
    job.stdout.on "data", (data) =>
      console.log data.toString()



module.exports = System