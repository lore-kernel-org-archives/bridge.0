DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:received:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:content-disposition;
	bh=44DGwFTcj2H6AvoUUQnvPvAC78RosqxQYVdMGfLZF/Y=;
	b=dIjRKPUKEyKh35YChaiisoIgsVFTE+cffK4ukJWt4wMmwvLvAPK7TJH2Nrwea40gY6h7c318Ooglo7eORfS9PcopRy/HyT7E1y/tex0pILecQ6+B2AuM9/Ycgvh/7hKhQsc4LDNZlSgICer2v+SglpKc5ddShk7YC6pfecMXpwA=
Message-ID: <47678D42.9020004@localhost>
Date: Tue, 18 Dec 2007 10:05:06 +0100
From: Jaime Medrano <jaime.medrano@gmail.com>
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH] Add vlan id to bridge forward database
References: <4766a3d1.02ab100a.0be8.6fdc@mx.google.com>
	<20071217085349.729e5c17@deepthought>
In-Reply-To: <20071217085349.729e5c17@deepthought>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline; filename=vlan.diff
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

Stephen Hemminger wrote:
>=20
> What about the nested vlan case?
>=20

Below is a new patch that handles the double-tagging case. I'm not sure=20
if it is worth a more generic case. =BFAre triple-tagging and so really use=
d?

> This is a user/kernel ABI change. Does it break old tools?

New patch gets rid of the unused field but it still doesn't break old tools.

Anyway, the user part is not really needed. I just think it could be useful.

Regards,
Jaime.

---
Subject: [PATCH] Add vlan id to bridge forward database

This makes forwarding table aware of 802.1Q vlan ids and stores
id with MACs in the table. Up to two vlan tags are handled.

It solves problems when having same MAC on diffent pairs
(vlan, port). Current code gets confused at that situation.

Local MACs are managed as present on every vlan.

Signed-off-by: Jaime Medrano <jaime.medrano@gmail.com>
---
 include/linux/if_bridge.h |    3 ++-
 net/atm/lec.c             |    2 +-
 net/bridge/br_device.c    |   23 +++++++++++++++++++----
 net/bridge/br_fdb.c       |   42 ++++++++++++++++++++++++++++++------------
 net/bridge/br_input.c     |   31 +++++++++++++++++++++++++++----
 net/bridge/br_private.h   |   18 ++++++++++++++----
 6 files changed, 93 insertions(+), 26 deletions(-)

Index: linux-2.6.23/net/bridge/br_private.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.23.orig/net/bridge/br_private.h	2007-12-18 09:42:45.000000000=
 +0100
+++ linux-2.6.23/net/bridge/br_private.h	2007-12-18 09:43:37.000000000 +0100
@@ -55,6 +55,8 @@
 	atomic_t			use_count;
 	unsigned long			ageing_timer;
 	mac_addr			addr;
+	unsigned short			vlan_first_id;
+	unsigned short			vlan_second_id;
 	unsigned char			is_local;
 	unsigned char			is_static;
 };
@@ -150,9 +152,13 @@
 extern void br_fdb_delete_by_port(struct net_bridge *br,
 				  const struct net_bridge_port *p, int do_all);
 extern struct net_bridge_fdb_entry *__br_fdb_get(struct net_bridge *br,
-						 const unsigned char *addr);
+						 const unsigned char *addr,
+					         unsigned short vlan_first_id,
+					         unsigned short vlan_second_id);
 extern struct net_bridge_fdb_entry *br_fdb_get(struct net_bridge *br,
-					       unsigned char *addr);
+					       unsigned char *addr,
+					       unsigned short vlan_first_id,
+					       unsigned short vlan_second_id);
 extern void br_fdb_put(struct net_bridge_fdb_entry *ent);
 extern int br_fdb_fillbuf(struct net_bridge *br, void *buf,
 			  unsigned long count, unsigned long off);
@@ -161,7 +167,9 @@
 			 const unsigned char *addr);
 extern void br_fdb_update(struct net_bridge *br,
 			  struct net_bridge_port *source,
-			  const unsigned char *addr);
+			  const unsigned char *addr,
+			  unsigned short vlan_first_id,
+			  unsigned short vlan_second_id);
=20
 /* br_forward.c */
 extern void br_deliver(const struct net_bridge_port *to,
@@ -237,7 +245,9 @@
=20
 /* br.c */
 extern struct net_bridge_fdb_entry *(*br_fdb_get_hook)(struct net_bridge *=
br,
-						       unsigned char *addr);
+						       unsigned char *addr,
+						       unsigned short vlan_first_id,
+						       unsigned short vlan_second_id);
 extern void (*br_fdb_put_hook)(struct net_bridge_fdb_entry *ent);
