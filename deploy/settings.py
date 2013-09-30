
def gen_mlist(prefs, suff):
    return [ '%s%s' % (p, suff) for p in prefs ]

mprefixs = ['gc-1', 'gc-2', 'gc-3', 'gc-4']

utah = gen_mlist(mprefixs, '.stephen.ch-geni-net.utah.geniracks.net')
kentucky = gen_mlist(mprefixs, '.stephen.ch-geni-net.lan.sdn.uky.edu')
gpo = gen_mlist(mprefixs, '.stephen.ch-geni-net.instageni.gpolab.bbn.com')

mprefixs = ['grack01', 'grack02', 'grack03', 'grack04', 'grack06']
uvic = gen_mlist(mprefixs, '.uvic.trans-cloud.net')

savi = ['142.104.64.68', '142.104.64.71']


# machines = utah + kentucky + gpo + uvic + savi
machines = [utah[0], kentucky[0], gpo[0], uvic[0], savi[0]]
master = uvic[-1]
# workers = machines.remove(master)
workers = machines



gitrepo = 'https://github.com/toadums/geelogic.git'