Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=9j78vu7ptfWqRyUO8h/FcNUzTEZkGd60eZJnk+28JkI=;
	b=LFhjxPHt8r/+VF7jvkLf35nXy0MpozaT0bKd630pgNvgmQ9OmbAfSPM3rEfWvNkFCA
	P2a/42B0bJ/Hg8X5iNvKFwr/A5cc0Nb04gm5l1RgSSyT1IWjGq7aCGJMrt6BYeur3x9G
	WMzx3rpBzxVstQtdSNydYlxGWdfSZDOtVBGAV3rkqxaacCz2wgMCqzDfsTyYNq8XU8uT
	ErqvAEmsdPMD4+tbcGKCk9yThrkUFcxRzEF/ABj0m/LWVdq0w47Os9vhWZ94nmI/o9Cd
	merPd1QjVAo+96PcNzRRNiQAmPtNHCEbZuU13+fcxHiMC/Y5VSqpD7qbr6WAfqBn0Kan
	hauw==
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Sun, 10 Feb 2019 09:50:49 -0800
Message-Id: <20190210175105.31629-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next v2 00/16] net: Remove switchdev_ops
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: devel@driverdev.osuosl.org, andrew@lunn.ch, Florian Fainelli <f.fainelli@gmail.com>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, idosch@mellanox.com, jiri@mellanox.com, vivien.didelot@gmail.com

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

Changes in v2:
- fixed bisectability issues in patch #15
- added Acked-by from Jiri where necessary
- fixed a few minor issues according to Jiri's feedback:
	- rename port_attr_event -> port_attr_set_event
	- moved SWITCHDEV_PORT_ATTR_SET closer to other blocking events

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
 .../mellanox/mlxsw/spectrum_switchdev.c       | 69 ++++----------
 drivers/net/ethernet/mscc/ocelot.c            | 21 +++-
 drivers/net/ethernet/rocker/rocker_main.c     | 95 ++++++++-----------
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c       | 48 ++++------
 include/linux/netdevice.h                     |  3 -
 include/net/switchdev.h                       | 36 ++-----
 net/bridge/br_switchdev.c                     | 20 +---
 net/dsa/dsa_priv.h                            |  3 +
 net/dsa/port.c                                | 10 ++
 net/dsa/slave.c                               | 40 ++++----
 net/switchdev/switchdev.c                     | 92 +++++-------------
 14 files changed, 170 insertions(+), 296 deletions(-)

-- 
2.19.1

