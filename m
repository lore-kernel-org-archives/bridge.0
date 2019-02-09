Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=ALcFwzOq1HbIP5Zq0tFSEUjDJkjB3cx5B3JV7pwKHaY=;
	b=Dto7JMQxP6sbs9m14Ys8hcTKshN6hPlRN1lHm2mMyNhCt78U56HSi91p6PwJIJ6sbn
	Mlg0QWVSZeuwubERNnTN++5afWn5WXaPnm/JKwfjRmgNJed8jJSRrsY8RwLAo/PPiE8z
	ekPpvbXD77gUeIPYJGpqxV1NzZc9H+9SJHGLK1mk5peklzDsgMsEBvZS3KVhzJ9fa2iZ
	pXtoUm/ysi73Htg2m73UdPZRVnL9qQXb7xDE+6DSxnvw8hLNoIqIwRRWysPlWMcYQFlY
	RKylH20mBGe/PVwt74F8BaFeU+T5phaMOft0c7jAnWGVcLk3UTsbQZr8I0JKWgcFxCWn
	oDgw==
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Fri,  8 Feb 2019 16:32:32 -0800
Message-Id: <20190209003248.31088-1-f.fainelli@gmail.com>
Subject: [Bridge] [PATCH net-next 00/16] net: Remove switchdev_ops
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>, andrew@lunn.ch, Florian Fainelli <f.fainelli@gmail.com>, "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, open list <linux-kernel@vger.kernel.org>, vivien.didelot@gmail.com, Ido Schimmel <idosch@mellanox.com>, jiri@mellanox.com, "David S. Miller" <davem@davemloft.net>

Hi all,

This patch series finishes by the removal of switchdev_ops. To get there
we need to do a few things:

- get rid of the one and only call to switchdev_port_attr_get() which is
  used to fetch the device's bridge port flags capabilities, instead we
  can just check what flags are being programmed during the prepare
  phase

- once we get rid of getting switchdev port attributes we convert the
  setting of such attributes using a blocking notifier

And then remove switchdev_ops completely.

Please review and let me know what you think!

Florian Fainelli (16):
  Documentation: networking: switchdev: Update port parent ID section
  mlxsw: spectrum: Check bridge flags during prepare phase
  staging: fsl-dpaa2: ethsw: Check bridge port flags during set
  net: dsa: Add setter for SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS
  rocker: Check bridge flags during prepare phase
  net: bridge: Stop calling switchdev_port_attr_get()
  net: Remove SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT
  net: Get rid of switchdev_port_attr_get()
  switchdev: Add SWITCHDEV_PORT_ATTR_SET
  rocker: Handle SWITCHDEV_PORT_ATTR_SET
  net: dsa: Handle SWITCHDEV_PORT_ATTR_SET
  mlxsw: spectrum_switchdev: Handle SWITCHDEV_PORT_ATTR_SET
  net: mscc: ocelot: Handle SWITCHDEV_PORT_ATTR_SET
  staging: fsl-dpaa2: ethsw: Handle SWITCHDEV_PORT_ATTR_SET
  net: switchdev: Replace port attr set SDO with a notification
  net: Remove switchdev_ops

 Documentation/networking/switchdev.txt        | 15 ++-
 .../net/ethernet/mellanox/mlxsw/spectrum.c    | 12 ---
 .../net/ethernet/mellanox/mlxsw/spectrum.h    |  2 -
 .../mellanox/mlxsw/spectrum_switchdev.c       | 72 +++++---------
 drivers/net/ethernet/mscc/ocelot.c            | 25 ++++-
 drivers/net/ethernet/rocker/rocker_main.c     | 99 +++++++++----------
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c       | 52 +++++-----
 include/linux/netdevice.h                     |  3 -
 include/net/switchdev.h                       | 37 ++-----
 net/bridge/br_switchdev.c                     | 20 +---
 net/dsa/dsa_priv.h                            |  3 +
 net/dsa/port.c                                | 10 ++
 net/dsa/slave.c                               | 44 +++++----
 net/switchdev/switchdev.c                     | 92 +++++------------
 14 files changed, 190 insertions(+), 296 deletions(-)

-- 
2.17.1

