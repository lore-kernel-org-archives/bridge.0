Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 734FB403B8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A604740125
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PRTMX2cyeDz0IjxF5vdAuoIeYnz1bsy0L4jrQBzjmmI=;
 b=o00iRMQHN+M/AZo/wKzLhYDavuaTwi7eUITzFfKn1I8iKSvdF9rqYx9sxephxE3f5QjDPc3xCMX8wljq+GpodXqhO2oWjzw9hm2WxtdCggVzrnuA/f9JiFIv+uWoty5njC5w5lxKK9CA+pg0Ld5kZ9xXudTKFuJMlXDn46qkApytNJC42ja1MtuznfUTEgzbphW5+maj79uKr6P9rrM4q23OyymMXF3Jn0CGPLg81FmQhWRZX0Bp2AAnmA0spMuk1keX7mLS0gEBmy1E0jx/xiS7Lf3cRbePm4USrWnM2Fq0FSZZXjYLyCs6bzjfhjgndgWjlynyOL/q4ZYOu9vlsA==
From: Ido Schimmel <idosch@nvidia.com>
Date: Sat, 10 Dec 2022 16:56:19 +0200
Message-Id: <20221210145633.1328511-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next v2 00/14] bridge: mcast: Extensions for
	EVPN
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: mlxsw@nvidia.com, razor@blackwall.org, Ido Schimmel <idosch@nvidia.com>, edumazet@google.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

tl;dr
=====

This patchset creates feature parity between user space and the kernel
and allows the former to install and replace MDB port group entries with
a source list and associated filter mode. This is required for EVPN use
cases where multicast state is not derived from snooped IGMP/MLD
packets, but instead derived from EVPN routes exchanged by the control
plane in user space.

Background
==========

IGMPv3 [1] and MLDv2 [2] differ from earlier versions of the protocols
in that they add support for source-specific multicast. That is, hosts
can advertise interest in listening to a particular multicast address
only from specific source addresses or from all sources except for
specific source addresses.

In kernel 5.10 [3][4], the bridge driver gained the ability to snoop
IGMPv3/MLDv2 packets and install corresponding MDB port group entries.
For example, a snooped IGMPv3 Membership Report that contains a single
MODE_IS_EXCLUDE record for group 239.10.10.10 with sources 192.0.2.1,
192.0.2.2, 192.0.2.20 and 192.0.2.21 would trigger the creation of these
entries:

 # bridge -d mdb show
 dev br0 port veth1 grp 239.10.10.10 src 192.0.2.21 temp filter_mode include proto kernel  blocked
 dev br0 port veth1 grp 239.10.10.10 src 192.0.2.20 temp filter_mode include proto kernel  blocked
 dev br0 port veth1 grp 239.10.10.10 src 192.0.2.2 temp filter_mode include proto kernel  blocked
 dev br0 port veth1 grp 239.10.10.10 src 192.0.2.1 temp filter_mode include proto kernel  blocked
 dev br0 port veth1 grp 239.10.10.10 temp filter_mode exclude source_list 192.0.2.21/0.00,192.0.2.20/0.00,192.0.2.2/0.00,192.0.2.1/0.00 proto kernel

While the kernel can install and replace entries with a filter mode and
source list, user space cannot. It can only add EXCLUDE entries with an
empty source list, which is sufficient for IGMPv2/MLDv1, but not for
IGMPv3/MLDv2.

Use cases where the multicast state is not derived from snooped packets,
but instead derived from routes exchanged by the user space control
plane require feature parity between user space and the kernel in terms
of MDB configuration. Such a use case is detailed in the next section.

Motivation
==========

RFC 7432 [5] defines a "MAC/IP Advertisement route" (type 2) [6] that
allows NVE switches in the EVPN network to advertise and learn
reachability information for unicast MAC addresses. Traffic destined to
a unicast MAC address can therefore be selectively forwarded to a single
NVE switch behind which the MAC is located.

The same is not true for IP multicast traffic. Such traffic is simply
flooded as BUM to all NVE switches in the broadcast domain (BD),
regardless if a switch has interested receivers for the multicast stream
or not. This is especially problematic for overlay networks that make
heavy use of multicast.

