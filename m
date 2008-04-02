Date: Wed, 2 Apr 2008 11:30:04 +0200
From: Jaime Medrano <jaime.medrano@gmail.com>
Message-ID: <20080402093004.GA13430@localhost>
References: <4766a3d1.02ab100a.0be8.6fdc@mx.google.com>
	<20071217085349.729e5c17@deepthought>
	<20080128153914.GA5880@localhost> <20080317113537.496d9347@extreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080317113537.496d9347@extreme>
Subject: Re: [Bridge] [PATCH] Add vlan id to bridge forward database
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: bridge@lists.osdl.org

On Mon, Mar 17, 2008 at 11:35:37AM -0700, Stephen Hemminger wrote:
> Minor stuff:
> 1. Please use shorter variable names, rather than:
>               unsigned short vlan_first_id;
>       I would choose:
>               u16 vlan1;

Done.

> 2. You probably can use skb->protocol rather than having to look at the packet
>     contents to check for 8021Q.

Done for non-nested case. Unavoidable for nested vlan tags.

> 3. Don't use __constant_htons(), just use htons().
>    The macro is smart enough to handle the
>    constant case, and it reads better, without the __constant_prefix.

Done.

> Major stuff:
> 1. This won't work with hardware accel VLAN receive. The tag is not put in
>    the skb?

It will work with drivers with hardware accel VLAN receive support if no
vlan device is attached to the network device of one of the ports of the
bridge. It will also work if a vlan device is attached to the bridge
device. In those cases, hw accel is not used.

However, it won't work if a vlan device is attached to the network
device of one of the ports. Hw accel will be used and the vlan tag won't
be available. Anyway, this is a bad idea since normal bridging won't work
either. The vlan won't be regenerated at bridge output since current
bridge code doesn't get that tag.

If the vlan device is attached to the bridge device then bridging has no
problems as hw accel receiving is not used.

The patch has also been generalized to support any number of vlan nested
tags. Vlan tag recording can be disabled at all if BR_MAX_VLAN_TAGS is
set to 0.

---
Subject: [PATCH] Add vlan tags to bridge forward database

This makes forwarding table aware of 802.1Q vlan tags and stores
vlan ids with MACs in the table.

It solves problems when having same MAC on diffent pairs
(vlan, port). Current code gets confused at that situation.

Nested vlan tags are also handled.

Local MACs are managed as present on every vlan.

Signed-off-by: Jaime Medrano <jaime.medrano@gmail.com>
---
 net/bridge/br_device.c  |   11 +++--
 net/bridge/br_fdb.c     |   91 ++++++++++++++++++++++++++++++++++++++++++------
 net/bridge/br_input.c   |   15 ++++---
 net/bridge/br_private.h |    9 +++-
 4 files changed, 103 insertions(+), 23 deletions(-)

Index: linux-2.6.25-rc7/net/bridge/br_private.h
===================================================================
--- linux-2.6.25-rc7.orig/net/bridge/br_private.h	2008-04-01 23:54:49.000000000 +0200
+++ linux-2.6.25-rc7/net/bridge/br_private.h	2008-04-01 23:55:13.000000000 +0200
@@ -26,6 +26,8 @@
 #define BR_PORT_BITS	10
 #define BR_MAX_PORTS	(1<<BR_PORT_BITS)
 
+#define BR_MAX_VLAN_TAGS	2
+
 #define BR_VERSION	"2.3"
 
 /* Path to usermode spanning tree program */
@@ -55,6 +57,7 @@
 	atomic_t			use_count;
 	unsigned long			ageing_timer;
 	mac_addr			addr;
+	__be16				vlan_tags[BR_MAX_VLAN_TAGS];
 	unsigned char			is_local;
 	unsigned char			is_static;
 };
@@ -150,7 +153,8 @@
 extern void br_fdb_delete_by_port(struct net_bridge *br,
 				  const struct net_bridge_port *p, int do_all);
 extern struct net_bridge_fdb_entry *__br_fdb_get(struct net_bridge *br,
-						 const unsigned char *addr);
+						 const unsigned char *addr,
+						 const struct sk_buff *skb);
 extern struct net_bridge_fdb_entry *br_fdb_get(struct net_bridge *br,
 					       unsigned char *addr);
 extern void br_fdb_put(struct net_bridge_fdb_entry *ent);
