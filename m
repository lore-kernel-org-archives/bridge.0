Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2D39881B9D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6163481BB0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dvCiINSgInnpIymRGCEhRqVBUTuaGlTHULAaBfYIF2M=;
 b=e5/1XUw27ciuZ4Ef3a2cZfUd9B2XtpgMdJSYDsxPteWQDn28AcSYZX6wlKCRbBEjl+WXVgjhgI0xoETOWOZZPBcyrjWf864VCojN00VUmshR/NUbJswfa6muhi8vpVFzHJTkwef0p4xDnf5uIy/P6FktCCy22pCtl1GyPBCsCH4sp51vnV9GpkEZk+tGgK0LSXI2VVrcx4mHI8bTZgu6epUYBaAU0ulYHdLI0CYX7fE7TAlQe6uiBkQj7caUUe2bVrgubI8qsnQYn52+rmqGa4RTsvGpKPO82o0Daj4CNsx9H57t4ktoEMuaQfoLciHjMrCd4xdQVj5/U5WyTkZIxg==
From: Ido Schimmel <idosch@nvidia.com>
Date: Sat, 10 Dec 2022 16:56:25 +0200
Message-Id: <20221210145633.1328511-7-idosch@nvidia.com>
In-Reply-To: <20221210145633.1328511-1-idosch@nvidia.com>
References: <20221210145633.1328511-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next v2 06/14] bridge: mcast: Expose
	__br_multicast_del_group_src()
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

Expose __br_multicast_del_group_src() which is symmetric to
br_multicast_new_group_src() and does not remove the installed {S, G}
forwarding entry, unlike br_multicast_del_group_src().

The function will be used in the error path when user space was able to
add a new source entry, but failed to install a corresponding forwarding
entry.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
---

Notes:
    v1:
    * New patch.

 net/bridge/br_multicast.c | 11 ++++++++---
 net/bridge/br_private.h   |  1 +
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index b2bc23fdcee5..8432b4ea7f28 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -650,18 +650,23 @@ static void br_multicast_destroy_group_src(struct net_bridge_mcast_gc *gc)
 	kfree_rcu(src, rcu);
 }
 
-void br_multicast_del_group_src(struct net_bridge_group_src *src,
-				bool fastleave)
+void __br_multicast_del_group_src(struct net_bridge_group_src *src)
 {
 	struct net_bridge *br = src->pg->key.port->br;
 
-	br_multicast_fwd_src_remove(src, fastleave);
 	hlist_del_init_rcu(&src->node);
 	src->pg->src_ents--;
 	hlist_add_head(&src->mcast_gc.gc_node, &br->mcast_gc_list);
 	queue_work(system_long_wq, &br->mcast_gc_work);
 }
 
+void br_multicast_del_group_src(struct net_bridge_group_src *src,
+				bool fastleave)
+{
+	br_multicast_fwd_src_remove(src, fastleave);
+	__br_multicast_del_group_src(src);
+}
+
 static void br_multicast_destroy_port_group(struct net_bridge_mcast_gc *gc)
 {
 	struct net_bridge_port_group *pg;
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 183de6c57d72..a3db99d79a3d 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -977,6 +977,7 @@ br_multicast_find_group_src(struct net_bridge_port_group *pg, struct br_ip *ip);
 struct net_bridge_group_src *
 br_multicast_new_group_src(struct net_bridge_port_group *pg,
 			   struct br_ip *src_ip);
+void __br_multicast_del_group_src(struct net_bridge_group_src *src);
 void br_multicast_del_group_src(struct net_bridge_group_src *src,
 				bool fastleave);
 void br_multicast_ctx_init(struct net_bridge *br,
-- 
2.37.3

