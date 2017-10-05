Return-Path: <dsahern@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=I61k4wi2/lRSA2fMEC2oX8jm/PyG0ujLZh+UU467kV4=;
	b=LdRlnwbZQ52GvVIBZ7erNlUFSe9QACpWkUhM5iqhj53zct3M7i2edYkrWoOIZvUPrS
	KHMtbiXIomT7d/0iOqffHrzQL2VlNZxTs0PUmKG77efFvzZ87Rzw597jieAPZRJ5bHwQ
	y58osEQUj/gti6fywE2nvNOefSInDAK6ooeFNJtL3uqOQ5lGQ24XrW63lW45092AQywK
	96G2uY06a2iuTSm2lkgyjUxB4/9xW4u6eD6lyp2i7o3UiM9eoeuUYErkfEnRZVjCoOOG
	bP2Kh5p0Q4NGfoakzzHvy8pPGzcfIND7VUd3rNDcIevVmkQls75nPfv+sIg8l2pcCby5
	jXQg==
From: David Ahern <dsahern@gmail.com>
Date: Wed,  4 Oct 2017 17:48:44 -0700
Message-Id: <1507164531-17732-1-git-send-email-dsahern@gmail.com>
Subject: [Bridge] [PATCH v2 net-next 0/7] net: Plumb extack error reporting
	to enslavements
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: j.vosburgh@gmail.com, bridge@lists.linux-foundation.org, idosch@mellanox.com, jiri@mellanox.com, vfalico@gmail.com, David Ahern <dsahern@gmail.com>, davem@davemloft.net

Another round of extending extack error reporting, this time for
enslavements through ndo_add_slave and notifiers.

v2
- changed how the messages are added to bonding driver per Jiri's request
- fixed spectrum message for LAG overflow per Ido's comment

David Ahern (7):
  net: Add extack to netdev_notifier_info
  net: Add extack to ndo_add_slave
  net: Add extack to upper device linking
  net: vrf: Add extack messages for enslave errors
  net: bonding: Add extack messages for some enslave failures
  net: bridge: Pass extack to down to netdev_master_upper_dev_link
  mlxsw: spectrum: Add extack messages for enslave failures

 drivers/net/bonding/bond_main.c                    | 19 +++--
 drivers/net/bonding/bond_options.c                 |  2 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c     | 47 ++++++++---
 drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c |  2 +-
 drivers/net/hyperv/netvsc_drv.c                    |  2 +-
 drivers/net/ipvlan/ipvlan_main.c                   |  2 +-
 drivers/net/macsec.c                               |  2 +-
 drivers/net/macvlan.c                              |  7 +-
 drivers/net/macvtap.c                              |  2 +-
 drivers/net/team/team.c                            |  5 +-
 drivers/net/usb/qmi_wwan.c                         |  2 +-
 drivers/net/vrf.c                                  | 23 ++++--
 include/linux/if_macvlan.h                         |  3 +-
 include/linux/netdevice.h                          | 19 ++++-
 include/net/bonding.h                              |  3 +-
 net/8021q/vlan.c                                   |  6 +-
 net/8021q/vlan.h                                   |  2 +-
 net/8021q/vlan_netlink.c                           |  2 +-
 net/batman-adv/hard-interface.c                    |  2 +-
 net/batman-adv/soft-interface.c                    |  3 +-
 net/bridge/br_device.c                             |  5 +-
 net/bridge/br_if.c                                 | 15 +++-
 net/bridge/br_ioctl.c                              |  2 +-
 net/bridge/br_private.h                            |  3 +-
 net/core/dev.c                                     | 96 +++++++++++++---------
 net/core/rtnetlink.c                               | 10 ++-
 net/openvswitch/vport-netdev.c                     |  3 +-
 27 files changed, 192 insertions(+), 97 deletions(-)

-- 
2.1.4

