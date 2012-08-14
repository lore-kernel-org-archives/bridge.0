Return-Path: <jiri@resnulli.us>
From: Jiri Pirko <jiri@resnulli.us>
Message-Id: <1344956748-2099-1-git-send-email-jiri@resnulli.us>
Subject: [Bridge] [patch net-next v2 00/15] net: introduce upper device
	lists and remove dev->master
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Tue, 14 Aug 2012 15:06:00 -0000
To: netdev@vger.kernel.org
Cc: bridge@lists.linux-foundation.org, ursula.braun@de.ibm.com, john.r.fastabend@intel.com, edumazet@google.com, shemminger@vyatta.com, sean.hefty@intel.com, therbert@google.com, roland@kernel.org, linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org, fubar@us.ibm.com, fbl@redhat.com, hal.rosenstock@gmail.com, faisal.latif@intel.com, sony.chacko@qlogic.com, blaschka@linux.vnet.ibm.com, gregory.v.rose@intel.com, bhutchings@solarflare.com, xiyou.wangcong@gmail.com, jitendra.kalsaria@qlogic.com, divy@chelsio.com, linux-driver@qlogic.com, linux-kernel@vger.kernel.org, kaber@trash.net, joe@perches.com, linux390@de.ibm.com, davem@davemloft.net

Hi all.

Recent discussion around
"[net-next] bonding: don't allow the master to become its slave"
forced me to think about upper<->lower device connections.

This patchset adds a possibility to record upper device linkage.
All upper<->lower devices are converted to use this mechanism right after.
That leads to dev->master removal because this info becomes redundant since
"unique links" have the same value.

After all changes, there is no longer possible to do:
"bond->someotherdevice->samebond"

Also I think that drivers like cxgb3, qlcnic, qeth would benefit by this
in future by being able to get more appropriate info about l3 addresses.

v1->v2:
- s/unique/master/ better naming + stays closer to the history
- fixed vlan err goto
- original patch 15 (WARN_ON change) is squashed into the first patch
- fixed netdev_unique_upper_dev_get_rcu() case of upper==NULL

Jiri Pirko (15):
  net: introduce upper device lists
  macvlan: add link to upper device
  vlan: add link to upper device
  rtnetlink: remove usage of dev->master
  team: remove usage of netdev_set_master()
  bridge: remove usage of netdev_set_master()
  netpoll: remove usage of dev->master
  cxgb3: remove usage of dev->master
  qlcnic: guard __vlan_find_dev_deep() by rcu_read_lock
  qeth: ensure that __vlan_find_dev_deep() is called with rcu_read_lock
  vlan: remove usage of dev->master in __vlan_find_dev_deep()
  nes: remove usage of dev->master
  bonding: remove usage of dev->master
  net: remove no longer used netdev_set_bond_master() and
    netdev_set_master()
  net: kill dev->master

 drivers/infiniband/hw/nes/nes.c                    |    8 +-
 drivers/infiniband/hw/nes/nes_cm.c                 |    2 +-
 drivers/net/bonding/bond_3ad.c                     |   30 +--
 drivers/net/bonding/bond_alb.c                     |    6 +-
 drivers/net/bonding/bond_main.c                    |   94 ++++----
 drivers/net/bonding/bonding.h                      |   14 +-
 drivers/net/ethernet/chelsio/cxgb3/cxgb3_offload.c |   11 +-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c   |    2 +
 drivers/net/macvlan.c                              |    9 +-
 drivers/net/team/team.c                            |   13 +-
 drivers/s390/net/qeth_l3_main.c                    |   21 +-
 include/linux/netdevice.h                          |   22 +-
 net/8021q/vlan.c                                   |   10 +-
 net/8021q/vlan_core.c                              |   18 +-
 net/bridge/br_if.c                                 |    6 +-
 net/core/dev.c                                     |  239 +++++++++++++++++---
 net/core/netpoll.c                                 |    8 +-
 net/core/rtnetlink.c                               |   45 ++--
 18 files changed, 391 insertions(+), 167 deletions(-)

-- 
1.7.10.4

