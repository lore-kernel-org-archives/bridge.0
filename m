Date: Sat, 7 Apr 2007 18:57:07 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
Message-ID: <20070407095707.GC4660@APFDCB5C>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Bridge] [PATCH] bridge: check kmem_cache_create() error
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

This patch checks kmem_cache_create() error and aborts loading module
on failure.

Cc: Stephen Hemminger <shemminger@linux-foundation.org>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

---
 net/bridge/br.c         |    7 ++++++-
 net/bridge/br_fdb.c     |    4 +++-
 net/bridge/br_private.h |    2 +-
 3 files changed, 10 insertions(+), 3 deletions(-)

Index: 2.6-mm/net/bridge/br.c
===================================================================
--- 2.6-mm.orig/net/bridge/br.c
+++ 2.6-mm/net/bridge/br.c
@@ -37,7 +37,9 @@ static int __init br_init(void)
 		return -EADDRINUSE;
 	}
 
-	br_fdb_init();
+	err = br_fdb_init();
+	if (err)
+		goto err_out0;
 
 	err = br_netfilter_init();
 	if (err)
@@ -63,7 +65,10 @@ err_out3:
 err_out2:
 	br_netfilter_fini();
 err_out1:
+	br_fdb_fini();
+err_out0:
 	llc_sap_put(br_stp_sap);
+
 	return err;
 }
 
Index: 2.6-mm/net/bridge/br_fdb.c
===================================================================
--- 2.6-mm.orig/net/bridge/br_fdb.c
+++ 2.6-mm/net/bridge/br_fdb.c
@@ -27,12 +27,14 @@ static struct kmem_cache *br_fdb_cache _
 static int fdb_insert(struct net_bridge *br, struct net_bridge_port *source,
 		      const unsigned char *addr);
 
-void __init br_fdb_init(void)
+int __init br_fdb_init(void)
 {
 	br_fdb_cache = kmem_cache_create("bridge_fdb_cache",
 					 sizeof(struct net_bridge_fdb_entry),
 					 0,
 					 SLAB_HWCACHE_ALIGN, NULL, NULL);
+
+	return br_fdb_cache ? 0 : -ENOMEM;
 }
 
 void __exit br_fdb_fini(void)
Index: 2.6-mm/net/bridge/br_private.h
===================================================================
--- 2.6-mm.orig/net/bridge/br_private.h
+++ 2.6-mm/net/bridge/br_private.h
@@ -133,7 +133,7 @@ extern void br_dev_setup(struct net_devi
 extern int br_dev_xmit(struct sk_buff *skb, struct net_device *dev);
 
 /* br_fdb.c */
-extern void br_fdb_init(void);
+extern int br_fdb_init(void);
 extern void br_fdb_fini(void);
 extern void br_fdb_changeaddr(struct net_bridge_port *p,
 			      const unsigned char *newaddr);
