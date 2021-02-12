Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mE/OVlXJFK1GimzChU0IMobvC2t4RAJYhxND9dZJsvY=;
 b=bHy9naBQqEYCJdPmyYg7EB5tRKfXeGjhU0sW1LfOvR//3Mk+6YoX6bdojQAbDxfkMK
 7KVNtbaV3JxPz5X+nuWQCSgG0GFmHBJHOe32FsjoJLO83jQGUwj8BfEFijss1HhkCpxB
 ueumz3wYFrKtJrPWnz8CAdGIe/AULhttcIHXBNcevT/2V/4CeWsqfu5VNyxQeJo4Bu/g
 mPnw8fzlLY5/L9yW4qf/RNulzYPLRg6wbW4/FWFQ/TP7uZ3Cyd7I/QCeMXmA7AaLH4MM
 OdduONNr1bk14giWUbNwp8TMzJwaUFXla34ENu9r2KB52SqlYY4efDMc1qo7hQLBFKY8
 jQ9Q==
From: Vladimir Oltean <olteanv@gmail.com>
Date: Fri, 12 Feb 2021 03:05:22 +0200
Message-Id: <20210212010531.2722925-1-olteanv@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH v4 net-next 0/9] Cleanup in brport flags switchdev
	offload for DSA
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Vadym Kochan <vkochan@marvell.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Ioana Ciornei <ioana.ciornei@nxp.com>, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, Taras Chornyi <tchornyi@marvell.com>, Ido Schimmel <idosch@idosch.org>, Claudiu Manoil <claudiu.manoil@nxp.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, linux-omap@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>

From: Vladimir Oltean <vladimir.oltean@nxp.com>

The initial goal of this series was to have better support for
standalone ports mode on the DSA drivers like ocelot/felix and sja1105.
This turned out to require some API adjustments in both directions:
to the information presented to and by the switchdev notifier, and to
the API presented to the switch drivers by the DSA layer.

Vladimir Oltean (9):
  net: switchdev: propagate extack to port attributes
  net: bridge: offload all port flags at once in br_setport
  net: bridge: don't print in br_switchdev_set_port_flag
  net: dsa: configure better brport flags when ports leave the bridge
  net: switchdev: pass flags and mask to both {PRE_,}BRIDGE_FLAGS
    attributes
  net: dsa: act as ass passthrough for bridge port flags
  net: mscc: ocelot: use separate flooding PGID for broadcast
  net: mscc: ocelot: offload bridge port flags to device
  net: dsa: sja1105: offload bridge port flags to device

 drivers/net/dsa/b53/b53_common.c              |  91 ++++---
 drivers/net/dsa/b53/b53_priv.h                |   2 -
 drivers/net/dsa/mv88e6xxx/chip.c              | 163 ++++++++++---
 drivers/net/dsa/mv88e6xxx/chip.h              |   6 +-
 drivers/net/dsa/mv88e6xxx/port.c              |  52 ++--
 drivers/net/dsa/mv88e6xxx/port.h              |  19 +-
 drivers/net/dsa/ocelot/felix.c                |  22 ++
 drivers/net/dsa/sja1105/sja1105.h             |   2 +
 drivers/net/dsa/sja1105/sja1105_main.c        | 222 +++++++++++++++++-
 drivers/net/dsa/sja1105/sja1105_spi.c         |   6 +
 .../marvell/prestera/prestera_switchdev.c     |  26 +-
 .../mellanox/mlxsw/spectrum_switchdev.c       |  53 +++--
 drivers/net/ethernet/mscc/ocelot.c            | 100 +++++++-
 drivers/net/ethernet/mscc/ocelot_net.c        |  52 +++-
 drivers/net/ethernet/rocker/rocker_main.c     |  10 +-
 drivers/net/ethernet/ti/cpsw_switchdev.c      |  27 ++-
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c       |  34 ++-
 include/net/dsa.h                             |  10 +-
 include/net/switchdev.h                       |  13 +-
 include/soc/mscc/ocelot.h                     |  20 +-
 net/bridge/br_netlink.c                       | 116 +++------
 net/bridge/br_private.h                       |   6 +-
 net/bridge/br_switchdev.c                     |  23 +-
 net/bridge/br_sysfs_if.c                      |   7 +-
 net/dsa/dsa_priv.h                            |  11 +-
 net/dsa/port.c                                |  76 ++++--
 net/dsa/slave.c                               |  10 +-
 net/switchdev/switchdev.c                     |  11 +-
 28 files changed, 870 insertions(+), 320 deletions(-)

-- 
2.25.1

