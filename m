Date: Fri, 28 Jan 2005 15:23:33 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] Benchmarking bridging vs. routing on same
	hardware/network
Message-ID: <20050128152333.5e718a26@dxpl.pdx.osdl.net>
In-Reply-To: <200501280417.j0S4HjTV020777@fire-1.osdl.org>
References: <20050126130903.02aaea4a@dxpl.pdx.osdl.net>
	<200501280417.j0S4HjTV020777@fire-1.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: dan-linuxbridge@unpossible.com
Cc: bridge@lists.osdl.org

Please try this patch,  it does:
	* don't spin_lock on the update path unless entry
	  is missing
	* increase size of hash table
	* use jenkins hash which might distribute better
	* run gc timer at fixed interval.

Purely experimental, but I'm running it here. If it works, will
split into pieces for inclusion


diff -Nru a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
--- a/net/bridge/br_fdb.c	2005-01-28 15:20:03 -08:00
+++ b/net/bridge/br_fdb.c	2005-01-28 15:20:03 -08:00
@@ -19,12 +19,17 @@
 #include <linux/times.h>
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
+#include <linux/jhash.h>
+
 #include <asm/atomic.h>
 #include "br_private.h"
 
+static struct net_bridge_fdb_entry *fdb_create(struct hlist_head *head,
+					       struct net_bridge_port *source,
+					       const unsigned char *addr,
+					       int is_local);
+
 static kmem_cache_t *br_fdb_cache;
-static int fdb_insert(struct net_bridge *br, struct net_bridge_port *source,
-		      const unsigned char *addr, int is_local);
 
 void __init br_fdb_init(void)
 {
@@ -43,40 +48,28 @@
 /* if topology_changing then use forward_delay (default 15 sec)
  * otherwise keep longer (default 5 minutes)
  */
-static __inline__ unsigned long hold_time(const struct net_bridge *br)
+static inline unsigned long hold_time(const struct net_bridge *br)
 {
 	return br->topology_change ? br->forward_delay : br->ageing_time;
 }
 
-static __inline__ int has_expired(const struct net_bridge *br,
+static inline int has_expired(const struct net_bridge *br,
 				  const struct net_bridge_fdb_entry *fdb)
 {
 	return !fdb->is_static 
 		&& time_before_eq(fdb->ageing_timer + hold_time(br), jiffies);
 }
 
-static __inline__ int br_mac_hash(const unsigned char *mac)
+static inline struct hlist_head *br_mac_hash(struct net_bridge *br,
+					     const unsigned char *mac)
 {
-	unsigned long x;
-
-	x = mac[0];
-	x = (x << 2) ^ mac[1];
-	x = (x << 2) ^ mac[2];
-	x = (x << 2) ^ mac[3];
-	x = (x << 2) ^ mac[4];
-	x = (x << 2) ^ mac[5];
-
-	x ^= x >> 8;
-
-	return x & (BR_HASH_SIZE - 1);
+	u32 hash = jhash(mac, ETH_ALEN, 0);
+	return &br->hash[hash & ((1<<BR_HASH_BITS)-1)];
 }
 
-static __inline__ void fdb_delete(struct net_bridge_fdb_entry *f)
+static inline void fdb_delete(struct net_bridge_fdb_entry *f)
 {
 	hlist_del_rcu(&f->hlist);
-	if (!f->is_static)
-		list_del(&f->u.age_list);
-
 	br_fdb_put(f);
 }
 
@@ -113,40 +106,34 @@
 		}
 	}
  insert:
-	/* insert new address,  may fail if invalid address or dup. */
-	fdb_insert(br, p, newaddr, 1);
-
 
