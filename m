Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LglH0w1vp4WC3sskwgO3VjbY6Ou7YGQatfYwouiD61E=;
 b=WRyjAeY2Uzqzgmo11Z6lFLoYYKfs2IInIsmk6c0Tul8ogYBON+WNPq3txN/2tVvxRDfJI8i3Wp2E3erX/ke7eZ1sk5EboWfEo/Y/2fQV7mCoHCyJM5ZN8YVtkrBAMxuGrXSbrlpMPlVzlpXphL2OH6eX8V6Yntthf2YMr4iBKfk=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Tue, 20 Jul 2021 16:46:45 +0300
Message-Id: <20210720134655.892334-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [PATCH v5 net-next 00/10] Let switchdev drivers offload
	and unoffload bridge ports at their own convenience
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, DENG Qingfang <dqfext@gmail.com>, bridge@lists.linux-foundation.org, Ido Schimmel <idosch@idosch.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Marek Behun <kabel@blackhole.sk>, Vivien Didelot <vivien.didelot@gmail.com>, Tobias Waldekranz <tobias@waldekranz.com>

This series introduces an explicit API through which switchdev drivers
mark a bridge port as offloaded or not:
- switchdev_bridge_port_offload()
- switchdev_bridge_port_unoffload()

Currently, the bridge assumes that a port is offloaded if
dev_get_port_parent_id(dev, &ppid, recurse=true) returns something, but
that is just an assumption that breaks some use cases (like a
non-offloaded LAG interface on top of a switchdev port, bridged with
other switchdev ports).

Along with some consolidation of the bridge logic to assign a "switchdev
offloading mark" to a port (now better called a "hardware domain"), this
series allows the bridge driver side to no longer impose restrictions on
that configuration.

Right now, all switchdev drivers must be modified to use the explicit
API, but more and more logic can then be placed centrally in the bridge
and therefore ease the job of a switchdev driver writer in the future.

For example, the first thing we can hook into the explicit switchdev
offloading API calls are the switchdev object and FDB replay helpers.
So far, these have only been used by DSA in "pull" mode (where the
driver must ask for them). Adding the replay helpers to other drivers
involves a lot of repetition. But by moving the helpers inside the
bridge port offload/unoffload hook points, we can move the entire replay
process to "push" mode (where the bridge provides them automatically).

The explicit switchdev offloading API will see further extensions in the
future.

The patches were split from a larger series for easier review:
https://patchwork.kernel.org/project/netdevbpf/cover/20210718214434.3938850-1-vladimir.oltean@nxp.com/

Tobias Waldekranz (2):
  net: bridge: disambiguate offload_fwd_mark
  net: bridge: switchdev: recycle unused hwdoms

Vladimir Oltean (8):
  net: dpaa2-switch: use extack in dpaa2_switch_port_bridge_join
  net: dpaa2-switch: refactor prechangeupper sanity checks
  mlxsw: spectrum: refactor prechangeupper sanity checks
  mlxsw: spectrum: refactor leaving an 8021q upper that is a bridge port
  net: marvell: prestera: refactor prechangeupper sanity checks
  net: switchdev: guard drivers against multiple obj replays on same
    bridge port
  net: bridge: switchdev: let drivers inform which bridge ports are
    offloaded
  net: bridge: switchdev object replay helpers for everybody

 .../ethernet/freescale/dpaa2/dpaa2-switch.c   |  69 +++-
 .../ethernet/marvell/prestera/prestera_main.c |  99 +++--
 .../marvell/prestera/prestera_switchdev.c     |  42 ++-
 .../marvell/prestera/prestera_switchdev.h     |   7 +-
 .../net/ethernet/mellanox/mlxsw/spectrum.c    | 347 ++++++++++++------
 .../net/ethernet/mellanox/mlxsw/spectrum.h    |   4 +
 .../mellanox/mlxsw/spectrum_switchdev.c       |  28 +-
 .../microchip/sparx5/sparx5_switchdev.c       |  48 ++-
 drivers/net/ethernet/mscc/ocelot_net.c        | 115 ++++--
 drivers/net/ethernet/rocker/rocker.h          |   9 +-
 drivers/net/ethernet/rocker/rocker_main.c     |  34 +-
 drivers/net/ethernet/rocker/rocker_ofdpa.c    |  42 ++-
 drivers/net/ethernet/ti/am65-cpsw-nuss.c      |  34 +-
 drivers/net/ethernet/ti/am65-cpsw-switchdev.c |  14 +-
 drivers/net/ethernet/ti/am65-cpsw-switchdev.h |   3 +
 drivers/net/ethernet/ti/cpsw_new.c            |  32 +-
 drivers/net/ethernet/ti/cpsw_switchdev.c      |   4 +-
 drivers/net/ethernet/ti/cpsw_switchdev.h      |   3 +
 include/linux/if_bridge.h                     |  60 +--
 net/bridge/br_fdb.c                           |   1 -
 net/bridge/br_if.c                            |  11 +-
 net/bridge/br_mdb.c                           |   1 -
 net/bridge/br_private.h                       |  61 ++-
 net/bridge/br_switchdev.c                     | 254 +++++++++++--
 net/bridge/br_vlan.c                          |   1 -
 net/dsa/port.c                                |  83 ++---
 26 files changed, 1059 insertions(+), 347 deletions(-)

-- 
2.25.1

