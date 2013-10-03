
class HostFileError(Exception): pass

def get_host_lists(hostfile="../hosts.txt"):
	hf = open(hostfile)
	inworkers = False
	inmaster = False
	workers = []
	master = None
	for line in hf.readlines():
		line = line.strip()
		if len(line):
	 		if '#' in line:
	 			if 'workers' in line.lower():
	 				inworkers = True
	 				inmaster = False
	 			elif 'master' in line.lower():
					inworkers = False	
	 				inmaster = True
	 		elif inmaster:
	 			master = line
	 		elif inworkers:
	 			workers.append(line)
	hf.close()
 	if len(workers) and master: 
 		return workers, master
 	raise HostFileError('Malformed host file %s' % (hostfile))

workers, master = get_host_lists()
machines = workers + [master]

gitrepo = 'https://github.com/toadums/geelogic.git'