+	if (is_valid_ether_addr(newaddr))
+		fdb_create(br_mac_hash(br, newaddr), p, newaddr, 1);
 	spin_unlock_bh(&br->hash_lock);
 }
 
 void br_fdb_cleanup(unsigned long _data)
 {
 	struct net_bridge *br = (struct net_bridge *)_data;
-	struct list_head *l, *n;
-	unsigned long delay;
+	unsigned long delay = hold_time(br);
+	int i;
 
 	spin_lock_bh(&br->hash_lock);
-	delay = hold_time(br);
-
-	list_for_each_safe(l, n, &br->age_list) {
+	for (i = 0; i < BR_HASH_SIZE; i++) {
 		struct net_bridge_fdb_entry *f;
-		unsigned long expires;
+		struct hlist_node *h, *n;
 
-		f = list_entry(l, struct net_bridge_fdb_entry, u.age_list);
-		expires = f->ageing_timer + delay;
-
-		if (time_before_eq(expires, jiffies)) {
-			WARN_ON(f->is_static);
-			pr_debug("expire age %lu jiffies %lu\n",
-				 f->ageing_timer, jiffies);
-			fdb_delete(f);
-		} else {
-			mod_timer(&br->gc_timer, expires);
-			break;
+		hlist_for_each_entry_safe(f, h, n, &br->hash[i], hlist) {
+			if (!f->is_static 
+			    && time_before_eq(f->ageing_timer + delay,
+					      jiffies)) {
+				fdb_delete(f);
+			}
 		}
 	}
 	spin_unlock_bh(&br->hash_lock);
+
+	mod_timer(&br->gc_timer, jiffies + HZ/10);
 }
 
 void br_fdb_delete_by_port(struct net_bridge *br, struct net_bridge_port *p)
@@ -191,10 +178,11 @@
 struct net_bridge_fdb_entry *__br_fdb_get(struct net_bridge *br,
 					  const unsigned char *addr)
 {
+	struct hlist_head *head = br_mac_hash(br,addr);
 	struct hlist_node *h;
 	struct net_bridge_fdb_entry *fdb;
 
-	hlist_for_each_entry_rcu(fdb, h, &br->hash[br_mac_hash(addr)], hlist) {
+	hlist_for_each_entry_rcu(fdb, h, head, hlist) {
 		if (!memcmp(fdb->addr.addr, addr, ETH_ALEN)) {
 			if (unlikely(has_expired(br, fdb)))
 				break;
@@ -205,6 +193,7 @@
 	return NULL;
 }
 
+#if defined(CONFIG_ATM_LANE) || defined(CONFIG_ATM_LANE_MODULE)
 /* Interface used by ATM hook that keeps a ref count */
 struct net_bridge_fdb_entry *br_fdb_get(struct net_bridge *br, 
 					unsigned char *addr)
@@ -218,19 +207,20 @@
 	rcu_read_unlock();
 	return fdb;
 }
+#endif
+
 
 static void fdb_rcu_free(struct rcu_head *head)
 {
-	struct net_bridge_fdb_entry *ent
-		= container_of(head, struct net_bridge_fdb_entry, u.rcu);
-	kmem_cache_free(br_fdb_cache, ent);
+	kmem_cache_free(br_fdb_cache, 
+			container_of(head, struct net_bridge_fdb_entry, rcu));
 }
 
 /* Set entry up for deletion with RCU  */
 void br_fdb_put(struct net_bridge_fdb_entry *ent)
 {
 	if (atomic_dec_and_test(&ent->use_count))
-		call_rcu(&ent->u.rcu, fdb_rcu_free);
+		call_rcu(&ent->rcu, fdb_rcu_free);
 }
 
 /*
@@ -278,80 +268,103 @@
 	return num;
 }
 
-static int fdb_insert(struct net_bridge *br, struct net_bridge_port *source,
-		  const unsigned char *addr, int is_local)
+static inline struct net_bridge_fdb_entry *
+fdb_find(struct hlist_head *head, const unsigned char *addr)
 {
 	struct hlist_node *h;
 	struct net_bridge_fdb_entry *fdb;
-	int hash = br_mac_hash(addr);
 
-	if (!is_valid_ether_addr(addr))
-		return -EADDRNOTAVAIL;
+	hlist_for_each_entry_rcu(fdb, h, head, hlist) {
+		if (!memcmp(fdb->addr.addr, addr, ETH_ALEN))
+			return fdb;
+	}
+	return NULL;
+}
 
-	hlist_for_each_entry(fdb, h, &br->hash[hash], hlist) {
-		if (!memcmp(fdb->addr.addr, addr, ETH_ALEN)) {
-			/* attempt to update an entry for a local interface */
-			if (fdb->is_local) {
-				/* it is okay to have multiple ports with same 
-				 * address, just don't allow to be spoofed.
-				 */
-				if (is_local) 
-					return 0;
-
-				if (net_ratelimit()) 
-					printk(KERN_WARNING "%s: received packet with "
-					       " own address as source address\n",
-					       source->dev->name);
-				return -EEXIST;
-			}
+static struct net_bridge_fdb_entry *
+fdb_create(struct hlist_head *head,
+	   struct net_bridge_port *source,
+	   const unsigned char *addr, int is_local)
+{
+	struct net_bridge_fdb_entry *fdb;
 
-			if (is_local) {
-				printk(KERN_WARNING "%s adding interface with same address "
-				       "as a received packet\n",
-				       source->dev->name);
-				goto update;
-			}
+	/* No match found */
+	fdb = kmem_cache_alloc(br_fdb_cache, GFP_ATOMIC);
+	if (fdb) {
+		memcpy(fdb->addr.addr, addr, ETH_ALEN);
+		atomic_set(&fdb->use_count, 1);
+
+		hlist_add_head_rcu(&fdb->hlist, head);
+
+		fdb->dst = source;
+		fdb->is_local = is_local;
+		fdb->is_static = is_local;
+		fdb->ageing_timer = jiffies;
+	}
 
-			if (fdb->is_static)
-				return 0;
+	return fdb;
+}
 
-			/* move to end of age list */
-			list_del(&fdb->u.age_list);
-			goto update;
-		}
-	}
 
-	fdb = kmem_cache_alloc(br_fdb_cache, GFP_ATOMIC);
-	if (!fdb)
-		return ENOMEM;
+int br_fdb_insert(struct net_bridge *br, struct net_bridge_port *source,
+		  const unsigned char *addr)
+{
+	struct hlist_head *head = br_mac_hash(br, addr);
+	struct net_bridge_fdb_entry *fdb;
+	int ret = 0;
+
+	if (!is_valid_ether_addr(addr))
+		return -EINVAL;
 
-	memcpy(fdb->addr.addr, addr, ETH_ALEN);
-	atomic_set(&fdb->use_count, 1);
-	hlist_add_head_rcu(&fdb->hlist, &br->hash[hash]);
-
-	if (!timer_pending(&br->gc_timer)) {
-		br->gc_timer.expires = jiffies + hold_time(br);
-		add_timer(&br->gc_timer);
+	spin_lock_bh(&br->hash_lock);
+	fdb = fdb_find(head, addr);
+	if (fdb) {
+		/* it is okay to have multiple ports with same 
+		 * address, just use the first one.
+		 */
+		if (fdb->is_local) 
+			goto out;
+
+		printk(KERN_WARNING "%s adding interface with same address "
+		       "as a received packet\n",
+		       source->dev->name);
+		fdb_delete(fdb);
 	}
 
- update:
-	fdb->dst = source;
-	fdb->is_local = is_local;
-	fdb->is_static = is_local;
-	fdb->ageing_timer = jiffies;
-	if (!is_local) 
-		list_add_tail(&fdb->u.age_list, &br->age_list);
+	if (!fdb_create(head, source, addr, 1))
+		ret = -ENOMEM;
 
-	return 0;
+ out:
+	spin_unlock_bh(&br->hash_lock);
+	return ret;
 }
 
-int br_fdb_insert(struct net_bridge *br, struct net_bridge_port *source,
-		  const unsigned char *addr, int is_local)
+void br_fdb_update(struct net_bridge *br, struct net_bridge_port *source,
+		  const unsigned char *addr)
 {
-	int ret;
+	struct hlist_head *head = br_mac_hash(br,addr);
+	struct net_bridge_fdb_entry *fdb;
+
+	rcu_read_lock();
+	fdb = fdb_find(head, addr);
+	if (likely(fdb)) {
+		/* attempt to update an entry for a local interface */
+		if (fdb->is_local) {
+			if (net_ratelimit()) 
+				printk(KERN_WARNING "%s: received packet with "
+				       " own address as source address\n",
+				       source->dev->name);
+		}
+
+		/* racy but okay */
+		fdb->dst = source;
+		fdb->ageing_timer = jiffies;
+		rcu_read_unlock();
+		return;
+	}
 
 	spin_lock_bh(&br->hash_lock);
-	ret = fdb_insert(br, source, addr, is_local);
+	if (!fdb_find(head, addr))
+		fdb_create(head, source, addr, 0);
 	spin_unlock_bh(&br->hash_lock);
-	return ret;
 }
diff -Nru a/net/bridge/br_forward.c b/net/bridge/br_forward.c
--- a/net/bridge/br_forward.c	2005-01-28 15:20:03 -08:00
+++ b/net/bridge/br_forward.c	2005-01-28 15:20:03 -08:00
@@ -22,36 +22,28 @@
 static inline int should_deliver(const struct net_bridge_port *p, 
 				 const struct sk_buff *skb)
 {
-	if (skb->dev == p->dev ||
-	    p->state != BR_STATE_FORWARDING)
-		return 0;
-
-	return 1;
+	return (skb->dev != p->dev && p->state == BR_STATE_FORWARDING);
 }
 
 int br_dev_queue_push_xmit(struct sk_buff *skb)
 {
-	if (skb->len > skb->dev->mtu) 
+	if (unlikely(skb->len > skb->dev->mtu)) {
 		kfree_skb(skb);
-	else {
+		return 0;
+	}
 #ifdef CONFIG_BRIDGE_NETFILTER
-		/* ip_refrag calls ip_fragment, doesn't copy the MAC header. */
-		nf_bridge_maybe_copy_header(skb);
+	/* ip_refrag calls ip_fragment, doesn't copy the MAC header. */
+	nf_bridge_maybe_copy_header(skb);
 #endif
-		skb_push(skb, ETH_HLEN);
-
-		dev_queue_xmit(skb);
-	}
-
-	return 0;
+	skb_push(skb, ETH_HLEN);
+	
+	return dev_queue_xmit(skb);
 }
 
 int br_forward_finish(struct sk_buff *skb)
 {
-	NF_HOOK(PF_BRIDGE, NF_BR_POST_ROUTING, skb, NULL, skb->dev,
+	return NF_HOOK(PF_BRIDGE, NF_BR_POST_ROUTING, skb, NULL, skb->dev,
 			br_dev_queue_push_xmit);
-
-	return 0;
 }
 
 static void __br_deliver(const struct net_bridge_port *to, struct sk_buff *skb)
@@ -73,7 +65,7 @@
 	skb->ip_summed = CHECKSUM_NONE;
 
 	NF_HOOK(PF_BRIDGE, NF_BR_FORWARD, skb, indev, skb->dev,
-			br_forward_finish);
+	        br_forward_finish);
 }
 
 /* called with rcu_read_lock */
diff -Nru a/net/bridge/br_if.c b/net/bridge/br_if.c
--- a/net/bridge/br_if.c	2005-01-28 15:20:03 -08:00
+++ b/net/bridge/br_if.c	2005-01-28 15:20:03 -08:00
@@ -165,7 +165,6 @@
 	br->topology_change = 0;
 	br->topology_change_detected = 0;
 	br->ageing_time = 300 * HZ;
-	INIT_LIST_HEAD(&br->age_list);
 
 	br_stp_timer_init(br);
 
@@ -258,6 +257,7 @@
 
 	if (ret) 
 		unregister_netdev(dev);
+
  out:
 	return ret;
 
@@ -332,7 +332,7 @@
 	if (IS_ERR(p = new_nbp(br, dev, br_initial_port_cost(dev))))
 		return PTR_ERR(p);
 
- 	if ((err = br_fdb_insert(br, p, dev->dev_addr, 1)))
+ 	if ((err = br_fdb_insert(br, p, dev->dev_addr)))
 		destroy_nbp(p);
  
 	else if ((err = br_sysfs_addif(p)))
@@ -347,6 +347,9 @@
 		if ((br->dev->flags & IFF_UP) 
 		    && (dev->flags & IFF_UP) && netif_carrier_ok(dev))
 			br_stp_enable_port(p);
+		
+		mod_timer(&br->gc_timer, jiffies + HZ/10);
+	
 		spin_unlock_bh(&br->lock);
 
 		dev_set_mtu(br->dev, br_min_mtu(br));
diff -Nru a/net/bridge/br_input.c b/net/bridge/br_input.c
--- a/net/bridge/br_input.c	2005-01-28 15:20:03 -08:00
+++ b/net/bridge/br_input.c	2005-01-28 15:20:03 -08:00
@@ -101,16 +101,17 @@
 {
 	struct sk_buff *skb = *pskb;
 	const unsigned char *dest = eth_hdr(skb)->h_dest;
+	const unsigned char *src = eth_hdr(skb)->h_source;
 
 	if (p->state == BR_STATE_DISABLED)
 		goto err;
 
-	if (eth_hdr(skb)->h_source[0] & 1)
+	if (!is_valid_ether_addr(src))
 		goto err;
 
 	if (p->state == BR_STATE_LEARNING ||
 	    p->state == BR_STATE_FORWARDING)
-		br_fdb_insert(p->br, p, eth_hdr(skb)->h_source, 0);
+		br_fdb_update(p->br, p, src);
 
 	if (p->br->stp_enabled &&
 	    !memcmp(dest, bridge_ula, 5) &&
diff -Nru a/net/bridge/br_private.h b/net/bridge/br_private.h
--- a/net/bridge/br_private.h	2005-01-28 15:20:03 -08:00
+++ b/net/bridge/br_private.h	2005-01-28 15:20:03 -08:00
@@ -16,10 +16,9 @@
 #define _BR_PRIVATE_H
 
 #include <linux/netdevice.h>
-#include <linux/miscdevice.h>
 #include <linux/if_bridge.h>
 
-#define BR_HASH_BITS 8
+#define BR_HASH_BITS 10
 #define BR_HASH_SIZE (1 << BR_HASH_BITS)
 
 #define BR_HOLD_TIME (1*HZ)
@@ -46,15 +45,12 @@
 {
 	struct hlist_node		hlist;
 	struct net_bridge_port		*dst;
-	union {
-		struct list_head	age_list;
-		struct rcu_head		rcu;
-	} u;
 	atomic_t			use_count;
 	unsigned long			ageing_timer;
 	mac_addr			addr;
 	unsigned char			is_local;
 	unsigned char			is_static;
+	struct rcu_head			rcu;
 };
 
 struct net_bridge_port
@@ -91,7 +87,6 @@
 	struct net_device_stats		statistics;
 	spinlock_t			hash_lock;
 	struct hlist_head		hash[BR_HASH_SIZE];
-	struct list_head		age_list;
 
 	/* STP */
 	bridge_id			designated_root;
@@ -148,8 +143,10 @@
 			  unsigned long count, unsigned long off);
 extern int br_fdb_insert(struct net_bridge *br,
 			 struct net_bridge_port *source,
-			 const unsigned char *addr,
-			 int is_local);
+			 const unsigned char *addr);
+extern void br_fdb_update(struct net_bridge *br,
+			  struct net_bridge_port *source,
+			  const unsigned char *addr);
 
 /* br_forward.c */
 extern void br_deliver(const struct net_bridge_port *to,