The issue is addressed by RFC 9251 [7] that defines a "Selective
Multicast Ethernet Tag Route" (type 6) [8] which allows NVE switches in
the EVPN network to advertise multicast streams that they are interested
in. This is done by having each switch suppress IGMP/MLD packets from
being transmitted to the NVE network and instead communicate the
information over BGP to other switches.

As far as the bridge driver is concerned, the above means that the
multicast state (i.e., {multicast address, group timer, filter-mode,
(source records)}) for the VXLAN bridge port is not populated by the
kernel from snooped IGMP/MLD packets (they are suppressed), but instead
by user space. Specifically, by the routing daemon that is exchanging
EVPN routes with other NVE switches.

Changes are obviously also required in the VXLAN driver, but they are
the subject of future patchsets. See the "Future work" section.

Implementation
==============

The user interface is extended to allow user space to specify the filter
mode of the MDB port group entry and its source list. Replace support is
also added so that user space would not need to remove an entry and
re-add it only to edit its source list or filter mode, as that would
result in packet loss. Example usage:

 # bridge mdb replace dev br0 port dummy10 grp 239.1.1.1 permanent \
	source_list 192.0.2.1,192.0.2.3 filter_mode exclude proto zebra
 # bridge -d -s mdb show
 dev br0 port dummy10 grp 239.1.1.1 src 192.0.2.3 permanent filter_mode include proto zebra  blocked    0.00
 dev br0 port dummy10 grp 239.1.1.1 src 192.0.2.1 permanent filter_mode include proto zebra  blocked    0.00
 dev br0 port dummy10 grp 239.1.1.1 permanent filter_mode exclude source_list 192.0.2.3/0.00,192.0.2.1/0.00 proto zebra     0.00

The netlink interface is extended with a few new attributes in the
RTM_NEWMDB request message:

[ struct nlmsghdr ]
[ struct br_port_msg ]
[ MDBA_SET_ENTRY ]
	struct br_mdb_entry
[ MDBA_SET_ENTRY_ATTRS ]
	[ MDBE_ATTR_SOURCE ]
		struct in_addr / struct in6_addr
	[ MDBE_ATTR_SRC_LIST ]		// new
		[ MDBE_SRC_LIST_ENTRY ]
			[ MDBE_SRCATTR_ADDRESS ]
				struct in_addr / struct in6_addr
		[ ...]
	[ MDBE_ATTR_GROUP_MODE ]	// new
		u8
	[ MDBE_ATTR_RTPORT ]		// new
		u8

No changes are required in RTM_NEWMDB responses and notifications, as
all the information can already be dumped by the kernel today.

Testing
=======

Tested with existing bridge multicast selftests: bridge_igmp.sh,
bridge_mdb_port_down.sh, bridge_mdb.sh, bridge_mld.sh,
bridge_vlan_mcast.sh.

In addition, added many new test cases for existing as well as for new
MDB functionality.

Patchset overview
=================

Patches #1-#8 are non-functional preparations for the core changes in
later patches.

Patches #9-#10 allow user space to install (*, G) entries with a source
list and associated filter mode. Specifically, patch #9 adds the
necessary kernel plumbing and patch #10 exposes the new functionality to
user space via a few new attributes.

Patch #11 allows user space to specify the routing protocol of new MDB
port group entries so that a routing daemon could differentiate between
entries installed by it and those installed by an administrator.

Patch #12 allows user space to replace MDB port group entries. This is
useful, for example, when user space wants to add a new source to a
source list. Instead of deleting a (*, G) entry and re-adding it with an
extended source list (which would result in packet loss), user space can
simply replace the current entry.

Patches #13-#14 add tests for existing MDB functionality as well as for
all new functionality added in this patchset.

Future work
===========

The VXLAN driver will need to be extended with an MDB so that it could
selectively forward IP multicast traffic to NVE switches with interested
receivers instead of simply flooding it to all switches as BUM.

The idea is to reuse the existing MDB interface for the VXLAN driver in
a similar way to how the FDB interface is shared between the bridge and
VXLAN drivers.

