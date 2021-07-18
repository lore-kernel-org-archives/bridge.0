Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aXgAZKpvFD7MrvWAjGcK4E55sPm7zle8836ggooTT2w=;
 b=ZIj79gD5BP8NSydaeHygbMG67UIVOjJRr5lz4z6yKA5TgGh1WnVTegkw3YuDA3YiHlydTyvTWb02s00WCwwRUg2zP+9v1A2ldBf0U8rhVhsK+FbSytRyhaV7/DkkWnbr85CPNJ5LvKmoPH/iKjzTL/ZVaseclZHmN9sP+Hz0gR8=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Mon, 19 Jul 2021 00:44:19 +0300
Message-Id: <20210718214434.3938850-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [PATCH v4 net-next 00/15] Allow forwarding for the
	software bridge data path to be offloaded to capable devices
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, DENG Qingfang <dqfext@gmail.com>, Vadym Kochan <vkochan@marvell.com>, Steen Hegelund <Steen.Hegelund@microchip.com>, bridge@lists.linux-foundation.org, Ioana Ciornei <ioana.ciornei@nxp.com>, UNGLinuxDriver@microchip.com, Ido Schimmel <idosch@idosch.org>, Claudiu Manoil <claudiu.manoil@nxp.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Marek Behun <kabel@blackhole.sk>, Taras Chornyi <tchornyi@marvell.com>, Vivien Didelot <vivien.didelot@gmail.com>, Lars Povlsen <lars.povlsen@microchip.com>, Tobias Waldekranz <tobias@waldekranz.com>

I would like these patches to simmer for a few days and get some
feedback / confirmation that there are no regressions from switchdev
driver maintainers.

===========================================================

The data plane of the software bridge can be partially offloaded to
switchdev, in the sense that we can trust the accelerator to:
(a) look up its FDB (which is more or less in sync with the software
    bridge FDB) for selecting the destination ports for a packet
(b) replicate the frame in hardware in case it's a multicast/broadcast,
    instead of the software bridge having to clone it and send the
    clones to each net device one at a time. This reduces the bandwidth
    needed between the CPU and the accelerator, as well as the CPU time
    spent.

The data path forwarding offload is managed per "hardware domain" - a
generalization of the "offload_fwd_mark" concept which is being
introduced in this series. Every packet is delivered only once to each
hardware domain.

===========================================================

Message for v4:

The biggest change compared to the previous series is not present in the
patches, but is rather a lack of them. Previously we were replaying
switchdev objects on the public notifier chain, but that was a mistake
in my reasoning and it was reverted for v4. Therefore, we are now
passing the notifier blocks as arguments to switchdev_bridge_port_offload()
for all drivers. This alone gets rid of 7 patches compared to v3.

Other changes are:
- Take more care for the case where mlxsw leaves a VLAN or LAG upper
  that is a bridge port, make sure that switchdev_bridge_port_unoffload()
  gets called for that case
- A couple of DSA bug fixes
- Add change logs for all patches
- Copy all switchdev driver maintainers on the changes relevant to them

===========================================================

Message for v3:
https://patchwork.kernel.org/project/netdevbpf/cover/20210712152142.800651-1-vladimir.oltean@nxp.com/

In this submission I have introduced a "native switchdev" driver API to
signal whether the TX forwarding offload is supported or not. This comes
after a third person has said that the macvlan offload framework used
for v2 and v1 was simply too convoluted.

This large patch set is submitted for discussion purposes (it is
provided in its entirety so it can be applied & tested on net-next).
It is only minimally tested, and yet I will not copy all switchdev
driver maintainers until we agree on the viability of this approach.

The major changes compared to v2:
- The introduction of switchdev_bridge_port_offload() and
  switchdev_bridge_port_unoffload() as two major API changes from the
  perspective of a switchdev driver. All drivers were converted to call
  these.
- Augment switchdev_bridge_port_{,un}offload to also handle the
  switchdev object replays on port join/leave.
- Augment switchdev_bridge_port_offload to also signal whether the TX
  forwarding offload is supported.

===========================================================

