Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=1pXVJqmKhJcvrRxONTsS1Oysqm17cirViqUhJzDEsoU=;
	b=lhhSv0FGaLKee7FV8Yi4Qdi4yQGF7+JN2mf1xvumG0TwmNTfiYxl0iyyZMoXbP7YbA
	mzmAdhr7njLaP6UrJuUDF6b2NeBjEo96RNhp//Zpmj87XQzFNaOFj/t53777E62jmh9f
	8kbsOTRY4sppZqUdzUPm9Qmyq5gBJQCFu9We7NqhBjGuJYSOXKz5V+Qtdc2A2Qke+pxE
	+ivfmk8jtHsJg+rMawdcn8t+vfizseL1MeZ5WUXKSATqMgvc4JnWn6d8lSsfpTyWsj5B
	g3dvFuXtNRSvcBj2lBkGDCBWKtOqXmu4kv19mQnTi1AOIe6Ke8hVkYzlY2vdGX40UHUy
	5rDQ==
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Wed, 27 Feb 2019 11:44:24 -0800
Message-Id: <20190227194432.725-1-f.fainelli@gmail.com>
Subject: [Bridge] [PATCH net-next v3 0/8] net: Remove switchdev_ops
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

Changes in v3:

- added Reviewed-by tags from Ido where relevant
- added missing notifier_to_errno() in net/bridge/br_switchdev.c when
  calling the atomic notifier for PRE_BRIDGE_FLAGS
- kept mlxsw_sp_switchdev_init() in mlxsw/

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

 .../net/ethernet/mellanox/mlxsw/spectrum.c    |   3 -
 .../net/ethernet/mellanox/mlxsw/spectrum.h    |   2 -
 .../mellanox/mlxsw/spectrum_switchdev.c       |  24 ++--
 drivers/net/ethernet/mscc/ocelot.c            |  32 +++++-
 drivers/net/ethernet/mscc/ocelot.h            |   1 +
 drivers/net/ethernet/mscc/ocelot_board.c      |   2 +
 drivers/net/ethernet/rocker/rocker_main.c     |  23 +++-
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c       |  24 +++-
 include/linux/netdevice.h                     |   3 -
 include/net/switchdev.h                       |  38 ++++---
 net/bridge/br_switchdev.c                     |   8 +-
 net/dsa/slave.c                               |  23 +++-
 net/switchdev/switchdev.c                     | 104 +++++++++++++-----
 13 files changed, 204 insertions(+), 83 deletions(-)

-- 
2.17.1

