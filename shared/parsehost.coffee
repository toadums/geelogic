
fs = require 'fs'

getHosts =  (hostfile) =>
	hostlist = parseHostFile(fs.readFileSync hostfile, 'utf8')

parseHostFile = (data) =>
	# may want to throw an error if data is fked
	hostlist = []
	for l in data.split('\n')
		if l.charAt(0) isnt '#' and l.trim() isnt ''
			hostlist.push l
	hostlist

console.log(getHosts '../hosts.txt')
