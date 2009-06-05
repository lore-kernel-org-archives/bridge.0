Date: Fri, 5 Jun 2009 13:12:12 +0200
From: =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
Message-ID: <20090605111212.GA27355@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [Bridge] [PATCH 2.6.29.4] bridge: Simplify interface for ATM LANE
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

This patch changes FDB entry check for ATM LANE bridge integration.
There's no point in holding a FDB entry around SKB building.

br_fdb_get()/br_fdb_put() pair are changed into single br_fdb_test_addr()
hook that checks if the addr has FDB entry pointing to other port
to the one the request arrived on.

FDB entry refcounting is removed as it's not used for anything else.

Signed-off-by: Micha=B3 Miros=B3aw <mirq-linux@rere.qmqm.pl>

diff -urpN patched/net/atm/lec.c patched2/net/atm/lec.c
--- patched/net/atm/lec.c	2009-03-24 00:12:14.000000000 +0100
+++ patched2/net/atm/lec.c	2009-06-03 12:45:23.000000000 +0200
@@ -34,7 +34,6 @@
=20
 /* Proxy LEC knows about bridging */
 #if defined(CONFIG_BRIDGE) || defined(CONFIG_BRIDGE_MODULE)
-#include <linux/if_bridge.h>
 #include "../bridge/br_private.h"
=20
 static unsigned char bridge_ula_lec[] =3D { 0x01, 0x80, 0xc2, 0x00, 0x00 };
