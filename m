Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E0C3170888
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1C06C70893
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZM+2gc7kqrtAMg493EL07svkmq0Gnp3RVzo7hp/UNeM=;
 b=pei49oiXZvJiUcDDVjaIxbv7Z5qkcSeINuvj1ChMSdwvDh+gQX+2p3r/xYp8/qF/rCv6U1cuOFdSINLA82+H1ffweU2Jl+PzRYVtVwW5qoh4PzgkEkfBNVO8vXHeDJAJexBH3VCC/68mDiuWfVMEvKqcros4Orw4/jEWcMRA2lFNko3cpz0G4iMvW3BDXLTizEINoENcNXxSh4aWphPzH/UT1C1FdeLTrmT2WwsS86+rB51qaLgsr1nLDwiZNN5zzOu0lb71tOoOJknVhT08/uSa22lVAHbvMSa8Ew3lvN/3KX0KsJYlVLCn/6pmsVB7a6WewZBj+OTqm6Lxh/GtlQ==
From: Ido Schimmel <idosch@nvidia.com>
Date: Wed, 25 Oct 2023 15:30:10 +0300
Message-ID: <20231025123020.788710-4-idosch@nvidia.com>
In-Reply-To: <20231025123020.788710-1-idosch@nvidia.com>
References: <20231025123020.788710-1-idosch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next v2 03/13] bridge: mcast: Factor out a
	helper for PG entry size calculation
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

Currently, netlink notifications are sent for individual port group
entries and not for the entire MDB entry itself.

Subsequent patches are going to add MDB get support which will require
the bridge driver to reply with an entire MDB entry.

Therefore, as a preparation, factor out an helper to calculate the size
of an individual port group entry. When determining the size of the
reply this helper will be invoked for each port group entry in the MDB
entry.

No functional changes intended.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_mdb.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index 08de94bffc12..42983f6a0abd 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -450,18 +450,13 @@ static int nlmsg_populate_mdb_fill(struct sk_buff *skb,
 	return -EMSGSIZE;
 }
 
-static size_t rtnl_mdb_nlmsg_size(struct net_bridge_port_group *pg)
+static size_t rtnl_mdb_nlmsg_pg_size(const struct net_bridge_port_group *pg)
 {
 	struct net_bridge_group_src *ent;
 	size_t nlmsg_size, addr_size = 0;
 
-	nlmsg_size = NLMSG_ALIGN(sizeof(struct br_port_msg)) +
-		     /* MDBA_MDB */
-		     nla_total_size(0) +
-		     /* MDBA_MDB_ENTRY */
-		     nla_total_size(0) +
 		     /* MDBA_MDB_ENTRY_INFO */
-		     nla_total_size(sizeof(struct br_mdb_entry)) +
+	nlmsg_size = nla_total_size(sizeof(struct br_mdb_entry)) +
 		     /* MDBA_MDB_EATTR_TIMER */
 		     nla_total_size(sizeof(u32));
 
@@ -511,6 +506,17 @@ static size_t rtnl_mdb_nlmsg_size(struct net_bridge_port_group *pg)
 	return nlmsg_size;
 }
 
+static size_t rtnl_mdb_nlmsg_size(const struct net_bridge_port_group *pg)
+{
+	return NLMSG_ALIGN(sizeof(struct br_port_msg)) +
+	       /* MDBA_MDB */
+	       nla_total_size(0) +
+	       /* MDBA_MDB_ENTRY */
+	       nla_total_size(0) +
+	       /* Port group entry */
+	       rtnl_mdb_nlmsg_pg_size(pg);
+}
+
 void br_mdb_notify(struct net_device *dev,
 		   struct net_bridge_mdb_entry *mp,
 		   struct net_bridge_port_group *pg,
-- 
2.40.1

