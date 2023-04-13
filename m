Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EBE1A615F5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1D971615F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lj90Ut8XMA486m20mHdynKT2IGXrETfyB0ICpCEDQgs=;
 b=S+SbjFpFDAm/9468kA89irQBHOMWm3Ky9Gl+M+E0wdxI94r7iYKzzFGDYj/01xSodtzlwuWtS0aIj1oxdc31zH0fJTjRMnbyT5zdU1IK49409HrY/azsU/HrxgrUTFi0JsuUOqs1JD4cGLDCETjdhfN/VKmUX/Rq5NMaOcr3oCoXbvD419N2SeJE/F6kE5R+miQt/KYvNpsi6KJYPDMriXMhOS4m/2++opMG1LJuKmBAy3WTSjX9l/YW571kvo/mW31sXSQYs76JLE9492FvBclsfuUsFn+A7lGfuXy0/NYLL9rFgvm+X2BDPU0jb4SXXc7xlopxaME2M4TF+mDV6Q==
From: Ido Schimmel <idosch@nvidia.com>
Date: Thu, 13 Apr 2023 12:58:26 +0300
Message-Id: <20230413095830.2182382-6-idosch@nvidia.com>
In-Reply-To: <20230413095830.2182382-1-idosch@nvidia.com>
References: <20230413095830.2182382-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [RFC PATCH net-next 5/9] bridge: Encapsulate data path
	neighbor suppression logic
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

Currently, there are various places in the bridge data path that check
whether neighbor suppression is enabled on a given bridge port.

As a preparation for per-{Port, VLAN} neighbor suppression, encapsulate
this logic in a function and pass the VLAN ID of the packet as an
argument.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/bridge/br_arp_nd_proxy.c | 15 ++++++++++-----
 net/bridge/br_forward.c      |  3 ++-
 net/bridge/br_private.h      |  1 +
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/net/bridge/br_arp_nd_proxy.c b/net/bridge/br_arp_nd_proxy.c
index 016a25a9e444..16c3a1c5d0ae 100644
--- a/net/bridge/br_arp_nd_proxy.c
+++ b/net/bridge/br_arp_nd_proxy.c
@@ -158,7 +158,7 @@ void br_do_proxy_suppress_arp(struct sk_buff *skb, struct net_bridge *br,
 		return;
 
 	if (br_opt_get(br, BROPT_NEIGH_SUPPRESS_ENABLED)) {
-		if (p && (p->flags & BR_NEIGH_SUPPRESS))
+		if (br_is_neigh_suppress_enabled(p, vid))
 			return;
 		if (parp->ar_op != htons(ARPOP_RREQUEST) &&
 		    parp->ar_op != htons(ARPOP_RREPLY) &&
@@ -202,8 +202,8 @@ void br_do_proxy_suppress_arp(struct sk_buff *skb, struct net_bridge *br,
 			bool replied = false;
 
 			if ((p && (p->flags & BR_PROXYARP)) ||
-			    (f->dst && (f->dst->flags & (BR_PROXYARP_WIFI |
-							 BR_NEIGH_SUPPRESS)))) {
+			    (f->dst && (f->dst->flags & BR_PROXYARP_WIFI)) ||
+			    br_is_neigh_suppress_enabled(f->dst, vid)) {
 				if (!vid)
 					br_arp_send(br, p, skb->dev, sip, tip,
 						    sha, n->ha, sha, 0, 0);
@@ -407,7 +407,7 @@ void br_do_suppress_nd(struct sk_buff *skb, struct net_bridge *br,
 
 	BR_INPUT_SKB_CB(skb)->proxyarp_replied = 0;
 
-	if (p && (p->flags & BR_NEIGH_SUPPRESS))
+	if (br_is_neigh_suppress_enabled(p, vid))
 		return;
 
 	if (msg->icmph.icmp6_type == NDISC_NEIGHBOUR_ADVERTISEMENT &&
@@ -461,7 +461,7 @@ void br_do_suppress_nd(struct sk_buff *skb, struct net_bridge *br,
 		if (f) {
 			bool replied = false;
 
-			if (f->dst && (f->dst->flags & BR_NEIGH_SUPPRESS)) {
+			if (br_is_neigh_suppress_enabled(f->dst, vid)) {
 				if (vid != 0)
 					br_nd_send(br, p, skb, n,
 						   skb->vlan_proto,
@@ -483,3 +483,8 @@ void br_do_suppress_nd(struct sk_buff *skb, struct net_bridge *br,
 	}
 }
 #endif
+
+bool br_is_neigh_suppress_enabled(const struct net_bridge_port *p, u16 vid)
+{
+	return p && (p->flags & BR_NEIGH_SUPPRESS);
+}
diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
index 94a8d757ae4e..57744704ff69 100644
--- a/net/bridge/br_forward.c
+++ b/net/bridge/br_forward.c
@@ -226,7 +226,8 @@ void br_flood(struct net_bridge *br, struct sk_buff *skb,
 		if (p->flags & BR_PROXYARP)
 			continue;
 		if (BR_INPUT_SKB_CB(skb)->proxyarp_replied &&
-		    (p->flags & (BR_PROXYARP_WIFI | BR_NEIGH_SUPPRESS)))
+		    ((p->flags & BR_PROXYARP_WIFI) ||
+		     br_is_neigh_suppress_enabled(p, vid)))
 			continue;
 
 		prev = maybe_deliver(prev, p, skb, local_orig);
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index b17fc821ecc8..2119729ded2b 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -2220,4 +2220,5 @@ void br_do_proxy_suppress_arp(struct sk_buff *skb, struct net_bridge *br,
 void br_do_suppress_nd(struct sk_buff *skb, struct net_bridge *br,
 		       u16 vid, struct net_bridge_port *p, struct nd_msg *msg);
 struct nd_msg *br_is_nd_neigh_msg(struct sk_buff *skb, struct nd_msg *m);
+bool br_is_neigh_suppress_enabled(const struct net_bridge_port *p, u16 vid);
 #endif
-- 
2.37.3

