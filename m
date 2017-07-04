Return-Path: <elena.reshetova@intel.com>
From: Elena Reshetova <elena.reshetova@intel.com>
Date: Tue,  4 Jul 2017 15:53:10 +0300
Message-Id: <1499172811-16271-16-git-send-email-elena.reshetova@intel.com>
In-Reply-To: <1499172811-16271-1-git-send-email-elena.reshetova@intel.com>
References: <1499172811-16271-1-git-send-email-elena.reshetova@intel.com>
Subject: [Bridge] [PATCH 15/36] net,
	ipx: convert ipx_route.refcnt from atomic_t to refcount_t
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: peterz@infradead.org, jchapman@katalix.com, bfields@fieldses.org, linux-sctp@vger.kernel.org, jlayton@poochiereds.net, Elena Reshetova <elena.reshetova@intel.com>, steffen.klassert@secunet.com, zyan@redhat.com, herbert@gondor.apana.org.au, linux-x25@vger.kernel.org, linux-rdma@vger.kernel.org, bridge@lists.linux-foundation.org, jmorris@namei.org, 3chas3@gmail.com, kuznet@ms2.inr.ac.ru, jreuter@yaina.de, keescook@chromium.org, santosh.shilimkar@oracle.com, jhs@mojatatu.com, Hans Liljestrand <ishkamiel@gmail.com>, linux-hams@vger.kernel.org, David Windsor <dwindsor@gmail.com>, linux-nfs@vger.kernel.org, sage@redhat.com, nhorman@tuxdriver.com, yoshfuji@linux-ipv6.org, vyasevich@gmail.com, linux-decnet-user@lists.sourceforge.net, linux-kernel@vger.kernel.org, ralf@linux-mips.org, kaber@trash.net, davem@davemloft.net

refcount_t type and corresponding API should be
used instead of atomic_t when the variable is used as
a reference counter. This allows to avoid accidental
refcounter overflows that might lead to use-after-free
situations.

Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
Signed-off-by: Hans Liljestrand <ishkamiel@gmail.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: David Windsor <dwindsor@gmail.com>
---
 include/net/ipx.h   | 6 +++---
 net/ipx/ipx_route.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/net/ipx.h b/include/net/ipx.h
index 2de1281..af32b97 100644
--- a/include/net/ipx.h
+++ b/include/net/ipx.h
@@ -81,7 +81,7 @@ struct ipx_route {
 	unsigned char		ir_routed;
 	unsigned char		ir_router_node[IPX_NODE_LEN];
 	struct list_head	node; /* node in ipx_routes list */
-	atomic_t		refcnt;
+	refcount_t		refcnt;
 };
 
 struct ipx_cb {
@@ -164,12 +164,12 @@ static __inline__ void ipxitf_put(struct ipx_interface *intrfc)
 
 static __inline__ void ipxrtr_hold(struct ipx_route *rt)
 {
-	        atomic_inc(&rt->refcnt);
+	        refcount_inc(&rt->refcnt);
 }
 
 static __inline__ void ipxrtr_put(struct ipx_route *rt)
 {
-	        if (atomic_dec_and_test(&rt->refcnt))
+	        if (refcount_dec_and_test(&rt->refcnt))
 			                kfree(rt);
 }
 #endif /* _NET_INET_IPX_H_ */
diff --git a/net/ipx/ipx_route.c b/net/ipx/ipx_route.c
index 3e2a32a..b5d9144 100644
--- a/net/ipx/ipx_route.c
+++ b/net/ipx/ipx_route.c
@@ -59,7 +59,7 @@ int ipxrtr_add_route(__be32 network, struct ipx_interface *intrfc,
 		if (!rt)
 			goto out;
 
-		atomic_set(&rt->refcnt, 1);
+		refcount_set(&rt->refcnt, 1);
 		ipxrtr_hold(rt);
 		write_lock_bh(&ipx_routes_lock);
 		list_add(&rt->node, &ipx_routes);
-- 
2.7.4

