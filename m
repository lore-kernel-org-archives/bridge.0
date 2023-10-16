Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 500F5611B1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 54ACF611CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C2lx4a/YsnaaU6/p/tzyWjrkHfRHP9a5+qb6DI6gwiY=;
 b=B1NOxvt8BUgAcewDDgz752ksdrfk1t5hNLmAo1D/UCMqL9/2hHDy5yxwrgxGCpIwP+n6cta0APT9j/QT3Sqr6Bop2vUJxE8hg7mR7jlzndMyaLO8RRQVMLMM8lfFi2zUCbXQYuDxh8gUhBDrbaqxwN1lN8WmY7wuXxyaM0/qt1UNVNZTVswtbBHZtuLzicjlsb0u48TYPhW8K7AjEfAvi9+fssDcNJrKhyNMV7+jJdUD/ykQmQABFIKJ+Ohi3HyTifj4zIeFDror+yL30DYV5Gizn1LpUBl1dVs42auNpbDJAzSE3NSSbfjVH1BUHK8PVAU1fMLL0NmLvuumechAWA==
From: Ido Schimmel <idosch@nvidia.com>
Date: Mon, 16 Oct 2023 16:12:48 +0300
Message-ID: <20231016131259.3302298-3-idosch@nvidia.com>
In-Reply-To: <20231016131259.3302298-1-idosch@nvidia.com>
References: <20231016131259.3302298-1-idosch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next 02/13] bridge: mcast: Account for missing
	attributes
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

The 'MDBA_MDB' and 'MDBA_MDB_ENTRY' nest attributes are not accounted
for when calculating the size of MDB notifications. Add them along with
comments for existing attributes.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/bridge/br_mdb.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index fb58bb1b60e8..08de94bffc12 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -452,11 +452,18 @@ static int nlmsg_populate_mdb_fill(struct sk_buff *skb,
 
 static size_t rtnl_mdb_nlmsg_size(struct net_bridge_port_group *pg)
 {
-	size_t nlmsg_size = NLMSG_ALIGN(sizeof(struct br_port_msg)) +
-			    nla_total_size(sizeof(struct br_mdb_entry)) +
-			    nla_total_size(sizeof(u32));
 	struct net_bridge_group_src *ent;
-	size_t addr_size = 0;
+	size_t nlmsg_size, addr_size = 0;
+
+	nlmsg_size = NLMSG_ALIGN(sizeof(struct br_port_msg)) +
+		     /* MDBA_MDB */
+		     nla_total_size(0) +
+		     /* MDBA_MDB_ENTRY */
+		     nla_total_size(0) +
+		     /* MDBA_MDB_ENTRY_INFO */
+		     nla_total_size(sizeof(struct br_mdb_entry)) +
+		     /* MDBA_MDB_EATTR_TIMER */
+		     nla_total_size(sizeof(u32));
 
 	if (!pg)
 		goto out;
-- 
2.40.1

