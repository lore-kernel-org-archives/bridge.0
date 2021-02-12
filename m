Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9js+f0qftXEjk3IJleRBb/QBgSDgHgl8iRdUuTKast8=;
 b=of3rK2160oByIIF+kBqqx46rjK0WSMxkO7kPEe6tJr4iA+dDvK7Dzat72AyCT5iI8v
 Da+pwi6/NfrUoK2avV2XFp4k0z0B6ji1v7rSzNfCPaV4NgExTJRU3yPmaJExppN4amXG
 eHFlLGmi9nfNtqBrAsPkrdL4TBoHHrGw21fa3WsMi14HyyHWrAEAXyuByn40KFvmZNX9
 ZpTkhmXIDolxrmpb/CvmI0wXf3OlnH7CzSsoW2secyyyHugLLTnhm+0Y6c4zGRAQJvNB
 CER3Gr9IuoTxnuUll2AurDx22ml2btXEag6zrEJ9AXat8AZLhwEgDuIEMsdNrulqOPCl
 M6GQ==
From: Vladimir Oltean <olteanv@gmail.com>
Date: Fri, 12 Feb 2021 17:15:50 +0200
Message-Id: <20210212151600.3357121-1-olteanv@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH v5 net-next 00/10] Cleanup in brport flags
	switchdev offload for DSA
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Vignesh Raghavendra <vigneshr@ti.com>, Vadym Kochan <vkochan@marvell.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Ioana Ciornei <ioana.ciornei@nxp.com>, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, Taras Chornyi <tchornyi@marvell.com>, Ido Schimmel <idosch@idosch.org>, Claudiu Manoil <claudiu.manoil@nxp.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, linux-omap@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>

From: Vladimir Oltean <vladimir.oltean@nxp.com>

The initial goal of this series was to have better support for
standalone ports mode on the DSA drivers like ocelot/felix and sja1105.
This turned out to require some API adjustments in both directions:
to the information presented to and by the switchdev notifier, and to
the API presented to the switch drivers by the DSA layer.

Vladimir Oltean (10):
  net: switchdev: propagate extack to port attributes
  net: bridge: offload all port flags at once in br_setport
  net: bridge: don't print in br_switchdev_set_port_flag
  net: dsa: configure better brport flags when ports leave the bridge
  net: switchdev: pass flags and mask to both {PRE_,}BRIDGE_FLAGS
    attributes
  net: dsa: act as passthrough for bridge port flags
  net: dsa: felix: restore multicast flood to CPU when NPI tagger
    reinitializes
  net: mscc: ocelot: use separate flooding PGID for broadcast
  net: mscc: ocelot: offload bridge port flags to device
  net: dsa: sja1105: offload bridge port flags to device

 drivers/net/dsa/b53/b53_common.c              |  91 ++++---
 drivers/net/dsa/b53/b53_priv.h                |   2 -
 drivers/net/dsa/mv88e6xxx/chip.c              | 163 ++++++++++---
 drivers/net/dsa/mv88e6xxx/chip.h              |   6 +-
 drivers/net/dsa/mv88e6xxx/port.c              |  52 ++--
 drivers/net/dsa/mv88e6xxx/port.h              |  19 +-
 drivers/net/dsa/ocelot/felix.c                |  25 ++
 drivers/net/dsa/sja1105/sja1105.h             |   2 +
 drivers/net/dsa/sja1105/sja1105_main.c        | 222 +++++++++++++++++-
 drivers/net/dsa/sja1105/sja1105_spi.c         |   6 +
 .../marvell/prestera/prestera_switchdev.c     |  26 +-
 .../mellanox/mlxsw/spectrum_switchdev.c       |  53 +++--
 drivers/net/ethernet/mscc/ocelot.c            | 100 +++++++-
 drivers/net/ethernet/mscc/ocelot_net.c        |  52 +++-
 drivers/net/ethernet/rocker/rocker_main.c     |  10 +-
 drivers/net/ethernet/ti/am65-cpsw-switchdev.c |  27 ++-
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
 29 files changed, 889 insertions(+), 331 deletions(-)

-- 
2.25.1

