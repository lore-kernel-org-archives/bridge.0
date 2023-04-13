Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E8D45615F5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B1391615E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qcmW5XoYWRoEgZ0UlmwVtLC6KBdkA25Co/jTfaAJNF8=;
 b=cwn5t0TFEMpVF5+fsvnJV5TckWzlEAiv63t8PV8zJLVF7KuhbH/9h1BuBwaLHLCdV2HIO3fb+Kif8WwPEkFMTf9kV6qHadx+MOqDOe+7OCI7yEhh2Y8XJzdzYTpAg6/roNqRnUHMQDXyUiU6VNNN6KanXwNtXG3kyavZm/1GKZV3hApcsToQ94rXptQSASrudGf6JAm367MnH77VrF+AyMquVDozI5KYbDRAzJg9W7GdP6JS/RPjGXpbKx4vWKjSROVTNzdT9/T7kyuhIml3wtFXbzdW+7O24elDprkrD06XbgoSQtC1Kc3xTA5FTcLn1vtCiYwqUNrzEk9o3a+dCw==
From: Ido Schimmel <idosch@nvidia.com>
Date: Thu, 13 Apr 2023 12:58:25 +0300
Message-Id: <20230413095830.2182382-5-idosch@nvidia.com>
In-Reply-To: <20230413095830.2182382-1-idosch@nvidia.com>
References: <20230413095830.2182382-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [RFC PATCH net-next 4/9] bridge: Take per-{Port,
	VLAN} neighbor suppression into account
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

The bridge driver gates the neighbor suppression code behind an internal
per-bridge flag called 'BROPT_NEIGH_SUPPRESS_ENABLED'. The flag is set
when at least one bridge port has neighbor suppression enabled.

As a preparation for per-{Port, VLAN} neighbor suppression, make sure
the global flag is also set if per-{Port, VLAN} neighbor suppression is
enabled. That is, when the 'BR_NEIGH_VLAN_SUPPRESS' flag is set on at
least one bridge port.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/bridge/br_arp_nd_proxy.c | 2 +-
 net/bridge/br_if.c           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_arp_nd_proxy.c b/net/bridge/br_arp_nd_proxy.c
index b45c00c01dea..016a25a9e444 100644
--- a/net/bridge/br_arp_nd_proxy.c
+++ b/net/bridge/br_arp_nd_proxy.c
@@ -30,7 +30,7 @@ void br_recalculate_neigh_suppress_enabled(struct net_bridge *br)
 	bool neigh_suppress = false;
 
 	list_for_each_entry(p, &br->port_list, list) {
-		if (p->flags & BR_NEIGH_SUPPRESS) {
+		if (p->flags & (BR_NEIGH_SUPPRESS | BR_NEIGH_VLAN_SUPPRESS)) {
 			neigh_suppress = true;
 			break;
 		}
diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index 24f01ff113f0..3f04b40f6056 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -759,7 +759,7 @@ void br_port_flags_change(struct net_bridge_port *p, unsigned long mask)
 	if (mask & BR_AUTO_MASK)
 		nbp_update_port_count(br);
 
-	if (mask & BR_NEIGH_SUPPRESS)
+	if (mask & (BR_NEIGH_SUPPRESS | BR_NEIGH_VLAN_SUPPRESS))
 		br_recalculate_neigh_suppress_enabled(br);
 }
 
-- 
2.37.3

