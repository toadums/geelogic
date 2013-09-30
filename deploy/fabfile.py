
from fabric.api import *
from settings import *


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
@roles('machines')
def start_workers():
	with cd('geelogic'):
		run('')


