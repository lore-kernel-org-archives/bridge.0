Return-Path: <petrm@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 44CB6414EE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CA2BF40A01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xOCr523mzKItGXdE26z8vzFu+vo9cyaFmxTQOXoHOig=;
 b=IfQCA9wYM91om3IYaHtBHaK4+vW8IX8kQvyQYYkV8IaFeozIf7D6lrjuHzh3Eu//vh16MbTYgEKRIzRdBgJzTTaW4N55ZDVea4/FlYjZ3JBfqUdvBsTLp37gfDSWIG17c/TLwtTw/Eyw2yS0gcM/BDTjH5CsOtnbJvbIohVRuSIcsjW9WtCjBX5SRFlBSQNoPw9Ylz/rD9coboTU2t/42pHo0h4OXky3QnkZasvzKg2lP38RNiVqKohjXB+nGmX/cJCCPwo63q5jVxrVb/xN3EG7n1XQ0/rPjGQ5pOCVAqyiX11c058IHxQ1WLgPHR09W9oc0ZzSBUtyubvmZYtlDQ==
From: Petr Machata <petrm@nvidia.com>
Date: Thu, 26 Jan 2023 18:01:08 +0100
Message-ID: <cover.1674752051.git.petrm@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next 00/16] bridge: Limit number of MDB entries
	per port, port-vlan
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org
Cc: Petr Machata <petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux-foundation.org

The MDB maintained by the bridge is limited. When the bridge is configured
for IGMP / MLD snooping, a buggy or malicious client can easily exhaust its
capacity. In SW datapath, the capacity is configurable through the
IFLA_BR_MCAST_HASH_MAX parameter, but ultimately is finite. Obviously a
similar limit exists in the HW datapath for purposes of offloading.

In order to prevent the issue of unilateral exhaustion of MDB resources,
introduce two parameters in each of two contexts:

- Per-port and (when BROPT_MCAST_VLAN_SNOOPING_ENABLED is enabled)
  per-port-VLAN number of MDB entries that the port is member in.

- Per-port and (when BROPT_MCAST_VLAN_SNOOPING_ENABLED is enabled)
  per-port-VLAN maximum permitted number of MDB entries, or 0 for
  no limit.

Per-port number of entries keeps track of the total number of MDB entries
configured on a given port. The per-port-VLAN value then keeps track of the
subset of MDB entries configured specifically for the given VLAN, on that
port. The number is adjusted as port_groups are created and deleted, and
therefore under multicast lock.

A maximum value, if non-zero, then places a limit on the number of entries
that can be configured in a given context. Attempts to add entries above
the maximum are rejected.

Rejection reason of netlink-based requests to add MDB entries is
communicated through extack. This channel is unavailable for rejections
triggered from the control path. To address this lack of visibility, the
patchset adds a tracepoint, bridge:br_mdb_full:

	# perf record -e bridge:br_mdb_full &
	# [...]
	# perf script | cut -d: -f4-
	 dev v2 af 2 src 192.0.2.1/:: grp 239.1.1.1/::/00:00:00:00:00:00 vid 0
	 dev v2 af 10 src 0.0.0.0/2001:db8:1::1 grp 0.0.0.0/ff0e::1/00:00:00:00:00:00 vid 0
	 dev v2 af 2 src 192.0.2.1/:: grp 239.1.1.1/::/00:00:00:00:00:00 vid 10
	 dev v2 af 10 src 0.0.0.0/2001:db8:1::1 grp 0.0.0.0/ff0e::1/00:00:00:00:00:00 vid 10

This tracepoint is triggered for mcast_hash_max exhaustions as well.

The following is an example of how the feature is used. A more extensive
example is available in patch #8:

	# bridge vlan set dev v1 vid 1 mcast_max_groups 1
	# bridge mdb add dev br port v1 grp 230.1.2.3 temp vid 1
	# bridge mdb add dev br port v1 grp 230.1.2.4 temp vid 1
	Error: bridge: Port-VLAN is already a member in mcast_max_groups (1) groups.

The patchset progresses as follows:

