# Basic queue
# Sept 11, 2013

class queue_me
	constructor: () ->
		@stack = []
		@running = 0 # store !0 if the process is running

	enqueue: (element) =>
		@stack.push(element)

	dequeue: () =>
		@stack.splice(0, 1) if not @isempty()

	isempty: () =>
		if @stack.length then false else true

	peek: () =>
		@stack[0]

# add a process to the queue by writing the attributes in a list like this:
# meow.enqueue([<id>, <process>])

module.exports = queue_me