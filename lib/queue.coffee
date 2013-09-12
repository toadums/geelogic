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


meow = new queue_me

meow.enqueue([0, "whole process"])
console.log meow.stack[0][0]
console.log meow.peek()

# add a process to the queue by writing the attributes in a list like this:
# meow.enqueue([<id>, <process>])