From command line perspective, configuration will look as follows:

 # bridge mdb add dev br0 port vxlan0 grp 239.1.1.1 permanent \
	filter_mode exclude source_list 198.50.100.1,198.50.100.2

 # bridge mdb add dev vxlan0 port vxlan0 grp 239.1.1.1 permanent \
	filter_mode include source_list 198.50.100.3,198.50.100.4 \
	dst 192.0.2.1 dst_port 4789 src_vni 2

 # bridge mdb add dev vxlan0 port vxlan0 grp 239.1.1.1 permanent \
	filter_mode exclude source_list 198.50.100.1,198.50.100.2 \
	dst 192.0.2.2 dst_port 4789 src_vni 2

Where the first command is enabled by this set, but the next two will be
the subject of future work.

From netlink perspective, the existing PF_BRIDGE/RTM_*MDB messages will
be extended to the VXLAN driver. This means that a few new attributes
will be added (e.g., 'MDBE_ATTR_SRC_VNI') and that the handlers for
these messages will need to move to net/core/rtnetlink.c. The rtnetlink
code will call into the appropriate driver based on the ifindex
specified in the ancillary header.

iproute2 patches can be found here [9].

Changelog
=========

Since v1 [10]:

* Patch #12: Remove extack from br_mdb_replace_group_sg().
* Patch #12: Change 'nlflags' to u16 and move it after 'filter_mode' to
  pack the structure.

Since RFC [11]:

* Patch #6: New patch.
* Patch #9: Use an array instead of a list to store source entries.
* Patch #10: Use an array instead of list to store source entries.
* Patch #10: Drop br_mdb_config_attrs_fini().
* Patch #11: Reject protocol for host entries.
* Patch #13: New patch.
* Patch #14: New patch.

[1] https://datatracker.ietf.org/doc/html/rfc3376
[2] https://www.rfc-editor.org/rfc/rfc3810
[3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6af52ae2ed14a6bc756d5606b29097dfd76740b8
[4] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=68d4fd30c83b1b208e08c954cd45e6474b148c87
[5] https://datatracker.ietf.org/doc/html/rfc7432
[6] https://datatracker.ietf.org/doc/html/rfc7432#section-7.2
[7] https://datatracker.ietf.org/doc/html/rfc9251
[8] https://datatracker.ietf.org/doc/html/rfc9251#section-9.1
[9] https://github.com/idosch/iproute2/commits/submit/mdb_v1
[10] https://lore.kernel.org/netdev/20221208152839.1016350-1-idosch@nvidia.com/
[11] https://lore.kernel.org/netdev/20221018120420.561846-1-idosch@nvidia.com/

Ido Schimmel (14):
  bridge: mcast: Do not derive entry type from its filter mode
  bridge: mcast: Split (*, G) and (S, G) addition into different
    functions
  bridge: mcast: Place netlink policy before validation functions
  bridge: mcast: Add a centralized error path
  bridge: mcast: Expose br_multicast_new_group_src()
  bridge: mcast: Expose __br_multicast_del_group_src()
  bridge: mcast: Add a flag for user installed source entries
  bridge: mcast: Avoid arming group timer when (S, G) corresponds to a
    source
  bridge: mcast: Add support for (*, G) with a source list and filter
    mode
  bridge: mcast: Allow user space to add (*, G) with a source list and
    filter mode
  bridge: mcast: Allow user space to specify MDB entry routing protocol
  bridge: mcast: Support replacement of MDB port group entries
  selftests: forwarding: Rename bridge_mdb test
  selftests: forwarding: Add bridge MDB test

 include/uapi/linux/if_bridge.h                |   21 +
 net/bridge/br_mdb.c                           |  525 +++++++-
 net/bridge/br_multicast.c                     |   16 +-
 net/bridge/br_private.h                       |   15 +
 .../testing/selftests/net/forwarding/Makefile |    1 +
 .../selftests/net/forwarding/bridge_mdb.sh    | 1127 ++++++++++++++++-
 .../net/forwarding/bridge_mdb_host.sh         |  103 ++
 7 files changed, 1708 insertions(+), 100 deletions(-)
 create mode 100755 tools/testing/selftests/net/forwarding/bridge_mdb_host.sh

-- 
2.37.3

