Return-Path: <elena.reshetova@intel.com>
From: Elena Reshetova <elena.reshetova@intel.com>
Date: Tue,  4 Jul 2017 15:53:20 +0300
Message-Id: <1499172811-16271-26-git-send-email-elena.reshetova@intel.com>
In-Reply-To: <1499172811-16271-1-git-send-email-elena.reshetova@intel.com>
References: <1499172811-16271-1-git-send-email-elena.reshetova@intel.com>
Subject: [Bridge] [PATCH 25/36] net,
	x25: convert x25_neigh.refcnt from atomic_t to refcount_t
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
 include/net/x25.h  | 6 +++---
 net/x25/x25_link.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/net/x25.h b/include/net/x25.h
index 1ac1400..2609b57 100644
--- a/include/net/x25.h
+++ b/include/net/x25.h
@@ -142,7 +142,7 @@ struct x25_neigh {
 	unsigned long		t20;
 	struct timer_list	t20timer;
 	unsigned long		global_facil_mask;
-	atomic_t		refcnt;
+	refcount_t		refcnt;
 };
 
 struct x25_sock {
@@ -243,12 +243,12 @@ void x25_link_free(void);
 /* x25_neigh.c */
 static __inline__ void x25_neigh_hold(struct x25_neigh *nb)
 {
-	atomic_inc(&nb->refcnt);
+	refcount_inc(&nb->refcnt);
 }
 
 static __inline__ void x25_neigh_put(struct x25_neigh *nb)
 {
-	if (atomic_dec_and_test(&nb->refcnt))
+	if (refcount_dec_and_test(&nb->refcnt))
 		kfree(nb);
 }
 
diff --git a/net/x25/x25_link.c b/net/x25/x25_link.c
index bcaa180..e0cd04d 100644
--- a/net/x25/x25_link.c
+++ b/net/x25/x25_link.c
@@ -266,7 +266,7 @@ void x25_link_device_up(struct net_device *dev)
 				       X25_MASK_PACKET_SIZE |
 				       X25_MASK_WINDOW_SIZE;
 	nb->t20      = sysctl_x25_restart_request_timeout;
-	atomic_set(&nb->refcnt, 1);
+	refcount_set(&nb->refcnt, 1);
 
 	write_lock_bh(&x25_neigh_list_lock);
 	list_add(&nb->node, &x25_neigh_list);
-- 
2.7.4

