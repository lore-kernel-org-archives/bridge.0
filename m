Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 09F1081E56
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B7DCD81E4E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJaNE3XF4lrpzF5wreA+/UkzWpCcVKuoJbopIEz17P4=;
 b=pvW/VjINK2ul7GEtdLH6sU+zY2J28465b/xbQqHrikw3YJpy6lhHsEk1YjP61AWxVKBdRtzNlxxYml8+mp9OhQganF7oL/GiyLRoyzrV9/d1rIQBqUh4+B5LHkbjJYfzB5SVd4HPWSQdpaJj92JT4GXvtUT9ybo+Oa6QJTGzGhuJitFZEQI7RZe6XQuQkcS47+voCvKB4/9lkkSq2fveryfy/Hh2OwioptY1kHfeYqleWwpKdLCDrx5oJoI3kKYYV9Ge4WeBlRCJCBk0VNBda3Zz1T62Hg7FyM9kZBCV5Ja/Ij55/Fj1f8jRBMqaIm9A8QXlgQpJsp051uA+KzVtCQ==
From: Ido Schimmel <idosch@nvidia.com>
Date: Tue,  6 Dec 2022 12:58:00 +0200
Message-Id: <20221206105809.363767-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next v2 0/9] bridge: mcast: Preparations for
	EVPN extensions
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

This patchset was split from [1] and includes non-functional changes
aimed at making it easier to add additional netlink attributes later on.
Future extensions are available here [2].

The idea behind these patches is to create an MDB configuration
structure into which netlink messages are parsed into. The structure is
then passed in the entry creation / deletion call chain instead of
passing the netlink attributes themselves. The same pattern is used by
other rtnetlink objects such as routes and nexthops.

I initially tried to extend the current code, but it proved to be too
difficult, which is why I decided to refactor it to the extensible and
familiar pattern used by other rtnetlink objects.

Tested using existing selftests and using a new selftest that will be
submitted together with the planned extensions.

v2:
* Patch #1: Remove 'skb' argument from br_mdb_config_init().
* Patch #1: Mark 'nlh' argument as 'const'.
* Patch #4: Pass 'cfg' as 'const'.
* Patch #5: Pass 'cfg' as 'const'.
* Patch #9: New patch.

[1] https://lore.kernel.org/netdev/20221018120420.561846-1-idosch@nvidia.com/
[2] https://github.com/idosch/linux/commits/submit/mdb_v1

Ido Schimmel (9):
  bridge: mcast: Centralize netlink attribute parsing
  bridge: mcast: Remove redundant checks
  bridge: mcast: Use MDB configuration structure where possible
  bridge: mcast: Propagate MDB configuration structure further
  bridge: mcast: Use MDB group key from configuration structure
  bridge: mcast: Remove br_mdb_parse()
  bridge: mcast: Move checks out of critical section
  bridge: mcast: Remove redundant function arguments
  bridge: mcast: Constify 'group' argument in
    br_multicast_new_port_group()

 net/bridge/br_mdb.c       | 312 ++++++++++++++++++--------------------
 net/bridge/br_multicast.c |   2 +-
 net/bridge/br_private.h   |  10 +-
 3 files changed, 159 insertions(+), 165 deletions(-)

-- 
2.37.3

