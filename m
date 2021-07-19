Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c7o9J0S8l6x7vFeL6vC550cfCfB16mSIdMYzy3heZZg=;
 b=eBDgd1rBiL0/6p9WrSRSfuE66FnPYQ0kTrBRf7Yci2s5V820egX/jPvgSoQWavza8itXMZaSximwkgTfeKbJe4drfRVTqlWDIt5UHG41mCfIMda1yyamjAlMaQpvOoUT+LOzV6PsjIXJjIyO93j8jpMqFu/ZTxz8ljQYkkFQizo=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Mon, 19 Jul 2021 12:39:16 +0300
Message-Id: <20210719093916.4099032-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [PATCH net] net: bridge: do not replay fdb entries
	pointing towards the bridge twice
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, bridge@lists.linux-foundation.org, Ido Schimmel <idosch@idosch.org>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Vivien Didelot <vivien.didelot@gmail.com>, Tobias Waldekranz <tobias@waldekranz.com>

This simple script:

ip link add br0 type bridge
ip link set swp2 master br0
ip link set br0 address 00:01:02:03:04:05
ip link del br0

produces this result on a DSA switch:

[  421.306399] br0: port 1(swp2) entered blocking state
[  421.311445] br0: port 1(swp2) entered disabled state
[  421.472553] device swp2 entered promiscuous mode
[  421.488986] device swp2 left promiscuous mode
[  421.493508] br0: port 1(swp2) entered disabled state
[  421.886107] sja1105 spi0.1: port 1 failed to delete 00:01:02:03:04:05 vid 1 from fdb: -ENOENT
[  421.894374] sja1105 spi0.1: port 1 failed to delete 00:01:02:03:04:05 vid 0 from fdb: -ENOENT
[  421.943982] br0: port 1(swp2) entered blocking state
[  421.949030] br0: port 1(swp2) entered disabled state
[  422.112504] device swp2 entered promiscuous mode

A very simplified view of what happens is:

(1) the bridge port is created, and the bridge device inherits its MAC
    address

(2) when joining, the bridge port (DSA) requests a replay of the
    addition of all FDB entries towards this bridge port and towards the
    bridge device itself. In fact, DSA calls br_fdb_replay() twice:

	br_fdb_replay(br, brport_dev);
	br_fdb_replay(br, br);

    DSA uses reference counting for the FDB entries. So the MAC address
    of the bridge is simply kept with refcount 2. When the bridge port
    leaves under normal circumstances, everything cancels out since the
    replay of the FDB entry deletion is also done twice per VLAN.

(3) when the bridge MAC address changes, switchdev is notified of the
    deletion of the old address and of the insertion of the new one.
    But the old address does not really go away, since it had refcount
    2, and the new address is added "only" with refcount 1.

(4) when the bridge port leaves now, it will replay a deletion of the
    FDB entries pointing towards the bridge twice. Then DSA will
    complain that it can't delete something that no longer exists.

It is clear that the problem is that the FDB entries towards the bridge
are replayed too many times, so let's fix that problem.

Fixes: 63c51453c82c ("net: dsa: replay the local bridge FDB entries pointing to the bridge dev too")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Reverting the blamed commit would have worked just as fine, but I prefer
to do it this way to avoid conflicts between "net" and "net-next".

 net/bridge/br_fdb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index 2b862cffc03a..a16191dcaed1 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -780,7 +780,7 @@ int br_fdb_replay(const struct net_device *br_dev, const struct net_device *dev,
 		struct net_device *dst_dev;
 
 		dst_dev = dst ? dst->dev : br->dev;
-		if (dst_dev != br_dev && dst_dev != dev)
+		if (dst_dev && dst_dev != dev)
 			continue;
 
 		err = br_fdb_replay_one(nb, fdb, dst_dev, action, ctx);
-- 
2.25.1

