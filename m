Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8QwqQleoGxCM0RtBR5+pJ1/nVkcUoQV4qf01skg7xRo=;
 b=vJdgSvHwBiANNhd65pdgBC6j5ySWEnDsF1VM5x1cWF7dwvbhOjDqQH7UY9n9thW8m5
 nHadsKPqBjFkVfke5OgXGg7vpkcstkZp+3KlYbjn1viyXU6EaIj15BqdEt3NO6AE3VC4
 TUe++h1+0BSlqqfN3J7yIAq8Di4qKoVKycLYtfwXdfY2S8hMYgTsX9a91PFjR9e+mX4f
 9N4BWGQIitrpbFsJj+b+UtOI5uumGTaFdOPw9inijm0CHCzSj49iY5qvKS/JcH6L0i2n
 01mSqDr04cwoWMh1PK8W+xZD0R6tWWPEvt7sd6TcpXiITSh03PdIoC+M9ye7UBQNc2Ri
 EDew==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Tue, 10 Aug 2021 18:29:29 +0300
Message-Id: <20210810152933.178325-12-razor@blackwall.org>
In-Reply-To: <20210810152933.178325-1-razor@blackwall.org>
References: <20210810152933.178325-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 11/15] net: bridge: mcast: querier and
	query state affect only current context type
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

It is a minor optimization and better behaviour to make sure querier and
query sending routines affect only the matching multicast context
depending if vlan snooping is enabled (vlan ctx vs bridge ctx).
It also avoids sending unnecessary extra query packets.

Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
 net/bridge/br_multicast.c | 14 +++++++++-----
 net/bridge/br_private.h   | 11 +++++++++++
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index fe1482efd59c..f30c2e5d3142 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1628,7 +1628,8 @@ static void __br_multicast_send_query(struct net_bridge_mcast *brmctx,
 	struct sk_buff *skb;
 	u8 igmp_type;
 
-	if (!br_multicast_ctx_should_use(brmctx, pmctx))
+	if (!br_multicast_ctx_should_use(brmctx, pmctx) ||
+	    !br_multicast_ctx_matches_vlan_snooping(brmctx))
 		return;
 
 again_under_lmqt:
@@ -3875,9 +3876,9 @@ void br_multicast_open(struct net_bridge *br)
 					__br_multicast_open(&vlan->br_mcast_ctx);
 			}
 		}
+	} else {
+		__br_multicast_open(&br->multicast_ctx);
 	}
-
-	__br_multicast_open(&br->multicast_ctx);
 }
 
 static void __br_multicast_stop(struct net_bridge_mcast *brmctx)
@@ -4028,9 +4029,9 @@ void br_multicast_stop(struct net_bridge *br)
 					__br_multicast_stop(&vlan->br_mcast_ctx);
 			}
 		}
+	} else {
+		__br_multicast_stop(&br->multicast_ctx);
 	}
-
-	__br_multicast_stop(&br->multicast_ctx);
 }
 
 void br_multicast_dev_del(struct net_bridge *br)
@@ -4175,6 +4176,9 @@ static void br_multicast_start_querier(struct net_bridge_mcast *brmctx,
 {
 	struct net_bridge_port *port;
 
+	if (!br_multicast_ctx_matches_vlan_snooping(brmctx))
+		return;
+
 	__br_multicast_open_query(brmctx->br, query);
 
 	rcu_read_lock();
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 50f38d6f586d..25db6b02b042 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -1209,6 +1209,17 @@ br_multicast_ctx_options_equal(const struct net_bridge_mcast *brmctx1,
 #endif
 	       true;
 }
+
+static inline bool
+br_multicast_ctx_matches_vlan_snooping(const struct net_bridge_mcast *brmctx)
+{
+	bool vlan_snooping_enabled;
+
+	vlan_snooping_enabled = !!br_opt_get(brmctx->br,
+					     BROPT_MCAST_VLAN_SNOOPING_ENABLED);
+
+	return !!(vlan_snooping_enabled == br_multicast_ctx_is_vlan(brmctx));
+}
 #else
 static inline int br_multicast_rcv(struct net_bridge_mcast **brmctx,
 				   struct net_bridge_mcast_port **pmctx,
-- 
2.31.1