@@ -528,18 +527,14 @@ static int lec_atm_send(struct atm_vcc *
 	case l_should_bridge:
 #if defined(CONFIG_BRIDGE) || defined(CONFIG_BRIDGE_MODULE)
 		{
-			struct net_bridge_fdb_entry *f;
-
 			pr_debug("%s: bridge zeppelin asks about %pM\n",
 				 dev->name, mesg->content.proxy.mac_addr);
=20
-			if (br_fdb_get_hook =3D=3D NULL || dev->br_port =3D=3D NULL)
+			if (br_fdb_test_addr_hook =3D=3D NULL)
 				break;
=20
-			f =3D br_fdb_get_hook(dev->br_port->br,
-					    mesg->content.proxy.mac_addr);
-			if (f !=3D NULL && f->dst->dev !=3D dev
-			    && f->dst->state =3D=3D BR_STATE_FORWARDING) {
+			if (br_fdb_test_addr_hook(dev,
+					mesg->content.proxy.mac_addr)) {
 				/* hit from bridge table, send LE_ARP_RESPONSE */
 				struct sk_buff *skb2;
 				struct sock *sk;
@@ -550,10 +545,8 @@ static int lec_atm_send(struct atm_vcc *
 				skb2 =3D
 				    alloc_skb(sizeof(struct atmlec_msg),
 					      GFP_ATOMIC);
-				if (skb2 =3D=3D NULL) {
-					br_fdb_put_hook(f);
+				if (skb2 =3D=3D NULL)
 					break;
-				}
 				skb2->len =3D sizeof(struct atmlec_msg);
 				skb_copy_to_linear_data(skb2, mesg,
 							sizeof(*mesg));
@@ -562,8 +555,6 @@ static int lec_atm_send(struct atm_vcc *
 				skb_queue_tail(&sk->sk_receive_queue, skb2);
 				sk->sk_data_ready(sk, skb2->len);
 			}
-			if (f !=3D NULL)
-				br_fdb_put_hook(f);
 		}
 #endif /* defined(CONFIG_BRIDGE) || defined(CONFIG_BRIDGE_MODULE) */
 		break;
diff -urpN patched/net/bridge/br.c patched2/net/bridge/br.c
--- patched/net/bridge/br.c	2009-03-24 00:12:14.000000000 +0100
+++ patched2/net/bridge/br.c	2009-06-03 12:54:49.000000000 +0200
@@ -65,8 +65,9 @@ static int __init br_init(void)
 	brioctl_set(br_ioctl_deviceless_stub);
 	br_handle_frame_hook =3D br_handle_frame;
=20
-	br_fdb_get_hook =3D br_fdb_get;
-	br_fdb_put_hook =3D br_fdb_put;
+#if defined(CONFIG_ATM_LANE) || defined(CONFIG_ATM_LANE_MODULE)
+	br_fdb_test_addr_hook =3D br_fdb_test_addr;
+#endif
=20
 	return 0;
 err_out4:
@@ -95,8 +96,9 @@ static void __exit br_deinit(void)
 	synchronize_net();
=20
 	br_netfilter_fini();
-	br_fdb_get_hook =3D NULL;
-	br_fdb_put_hook =3D NULL;
+#if defined(CONFIG_ATM_LANE) || defined(CONFIG_ATM_LANE_MODULE)
+	br_fdb_test_addr_hook =3D NULL;
+#endif
=20
 	br_handle_frame_hook =3D NULL;
 	br_fdb_fini();
diff -urpN patched/net/bridge/br_fdb.c patched2/net/bridge/br_fdb.c
--- patched/net/bridge/br_fdb.c	2009-03-24 00:12:14.000000000 +0100
+++ patched2/net/bridge/br_fdb.c	2009-06-03 13:43:19.000000000 +0200
@@ -71,10 +71,17 @@ static inline int br_mac_hash(const unsi
 	return jhash_1word(key, fdb_salt) & (BR_HASH_SIZE - 1);
 }
=20
+static void fdb_rcu_free(struct rcu_head *head)
+{
+	struct net_bridge_fdb_entry *ent
+		=3D container_of(head, struct net_bridge_fdb_entry, rcu);
+	kmem_cache_free(br_fdb_cache, ent);
+}
+
 static inline void fdb_delete(struct net_bridge_fdb_entry *f)
 {
 	hlist_del_rcu(&f->hlist);
-	br_fdb_put(f);
+	call_rcu(&f->rcu, fdb_rcu_free);
 }
=20
 void br_fdb_changeaddr(struct net_bridge_port *p, const unsigned char *new=
addr)
@@ -226,33 +233,26 @@ struct net_bridge_fdb_entry *__br_fdb_ge
 	return NULL;
 }
=20
-/* Interface used by ATM hook that keeps a ref count */
-struct net_bridge_fdb_entry *br_fdb_get(struct net_bridge *br,
-					unsigned char *addr)
+#if defined(CONFIG_ATM_LANE) || defined(CONFIG_ATM_LANE_MODULE)
+/* Interface used by ATM LANE hook to test
+ * if an addr is on some other bridge port */
+int br_fdb_test_addr(struct net_device *dev, unsigned char *addr)
 {
 	struct net_bridge_fdb_entry *fdb;
+	int ret;
+
+	if (!dev->br_port)
+		return 0;
=20
 	rcu_read_lock();
-	fdb =3D __br_fdb_get(br, addr);
-	if (fdb && !atomic_inc_not_zero(&fdb->use_count))
-		fdb =3D NULL;
+	fdb =3D __br_fdb_get(dev->br_port->br, addr);
+	ret =3D fdb && fdb->dst->dev !=3D dev &&
+		fdb->dst->state =3D=3D BR_STATE_FORWARDING;
 	rcu_read_unlock();
-	return fdb;
-}
-
-static void fdb_rcu_free(struct rcu_head *head)
-{
-	struct net_bridge_fdb_entry *ent
-		=3D container_of(head, struct net_bridge_fdb_entry, rcu);
-	kmem_cache_free(br_fdb_cache, ent);
-}
=20
-/* Set entry up for deletion with RCU  */
-void br_fdb_put(struct net_bridge_fdb_entry *ent)
-{
-	if (atomic_dec_and_test(&ent->use_count))
-		call_rcu(&ent->rcu, fdb_rcu_free);
+	return ret;
 }
+#endif /* CONFIG_ATM_LANE */
=20
 /*
  * Fill buffer with forwarding table records in
@@ -326,7 +326,6 @@ static struct net_bridge_fdb_entry *fdb_
 	fdb =3D kmem_cache_alloc(br_fdb_cache, GFP_ATOMIC);
 	if (fdb) {
 		memcpy(fdb->addr.addr, addr, ETH_ALEN);
-		atomic_set(&fdb->use_count, 1);
 		hlist_add_head_rcu(&fdb->hlist, head);
=20
 		fdb->dst =3D source;
diff -urpN patched/net/bridge/br_private.h patched2/net/bridge/br_private.h
--- patched/net/bridge/br_private.h	2009-03-24 00:12:14.000000000 +0100
+++ patched2/net/bridge/br_private.h	2009-06-03 12:56:53.000000000 +0200
@@ -51,7 +51,6 @@ struct net_bridge_fdb_entry
 	struct net_bridge_port		*dst;
=20
 	struct rcu_head			rcu;
-	atomic_t			use_count;
 	unsigned long			ageing_timer;
 	mac_addr			addr;
 	unsigned char			is_local;
@@ -154,9 +153,7 @@ extern void br_fdb_delete_by_port(struct
 				  const struct net_bridge_port *p, int do_all);
 extern struct net_bridge_fdb_entry *__br_fdb_get(struct net_bridge *br,
 						 const unsigned char *addr);
-extern struct net_bridge_fdb_entry *br_fdb_get(struct net_bridge *br,
-					       unsigned char *addr);
-extern void br_fdb_put(struct net_bridge_fdb_entry *ent);
+extern int br_fdb_test_addr(struct net_device *dev, unsigned char *addr);
 extern int br_fdb_fillbuf(struct net_bridge *br, void *buf,
 			  unsigned long count, unsigned long off);
 extern int br_fdb_insert(struct net_bridge *br,
@@ -242,10 +239,9 @@ extern void br_stp_port_timer_init(struc
 extern unsigned long br_timer_value(const struct timer_list *timer);
=20
 /* br.c */
-extern struct net_bridge_fdb_entry *(*br_fdb_get_hook)(struct net_bridge *=
br,
-						       unsigned char *addr);
-extern void (*br_fdb_put_hook)(struct net_bridge_fdb_entry *ent);
-
+#if defined(CONFIG_ATM_LANE) || defined(CONFIG_ATM_LANE_MODULE)
+extern int (*br_fdb_test_addr_hook)(struct net_device *dev, unsigned char =
*addr);
+#endif
=20
 /* br_netlink.c */
 extern int br_netlink_init(void);
diff -urpN patched/net/core/dev.c patched2/net/core/dev.c
--- patched/net/core/dev.c	2009-03-24 00:12:14.000000000 +0100
+++ patched2/net/core/dev.c	2009-06-03 12:36:41.000000000 +0200
@@ -2062,11 +2062,13 @@ static inline int deliver_skb(struct sk_
 }
=20
 #if defined(CONFIG_BRIDGE) || defined (CONFIG_BRIDGE_MODULE)
-/* These hooks defined here for ATM */
-struct net_bridge;
-struct net_bridge_fdb_entry *(*br_fdb_get_hook)(struct net_bridge *br,
-						unsigned char *addr);
-void (*br_fdb_put_hook)(struct net_bridge_fdb_entry *ent) __read_mostly;
+
+#if defined(CONFIG_ATM_LANE) || defined(CONFIG_ATM_LANE_MODULE)
+/* This hook is defined here for ATM LANE */
+int (*br_fdb_test_addr_hook)(struct net_device *dev,
+			     unsigned char *addr) __read_mostly;
+EXPORT_SYMBOL(br_fdb_test_addr_hook);
+#endif
=20
 /*
  * If bridge module is loaded call bridging hook.
@@ -2074,6 +2076,8 @@ void (*br_fdb_put_hook)(struct net_bridg
  */
 struct sk_buff *(*br_handle_frame_hook)(struct net_bridge_port *p,
 					struct sk_buff *skb) __read_mostly;
+EXPORT_SYMBOL(br_handle_frame_hook);
+
 static inline struct sk_buff *handle_bridge(struct sk_buff *skb,
 					    struct packet_type **pt_prev, int *ret,
 					    struct net_device *orig_dev)
@@ -5266,12 +5270,6 @@ EXPORT_SYMBOL(net_enable_timestamp);
 EXPORT_SYMBOL(net_disable_timestamp);
 EXPORT_SYMBOL(dev_get_flags);
=20
-#if defined(CONFIG_BRIDGE) || defined(CONFIG_BRIDGE_MODULE)
-EXPORT_SYMBOL(br_handle_frame_hook);
-EXPORT_SYMBOL(br_fdb_get_hook);
-EXPORT_SYMBOL(br_fdb_put_hook);
-#endif
-
 EXPORT_SYMBOL(dev_load);
=20
 EXPORT_PER_CPU_SYMBOL(softnet_data);