=20
=20
Index: linux-2.6.23/net/bridge/br_device.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.23.orig/net/bridge/br_device.c	2007-12-18 09:42:45.000000000 =
+0100
+++ linux-2.6.23/net/bridge/br_device.c	2007-12-18 09:43:37.000000000 +0100
@@ -17,6 +17,7 @@
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
 #include <linux/ethtool.h>
+#include <linux/if_vlan.h>
=20
 #include <asm/uaccess.h>
 #include "br_private.h"
@@ -42,10 +43,24 @@
=20
 	if (dest[0] & 1)
 		br_flood_deliver(br, skb);
-	else if ((dst =3D __br_fdb_get(br, dest)) !=3D NULL)
-		br_deliver(dst->dst, skb);
-	else
-		br_flood_deliver(br, skb);
+	else {
+		struct vlan_ethhdr *veth =3D vlan_eth_hdr(skb);
+		unsigned short vlan_first_id =3D 0;
+		unsigned short vlan_second_id =3D 0;
+		if (veth->h_vlan_proto =3D=3D __constant_htons(ETH_P_8021Q)) {
+			vlan_first_id =3D ntohs(veth->h_vlan_TCI) & VLAN_VID_MASK;
+			if (veth->h_vlan_encapsulated_proto =3D=3D
+			    __constant_htons(ETH_P_8021Q)) {
+				struct vlan_hdr *veth2 =3D (struct vlan_hdr *) (veth+1);
+				vlan_second_id =3D ntohs(veth2->h_vlan_TCI) & VLAN_VID_MASK;
+			}
+		}
+		if ((dst =3D __br_fdb_get(br, dest, vlan_first_id,
+				vlan_second_id)) !=3D NULL)
+			br_deliver(dst->dst, skb);
+		else
+			br_flood_deliver(br, skb);
+	}
=20
 	return 0;
 }
