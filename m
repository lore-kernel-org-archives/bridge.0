Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=UgKTTiydxItDkxuIEgW/VK21xYOkRzo4esbB+7uQQT0=;
	b=MgsFPtdgbqFrPuEd2vf+JMWATlhAxjyPZPndZzNFc8kIDkkZ0pNfWmV0/9AVZ37fRX
	1W8l7Az/cVTJRx8Xl9/D2StNT2FNUduNo8ODZEEAyLOTbYcwGdlPpvMUQppm6QzmNI4k
	syCxNStb+HekO2otDS0iILRjG2tqYf+30iIWw=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Fri, 16 Nov 2018 18:50:01 +0200
Message-Id: <20181116165001.30896-1-nikolay@cumulusnetworks.com>
In-Reply-To: <20181114172703.5795-1-nikolay@cumulusnetworks.com>
References: <20181114172703.5795-1-nikolay@cumulusnetworks.com>
Subject: [Bridge] [PATCH net v3] net: bridge: fix vlan stats use-after-free
	on destruction
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, syzkaller-bugs@googlegroups.com, davem@davemloft.net

Syzbot reported a use-after-free of the global vlan context on port vlan
destruction. When I added per-port vlan stats I missed the fact that the
global vlan context can be freed before the per-port vlan rcu callback.
There're a few different ways to deal with this, I've chosen to add a
new private flag that is set only when per-port stats are allocated so
we can directly check it on destruction without dereferencing the global
context at all. The new field in net_bridge_vlan uses a hole.

v2: cosmetic change, move the check to br_process_vlan_info where the
    other checks are done
v3: add change log in the patch, add private (in-kernel only) flags in a
    hole in net_bridge_vlan struct and use that instead of mixing
    user-space flags with private flags

Fixes: 9163a0fc1f0c ("net: bridge: add support for per-port vlan stats")
Reported-by: syzbot+04681da557a0e49a52e5@syzkaller.appspotmail.com
Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
After the jet lag mostly passed it has all come together in a cleaner
and less future error-prone way. :)

 net/bridge/br_private.h | 7 +++++++
 net/bridge/br_vlan.c    | 3 ++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 2920e06a5403..04c19a37e500 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -102,12 +102,18 @@ struct br_tunnel_info {
 	struct metadata_dst	*tunnel_dst;
 };
 
+/* private vlan flags */
+enum {
+	BR_VLFLAG_PER_PORT_STATS = BIT(0),
+};
+
 /**
  * struct net_bridge_vlan - per-vlan entry
  *
  * @vnode: rhashtable member
  * @vid: VLAN id
  * @flags: bridge vlan flags
+ * @priv_flags: private (in-kernel) bridge vlan flags
  * @stats: per-cpu VLAN statistics
  * @br: if MASTER flag set, this points to a bridge struct
  * @port: if MASTER flag unset, this points to a port struct
@@ -127,6 +133,7 @@ struct net_bridge_vlan {
 	struct rhash_head		tnode;
 	u16				vid;
 	u16				flags;
+	u16				priv_flags;
 	struct br_vlan_stats __percpu	*stats;
 	union {
 		struct net_bridge	*br;
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 8c9297a01947..e84be08b8285 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -197,7 +197,7 @@ static void nbp_vlan_rcu_free(struct rcu_head *rcu)
 	v = container_of(rcu, struct net_bridge_vlan, rcu);
 	WARN_ON(br_vlan_is_master(v));
 	/* if we had per-port stats configured then free them here */
-	if (v->brvlan->stats != v->stats)
+	if (v->priv_flags & BR_VLFLAG_PER_PORT_STATS)
 		free_percpu(v->stats);
 	v->stats = NULL;
 	kfree(v);
@@ -264,6 +264,7 @@ static int __vlan_add(struct net_bridge_vlan *v, u16 flags)
 				err = -ENOMEM;
 				goto out_filt;
 			}
+			v->priv_flags |= BR_VLFLAG_PER_PORT_STATS;
 		} else {
 			v->stats = masterv->stats;
 		}
-- 
2.17.2

