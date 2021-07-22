Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NG5DNaes5yll3Ujhl93ZAxWZcRBX/Nqq9KUv/zURod0=;
 b=UOfYWiCl6ICByqsb3MG4MIsCDyP13Htw+gFS/jwrFa7amxLE/3qu0O11IfQAI3CLdduDBgRFP0CwW5JnSRdcZAIzl5rDIVOlM2hcJb1IHcMjgs0/9GPgc5oxOFmW7kXCHkEL1PG7feUY1mFxC3TnBqpgH4BPd25qKbuegUYEHQE=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Thu, 22 Jul 2021 18:55:37 +0300
Message-Id: <20210722155542.2897921-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [PATCH v5 net-next 0/5] Allow TX forwarding for the
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

On RX, switchdev drivers have the ability to mark packets for the
software bridge as "already forwarded in hardware" via
skb->offload_fwd_mark. This instructs the nbp_switchdev_allowed_egress()
function to perform software forwarding of that packet only to the bridge
ports that are not in the same hardware domain as the source packet.

This series expands the concept for TX, in the sense that we can trust
the accelerator to:
(a) look up its FDB (which is more or less in sync with the software
    bridge FDB) for selecting the destination ports for a packet
(b) replicate the frame in hardware in case it's a multicast/broadcast,
    instead of the software bridge having to clone it and send the
    clones to each net device one at a time. This reduces the bandwidth
    needed between the CPU and the accelerator, as well as the CPU time
    spent.

This is done by augmenting nbp_switchdev_allowed_egress() to also
exclude the bridge ports which have the tx_fwd_offload capability if the
skb has already been transmitted to one port from their hardware domain.

Even though in reality, the software bridge still technically looks up
the FDB/MDB for every frame, but all skb clones are suppressed, this
offload specifically requires that the switchdev accelerator looks up
its FDB/MDB again. It is intended to be used to inject "data plane
packets" into the hardware as opposed to "control plane packets" which
target a precise destination port.

Towards that goal, the bridge always provides the TX packets with
skb->offload_fwd_mark = true with the VLAN tag always present, so that
the accelerator can forward according to that VLAN broadcast domain.

This work is not intended to cater to switches which can inject control
plane packets to a bit mask of destination ports. I see that as a more
difficult task to accomplish with potentially less benefits (it provides
only replication offload). The reason it is more difficult is that
struct skb_buff would probably need to be extended to contain a list of
struct net_devices that the packet must be replicated to. Sending data
plane packets avoids that issue by keeping the hardware and software FDB
more or less in sync and looking it up twice.

Additionally, the ability for the software bridge to request data plane
packets to be sent brings the opportunity for "dumb switches" to support
traffic termination to/from the bridge. Such switches (DSA or otherwise)
typically only use control packets for link-local traps, and sending or
receiving a control packet is an expensive operation.

For this class of switches, this patch series makes the difference
between supporting and not supporting local IP termination through a
VLAN-aware bridge, bridging with a foreign interface, bridging with
software upper interfaces like LAG, etc. So instead of telling them
"oh, what a dumb switch you are!", we can now tell them "oh, what a
stark contrast you have between the control and data plane!".

Patches 1-3 tested on Turris MOX (3 mv88e6xxx switches in a daisy chain
topology) and a second DSA driver to be added soon. Patches 4-5 tested
only on Turris MOX.

===========================================================

Changes in v5:
- make sure the static key is decremented on bridge port unoffload
- rename functions and variables so that the "tx_fwd_offload" string is
  easy to grep across the git tree
- simplify DSA core bookkeeping of the bridge_num

===========================================================

Changes in v4:

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

===========================================================

Cc: Vadym Kochan <vkochan@marvell.com>
Cc: Taras Chornyi <tchornyi@marvell.com>
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: Lars Povlsen <lars.povlsen@microchip.com>
Cc: Steen Hegelund <Steen.Hegelund@microchip.com>
Cc: UNGLinuxDriver@microchip.com
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>

Tobias Waldekranz (2):
  net: bridge: switchdev: allow the TX data plane forwarding to be
    offloaded
  net: dsa: tag_dsa: offload the bridge forwarding process

Vladimir Oltean (3):
  net: dsa: track the number of switches in a tree
  net: dsa: add support for bridge TX forwarding offload
  net: dsa: mv88e6xxx: map virtual bridges with forwarding offload in
    the PVT

 drivers/net/dsa/mv88e6xxx/chip.c              | 78 ++++++++++++++++-
 .../ethernet/freescale/dpaa2/dpaa2-switch.c   |  2 +-
 .../marvell/prestera/prestera_switchdev.c     |  2 +-
 .../mellanox/mlxsw/spectrum_switchdev.c       |  2 +-
 .../microchip/sparx5/sparx5_switchdev.c       |  2 +-
 drivers/net/ethernet/mscc/ocelot_net.c        |  2 +-
 drivers/net/ethernet/rocker/rocker_ofdpa.c    |  2 +-
 drivers/net/ethernet/ti/am65-cpsw-nuss.c      |  2 +-
 drivers/net/ethernet/ti/cpsw_new.c            |  2 +-
 include/linux/if_bridge.h                     |  3 +
 include/net/dsa.h                             | 21 +++++
 net/bridge/br_forward.c                       |  9 ++
 net/bridge/br_private.h                       | 31 +++++++
 net/bridge/br_switchdev.c                     | 68 ++++++++++++++-
 net/bridge/br_vlan.c                          | 10 ++-
 net/dsa/dsa2.c                                |  4 +
 net/dsa/dsa_priv.h                            |  2 +
 net/dsa/port.c                                | 84 ++++++++++++++++++-
 net/dsa/tag_dsa.c                             | 52 ++++++++++--
 19 files changed, 352 insertions(+), 26 deletions(-)

-- 
2.25.1

