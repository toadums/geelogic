# Basic queue
# Sept 11, 2013

# NPM  Includes
async = require 'async'

class queue_me
	constructor: () ->
		@stack = []
		@running = 0 # store !0 if the process is running

	enqueue: (element) =>

		@stack.push(element)

	dequeue: (job) =>
		if job
			index = @stack.indexOf job
			return if index is - 1

			@stack.splice(index, 1)

		else
			@stack.splice(0, 1) if not @isempty()

	isempty: () =>
		if @stack.length then false else true

	peek: () =>
		@stack[0]

	humanReadable: (res) =>
		str = ""
		async.each(
			@stack
			(item, cb) =>
				str += item.id + ": " + item.name + '\n'
				cb()
			(err) =>
				if err then console.log err
				else
					res str
			)



# add a process to the queue by writing the attributes in a list like this:
# meow.enqueue([<id>, <process>])

module.exports = queue_me