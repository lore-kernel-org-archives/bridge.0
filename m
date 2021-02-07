Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=qdOLN8iSy3qRTlCt7W2Tkt/uKoMbxQxcelWIFl4Tv0c=;
 b=Byzf7Ch6lxgMByroVpIyGbVWj+WES57XvUbGEWPQ2MDz1xZYNGbPNk9g/UBuyfdJZ0
 370tyntgVPLxpitPW7poWT9XkCvYie4tVQJvYCzW2etWEZn3SzhHcC3YkOc9tMrGVrF4
 C0oDi+3KPIy9x8XBuEYc3IGodXUknCADmCP7cKJTD9L3VMdJdGyd7DL6tXh5gdT4BC6I
 lfh5i28iucwGR6Tf5WYOiVW7P/zSvHTyzFeK+VME2GVttYIqHK31T+1nVE4FAzBbKKxQ
 IQuDdIcAeQ3vnKwNdl2INdVhnREjtNSwTEaiPdPTMUJDmsr15U1xyiMNUTkKn4TBRL7u
 0kWw==
From: Vladimir Oltean <olteanv@gmail.com>
Date: Mon,  8 Feb 2021 01:21:32 +0200
Message-Id: <20210207232141.2142678-1-olteanv@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 0/9] Cleanup in brport flags switchdev
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
standalone ports mode and multiple bridges on the Ocelot/Felix DSA
driver. Proper support for standalone mode requires disabling address
learning, which in turn requires interaction with the switchdev notifier,
which is actually where most of the patches are.

Vladimir Oltean (9):
  net: bridge: don't print in br_switchdev_set_port_flag
  net: bridge: offload initial and final port flags through switchdev
  net: dsa: stop setting initial and final brport flags
  net: dsa: kill .port_egress_floods overengineering
  net: squash switchdev attributes PRE_BRIDGE_FLAGS and BRIDGE_FLAGS
  net: bridge: stop treating EOPNOTSUPP as special in
    br_switchdev_set_port_flag
  net: mscc: ocelot: use separate flooding PGID for broadcast
  net: mscc: ocelot: offload bridge port flags to device
  net: mscc: ocelot: support multiple bridges

 drivers/net/dsa/b53/b53_common.c              |  18 ++-
 drivers/net/dsa/mv88e6xxx/chip.c              |  19 ++-
 drivers/net/dsa/ocelot/felix.c                |   9 ++
 .../marvell/prestera/prestera_switchdev.c     |  16 +--
 .../mellanox/mlxsw/spectrum_switchdev.c       |  28 ++--
 drivers/net/ethernet/mscc/ocelot.c            | 135 +++++++++++++-----
 drivers/net/ethernet/mscc/ocelot_net.c        |   4 +
 drivers/net/ethernet/mscc/ocelot_vsc7514.c    |   2 +-
 drivers/net/ethernet/rocker/rocker_main.c     |  24 +---
 drivers/net/ethernet/ti/cpsw_switchdev.c      |  20 +--
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c       |  22 +--
 include/net/dsa.h                             |   6 +-
 include/net/switchdev.h                       |   8 +-
 include/soc/mscc/ocelot.h                     |  26 ++--
 net/bridge/br_if.c                            |  24 +++-
 net/bridge/br_netlink.c                       |  67 +++++----
 net/bridge/br_private.h                       |   8 +-
 net/bridge/br_switchdev.c                     |  35 ++---
 net/dsa/dsa_priv.h                            |   4 +-
 net/dsa/port.c                                |  40 ++----
 net/dsa/slave.c                               |   3 -
 21 files changed, 285 insertions(+), 233 deletions(-)

-- 
2.25.1

