
from fabric.api import *
from config import *


env.roledefs = {'machines': machines,
				'master': [master],
				'workers': workers}

env.key_filename = '~/.ssh/st_rsa'

# this has to be set to any string (empty is fine) 
#  or we get an odd logging error
env.password = ''


@parallel
@roles('machines')
def deploy():
	with settings(warn_only=True):
		run('git clone %s' % (gitrepo))
	with cd('geelogic'):
		run('./setup.sh')


@parallel
@roles('machines')
def install_node():
	with settings(warn_only=True):
		if run('which node').succeeded: return
		run('git clone https://github.com/joyent/node.git')
	with cd('node'):
		run('./configure')
		run('make')
		sudo('make install')


@parallel
@roles('workers')
def worker_script(script):
	with cd('geelogic/client')
		run(script)

def start_workers():
	execute(worker_script:'start.sh')

def stop_workers():
	execute(worker_script:'stop.sh')

def restart_workers(): 
	execute(worker_script:'stop.sh && start.sh')


@roles('master')
def master_script(script):
	with cd('geelogic/server')
		run(script)

def start_master():
	execute(master_script:'start.sh')

def stop_master():
	execute(master_script:'stop.sh')

def restart_master():
	execute(master_script:'stop.sh && start.sh')

