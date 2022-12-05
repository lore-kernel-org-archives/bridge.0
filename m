Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 35F1781B48
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 85CA981B0A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kjS9aGsGx4YbQiLY0sTiMku2ZELoS5l/XzWb4p/TRFs=;
 b=udHwcQ0+5THTQ3FelC894ZwemG9xObXl8o6uXIoti8i/Op8MzjcuXrDMO74m6UJG+vk9Mcy92hD+7yp4UOEYG6jw5DvQFyAoURjwMojMGdtc7HcM8WCyQtt8tLsC31CknYNRBT8qXLDKvq6nQ5BY0KXq1RAsruKN8JLhW8bcpoj0CzSon7LGOneP0IbNkkhYZMOrmJrt688JGFDP/N+B/S9m8/KxfJvfxwRDGdomssmI60XR1b+CBr2EO4nZ1OG5jDi63x/GD5H2rmiC+VSKVkQfHDoX4vgxbzP8wH0pSwyo4sIO8Gv9kkD3TgIXmKhMmB+jSJa0xSJCbgMG/mnrdQ==
From: Ido Schimmel <idosch@nvidia.com>
Date: Mon,  5 Dec 2022 09:42:43 +0200
Message-Id: <20221205074251.4049275-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next 0/8] bridge: mcast: Preparations for EVPN
	extensions
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

No changes since initial RFC.

[1] https://lore.kernel.org/netdev/20221018120420.561846-1-idosch@nvidia.com/
[2] https://github.com/idosch/linux/commits/submit/mdb_v1

Ido Schimmel (8):
  bridge: mcast: Centralize netlink attribute parsing
  bridge: mcast: Remove redundant checks
  bridge: mcast: Use MDB configuration structure where possible
  bridge: mcast: Propagate MDB configuration structure further
  bridge: mcast: Use MDB group key from configuration structure
  bridge: mcast: Remove br_mdb_parse()
  bridge: mcast: Move checks out of critical section
  bridge: mcast: Remove redundant function arguments

 net/bridge/br_mdb.c     | 312 +++++++++++++++++++---------------------
 net/bridge/br_private.h |   7 +
 2 files changed, 156 insertions(+), 163 deletions(-)

-- 
2.37.3