- In patch #1, set strict_start_type at two bridge-related policies. The
  reason is we are adding a new attribute to one of these, and want the new
  attribute to be parsed strictly. The other was adjusted for completeness'
  sake.

- In patches #2 to #5, br_mdb and br_multicast code is adjusted to make the
  following additions smoother.

- In patch #6, add the tracepoint.

- In patch #7, the code to maintain number of MDB entries is added as
  struct net_bridge_mcast_port::mdb_n_entries. The maximum is added, too,
  as struct net_bridge_mcast_port::mdb_max_entries, however at this point
  there is no way to set the value yet, and since 0 is treated as "no
  limit", the functionality doesn't change at this point. Note however,
  that mcast_hash_max violations already do trigger at this point.

- In patch #8, netlink plumbing is added: reading of number of entries, and
  reading and writing of maximum.

  The per-port values are passed through RTM_NEWLINK / RTM_GETLINK messages
  in IFLA_BRPORT_MCAST_N_GROUPS and _MAX_GROUPS, inside IFLA_PROTINFO nest.

  The per-port-vlan values are passed through RTM_GETVLAN / RTM_NEWVLAN
  messages in BRIDGE_VLANDB_ENTRY_MCAST_N_GROUPS, _MAX_GROUPS, inside
  BRIDGE_VLANDB_ENTRY.

The following patches deal with the selftest:

- Patches #9 and #10 clean up and move around some selftest code.

- Patches #11 to #14 add helpers and generalize the existing IGMP / MLD
  support to allow generating packets with configurable group addresses and
  varying source lists for (S,G) memberships.

- Patch #15 adds code to generate IGMP leave and MLD done packets.

- Patch #16 finally adds the selftest itself.

Petr Machata (16):
  net: bridge: Set strict_start_type at two policies
  net: bridge: Add extack to br_multicast_new_port_group()
  net: bridge: Move extack-setting to br_multicast_new_port_group()
  net: bridge: Add br_multicast_del_port_group()
  net: bridge: Change a cleanup in br_multicast_new_port_group() to goto
  net: bridge: Add a tracepoint for MDB overflows
  net: bridge: Maintain number of MDB entries in net_bridge_mcast_port
  net: bridge: Add netlink knobs for number / maximum MDB entries
  selftests: forwarding: Move IGMP- and MLD-related functions to lib
  selftests: forwarding: bridge_mdb: Fix a typo
  selftests: forwarding: lib: Add helpers for IP address handling
  selftests: forwarding: lib: Add helpers for checksum handling
  selftests: forwarding: lib: Parameterize IGMPv3/MLDv2 generation
  selftests: forwarding: lib: Allow list of IPs for IGMPv3/MLDv2
  selftests: forwarding: lib: Add helpers to build IGMP/MLD leave
    packets
  selftests: forwarding: bridge_mdb_max: Add a new selftest

 include/trace/events/bridge.h                 |  67 ++
 include/uapi/linux/if_bridge.h                |   2 +
 include/uapi/linux/if_link.h                  |   2 +
 net/bridge/br_mdb.c                           |  17 +-
 net/bridge/br_multicast.c                     | 255 ++++-
 net/bridge/br_netlink.c                       |  21 +-
 net/bridge/br_netlink_tunnel.c                |   3 +
 net/bridge/br_private.h                       |  22 +-
 net/bridge/br_vlan.c                          |  11 +-
 net/bridge/br_vlan_options.c                  |  33 +-
 net/core/net-traces.c                         |   1 +
 net/core/rtnetlink.c                          |   2 +-
 .../testing/selftests/net/forwarding/Makefile |   1 +
 .../selftests/net/forwarding/bridge_mdb.sh    |  60 +-
 .../net/forwarding/bridge_mdb_max.sh          | 970 ++++++++++++++++++
 tools/testing/selftests/net/forwarding/lib.sh | 216 ++++
 16 files changed, 1604 insertions(+), 79 deletions(-)
 create mode 100755 tools/testing/selftests/net/forwarding/bridge_mdb_max.sh

-- 
2.39.0

