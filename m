Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kq9gweTp7WIVGQXVtTj5MBcqZ9A9FPIrRwsOGnrPKZY=;
 b=emmQbmXFtosq8IkVmUd/E8VNZHP3Jfcd7MF4G2hNqSLh/Rr1e3vcePnTlsfEvBK1UoBPEKXtfnSmXVzIk1S6oqJCU8sJsaVAYMkEpUlkv83SDSAwSa4MRvb7/c1F1RC2cFr27phqFb1g8Qi/aeOvmNUxVTXWBizoIodcafElrhk=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Thu, 29 Oct 2020 01:48:15 +0200
Message-Id: <20201028234815.613226-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next] net: bridge: explicitly convert between
	mdb entry state and port group flags
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, bridge@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

When creating a new multicast port group, there is implicit conversion
between the __u8 state member of struct br_mdb_entry and the unsigned
char flags member of struct net_bridge_port_group. This implicit
conversion relies on the fact that MDB_PERMANENT is equal to
MDB_PG_FLAGS_PERMANENT.

Let's be more explicit and convert the state to flags manually.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 net/bridge/br_mdb.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index 3c8863418d0b..8846c5bcd075 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -846,6 +846,7 @@ static int br_mdb_add_group(struct net_bridge *br, struct net_bridge_port *port,
 	struct net_bridge_port_group __rcu **pp;
 	struct br_ip group, star_group;
 	unsigned long now = jiffies;
+	unsigned char flags = 0;
 	u8 filter_mode;
 	int err;
 
@@ -904,7 +905,10 @@ static int br_mdb_add_group(struct net_bridge *br, struct net_bridge_port *port,
 	filter_mode = br_multicast_is_star_g(&group) ? MCAST_EXCLUDE :
 						       MCAST_INCLUDE;
 
-	p = br_multicast_new_port_group(port, &group, *pp, entry->state, NULL,
+	if (entry->state == MDB_PERMANENT)
+		flags |= MDB_PG_FLAGS_PERMANENT;
+
+	p = br_multicast_new_port_group(port, &group, *pp, flags, NULL,
 					filter_mode, RTPROT_STATIC);
 	if (unlikely(!p)) {
 		NL_SET_ERR_MSG_MOD(extack, "Couldn't allocate new port group");
-- 
2.25.1