Message for v2:
https://patchwork.kernel.org/project/netdevbpf/cover/20210703115705.1034112-1-vladimir.oltean@nxp.com/

For this series I have taken Tobias' work from here:
https://patchwork.kernel.org/project/netdevbpf/cover/20210426170411.1789186-1-tobias@waldekranz.com/
and made the following changes:
- I collected and integrated (hopefully all of) Nikolay's, Ido's and my
  feedback on the bridge driver changes. Otherwise, the structure of the
  bridge changes is pretty much the same as Tobias left it.
- I basically rewrote the DSA infrastructure for the data plane
  forwarding offload, based on the commonalities with another switch
  driver for which I implemented this feature (not submitted here)
- I adapted mv88e6xxx to use the new infrastructure, hopefully it still
  works but I didn't test that

In addition, Tobias said in the original cover letter:

===========================================================

## Overview

   vlan1   vlan2
       \   /
   .-----------.
   |    br0    |
   '-----------'
   /   /   \   \
swp0 swp1 swp2 eth0
  :   :   :
  (hwdom 1)

Up to this point, switchdevs have been trusted with offloading
forwarding between bridge ports, e.g. forwarding a unicast from swp0
to swp1 or flooding a broadcast from swp2 to swp1 and swp0. This
series extends forward offloading to include some new classes of
traffic:

- Locally originating flows, i.e. packets that ingress on br0 that are
  to be forwarded to one or several of the ports swp{0,1,2}. Notably
  this also includes routed flows, e.g. a packet ingressing swp0 on
  VLAN 1 which is then routed over to VLAN 2 by the CPU and then
  forwarded to swp1 is "locally originating" from br0's point of view.

- Flows originating from "foreign" interfaces, i.e. an interface that
  is not offloaded by a particular switchdev instance. This includes
  ports belonging to other switchdev instances. A typical example
  would be flows from eth0 towards swp{0,1,2}.

The bridge still looks up its FDB/MDB as usual and then notifies the
switchdev driver that a particular skb should be offloaded if it
matches one of the classes above. It does so by using the _accel
version of dev_queue_xmit, supplying its own netdev as the
"subordinate" device. The driver can react to the presence of the
subordinate in its .ndo_select_queue in what ever way it needs to make
sure to forward the skb in much the same way that it would for packets
ingressing on regular ports.

Hardware domains to which a particular skb has been forwarded are
recorded so that duplicates are avoided.

The main performance benefit is thus seen on multicast flows. Imagine
for example that:

- An IP camera is connected to swp0 (VLAN 1)

- The CPU is acting as a multicast router, routing the group from VLAN
  1 to VLAN 2.

- There are subscribers for the group in question behind both swp1 and
  swp2 (VLAN 2).

With this offloading in place, the bridge need only send a single skb
to the driver, which will send it to the hardware marked in such a way
that the switch will perform the multicast replication according to
the MDB configuration. Naturally, the number of saved skb_clones
increase linearly with the number of subscribed ports.

As an extra benefit, on mv88e6xxx, this also allows the switch to
perform source address learning on these flows, which avoids having to
sync dynamic FDB entries over slow configuration interfaces like MDIO
to avoid flows directed towards the CPU being flooded as unknown
unicast by the switch.


## RFC

- In general, what do you think about this idea?

- hwdom. What do you think about this terminology? Personally I feel
  that we had too many things called offload_fwd_mark, and that as the
  use of the bridge internal ID (nbp->offload_fwd_mark) expands, it
  might be useful to have a separate term for it.

- .dfwd_{add,del}_station. Am I stretching this abstraction too far,
  and if so do you have any suggestion/preference on how to signal the
  offloading from the bridge down to the switchdev driver?

- The way that flooding is implemented in br_forward.c (lazily cloning
  skbs) means that you have to mark the forwarding as completed very
  early (right after should_deliver in maybe_deliver) in order to
  avoid duplicates. Is there some way to move this decision point to a
  later stage that I am missing?

