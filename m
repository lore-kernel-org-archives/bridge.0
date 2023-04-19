Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 894EF8412F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C9E2784107
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUmFijYCPgEX04cPjZN0kCpLZm8abO4duay48UU4ewc=;
 b=hxAIK3wO9ESg8RSoyZ3XL9ggXJ8YR0H2US/ZviO6uJJD6GWcmZaj54avwzt6kvRLqWGvFQXiUe709CtHXX4jpq3sQy4ay9c+cVbvDVAtjyjcp1beCeOcSGThrPdfHfKBc6DAtOkvTBGpt88FswMP1KmAbErx++qaunem9zljp8t7PQDNpoDvrhBT6T9gXGmDgbmQSfIGAHPxPoiwDzEWqIiqYm+IdK53vqmRBYv8wLN3VTBqcrpaKch97sqRDh3sXeslizSSrwx7dC65VmwqA4p0kZolvBk6QWqnlx96E/vFCBjNRSWB/HOyxJlCjont4fMOIqenYaHGehRHPjXOAQ==
From: Ido Schimmel <idosch@nvidia.com>
Date: Wed, 19 Apr 2023 18:34:57 +0300
Message-Id: <20230419153500.2655036-7-idosch@nvidia.com>
In-Reply-To: <20230419153500.2655036-1-idosch@nvidia.com>
References: <20230419153500.2655036-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next v2 6/9] bridge: Add per-{Port,
	VLAN} neighbor suppression data path support
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

When the bridge is not VLAN-aware (i.e., VLAN ID is 0), determine if
neighbor suppression is enabled on a given bridge port solely based on
the existing 'BR_NEIGH_SUPPRESS' flag.

Otherwise, if the bridge is VLAN-aware, first check if per-{Port, VLAN}
neighbor suppression is enabled on the given bridge port using the
'BR_NEIGH_VLAN_SUPPRESS' flag. If so, look up the VLAN and check whether
it has neighbor suppression enabled based on the per-VLAN
'BR_VLFLAG_NEIGH_SUPPRESS_ENABLED' flag.

If the bridge is VLAN-aware, but the bridge port does not have
per-{Port, VLAN} neighbor suppression enabled, then fallback to
determine neighbor suppression based on the 'BR_NEIGH_SUPPRESS' flag.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_arp_nd_proxy.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_arp_nd_proxy.c b/net/bridge/br_arp_nd_proxy.c
index 16c3a1c5d0ae..c7869a286df4 100644
--- a/net/bridge/br_arp_nd_proxy.c
+++ b/net/bridge/br_arp_nd_proxy.c
@@ -486,5 +486,21 @@ void br_do_suppress_nd(struct sk_buff *skb, struct net_bridge *br,
 
 bool br_is_neigh_suppress_enabled(const struct net_bridge_port *p, u16 vid)
 {
-	return p && (p->flags & BR_NEIGH_SUPPRESS);
+	if (!p)
+		return false;
+
+	if (!vid)
+		return !!(p->flags & BR_NEIGH_SUPPRESS);
+
+	if (p->flags & BR_NEIGH_VLAN_SUPPRESS) {
+		struct net_bridge_vlan_group *vg = nbp_vlan_group_rcu(p);
+		struct net_bridge_vlan *v;
+
+		v = br_vlan_find(vg, vid);
+		if (!v)
+			return false;
+		return !!(v->priv_flags & BR_VLFLAG_NEIGH_SUPPRESS_ENABLED);
+	} else {
+		return !!(p->flags & BR_NEIGH_SUPPRESS);
+	}
 }
-- 
2.37.3

