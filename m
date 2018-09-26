Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id;
	bh=1hP9PM1Tfasb60a4yOWXlbCio1+a97wn57Xaf2i9N4g=;
	b=hjabEdhxfpR2jE023116z3yDIX0L37yAxP/74n5iezT2dLK+AWPZ9hgPKbrvy3aZgH
	NBEK8J5sZHOPeRww2CxZ+QMRSZlVOTJyB6S7DAA1y3lbbqO6GnvOFhNDU7Msu/I/Uv/f
	Us5G91TQ4lnJyTuYKWWYbdaxZM+9UA54gqRV4=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Wed, 26 Sep 2018 15:17:53 +0300
Message-Id: <20180926121802.27851-1-nikolay@cumulusnetworks.com>
Subject: [Bridge] [PATCH net-next 0/9] net: bridge: convert bool options to
	bits
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net

Hi,
A lot of boolean bridge options have been added around the net_bridge
structure resulting in holes and more importantly different cache lines
that need to be fetched in the fast path. This set moves all of those
to bits in a bitfield which resides in a hot cache line thus reducing
the size of net_bridge, the number of holes and the number of cache
lines needed for the fast path.
The set is also sent in preparation for new boolean options to avoid
spreading them in the structure and making new holes.
One nice side-effect is that we avoid potential race conditions by using
the bitops since some of the options were bits being directly set in
parallel risking hard to debug issues (has_ipv6_addr).

Before:
 size: 1184, holes: 8, sum holes: 30
After:
 size: 1160, holes: 2, sum holes: 3

Patch 01 is a trivial style fix
Patch 02 adds the new options bitfield and converts the vlan boolean
         options to bits
Patches 03-08 convert the rest of the boolean options to bits
Patch 09 re-arranges a few fields in net_bridge to avoid fetching one
         extra cache line in fast path and to further reduce size

Thanks,
 Nik


Nikolay Aleksandrov (9):
  net: bridge: make struct opening bracket consistent
  net: bridge: add bitfield for options and convert vlan opts
  net: bridge: convert nf call options to bits
  net: bridge: convert group_addr_set option to a bit
  net: bridge: convert and rename mcast disabled
  net: bridge: convert mcast options to bits
  net: bridge: convert neigh_suppress_enabled option to a bit
  net: bridge: convert mtu_set_by_user to a bit
  net: bridge: pack net_bridge better

 net/bridge/br.c                 | 16 +++++++++
 net/bridge/br_arp_nd_proxy.c    | 13 +++++---
 net/bridge/br_device.c          |  6 ++--
 net/bridge/br_if.c              |  4 +--
 net/bridge/br_input.c           |  2 +-
 net/bridge/br_mdb.c             |  6 ++--
 net/bridge/br_multicast.c       | 54 +++++++++++++++---------------
 net/bridge/br_netfilter_hooks.c |  7 ++--
 net/bridge/br_netlink.c         | 31 +++++++++--------
 net/bridge/br_private.h         | 74 +++++++++++++++++++++++------------------
 net/bridge/br_sysfs_br.c        | 32 +++++++++---------
 net/bridge/br_vlan.c            | 30 +++++++++--------
 12 files changed, 155 insertions(+), 120 deletions(-)

-- 
2.11.0

