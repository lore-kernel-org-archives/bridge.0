Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=Y+ay6SV/BFYUMRbOxWKkp7WjzKgRjee0FGJy6UkTvYI=;
	b=ivmBfcNwjjQxi17W5sZ3yKZRKRnCfR/z7Ve40DljruO78jg7NPH2BDH6TDyg1J655U
	vh5pxM0WGrua21AznJn8ttrFL0ZWQo3J2RXWY7VUXNex/aNPjwkth5XhgpwhfiwY/+Bk
	9r7xfTKHksh2UV9qlTNtCguqNDISbvL/EuKEqqg7jNS20M2CYtoERDDpFGVNCvHHUkqx
	0vbgG+ylg5rWhAIN2OUZCtnl0Feo0CdbRje1A9tAyBlfPC9whmhkPt/cP5SYarpSza73
	BdvhMpQAyysL670o2mg8Ciwwd5pIjJWCuiCd3ivaK7VI5vQvNFkMZq3DFgV3u/Dgsv56
	6bSg==
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Tue,  5 Feb 2019 14:12:59 -0800
Message-Id: <20190205221311.18476-1-f.fainelli@gmail.com>
Subject: [Bridge] [PATCH net-next v2 00/12] net: Introduce
	ndo_get_port_parent_id()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>, Florian Fainelli <f.fainelli@gmail.com>, "open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>, "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, open list <linux-kernel@vger.kernel.org>, Ido Schimmel <idosch@mellanox.com>, "open list:NETRONOME ETHERNET DRIVERS" <oss-drivers@netronome.com>, "David S. Miller" <davem@davemloft.net>

Hi all,

Based on discussion with Ido and feedback from Jakub there are clearly
two classes of users that implement SWITCHDEV_ATTR_ID_PORT_PARENT_ID:

- PF/VF drivers which typically only implement return the port's parent
  ID, yet have to implement switchdev_port_attr_get() just for that

- Ethernet switch drivers: mlxsw, ocelot, DSA, etc. which implement more
  attributes which we want to be able to eventually veto in the context
  of the caller, thus making them candidates for using a blocking notifier
  chain

Changes in v2:

- resolved build failures spotted by kbuild test robot
- added helpers functions into the core network device layer:
  dev_get_port_parent_id() and netdev_port_same_parent_id();
- added support for recursion to lower devices

Changes from RFC:

- introduce a ndo_get_port_parent_id() and convert all relevant drivers
  to use it

- get rid of SWITCHDEV_ATTR_ID_PORT_PARENT_ID

A subsequent set of patches will convert switchdev_port_attr_set() to
use a blocking notifier call, and still get rid of
switchdev_port_attr_get() altogether.

Florian Fainelli (12):
  net: Introduce ndo_get_port_parent_id()
  bnxt: Implement ndo_get_port_parent_id()
  liquidio: Implement ndo_get_port_parent_id()
  net/mlx5e: Implement ndo_get_port_parent_id()
  mlxsw: Implement ndo_get_port_parent_id()
  mscc: ocelot: Implement ndo_get_port_parent_id()
  nfp: Implement ndo_get_port_parent_id()
  rocker: Implement ndo_get_port_parent_id()
  netdevsim: Implement ndo_get_port_parent_id()
  staging: fsl-dpaa2: ethsw: Implement ndo_get_port_parent_id()
  net: dsa: Implement ndo_get_port_parent_id()
  net: Get rid of SWITCHDEV_ATTR_ID_PORT_PARENT_ID

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 28 +++------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  4 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c  |  3 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_vfr.c | 12 ++--
 .../net/ethernet/cavium/liquidio/lio_main.c   | 22 ++-----
 .../net/ethernet/cavium/liquidio/lio_vf_rep.c | 25 +++-----
 .../ethernet/mellanox/mlx5/core/en/tc_tun.c   |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en_rep.c  | 31 ++++------
 .../net/ethernet/mellanox/mlx5/core/en_tc.c   |  5 +-
 .../net/ethernet/mellanox/mlxsw/spectrum.c    | 13 +++++
 .../mellanox/mlxsw/spectrum_switchdev.c       |  5 --
 .../net/ethernet/mellanox/mlxsw/switchx2.c    | 36 +++++-------
 drivers/net/ethernet/mscc/ocelot.c            | 33 +++++------
 .../ethernet/netronome/nfp/flower/action.c    |  3 +-
 .../ethernet/netronome/nfp/nfp_net_common.c   |  4 +-
 .../net/ethernet/netronome/nfp/nfp_net_repr.c |  4 +-
 drivers/net/ethernet/netronome/nfp/nfp_port.c | 23 ++------
 drivers/net/ethernet/netronome/nfp/nfp_port.h |  4 +-
 drivers/net/ethernet/rocker/rocker_main.c     | 17 ++++--
 drivers/net/netdevsim/netdev.c                | 22 ++-----
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c       | 17 ++++--
 include/linux/netdevice.h                     |  9 +++
 include/net/switchdev.h                       | 11 ----
 net/bridge/br_switchdev.c                     | 11 ++--
 net/core/dev.c                                | 57 +++++++++++++++++++
 net/core/net-sysfs.c                          | 12 +---
 net/core/rtnetlink.c                          | 14 ++---
 net/dsa/slave.c                               | 18 ++++--
 net/ipv4/ipmr.c                               | 14 ++---
 net/switchdev/switchdev.c                     | 20 -------
 30 files changed, 219 insertions(+), 260 deletions(-)

-- 
2.17.1

