Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Sat, 26 Aug 2017 22:56:05 +0200
Message-Id: <1503780970-10312-1-git-send-email-andrew@lunn.ch>
Subject: [Bridge] [PATCH RFC WIP 0/5] IGMP snooping for local traffic
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev <netdev@vger.kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Vivien Didelot <vivien.didelot@savoirfairelinux.com>, nikolay@cumulusnetworks.com, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, jiri@mellanox.com

This is a WIP patchset i would like comments on from bridge, switchdev
and hardware offload people.

The linux bridge supports IGMP snooping. It will listen to IGMP
reports on bridge ports and keep track of which groups have been
joined on an interface. It will then forward multicast based on this
group membership.

When the bridge adds or removed groups from an interface, it uses
switchdev to request the hardware add an mdb to a port, so the
hardware can perform the selective forwarding between ports.

What is not covered by the current bridge code, is IGMP joins/leaves
from the host on the brX interface. No such monitoring is
performed. With a pure software bridge, it is not required. All
mulitcast frames are passed to the brX interface, and the network
stack filters them, as it does for any interface. However, when
hardware offload is involved, things change. We should program the
hardware to only send multcast packets to the host when the host has
in interest in them.

Thus we need to perform IGMP snooping on the brX interface, just like
any other interface of the bridge. However, currently the brX
interface is missing all the needed data structures to do this. There
is no net_bridge_port structure for the brX interface. This strucuture
is created when an interface is added to the bridge. But the brX
interface is not a member of the bridge. So this patchset makes the
brX interface a first class member of the bridge. When the brX
interface is opened, the interface is added to the bridge. A
net_bridge_port is allocated for it, and IGMP snooping is performed as
usual.

There are some complexities here. Some assumptions are broken, like
the master interface of a port interface is the bridge interface. The
brX interface cannot be its own master. The use of
netdev_master_upper_dev_get() within the bridge code has been changed
to reflecit this. The bridge receive handler needs to not process
frames for the brX interface, etc.

The interface downward to the hardware is also an issue. The code
presented here is a hack and needs to change. But that is secondary
and can be solved once it is agreed how the bridge needs to change to
support this use case.

Comment welcome and wanted.

	Andrew

Andrew Lunn (5):
  net: rtnetlink: Handle bridge port without upper device
  net: bridge: Skip receive handler on brX interface
  net: bridge: Make the brX interface a member of the bridge
  net: dsa: HACK: Handle MDB add/remove for none-switch ports
  net: dsa: Don't include CPU port when adding MDB to a port

 include/linux/if_bridge.h |  1 +
 net/bridge/br_device.c    | 12 ++++++++++--
 net/bridge/br_if.c        | 37 ++++++++++++++++++++++++-------------
 net/bridge/br_input.c     |  4 ++++
 net/bridge/br_mdb.c       |  2 --
 net/bridge/br_multicast.c |  7 ++++---
 net/bridge/br_private.h   |  1 +
 net/core/rtnetlink.c      | 23 +++++++++++++++++++++--
 net/dsa/port.c            | 19 +++++++++++++++++--
 net/dsa/switch.c          |  2 +-
 10 files changed, 83 insertions(+), 25 deletions(-)

-- 
2.14.1