@@ -161,7 +165,8 @@
 			 const unsigned char *addr);
 extern void br_fdb_update(struct net_bridge *br,
 			  struct net_bridge_port *source,
-			  const unsigned char *addr);
+			  const unsigned char *addr,
+			  const struct sk_buff *skb);
 
 /* br_forward.c */
 extern void br_deliver(const struct net_bridge_port *to,
Index: linux-2.6.25-rc7/net/bridge/br_device.c
===================================================================
--- linux-2.6.25-rc7.orig/net/bridge/br_device.c	2008-04-01 23:54:49.000000000 +0200
+++ linux-2.6.25-rc7/net/bridge/br_device.c	2008-04-01 23:55:13.000000000 +0200
@@ -42,10 +42,13 @@
 
 	if (dest[0] & 1)
 		br_flood_deliver(br, skb);
-	else if ((dst = __br_fdb_get(br, dest)) != NULL)
-		br_deliver(dst->dst, skb);
-	else
-		br_flood_deliver(br, skb);
+	else {
+		dst = __br_fdb_get(br, dest, skb);
+		if (dst != NULL)
+			br_deliver(dst->dst, skb);
+		else
+			br_flood_deliver(br, skb);
+	}
 
 	return 0;
 }
Index: linux-2.6.25-rc7/net/bridge/br_fdb.c
===================================================================
--- linux-2.6.25-rc7.orig/net/bridge/br_fdb.c	2008-04-01 23:54:49.000000000 +0200
+++ linux-2.6.25-rc7/net/bridge/br_fdb.c	2008-04-01 23:55:13.000000000 +0200
@@ -24,6 +24,7 @@
 #include <asm/atomic.h>
 #include <asm/unaligned.h>
 #include "br_private.h"
+#include <linux/if_vlan.h>
 
 static struct kmem_cache *br_fdb_cache __read_mostly;
 static int fdb_insert(struct net_bridge *br, struct net_bridge_port *source,
@@ -209,15 +210,79 @@
 	spin_unlock_bh(&br->hash_lock);
 }
 