- BR_MULTICAST_TO_UNICAST. Right now, I expect that this series is not
  compatible with unicast-to-multicast being used on a port. Then
  again, I think that this would also be broken for regular switchdev
  bridge offloading as this flag is not offloaded to the switchdev
  port, so there is no way for the driver to refuse it. Any ideas on
  how to handle this?


## mv88e6xxx Specifics

Since we are now only receiving a single skb for both unicast and
multicast flows, we can tag the packets with the FORWARD command
instead of FROM_CPU. The swich(es) will then forward the packet in
accordance with its ATU, VTU, STU, and PVT configuration - just like
for packets ingressing on user ports.

Crucially, FROM_CPU is still used for:

- Ports in standalone mode.

- Flows that are trapped to the CPU and software-forwarded by a
  bridge. Note that these flows match neither of the classes discussed
  in the overview.

- Packets that are sent directly to a port netdev without going
  through the bridge, e.g. lldpd sending out PDU via an AF_PACKET
  socket.

We thus have a pretty clean separation where the data plane uses
FORWARDs and the control plane uses TO_/FROM_CPU.

The barrier between different bridges is enforced by port based VLANs
on mv88e6xxx, which in essence is a mapping from a source device/port
pair to an allowed set of egress ports. In order to have a FORWARD
frame (which carries a _source_ device/port) correctly mapped by the
PVT, we must use a unique pair for each bridge.

Fortunately, there is typically lots of unused address space in most
switch trees. When was the last time you saw an mv88e6xxx product
using more than 4 chips? Even if you found one with 16 (!) devices,
you would still have room to allocate 16*16 virtual ports to software
bridges.

Therefore, the mv88e6xxx driver will allocate a virtual device/port
pair to each bridge that it offloads. All members of the same bridge
are then configured to allow packets from this virtual port in their
PVTs.
====================

Cc: Vadym Kochan <vkochan@marvell.com>
Cc: Taras Chornyi <tchornyi@marvell.com>
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: Lars Povlsen <lars.povlsen@microchip.com>
Cc: Steen Hegelund <Steen.Hegelund@microchip.com>
Cc: UNGLinuxDriver@microchip.com
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>

Tobias Waldekranz (4):
  net: bridge: disambiguate offload_fwd_mark
  net: bridge: switchdev: recycle unused hwdoms
  net: bridge: switchdev: allow the TX data plane forwarding to be
    offloaded
  net: dsa: tag_dsa: offload the bridge forwarding process

Vladimir Oltean (11):
  net: dpaa2-switch: use extack in dpaa2_switch_port_bridge_join
  net: dpaa2-switch: refactor prechangeupper sanity checks
  mlxsw: spectrum: refactor prechangeupper sanity checks
  mlxsw: spectrum: refactor leaving an 8021q upper that is a bridge port
  net: marvell: prestera: refactor prechangeupper sanity checks
  net: switchdev: guard against multiple switchdev obj replays on same
    bridge port
  net: bridge: switchdev: let drivers inform which bridge ports are
    offloaded
  net: bridge: switchdev object replay helpers for everybody
  net: dsa: track the number of switches in a tree
  net: dsa: add support for bridge TX forwarding offload
  net: dsa: mv88e6xxx: map virtual bridges with forwarding offload in
    the PVT

 drivers/net/dsa/mv88e6xxx/chip.c              |  78 +++-
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
 include/linux/if_bridge.h                     |  63 ++--
 include/net/dsa.h                             |  21 ++
 net/bridge/br_fdb.c                           |   1 -
 net/bridge/br_forward.c                       |   9 +
 net/bridge/br_if.c                            |  11 +-
 net/bridge/br_mdb.c                           |   1 -
 net/bridge/br_private.h                       |  84 ++++-
 net/bridge/br_switchdev.c                     | 287 +++++++++++++--
 net/bridge/br_vlan.c                          |  11 +-
 net/dsa/dsa2.c                                |   4 +
 net/dsa/dsa_priv.h                            |   6 +
 net/dsa/port.c                                | 192 +++++++---
 net/dsa/tag_dsa.c                             |  52 ++-
 32 files changed, 1406 insertions(+), 348 deletions(-)

-- 
2.25.1

