DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:received:received:received:user-agent:date:from:to:subject:content-disposition:message-id;
	bh=tgwDXcRqVcdyRC128lJBBpbXkggH/8G3PPxU/tlYiFU=;
	b=ioYPJgzYZfan/SzhB1Ms+GKpnoV33ZY682wkMaw1f0vIv9vipM/u0zbAtWUA6eyGoQWR25ipGMmb7hXpN/Yc0pwyuHYYYZYCkGnvIFPTjbkMPwyh7rGNoan2O21KNh6VCi8OFpQnUAvmx0/l6dNZ8Qs8Vt2izOsDwuWS6lvrdLo=
Date: Mon, 17 Dec 2007 17:13:09 +0100
From: Jaime Medrano <jaime.medrano@gmail.com>
Content-Disposition: inline; filename=vlan.diff
Message-ID: <4766a1b9.06c7100a.5269.6cf0@mx.google.com>
Subject: [Bridge] [PATCH] Add vlan id to bridge forward database
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hi!

This makes forwarding table aware of 802.1Q vlan ids and stores
id with MACs in the table.

It solves problems when having same MAC on diffent pairs
(vlan, port). Current code gets confused at that situation.

Local MACs are managed as present on every vlan.

Signed-off-by: Jaime Medrano <jaime.medrano@gmail.com>
---
 include/linux/if_bridge.h |    3 ++-
 net/atm/lec.c             |    2 +-
 net/bridge/br_device.c    |   13 +++++++++----
 net/bridge/br_fdb.c       |   32 ++++++++++++++++++++------------
 net/bridge/br_input.c     |   15 ++++++++++++---
 net/bridge/br_private.h   |   13 +++++++++----
 6 files changed, 53 insertions(+), 25 deletions(-)

Index: linux-2.6.23/net/bridge/br_private.h
===================================================================
--- linux-2.6.23.orig/net/bridge/br_private.h	2007-12-17 11:53:56.000000000 +0100
+++ linux-2.6.23/net/bridge/br_private.h	2007-12-17 11:55:17.000000000 +0100
@@ -55,6 +55,7 @@
 	atomic_t			use_count;
 	unsigned long			ageing_timer;
 	mac_addr			addr;
+	unsigned short			vlan_id;
 	unsigned char			is_local;
 	unsigned char			is_static;
 };
@@ -150,9 +151,11 @@
 extern void br_fdb_delete_by_port(struct net_bridge *br,
 				  const struct net_bridge_port *p, int do_all);
 extern struct net_bridge_fdb_entry *__br_fdb_get(struct net_bridge *br,
-						 const unsigned char *addr);
+						 const unsigned char *addr,
+					         unsigned short vlan_id);
 extern struct net_bridge_fdb_entry *br_fdb_get(struct net_bridge *br,
-					       unsigned char *addr);
+					       unsigned char *addr,
+					       unsigned short vlan_id);
 extern void br_fdb_put(struct net_bridge_fdb_entry *ent);
 extern int br_fdb_fillbuf(struct net_bridge *br, void *buf,
 			  unsigned long count, unsigned long off);
@@ -161,7 +164,8 @@
 			 const unsigned char *addr);
 extern void br_fdb_update(struct net_bridge *br,
 			  struct net_bridge_port *source,
-			  const unsigned char *addr);
+			  const unsigned char *addr,
+			  unsigned short vlan_id);
 
 /* br_forward.c */
 extern void br_deliver(const struct net_bridge_port *to,
@@ -237,7 +241,8 @@
 
 /* br.c */
 extern struct net_bridge_fdb_entry *(*br_fdb_get_hook)(struct net_bridge *br,
-						       unsigned char *addr);
+						       unsigned char *addr,
+						       unsigned short vlan_id);
 extern void (*br_fdb_put_hook)(struct net_bridge_fdb_entry *ent);
 
 
Index: linux-2.6.23/net/bridge/br_device.c
===================================================================
--- linux-2.6.23.orig/net/bridge/br_device.c	2007-12-17 11:53:56.000000000 +0100
+++ linux-2.6.23/net/bridge/br_device.c	2007-12-17 11:55:17.000000000 +0100
@@ -17,6 +17,7 @@
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
 #include <linux/ethtool.h>
+#include <linux/if_vlan.h>
 
 #include <asm/uaccess.h>
 #include "br_private.h"
@@ -42,10 +43,14 @@
 
 	if (dest[0] & 1)
 		br_flood_deliver(br, skb);
-	else if ((dst = __br_fdb_get(br, dest)) != NULL)
-		br_deliver(dst->dst, skb);
-	else
-		br_flood_deliver(br, skb);
+	else {
+		unsigned short vlan_id = 0;
+		vlan_get_tag(skb, &vlan_id);
+		if ((dst = __br_fdb_get(br, dest, vlan_id)) != NULL)
+			br_deliver(dst->dst, skb);
+		else
+			br_flood_deliver(br, skb);
+	}
 
 	return 0;
 }