+#if BR_MAX_VLAN_TAGS > 0
+static void set_vlan_tags(const struct sk_buff *skb, __be16 *tags)
+{
+	__be16 proto;
+	int i, off;
+	struct vlan_hdr _hdr;
+	struct vlan_hdr *hdr;
+
+	if (!skb || skb->protocol != htons(ETH_P_8021Q)) {
+		tags[0] = 0;
+		return;
+	}
+
+	proto = skb->protocol;
+
+	for (i = 0, off = 0 ;
+	     i < BR_MAX_VLAN_TAGS && proto == htons(ETH_P_8021Q) ;
+	     i++, off += VLAN_HLEN) {
+		hdr = skb_header_pointer(skb, off, sizeof(_hdr), &_hdr);
+		tags[i] = hdr->h_vlan_TCI & htons(VLAN_VID_MASK);
+		proto = hdr->h_vlan_encapsulated_proto;
+	}
+
+	if (i < BR_MAX_VLAN_TAGS)
+		tags[i] = 0;
+}
+
+static int compare_vlan_tags(const struct sk_buff *skb, const __be16 *tags)
+{
+	__be16 proto;
+	int i, off;
+	struct vlan_hdr _hdr;
+	struct vlan_hdr *hdr;
+
+	if (!skb || skb->protocol != htons(ETH_P_8021Q))
+		return tags[0] != 0;
+
+	proto = skb->protocol;
+
+	for (i = 0, off = 0 ;
+	     i < BR_MAX_VLAN_TAGS && tags[i] && proto == htons(ETH_P_8021Q) ;
+	     i++, off += VLAN_HLEN) {
+		hdr = skb_header_pointer(skb, off, sizeof(_hdr), &_hdr);
+		if ((hdr->h_vlan_TCI & htons(VLAN_VID_MASK)) != tags[i])
+			return 1;
+		proto = hdr->h_vlan_encapsulated_proto;
+	}
+
+	return i < BR_MAX_VLAN_TAGS && (tags[i] || proto == htons(ETH_P_8021Q));
+}
+
+#else
+static void set_vlan_tags(const struct sk_buff *skb, __be16 *tags)
+{
+}
+
+static int compare_vlan_tags(const struct sk_buff *skb, const __be16 *tags)
+{
+	return 0;
+}
+#endif
+
 /* No locking or refcounting, assumes caller has no preempt (rcu_read_lock) */
 struct net_bridge_fdb_entry *__br_fdb_get(struct net_bridge *br,
-					  const unsigned char *addr)
+					  const unsigned char *addr,
+					  const struct sk_buff *skb)
 {
 	struct hlist_node *h;
 	struct net_bridge_fdb_entry *fdb;
 
 	hlist_for_each_entry_rcu(fdb, h, &br->hash[br_mac_hash(addr)], hlist) {
-		if (!compare_ether_addr(fdb->addr.addr, addr)) {
+		if (!compare_ether_addr(fdb->addr.addr, addr) && (fdb->is_local
+		    || !compare_vlan_tags(skb, fdb->vlan_tags))) {
 			if (unlikely(has_expired(br, fdb)))
 				break;
 			return fdb;
@@ -234,7 +299,7 @@
 	struct net_bridge_fdb_entry *fdb;
 
 	rcu_read_lock();
-	fdb = __br_fdb_get(br, addr);
+	fdb = __br_fdb_get(br, addr, NULL);
 	if (fdb && !atomic_inc_not_zero(&fdb->use_count))
 		fdb = NULL;
 	rcu_read_unlock();
@@ -301,13 +366,15 @@
 }
 
 static inline struct net_bridge_fdb_entry *fdb_find(struct hlist_head *head,
-						    const unsigned char *addr)
+						    const unsigned char *addr,
+						    const struct sk_buff *skb)
 {
 	struct hlist_node *h;
 	struct net_bridge_fdb_entry *fdb;
 
 	hlist_for_each_entry_rcu(fdb, h, head, hlist) {
-		if (!compare_ether_addr(fdb->addr.addr, addr))
+		if (!compare_ether_addr(fdb->addr.addr, addr) &&
+		    (fdb->is_local || !compare_vlan_tags(skb, fdb->vlan_tags)))
 			return fdb;
 	}
 	return NULL;
@@ -316,6 +383,7 @@
 static struct net_bridge_fdb_entry *fdb_create(struct hlist_head *head,
 					       struct net_bridge_port *source,
 					       const unsigned char *addr,
+					       const struct sk_buff *skb,
 					       int is_local)
 {
 	struct net_bridge_fdb_entry *fdb;
@@ -323,6 +391,7 @@
 	fdb = kmem_cache_alloc(br_fdb_cache, GFP_ATOMIC);
 	if (fdb) {
 		memcpy(fdb->addr.addr, addr, ETH_ALEN);
+		set_vlan_tags(skb, fdb->vlan_tags);
 		atomic_set(&fdb->use_count, 1);
 		hlist_add_head_rcu(&fdb->hlist, head);
 
@@ -343,7 +412,7 @@
 	if (!is_valid_ether_addr(addr))
 		return -EINVAL;
 
-	fdb = fdb_find(head, addr);
+	fdb = fdb_find(head, addr, NULL);
 	if (fdb) {
 		/* it is okay to have multiple ports with same
 		 * address, just use the first one.
@@ -357,7 +426,7 @@
 		fdb_delete(fdb);
 	}
 
-	if (!fdb_create(head, source, addr, 1))
+	if (!fdb_create(head, source, addr, NULL, 1))
 		return -ENOMEM;
 
 	return 0;
@@ -375,7 +444,7 @@
 }
 
 void br_fdb_update(struct net_bridge *br, struct net_bridge_port *source,
-		   const unsigned char *addr)
+		   const unsigned char *addr, const struct sk_buff *skb)
 {
 	struct hlist_head *head = &br->hash[br_mac_hash(addr)];
 	struct net_bridge_fdb_entry *fdb;
@@ -389,7 +458,7 @@
 	      source->state == BR_STATE_FORWARDING))
 		return;
 
-	fdb = fdb_find(head, addr);
+	fdb = fdb_find(head, addr, skb);
 	if (likely(fdb)) {
 		/* attempt to update an entry for a local interface */
 		if (unlikely(fdb->is_local)) {
@@ -404,8 +473,8 @@
 		}
 	} else {
 		spin_lock(&br->hash_lock);
-		if (!fdb_find(head, addr))
-			fdb_create(head, source, addr, 0);
+		if (!fdb_find(head, addr, skb))
+			fdb_create(head, source, addr, skb, 0);
 		/* else  we lose race and someone else inserts
 		 * it first, don't bother updating
 		 */
Index: linux-2.6.25-rc7/net/bridge/br_input.c
===================================================================
--- linux-2.6.25-rc7.orig/net/bridge/br_input.c	2008-04-01 23:54:49.000000000 +0200
+++ linux-2.6.25-rc7/net/bridge/br_input.c	2008-04-01 23:55:13.000000000 +0200
@@ -50,7 +50,7 @@
 
 	/* insert into forwarding database after filtering to avoid spoofing */
 	br = p->br;
-	br_fdb_update(br, p, eth_hdr(skb)->h_source);
+	br_fdb_update(br, p, eth_hdr(skb)->h_source, skb);
 
 	if (p->state == BR_STATE_LEARNING)
 		goto drop;
@@ -66,10 +66,13 @@
 	if (is_multicast_ether_addr(dest)) {
 		br->statistics.multicast++;
 		skb2 = skb;
-	} else if ((dst = __br_fdb_get(br, dest)) && dst->is_local) {
-		skb2 = skb;
-		/* Do not forward the packet since it's local. */
-		skb = NULL;
+	} else {
+		dst = __br_fdb_get(br, dest, skb);
+		if (dst && dst->is_local) {
+			skb2 = skb;
+			/* Do not forward the packet since it's local. */
+			skb = NULL;
+		}
 	}
 
 	if (skb2 == skb)
@@ -98,7 +101,7 @@
 	struct net_bridge_port *p = rcu_dereference(skb->dev->br_port);
 
 	if (p)
-		br_fdb_update(p->br, p, eth_hdr(skb)->h_source);
+		br_fdb_update(p->br, p, eth_hdr(skb)->h_source, skb);
 	return 0;	 /* process further */
 }
 
