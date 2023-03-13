Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2456D41703
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EE9E3416E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kw/A6aRR7w4f7luwdrzzzDDo8ekmSK6/dM7h+W39FpA=;
 b=XTDOXwAWLSwZdMZ49W94PzC0xmhbsBgLA7P48oQCt1tjBzVswyXCBIHWcHyzIpB9Zm0xQd0+DBwAJzin1oeNZna0xebboTLqN0JZ+Sz36iNWKJ5VqiO6+kkN8MCbxwUYNZp2IuD5wL/9T618wlZny7yjfaJJmhp1zqRmiMA3yQJ1XojbHjru5OlCp1JJOcqXQAvDC0peyA3VEj6FNcM3wbaEaueKWr0pl68c7uMDDPV+M4iN/H0E1VFuTlYaLcdFHRK5nzCNQ6amCES1cEP8co7EvrWvghfwGEAETUa5GoUYgJVHqB9ugcl1CBYQCwJjCGgFjyFJJxl89L0SEdP5UQ==
From: Ido Schimmel <idosch@nvidia.com>
Date: Mon, 13 Mar 2023 16:53:38 +0200
Message-Id: <20230313145349.3557231-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next 00/11] vxlan: Add MDB support
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: petrm@nvidia.com, mlxsw@nvidia.com, razor@blackwall.org, Ido Schimmel <idosch@nvidia.com>, edumazet@google.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

tl;dr
=====

This patchset implements MDB support in the VXLAN driver, allowing it to
selectively forward IP multicast traffic to VTEPs with interested
receivers instead of flooding it to all the VTEPs as BUM. The motivating
use case is intra and inter subnet multicast forwarding using EVPN
[1][2], which means that MDB entries are only installed by the user
space control plane and no snooping is implemented, thereby avoiding a
lot of unnecessary complexity in the kernel.

Background
==========

Both the bridge and VXLAN drivers have an FDB that allows them to
forward Ethernet frames based on their destination MAC addresses and
VLAN/VNI. These FDBs are managed using the same PF_BRIDGE/RTM_*NEIGH
netlink messages and bridge(8) utility.

However, only the bridge driver has an MDB that allows it to selectively
forward IP multicast packets to bridge ports with interested receivers
behind them, based on (S, G) and (*, G) MDB entries. When these packets
reach the VXLAN driver they are flooded using the "all-zeros" FDB entry
(00:00:00:00:00:00). The entry either includes the list of all the VTEPs
in the tenant domain (when ingress replication is used) or the multicast
address of the BUM tunnel (when P2MP tunnels are used), to which all the
VTEPs join.

Networks that make heavy use of multicast in the overlay can benefit
from a solution that allows them to selectively forward IP multicast
traffic only to VTEPs with interested receivers. Such a solution is
described in the next section.

Motivation
==========

RFC 7432 [3] defines a "MAC/IP Advertisement route" (type 2) [4] that
allows VTEPs in the EVPN network to advertise and learn reachability
information for unicast MAC addresses. Traffic destined to a unicast MAC
address can therefore be selectively forwarded to a single VTEP behind
which the MAC is located.

The same is not true for IP multicast traffic. Such traffic is simply
flooded as BUM to all VTEPs in the broadcast domain (BD) / subnet,
regardless if a VTEP has interested receivers for the multicast stream
or not. This is especially problematic for overlay networks that make
heavy use of multicast.

The issue is addressed by RFC 9251 [1] that defines a "Selective
Multicast Ethernet Tag Route" (type 6) [5] which allows VTEPs in the
EVPN network to advertise multicast streams that they are interested in.
This is done by having each VTEP suppress IGMP/MLD packets from being
transmitted to the NVE network and instead communicate the information
over BGP to other VTEPs.

The draft in [2] further extends RFC 9251 with procedures to allow
efficient forwarding of IP multicast traffic not only in a given subnet,
but also between different subnets in a tenant domain.

