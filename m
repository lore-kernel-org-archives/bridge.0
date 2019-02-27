Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=cH9oJKpXYpzUBm/E3y8LZkm21TWeyoHh6mJNc57m+hA=;
	b=PyWycX+ScpJfmaeaAtaJ3Y94FGziaYuQ1mEBYYDcAbP4Lz7Hd2pubw5AFiwns4R74a
	ft6d0ZOCS+0g1Axpue7TY/5w5O/4yCiGpPH2WRhi1zm7yPcNoDuadnARPxPzSRLiMqaE
	faIaUlMCIZimDXEd+PxZbL5kXerf/ZvpR5XaiBJKdkUtM6QL9+mbgboCmiC2JxjN4+UJ
	hQxY11DbjIDXwO+FU1M8kq9uKVX47CZZsIsco60AaK1ET4tntom7qDpJaCGfTRbQHiZX
	Nb/OGKRFJF0fJNfc4RVc44voNsxk96KE6QVl28vD3iEcwEzJvh7bcb0fdfb9GZ92w5jW
	DpBQ==
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Tue, 26 Feb 2019 17:14:19 -0800
Message-Id: <20190227011427.16487-1-f.fainelli@gmail.com>
Subject: [Bridge] [PATCH net-next v2 0/8] net: Remove switchdev_ops
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

This patch series completes the removal of the switchdev_ops by
converting switchdev_port_attr_set() to use either the blocking
(process) or non-blocking (atomic) notifier since we typically need to
deal with both depending on where in the bridge code we get called from.

This was tested with the forwarding selftests and DSA hardware.

Ido, hopefully this captures your comments done on v1, if not, can you
illustrate with some pseudo-code what you had in mind if that's okay?

Changes in v2:

- do not check for SWITCHDEV_F_DEFER when calling the blocking notifier
  and instead directly call the atomic notifier from the single location
  where this is required

Florian Fainelli (8):
  switchdev: Add SWITCHDEV_PORT_ATTR_SET
  rocker: Handle SWITCHDEV_PORT_ATTR_SET
  net: dsa: Handle SWITCHDEV_PORT_ATTR_SET
  mlxsw: spectrum_switchdev: Handle SWITCHDEV_PORT_ATTR_SET
  net: mscc: ocelot: Handle SWITCHDEV_PORT_ATTR_SET
  staging: fsl-dpaa2: ethsw: Handle SWITCHDEV_PORT_ATTR_SET
  net: switchdev: Replace port attr set SDO with a notification
  net: Remove switchdev_ops

 .../net/ethernet/mellanox/mlxsw/spectrum.c    |  12 --
 .../net/ethernet/mellanox/mlxsw/spectrum.h    |   2 -
 .../mellanox/mlxsw/spectrum_switchdev.c       |  24 ++--
 drivers/net/ethernet/mscc/ocelot.c            |  32 +++++-
 drivers/net/ethernet/mscc/ocelot.h            |   1 +
 drivers/net/ethernet/mscc/ocelot_board.c      |   2 +
 drivers/net/ethernet/rocker/rocker_main.c     |  23 +++-
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c       |  24 +++-
 include/linux/netdevice.h                     |   3 -
 include/net/switchdev.h                       |  38 ++++---
 net/bridge/br_switchdev.c                     |   7 +-
 net/dsa/slave.c                               |  23 +++-
 net/switchdev/switchdev.c                     | 104 +++++++++++++-----
 13 files changed, 203 insertions(+), 92 deletions(-)

-- 
2.17.1