Index: linux-2.6.23/net/bridge/br_fdb.c
===================================================================
--- linux-2.6.23.orig/net/bridge/br_fdb.c	2007-12-17 11:53:56.000000000 +0100
+++ linux-2.6.23/net/bridge/br_fdb.c	2007-12-17 12:00:28.000000000 +0100
@@ -211,13 +211,15 @@
 
 /* No locking or refcounting, assumes caller has no preempt (rcu_read_lock) */
 struct net_bridge_fdb_entry *__br_fdb_get(struct net_bridge *br,
-					  const unsigned char *addr)
+					  const unsigned char *addr,
+					  unsigned short vlan_id)
 {
 	struct hlist_node *h;
 	struct net_bridge_fdb_entry *fdb;
 
 	hlist_for_each_entry_rcu(fdb, h, &br->hash[br_mac_hash(addr)], hlist) {
-		if (!compare_ether_addr(fdb->addr.addr, addr)) {
+		if (!compare_ether_addr(fdb->addr.addr, addr)
+		    && (fdb->is_local || fdb->vlan_id == vlan_id)) {
 			if (unlikely(has_expired(br, fdb)))
 				break;
 			return fdb;
@@ -229,12 +231,13 @@
 
 /* Interface used by ATM hook that keeps a ref count */
 struct net_bridge_fdb_entry *br_fdb_get(struct net_bridge *br,
-					unsigned char *addr)
+					unsigned char *addr,
+					unsigned short vlan_id)
 {
 	struct net_bridge_fdb_entry *fdb;
 
 	rcu_read_lock();
-	fdb = __br_fdb_get(br, addr);
+	fdb = __br_fdb_get(br, addr, vlan_id);
 	if (fdb && !atomic_inc_not_zero(&fdb->use_count))
 		fdb = NULL;
 	rcu_read_unlock();
@@ -289,6 +292,7 @@
 			fe->is_local = f->is_local;
 			if (!f->is_static)
 				fe->ageing_timer_value = jiffies_to_clock_t(jiffies - f->ageing_timer);
+			fe->vlan_id = f->vlan_id;
 			++fe;
 			++num;
 		}
@@ -301,13 +305,15 @@
 }
 
 static inline struct net_bridge_fdb_entry *fdb_find(struct hlist_head *head,
-						    const unsigned char *addr)
+						    const unsigned char *addr,
+						    unsigned short vlan_id)
 {
 	struct hlist_node *h;
 	struct net_bridge_fdb_entry *fdb;
 
 	hlist_for_each_entry_rcu(fdb, h, head, hlist) {
-		if (!compare_ether_addr(fdb->addr.addr, addr))
+		if (!compare_ether_addr(fdb->addr.addr, addr)
+		    && (fdb->is_local || fdb->vlan_id == vlan_id))
 			return fdb;
 	}
 	return NULL;
@@ -316,6 +322,7 @@
 static struct net_bridge_fdb_entry *fdb_create(struct hlist_head *head,
 					       struct net_bridge_port *source,
 					       const unsigned char *addr,
+					       unsigned short vlan_id,
 					       int is_local)
 {
 	struct net_bridge_fdb_entry *fdb;
@@ -323,6 +330,7 @@
 	fdb = kmem_cache_alloc(br_fdb_cache, GFP_ATOMIC);
 	if (fdb) {
 		memcpy(fdb->addr.addr, addr, ETH_ALEN);
+		fdb->vlan_id = vlan_id;
 		atomic_set(&fdb->use_count, 1);
 		hlist_add_head_rcu(&fdb->hlist, head);
 
@@ -343,7 +351,7 @@
 	if (!is_valid_ether_addr(addr))
 		return -EINVAL;
 
-	fdb = fdb_find(head, addr);
+	fdb = fdb_find(head, addr, 0);
 	if (fdb) {
 		/* it is okay to have multiple ports with same
 		 * address, just use the first one.
@@ -357,7 +365,7 @@
 		fdb_delete(fdb);
 	}
 
-	if (!fdb_create(head, source, addr, 1))
+	if (!fdb_create(head, source, addr, 0, 1))
 		return -ENOMEM;
 
 	return 0;
@@ -375,7 +383,7 @@
 }
 
 void br_fdb_update(struct net_bridge *br, struct net_bridge_port *source,
-		   const unsigned char *addr)
+		   const unsigned char *addr, unsigned short vlan_id)
 {
 	struct hlist_head *head = &br->hash[br_mac_hash(addr)];
 	struct net_bridge_fdb_entry *fdb;
@@ -389,7 +397,7 @@
 	      source->state == BR_STATE_FORWARDING))
 		return;
 
-	fdb = fdb_find(head, addr);
+	fdb = fdb_find(head, addr, vlan_id);
 	if (likely(fdb)) {
 		/* attempt to update an entry for a local interface */
 		if (unlikely(fdb->is_local)) {
@@ -404,8 +412,8 @@
 		}
 	} else {
 		spin_lock(&br->hash_lock);
-		if (!fdb_find(head, addr))
-			fdb_create(head, source, addr, 0);
+		if (!fdb_find(head, addr, vlan_id))
+			fdb_create(head, source, addr, vlan_id, 0);
 		/* else  we lose race and someone else inserts
 		 * it first, don't bother updating
 		 */
Index: linux-2.6.23/net/bridge/br_input.c
===================================================================
--- linux-2.6.23.orig/net/bridge/br_input.c	2007-12-17 11:53:56.000000000 +0100
+++ linux-2.6.23/net/bridge/br_input.c	2007-12-17 11:55:17.000000000 +0100
@@ -17,6 +17,7 @@
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
 #include <linux/netfilter_bridge.h>
+#include <linux/if_vlan.h>
 #include "br_private.h"
 
 /* Bridge group multicast address 802.1d (pg 51). */
@@ -44,13 +45,17 @@
 	struct net_bridge *br;
 	struct net_bridge_fdb_entry *dst;
 	struct sk_buff *skb2;
+	struct vlan_ethhdr *veth = vlan_eth_hdr(skb);
+	unsigned short vlan_id = 0;
 
 	if (!p || p->state == BR_STATE_DISABLED)
 		goto drop;
 
 	/* insert into forwarding database after filtering to avoid spoofing */
+	if (veth->h_vlan_proto == __constant_htons(ETH_P_8021Q))
+		vlan_id = ntohs(veth->h_vlan_TCI) & VLAN_VID_MASK;
 	br = p->br;
-	br_fdb_update(br, p, eth_hdr(skb)->h_source);
+	br_fdb_update(br, p, eth_hdr(skb)->h_source, vlan_id);
 
 	if (p->state == BR_STATE_LEARNING)
 		goto drop;
@@ -66,7 +71,7 @@
 	if (is_multicast_ether_addr(dest)) {
 		br->statistics.multicast++;
 		skb2 = skb;
-	} else if ((dst = __br_fdb_get(br, dest)) && dst->is_local) {
+	} else if ((dst = __br_fdb_get(br, dest, vlan_id)) && dst->is_local) {
 		skb2 = skb;
 		/* Do not forward the packet since it's local. */
 		skb = NULL;
@@ -96,9 +101,13 @@
 static int br_handle_local_finish(struct sk_buff *skb)
 {
 	struct net_bridge_port *p = rcu_dereference(skb->dev->br_port);
+	struct vlan_ethhdr *veth = vlan_eth_hdr(skb);
+	unsigned short vlan_id = 0;
 
+	if (veth->h_vlan_proto == __constant_htons(ETH_P_8021Q))
+		vlan_id = ntohs(veth->h_vlan_TCI) & VLAN_VID_MASK;
 	if (p)
-		br_fdb_update(p->br, p, eth_hdr(skb)->h_source);
+		br_fdb_update(p->br, p, eth_hdr(skb)->h_source, vlan_id);
 	return 0;	 /* process further */
 }
 
Index: linux-2.6.23/net/atm/lec.c
===================================================================
--- linux-2.6.23.orig/net/atm/lec.c	2007-12-17 11:53:56.000000000 +0100
+++ linux-2.6.23/net/atm/lec.c	2007-12-17 11:55:17.000000000 +0100
@@ -557,7 +557,7 @@
 				break;
 
 			f = br_fdb_get_hook(dev->br_port->br,
-					    mesg->content.proxy.mac_addr);
+					    mesg->content.proxy.mac_addr, 0);
 			if (f != NULL && f->dst->dev != dev
 			    && f->dst->state == BR_STATE_FORWARDING) {
 				/* hit from bridge table, send LE_ARP_RESPONSE */
Index: linux-2.6.23/include/linux/if_bridge.h
===================================================================
--- linux-2.6.23.orig/include/linux/if_bridge.h	2007-12-17 11:59:46.000000000 +0100
+++ linux-2.6.23/include/linux/if_bridge.h	2007-12-17 12:00:28.000000000 +0100
@@ -97,7 +97,8 @@
 	__u8 port_no;
 	__u8 is_local;
 	__u32 ageing_timer_value;
-	__u32 unused;
+	__u16 vlan_id;
+	__u16 unused;
 };
 
 #ifdef __KERNEL__

-- 

