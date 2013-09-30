
from fabric.api import *
from settings import *


env.roledefs = {'machines': machines,
				'master': [master],
				'workers': workers}


env.key_filename = '~/.ssh/st_rsa'


@parallel
@roles('workers')
def deploy():
	with settings(warn_only=True):
		run('git clone %s' % (gitrepo))


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
		run()


