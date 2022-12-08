Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7E18440888
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7AA3F40300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PP7f+3IMbnf2HQwE4RvEho0oODh0ZQSUtULC6WZo7Lg=;
 b=Z02Nr9SXoMI5AkZY8i11gsMip6VVur+Bynh19XmSAPni9OdvQ6Y1/vDLUXAMMftGgCiX1r5csGfrdGdScrAHFn9eaeN7LE/uOPzVDxDBiP+i4gYfyimLcPFvCZR34cpvWZHSgKEJ23JiNR4rYRIUy+Qadeq35xHoB8+Qr2Y9ZOscBkiDnhKbhGKaFX6Ndbv+C6iqlHIzUkcVmuzw0mu+FGoqYCIK21OdCqxvP7RR/h7gSbvMLHTi/j8DCPOvNj9LolBh4o5x5Wk3XMUwctuMwPf0vYqJ1EHsD4LcVD6k/GbJZuxlXPOYgzHA66vyx0Cy4K0DAfIZ+FTYt/z6Wamkwg==
From: Ido Schimmel <idosch@nvidia.com>
Date: Thu,  8 Dec 2022 17:28:31 +0200
Message-Id: <20221208152839.1016350-7-idosch@nvidia.com>
In-Reply-To: <20221208152839.1016350-1-idosch@nvidia.com>
References: <20221208152839.1016350-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next 06/14] bridge: mcast: Expose
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