Index: linux-2.6.23/net/bridge/br_fdb.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.23.orig/net/bridge/br_fdb.c	2007-12-18 09:42:45.000000000 +01=
00
+++ linux-2.6.23/net/bridge/br_fdb.c	2007-12-18 09:43:37.000000000 +0100
@@ -211,13 +211,17 @@
=20
 /* No locking or refcounting, assumes caller has no preempt (rcu_read_lock=
) */
 struct net_bridge_fdb_entry *__br_fdb_get(struct net_bridge *br,
-					  const unsigned char *addr)
+					  const unsigned char *addr,
+					  unsigned short vlan_first_id,
+					  unsigned short vlan_second_id)
 {
 	struct hlist_node *h;
 	struct net_bridge_fdb_entry *fdb;
=20
 	hlist_for_each_entry_rcu(fdb, h, &br->hash[br_mac_hash(addr)], hlist) {
-		if (!compare_ether_addr(fdb->addr.addr, addr)) {
+		if (!compare_ether_addr(fdb->addr.addr, addr)
+		    && (fdb->is_local || (fdb->vlan_first_id =3D=3D vlan_first_id &&
+			fdb->vlan_second_id =3D=3D vlan_second_id))) {
 			if (unlikely(has_expired(br, fdb)))
 				break;
 			return fdb;
@@ -229,12 +233,14 @@
=20
 /* Interface used by ATM hook that keeps a ref count */
 struct net_bridge_fdb_entry *br_fdb_get(struct net_bridge *br,
-					unsigned char *addr)
+					unsigned char *addr,
+					unsigned short vlan_first_id,
+					unsigned short vlan_second_id)
 {
 	struct net_bridge_fdb_entry *fdb;
=20
 	rcu_read_lock();
-	fdb =3D __br_fdb_get(br, addr);
+	fdb =3D __br_fdb_get(br, addr, vlan_first_id, vlan_second_id);
 	if (fdb && !atomic_inc_not_zero(&fdb->use_count))
 		fdb =3D NULL;
 	rcu_read_unlock();
@@ -289,6 +295,8 @@
 			fe->is_local =3D f->is_local;
 			if (!f->is_static)
 				fe->ageing_timer_value =3D jiffies_to_clock_t(jiffies - f->ageing_time=
r);
+			fe->vlan_first_id =3D f->vlan_first_id;
+			fe->vlan_second_id =3D f->vlan_second_id;
 			++fe;
 			++num;
 		}
@@ -301,13 +309,17 @@
 }
=20
 static inline struct net_bridge_fdb_entry *fdb_find(struct hlist_head *hea=
d,
-						    const unsigned char *addr)
+						    const unsigned char *addr,
+						    unsigned short vlan_first_id,
+						    unsigned short vlan_second_id)
 {
 	struct hlist_node *h;
 	struct net_bridge_fdb_entry *fdb;
=20
 	hlist_for_each_entry_rcu(fdb, h, head, hlist) {
-		if (!compare_ether_addr(fdb->addr.addr, addr))
+		if (!compare_ether_addr(fdb->addr.addr, addr)
+		    && (fdb->is_local || (fdb->vlan_first_id =3D=3D vlan_first_id
+			&& fdb->vlan_second_id =3D=3D vlan_second_id)))
 			return fdb;
 	}
 	return NULL;
@@ -316,6 +328,8 @@
 static struct net_bridge_fdb_entry *fdb_create(struct hlist_head *head,
 					       struct net_bridge_port *source,
 					       const unsigned char *addr,
+					       unsigned short vlan_first_id,
+					       unsigned short vlan_second_id,
 					       int is_local)
 {
 	struct net_bridge_fdb_entry *fdb;
@@ -323,6 +337,8 @@
 	fdb =3D kmem_cache_alloc(br_fdb_cache, GFP_ATOMIC);
 	if (fdb) {
 		memcpy(fdb->addr.addr, addr, ETH_ALEN);
+		fdb->vlan_first_id =3D vlan_first_id;
+		fdb->vlan_second_id =3D vlan_second_id;
 		atomic_set(&fdb->use_count, 1);
 		hlist_add_head_rcu(&fdb->hlist, head);
=20
@@ -343,7 +359,7 @@
 	if (!is_valid_ether_addr(addr))
 		return -EINVAL;
=20
-	fdb =3D fdb_find(head, addr);
+	fdb =3D fdb_find(head, addr, 0, 0);
 	if (fdb) {
 		/* it is okay to have multiple ports with same
 		 * address, just use the first one.
@@ -357,7 +373,7 @@
 		fdb_delete(fdb);
 	}
=20
-	if (!fdb_create(head, source, addr, 1))
+	if (!fdb_create(head, source, addr, 0, 0, 1))
 		return -ENOMEM;
=20
 	return 0;
@@ -375,7 +391,8 @@
 }
=20
 void br_fdb_update(struct net_bridge *br, struct net_bridge_port *source,
-		   const unsigned char *addr)
+		   const unsigned char *addr, unsigned short vlan_first_id,
+		   unsigned short vlan_second_id)
 {
 	struct hlist_head *head =3D &br->hash[br_mac_hash(addr)];
 	struct net_bridge_fdb_entry *fdb;
@@ -389,7 +406,7 @@
 	      source->state =3D=3D BR_STATE_FORWARDING))
 		return;
=20
-	fdb =3D fdb_find(head, addr);
+	fdb =3D fdb_find(head, addr, vlan_first_id, vlan_second_id);
 	if (likely(fdb)) {
 		/* attempt to update an entry for a local interface */
 		if (unlikely(fdb->is_local)) {
@@ -404,8 +421,9 @@
 		}
 	} else {
 		spin_lock(&br->hash_lock);
-		if (!fdb_find(head, addr))
-			fdb_create(head, source, addr, 0);
+		if (!fdb_find(head, addr, vlan_first_id, vlan_second_id))
+			fdb_create(head, source, addr, vlan_first_id,
+				   vlan_second_id, 0);
 		/* else  we lose race and someone else inserts
 		 * it first, don't bother updating
 		 */
Index: linux-2.6.23/net/bridge/br_input.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.23.orig/net/bridge/br_input.c	2007-12-18 09:42:45.000000000 +=
0100
+++ linux-2.6.23/net/bridge/br_input.c	2007-12-18 09:43:37.000000000 +0100
@@ -17,6 +17,7 @@
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
 #include <linux/netfilter_bridge.h>
+#include <linux/if_vlan.h>
 #include "br_private.h"
=20
 /* Bridge group multicast address 802.1d (pg 51). */
@@ -44,13 +45,24 @@
 	struct net_bridge *br;
 	struct net_bridge_fdb_entry *dst;
 	struct sk_buff *skb2;
+	struct vlan_ethhdr *veth =3D vlan_eth_hdr(skb);
+	unsigned short vlan_first_id =3D 0;
+	unsigned short vlan_second_id =3D 0;
=20
 	if (!p || p->state =3D=3D BR_STATE_DISABLED)
 		goto drop;
=20
 	/* insert into forwarding database after filtering to avoid spoofing */
+	if (veth->h_vlan_proto =3D=3D __constant_htons(ETH_P_8021Q)) {
+		vlan_first_id =3D ntohs(veth->h_vlan_TCI) & VLAN_VID_MASK;
+		if (veth->h_vlan_encapsulated_proto =3D=3D
+				__constant_htons(ETH_P_8021Q)) {
+			struct vlan_hdr *veth2 =3D (struct vlan_hdr *) (veth+1);
+			vlan_second_id =3D ntohs(veth2->h_vlan_TCI) & VLAN_VID_MASK;
+		}
+	}
 	br =3D p->br;
-	br_fdb_update(br, p, eth_hdr(skb)->h_source);
+	br_fdb_update(br, p, eth_hdr(skb)->h_source, vlan_first_id, vlan_second_i=
d);
=20
 	if (p->state =3D=3D BR_STATE_LEARNING)
 		goto drop;
@@ -66,7 +78,7 @@
 	if (is_multicast_ether_addr(dest)) {
 		br->statistics.multicast++;
 		skb2 =3D skb;
-	} else if ((dst =3D __br_fdb_get(br, dest)) && dst->is_local) {
+	} else if ((dst =3D __br_fdb_get(br, dest, vlan_first_id, vlan_second_id)=
) && dst->is_local) {
 		skb2 =3D skb;
 		/* Do not forward the packet since it's local. */
 		skb =3D NULL;
@@ -96,9 +108,20 @@
 static int br_handle_local_finish(struct sk_buff *skb)
 {
 	struct net_bridge_port *p =3D rcu_dereference(skb->dev->br_port);
-
+	struct vlan_ethhdr *veth =3D vlan_eth_hdr(skb);
+	unsigned short vlan_first_id =3D 0;
+	unsigned short vlan_second_id =3D 0;
+
+	if (veth->h_vlan_proto =3D=3D __constant_htons(ETH_P_8021Q)) {
+		vlan_first_id =3D ntohs(veth->h_vlan_TCI) & VLAN_VID_MASK;
+		if (veth->h_vlan_encapsulated_proto =3D=3D
+				__constant_htons(ETH_P_8021Q)) {
+			struct vlan_hdr *veth2 =3D (struct vlan_hdr *) (veth+1);
+			vlan_second_id =3D ntohs(veth2->h_vlan_TCI) & VLAN_VID_MASK;
+		}
+	}
 	if (p)
-		br_fdb_update(p->br, p, eth_hdr(skb)->h_source);
+		br_fdb_update(p->br, p, eth_hdr(skb)->h_source, vlan_first_id, vlan_seco=
nd_id);
 	return 0;	 /* process further */
 }
=20
Index: linux-2.6.23/net/atm/lec.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.23.orig/net/atm/lec.c	2007-12-18 09:42:45.000000000 +0100
+++ linux-2.6.23/net/atm/lec.c	2007-12-18 09:43:37.000000000 +0100
@@ -557,7 +557,7 @@
 				break;
=20
 			f =3D br_fdb_get_hook(dev->br_port->br,
-					    mesg->content.proxy.mac_addr);
+					    mesg->content.proxy.mac_addr, 0, 0);
 			if (f !=3D NULL && f->dst->dev !=3D dev
 			    && f->dst->state =3D=3D BR_STATE_FORWARDING) {
 				/* hit from bridge table, send LE_ARP_RESPONSE */
Index: linux-2.6.23/include/linux/if_bridge.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.23.orig/include/linux/if_bridge.h	2007-12-18 09:42:45.0000000=
00 +0100
+++ linux-2.6.23/include/linux/if_bridge.h	2007-12-18 09:43:37.000000000 +0=
100
@@ -97,7 +97,8 @@
 	__u8 port_no;
 	__u8 is_local;
 	__u32 ageing_timer_value;
-	__u32 unused;
+	__u16 vlan_first_id;
+	__u16 vlan_second_id;
 };
=20
 #ifdef __KERNEL__

--=20

