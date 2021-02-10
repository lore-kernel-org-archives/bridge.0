Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=qNqiC3tG2xwOJq2qddxb/1WR+HrSzwiNawlUePCsQFs=;
 b=FZHA5b7/YbuGyx85UjaXr9oA7wpfJd4MyLm1ksHXD3V6l7MiRrIaewHCmrv+bq8Zi8
 hiJ22S3maNnxwqq2z4zZn9+TANcjaVDKFB6MX/1Vi3hnHUH+cTuWfy5r8n1etiZUXQdM
 LMfkTM71xfGGdEwcSrTmn70MpKhdA0FNWu4YQIStGJ4vr55WIyH7/AYfQ4SALcTXr6sk
 rxpgfNbQc9Z22hNYBB9+cL8Z/2Ue9GL8iuCl06lZN9wyyarPc4pKVqdZn0f5WJIBAoeg
 5F2jOum72Q5wcrtY5tjoR2ETeeXSk1Aai3Vc3ZChzfqCRC5WpEVJKfwwvp9XZAYFw3zI
 ccTQ==
From: Vladimir Oltean <olteanv@gmail.com>
Date: Wed, 10 Feb 2021 11:14:34 +0200
Message-Id: <20210210091445.741269-1-olteanv@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH v3 net-next 00/11] Cleanup in brport flags
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
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Vadym Kochan <vkochan@marvell.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Ioana Ciornei <ioana.ciornei@nxp.com>, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, Taras Chornyi <tchornyi@marvell.com>, Ido Schimmel <idosch@idosch.org>, Claudiu Manoil <claudiu.manoil@nxp.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, linux-omap@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>

From: Vladimir Oltean <vladimir.oltean@nxp.com>

The initial goal of this series was to have better support for
standalone ports mode and multiple bridges on the DSA drivers like
ocelot/felix and sja1105. Proper support for standalone mode requires
disabling address learning, which in turn requires interaction with the
switchdev notifier, which is actually where most of the patches are.

I also noticed that most of the drivers are actually talking either to
firmware or SPI/MDIO connected devices from the brport flags switchdev
attribute handler, so it makes sense to actually make it sleepable
instead of atomic.

Vladimir Oltean (11):
  net: switchdev: propagate extack to port attributes
  net: bridge: offload all port flags at once in br_setport
  net: bridge: don't print in br_switchdev_set_port_flag
  net: dsa: configure proper brport flags when ports leave the bridge
  net: squash switchdev attributes PRE_BRIDGE_FLAGS and BRIDGE_FLAGS
  net: dsa: kill .port_egress_floods overengineering
  net: prep switchdev drivers for concurrent
    SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS
  net: bridge: put SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS on the blocking
    call chain
  net: mscc: ocelot: use separate flooding PGID for broadcast
  net: mscc: ocelot: offload bridge port flags to device
  net: dsa: sja1105: offload bridge port flags to device

 drivers/net/dsa/b53/b53_common.c              |  20 +-
 drivers/net/dsa/mv88e6xxx/chip.c              |  21 +-
 drivers/net/dsa/ocelot/felix.c                |  10 +
 drivers/net/dsa/sja1105/sja1105.h             |   2 +
 drivers/net/dsa/sja1105/sja1105_main.c        | 212 +++++++++++++++++-
 drivers/net/dsa/sja1105/sja1105_spi.c         |   6 +
 .../marvell/prestera/prestera_switchdev.c     |  54 +++--
 .../mellanox/mlxsw/spectrum_switchdev.c       |  90 ++++----
 drivers/net/ethernet/mscc/ocelot.c            |  72 +++++-
 drivers/net/ethernet/mscc/ocelot_net.c        |   7 +-
 drivers/net/ethernet/rocker/rocker.h          |   2 +-
 drivers/net/ethernet/rocker/rocker_main.c     |  24 +-
 drivers/net/ethernet/rocker/rocker_ofdpa.c    |  26 ++-
 drivers/net/ethernet/ti/cpsw_switchdev.c      |  35 ++-
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c       |  43 ++--
 include/net/dsa.h                             |   7 +-
 include/net/switchdev.h                       |  14 +-
 include/soc/mscc/ocelot.h                     |  18 +-
 net/bridge/br_netlink.c                       | 162 ++++++-------
 net/bridge/br_private.h                       |   6 +-
 net/bridge/br_switchdev.c                     |  33 ++-
 net/bridge/br_sysfs_if.c                      |  21 +-
 net/dsa/dsa_priv.h                            |   8 +-
 net/dsa/port.c                                |  76 ++++---
 net/dsa/slave.c                               |  10 +-
 net/switchdev/switchdev.c                     |  11 +-
 26 files changed, 654 insertions(+), 336 deletions(-)

-- 
2.25.1

