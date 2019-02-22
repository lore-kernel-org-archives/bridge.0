Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=p30AzGcPU94wCBS8YtPQqGyNulXQ5D1avMwXHp83bds=;
	b=dIUQohihWGlkYp7ehda73F3TvfwAG9VhTYUd85Xz4jtLlOuIaNvewcP3gJb0K7rneO
	KEa8tjRpwb6Yd+OLdRAp5Abzco36eni96Kgb3c+KxgeHx0NAp0TJDe2KdhTteWcu3Aqz
	fAmi/QVAPs+GaHM7FT6XEPwUDMfXG/TEgLPkVA4QBbcLl0YDhn2m55QBy6LapGzQupPH
	YrP8X9AaK8IaosUKRMruRY5omYqqQHiafGvoudri4vx9FSYOrUgcNh1S7m+43C7xCfy2
	eCdr+z225Ebzve44jE9d+wNwP6PEEwRmAfNqLfbZVAm0aipBZZK/5cwVmGAFmeC50fOc
	LSeg==
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Fri, 22 Feb 2019 15:59:18 -0800
Message-Id: <20190222235927.10295-1-f.fainelli@gmail.com>
Subject: [Bridge] [PATCH net-next 0/8] net: Remove switchdev_ops
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

Ido, Jiri, please review :)

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
 .../mellanox/mlxsw/spectrum_switchdev.c       |  24 +--
 drivers/net/ethernet/mscc/ocelot.c            |  32 +++-
 drivers/net/ethernet/mscc/ocelot.h            |   1 +
 drivers/net/ethernet/mscc/ocelot_board.c      |   2 +
 drivers/net/ethernet/rocker/rocker_main.c     |  23 ++-
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c       |  26 +++-
 include/linux/netdevice.h                     |   3 -
 include/net/switchdev.h                       |  42 ++---
 net/dsa/slave.c                               |  23 ++-
 net/switchdev/switchdev.c                     | 147 +++++++++---------
 12 files changed, 200 insertions(+), 137 deletions(-)

-- 
2.17.1

