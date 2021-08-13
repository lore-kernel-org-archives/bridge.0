Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=dI0OL75ZDd6qvxHet20KtzBgKETMju9g8K1SgE3M6N0=;
 b=P2UJZm2hzcIeNVyOlO5mFN4pF3gq+JnzhGkW9XxE8KHbLSIohnqzR3b/S2TKmx2yLI
 368ERvOOJ34F7M9EwV8/4IZQofaGhm6rRlan/cy1CbB/n6nGpPQaGTyyHtDjU9lYj55F
 2DAMLTw3Fk2PxmvDZn2aZHxPF1WGk54yVd2NXLS055+9UqegdO1Zq4v9142rNSG0VYx6
 3BoOtU0D1okY9IV9gs3dnZ2A0zNTpqMWJ3v3X4noaDcwo5+F8p0KQmVo8DUzwhfqgOgk
 EPBwbs1IKj725aBLhfJ87NxRB1VyK3NaEuUxREWJ130/v8rxCURGWCQdANoFutyWU5+9
 Q8qg==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Fri, 13 Aug 2021 17:59:56 +0300
Message-Id: <20210813150002.673579-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 0/6] net: bridge: mcast: dump querier state
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: bridge@lists.linux-foundation.org, Nikolay Aleksandrov <nikolay@nvidia.com>, roopa@nvidia.com

From: Nikolay Aleksandrov <nikolay@nvidia.com>

Hi,
This set adds the ability to dump the current multicast querier state.
This is extremely useful when debugging multicast issues, we've had
many cases of unexpected queriers causing strange behaviour and mcast
test failures. The first patch changes the querier struct to record
a port device's ifindex instead of a pointer to the port itself so we
can later retrieve it, I chose this way because it's much simpler
and doesn't require us to do querier port ref counting, it is best
effort anyway. Then patch 02 makes the querier address/port updates
consistent via a combination of multicast_lock and seqcount, so readers
can only use seqcount to get a consistent snapshot of address and port.
Patch 03 is a minor cleanup in preparation for the dump support, it
consolidates IPv4 and IPv6 querier selection paths as they share most of
the logic (except address comparisons of course). Finally the last three
patches add the new querier state dumping support, for the bridge's
global multicast context we embed the BRIDGE_QUERIER_xxx attributes
into IFLA_BR_MCAST_QUERIER_STATE and for the per-vlan global mcast
contexts we embed them into BRIDGE_VLANDB_GOPTS_MCAST_QUERIER_STATE.

The structure is:
  [IFLA_BR_MCAST_QUERIER_STATE / BRIDGE_VLANDB_GOPTS_MCAST_QUERIER_STATE]
  `[BRIDGE_QUERIER_IP_ADDRESS] - ip address of the querier
  `[BRIDGE_QUERIER_IP_PORT]    - bridge port ifindex where the querier was
                                 seen (set only if external querier)
  `[BRIDGE_QUERIER_IP_OTHER_TIMER]   -  other querier timeout
  `[BRIDGE_QUERIER_IPV6_ADDRESS] - ip address of the querier
  `[BRIDGE_QUERIER_IPV6_PORT]    - bridge port ifindex where the querier
                                   was seen (set only if external querier)
  `[BRIDGE_QUERIER_IPV6_OTHER_TIMER]   -  other querier timeout

Later we can also add IGMP version of seen queriers and last seen values
from the queries.

Thanks,
 Nik

Nikolay Aleksandrov (6):
  net: bridge: mcast: record querier port device ifindex instead of
    pointer
  net: bridge: mcast: make sure querier port/address updates are
    consistent
  net: bridge: mcast: consolidate querier selection for ipv4 and ipv6
  net: bridge: mcast: dump ipv4 querier state
  net: bridge: mcast: dump ipv6 querier state
  net: bridge: vlan: dump mcast ctx querier state

 include/uapi/linux/if_bridge.h |  14 +++
 include/uapi/linux/if_link.h   |   1 +
 net/bridge/br_multicast.c      | 211 ++++++++++++++++++++++++++-------
 net/bridge/br_netlink.c        |   5 +-
 net/bridge/br_private.h        |   7 +-
 net/bridge/br_vlan_options.c   |   5 +-
 6 files changed, 199 insertions(+), 44 deletions(-)

-- 
2.31.1

