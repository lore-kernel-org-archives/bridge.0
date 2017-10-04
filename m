Return-Path: <dsahern@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=URS3qD8JXS+pLi8pOf9NWOwKqwG9/ltFZGWhcdyE1cM=;
	b=H3gQ0E8JN+bSiJgEn+nxvnxy72THnVZ0Fe89m5a4KJjr9QQ9TJGXCeCftrxYLniZWe
	2N5RSuFUGqeVpijSPr/WsS2piXbMugYAXJXq4AjXbiy8R03yhRCK9awpvEHS6BhS2ipE
	mSuirs3wVABAfO060w/4CRtC4v6YWrkC/UwyFz5VNqan3r4pPJ9AUXgSsQweoGmrx6C7
	jf/bKbvSyPxurvvzN69tyb7AuPSTGpSjQ5RnJagl2qVhksMJi5GYfyPKQ4/6JYut140L
	K4gYDMCLVoelo/LiM+OD/qEF5SwzLgtxXVx3Q9x0k+XTb7PQOfy59MgKn4kWskEs3dbo
	pceg==
From: David Ahern <dsahern@gmail.com>
Date: Tue,  3 Oct 2017 21:58:47 -0700
Message-Id: <1507093134-20406-1-git-send-email-dsahern@gmail.com>
Subject: [Bridge] [PATCH net-next 0/7] net: Plumb extack error reporting to
	enslavements
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

David Ahern (7):
  net: Add extack to netdev_notifier_info
  net: Add extack to ndo_add_slave
  net: Add extack to upper device linking
  net: vrf: Add extack messages for enslave errors
  net: bonding: Add extack messages for some enslave failures
  net: bridge: Pass extack to down to netdev_master_upper_dev_link
  mlxsw: spectrum: Add extack messages for enslave failures

 drivers/net/bonding/bond_main.c                    | 24 ++++--
 drivers/net/bonding/bond_options.c                 |  2 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c     | 46 ++++++++---
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
 27 files changed, 196 insertions(+), 97 deletions(-)

-- 
2.1.4

