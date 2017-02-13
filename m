Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=R6Wjtkz0xtJhCru8L8+4MfpWTOJZrE78LxLM86g8jJo=;
	b=XHC9uudFEj9TJJ1WsgA9FOepLJXdbBdr/+SlvBUDgrEJgrMWf4vcbg+ZSplXXqDBYR
	U/Qib/2L+UPcQHDzE42JICmFflvoB5FEri3J04sBeqC4Pnp2H//GKQcufHynLGEEl51P
	2/kq4iwco0yLZb+y32RLSFsHAvCU5tz4XTdcc=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Mon, 13 Feb 2017 14:59:11 +0100
Message-Id: <1486994351-1137-4-git-send-email-nikolay@cumulusnetworks.com>
In-Reply-To: <1486994351-1137-1-git-send-email-nikolay@cumulusnetworks.com>
References: <1486994351-1137-1-git-send-email-nikolay@cumulusnetworks.com>
Subject: [Bridge] [PATCH net-next 3/3] bridge: fdb: converge fdb_delete_by
	functions into one
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net

We can simplify the logic of entries pointing to the bridge by
converging the fdb_delete_by functions, this would allow us to use the
same function for both cases since the fdb's dst is set to NULL if it is
pointing to the bridge thus we can always check for a port match.

Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 net/bridge/br_fdb.c | 62 +++++++++++++----------------------------------------
 1 file changed, 15 insertions(+), 47 deletions(-)

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index da5ed7d0a3c8..4ac11574117c 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -930,35 +930,10 @@ int br_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
 	return err;
 }
 
-static int fdb_delete_by_addr(struct net_bridge *br, const u8 *addr,
-			      u16 vid)
-{
-	struct net_bridge_fdb_entry *fdb;
-
-	fdb = br_fdb_find(br, addr, vid);
-	if (!fdb)
-		return -ENOENT;
-
-	fdb_delete(br, fdb);
-	return 0;
-}
-
-static int __br_fdb_delete_by_addr(struct net_bridge *br,
-				   const unsigned char *addr, u16 vid)
-{
-	int err;
-
-	spin_lock_bh(&br->hash_lock);
-	err = fdb_delete_by_addr(br, addr, vid);
-	spin_unlock_bh(&br->hash_lock);
-
-	return err;
-}
-
-static int fdb_delete_by_addr_and_port(struct net_bridge_port *p,
+static int fdb_delete_by_addr_and_port(struct net_bridge *br,
+				       const struct net_bridge_port *p,
 				       const u8 *addr, u16 vlan)
 {
-	struct net_bridge *br = p->br;
 	struct net_bridge_fdb_entry *fdb;
 
 	fdb = br_fdb_find(br, addr, vlan);
@@ -966,17 +941,19 @@ static int fdb_delete_by_addr_and_port(struct net_bridge_port *p,
 		return -ENOENT;
 
 	fdb_delete(br, fdb);
+
 	return 0;
 }
 
-static int __br_fdb_delete(struct net_bridge_port *p,
+static int __br_fdb_delete(struct net_bridge *br,
+			   const struct net_bridge_port *p,
 			   const unsigned char *addr, u16 vid)
 {
 	int err;
 
-	spin_lock_bh(&p->br->hash_lock);
-	err = fdb_delete_by_addr_and_port(p, addr, vid);
-	spin_unlock_bh(&p->br->hash_lock);
+	spin_lock_bh(&br->hash_lock);
+	err = fdb_delete_by_addr_and_port(br, p, addr, vid);
+	spin_unlock_bh(&br->hash_lock);
 
 	return err;
 }
@@ -989,7 +966,7 @@ int br_fdb_delete(struct ndmsg *ndm, struct nlattr *tb[],
 	struct net_bridge_vlan_group *vg;
 	struct net_bridge_port *p = NULL;
 	struct net_bridge_vlan *v;
-	struct net_bridge *br = NULL;
+	struct net_bridge *br;
 	int err;
 
 	if (dev->priv_flags & IFF_EBRIDGE) {
@@ -1003,6 +980,7 @@ int br_fdb_delete(struct ndmsg *ndm, struct nlattr *tb[],
 			return -EINVAL;
 		}
 		vg = nbp_vlan_group(p);
+		br = p->br;
 	}
 
 	if (vid) {
@@ -1012,30 +990,20 @@ int br_fdb_delete(struct ndmsg *ndm, struct nlattr *tb[],
 			return -EINVAL;
 		}
 
-		if (dev->priv_flags & IFF_EBRIDGE)
-			err = __br_fdb_delete_by_addr(br, addr, vid);
-		else
-			err = __br_fdb_delete(p, addr, vid);
+		err = __br_fdb_delete(br, p, addr, vid);
 	} else {
 		err = -ENOENT;
-		if (dev->priv_flags & IFF_EBRIDGE)
-			err = __br_fdb_delete_by_addr(br, addr, 0);
-		else
-			err &= __br_fdb_delete(p, addr, 0);
-
+		err &= __br_fdb_delete(br, p, addr, 0);
 		if (!vg || !vg->num_vlans)
-			goto out;
+			return err;
 
 		list_for_each_entry(v, &vg->vlan_list, vlist) {
 			if (!br_vlan_should_use(v))
 				continue;
-			if (dev->priv_flags & IFF_EBRIDGE)
-				err = __br_fdb_delete_by_addr(br, addr, v->vid);
-			else
-				err &= __br_fdb_delete(p, addr, v->vid);
+			err &= __br_fdb_delete(br, p, addr, v->vid);
 		}
 	}
-out:
+
 	return err;
 }
 
-- 
2.1.4