The required changes in the bridge driver to support the above were
already merged in merge commit 8150f0cfb24f ("Merge branch
'bridge-mcast-extensions-for-evpn'"). However, full support entails MDB
support in the VXLAN driver so that it will be able to selectively
forward IP multicast traffic only to VTEPs with interested receivers.
The implementation of this MDB is described in the next section.

Implementation
==============

The user interface is extended to allow user space to specify the
destination VTEP(s) and related parameters. Example usage:

 # bridge mdb add dev vxlan0 port vxlan0 grp 239.1.1.1 permanent dst 198.51.100.1
 # bridge mdb add dev vxlan0 port vxlan0 grp 239.1.1.1 permanent dst 192.0.2.1

 $ bridge -d -s mdb show
 dev vxlan0 port vxlan0 grp 239.1.1.1 permanent filter_mode exclude proto static dst 192.0.2.1    0.00
 dev vxlan0 port vxlan0 grp 239.1.1.1 permanent filter_mode exclude proto static dst 198.51.100.1    0.00

Since the MDB is fully managed by user space and since snooping is not
implemented, only permanent entries can be installed and temporary
entries are rejected by the kernel.

The netlink interface is extended with a few new attributes in the
RTM_NEWMDB / RTM_DELMDB request messages:

[ struct nlmsghdr ]
[ struct br_port_msg ]
[ MDBA_SET_ENTRY ]
	struct br_mdb_entry
[ MDBA_SET_ENTRY_ATTRS ]
	[ MDBE_ATTR_SOURCE ]
		struct in_addr / struct in6_addr
	[ MDBE_ATTR_SRC_LIST ]
		[ MDBE_SRC_LIST_ENTRY ]
			[ MDBE_SRCATTR_ADDRESS ]
				struct in_addr / struct in6_addr
		[ ...]
	[ MDBE_ATTR_GROUP_MODE ]
		u8
	[ MDBE_ATTR_RTPORT ]
		u8
	[ MDBE_ATTR_DST ]	// new
		struct in_addr / struct in6_addr
	[ MDBE_ATTR_DST_PORT ]	// new
		u16
	[ MDBE_ATTR_VNI ]	// new
		u32
	[ MDBE_ATTR_IFINDEX ]	// new
		s32
	[ MDBE_ATTR_SRC_VNI ]	// new
		u32

RTM_NEWMDB / RTM_DELMDB responses and notifications are extended with
corresponding attributes.

One MDB entry that can be installed in the VXLAN MDB, but not in the
bridge MDB is the catchall entry (0.0.0.0 / ::). It is used to transmit
unregistered multicast traffic that is not link-local and is especially
useful when inter-subnet multicast forwarding is required. See patch #12
for a detailed explanation and motivation. It is similar to the
"all-zeros" FDB entry that can be installed in the VXLAN FDB, but not
the bridge FDB.

"added_by_star_ex" entries
--------------------------

The bridge driver automatically installs (S, G) MDB port group entries
marked as "added_by_star_ex" whenever it detects that an (S, G) entry
can prevent traffic from being forwarded via a port associated with an
EXCLUDE (*, G) entry. The bridge will add the port to the port group of
the (S, G) entry, thereby creating a new port group entry. The
complexity associated with these entries is not trivial, but it needs to
reside in the bridge driver because it automatically installs MDB
entries in response to snooped IGMP / MLD packets.

The same in not true for the VXLAN MDB which is entirely managed by user
space who is fully capable of forming the correct replication lists on
its own. In addition, the complexity associated with the
"added_by_star_ex" entries in the VXLAN driver is higher compared to the
bridge: Whenever a remote VTEP is added to the catchall entry, it needs
to be added to all the existing MDB entries, as such a remote requested
all the multicast traffic to be forwarded to it. Similarly, whenever an
(*, G) or (S, G) entry is added, all the remotes associated with the
catchall entry need to be added to it.

Given the above, this patchset does not implement support for such
entries.  One argument against this decision can be that in the future
someone might want to populate the VXLAN MDB in response to decapsulated
IGMP / MLD packets and not according to EVPN routes. Regardless of my
doubts regarding this possibility, it can be implemented using a new
VXLAN device knob that will also enable the "added_by_star_ex"
functionality.

Testing
=======

Tested using existing VXLAN and MDB selftests under "net/" and
"net/forwarding/". Added a dedicated selftest in the last patch.

Patchset overview
=================

Patches #1-#3 are small preparations in the bridge driver. I plan to
submit them separately together with an MDB dump test case.

Patches #4-#6 are additional preparations centered around the extraction
of the MDB netlink handlers from the bridge driver to the common
rtnetlink code. This allows reusing the existing MDB netlink messages
for the configuration of the VXLAN MDB.

Patches #7-#9 include more small preparations in the common rtnetlink
code and the VXLAN driver.

Patch #10 implements the MDB control path in the VXLAN driver, which
will allow user space to create, delete, replace and dump MDB entries.

Patches #11-#12 implement the MDB data path in the VXLAN driver,
allowing it to selectively forward IP multicast traffic according to the
matched MDB entry.

Patch #13 finally enables MDB support in the VXLAN driver.

iproute2 patches can be found here [6].

Note that in order to fully support the specifications in [1] and [2],
additional functionality is required from the data path. However, it can
be achieved using existing kernel interfaces which is why it is not
described here.

Changelog
=========

Since RFC [7]:

Patch #3: Use NL_ASSERT_DUMP_CTX_FITS().
Patch #3: memset the entire context when moving to the next device.
Patch #3: Reset sequence counters when moving to the next device.
Patch #3: Use NL_SET_ERR_MSG_ATTR() in rtnl_validate_mdb_entry().
Patch #7: Remove restrictions regarding mixing of multicast and unicast
remote destination IPs in an MDB entry. While such configuration does
not make sense to me, it is no forbidden by the VXLAN FDB code and does
not crash the kernel.
Patch #7: Fix check regarding all-zeros MDB entry and source.
Patch #11: New patch.

[1] https://datatracker.ietf.org/doc/html/rfc9251
[2] https://datatracker.ietf.org/doc/html/draft-ietf-bess-evpn-irb-mcast
[3] https://datatracker.ietf.org/doc/html/rfc7432
[4] https://datatracker.ietf.org/doc/html/rfc7432#section-7.2
[5] https://datatracker.ietf.org/doc/html/rfc9251#section-9.1
[6] https://github.com/idosch/iproute2/commits/submit/mdb_vxlan_rfc_v1
[7] https://lore.kernel.org/netdev/20230204170801.3897900-1-idosch@nvidia.com/

Ido Schimmel (11):
  net: Add MDB net device operations
  bridge: mcast: Implement MDB net device operations
  rtnetlink: bridge: mcast: Move MDB handlers out of bridge driver
  rtnetlink: bridge: mcast: Relax group address validation in common
    code
  vxlan: Move address helpers to private headers
  vxlan: Expose vxlan_xmit_one()
  vxlan: mdb: Add MDB control path support
  vxlan: mdb: Add an internal flag to indicate MDB usage
  vxlan: Add MDB data path support
  vxlan: Enable MDB support
  selftests: net: Add VXLAN MDB test

 drivers/net/vxlan/Makefile                    |    2 +-
 drivers/net/vxlan/vxlan_core.c                |   78 +-
 drivers/net/vxlan/vxlan_mdb.c                 | 1462 +++++++++++
 drivers/net/vxlan/vxlan_private.h             |   84 +
 include/linux/netdevice.h                     |   21 +
 include/net/vxlan.h                           |    6 +
 include/uapi/linux/if_bridge.h                |   10 +
 net/bridge/br_device.c                        |    3 +
 net/bridge/br_mdb.c                           |  219 +-
 net/bridge/br_netlink.c                       |    3 -
 net/bridge/br_private.h                       |   22 +-
 net/core/rtnetlink.c                          |  218 ++
 tools/testing/selftests/net/Makefile          |    1 +
 tools/testing/selftests/net/config            |    1 +
 tools/testing/selftests/net/test_vxlan_mdb.sh | 2318 +++++++++++++++++
 15 files changed, 4207 insertions(+), 241 deletions(-)
 create mode 100644 drivers/net/vxlan/vxlan_mdb.c
 create mode 100755 tools/testing/selftests/net/test_vxlan_mdb.sh

-- 
2.37.3

