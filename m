Return-Path: <elena.reshetova@intel.com>
From: Elena Reshetova <elena.reshetova@intel.com>
Date: Tue,  4 Jul 2017 15:53:31 +0300
Message-Id: <1499172811-16271-37-git-send-email-elena.reshetova@intel.com>
In-Reply-To: <1499172811-16271-1-git-send-email-elena.reshetova@intel.com>
References: <1499172811-16271-1-git-send-email-elena.reshetova@intel.com>
Subject: [Bridge] [PATCH 36/36] net,
	ax25: convert ax25_cb.refcount from atomic_t to refcount_t
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
 include/net/ax25.h | 6 +++---
 net/ax25/af_ax25.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/net/ax25.h b/include/net/ax25.h
index e3467ba..c4a0cf6 100644
--- a/include/net/ax25.h
+++ b/include/net/ax25.h
@@ -244,7 +244,7 @@ typedef struct ax25_cb {
 	unsigned char		window;
 	struct timer_list	timer, dtimer;
 	struct sock		*sk;		/* Backlink to socket */
-	atomic_t		refcount;
+	refcount_t		refcount;
 } ax25_cb;
 
 struct ax25_sock {
@@ -266,11 +266,11 @@ static inline struct ax25_cb *sk_to_ax25(const struct sock *sk)
 	hlist_for_each_entry(__ax25, list, ax25_node)
 
 #define ax25_cb_hold(__ax25) \
-	atomic_inc(&((__ax25)->refcount))
+	refcount_inc(&((__ax25)->refcount))
 
 static __inline__ void ax25_cb_put(ax25_cb *ax25)
 {
-	if (atomic_dec_and_test(&ax25->refcount)) {
+	if (refcount_dec_and_test(&ax25->refcount)) {
 		kfree(ax25->digipeat);
 		kfree(ax25);
 	}
diff --git a/net/ax25/af_ax25.c b/net/ax25/af_ax25.c
index 0c92ba0..f3f9d18 100644
--- a/net/ax25/af_ax25.c
+++ b/net/ax25/af_ax25.c
@@ -510,7 +510,7 @@ ax25_cb *ax25_create_cb(void)
 	if ((ax25 = kzalloc(sizeof(*ax25), GFP_ATOMIC)) == NULL)
 		return NULL;
 
-	atomic_set(&ax25->refcount, 1);
+	refcount_set(&ax25->refcount, 1);
 
 	skb_queue_head_init(&ax25->write_queue);
 	skb_queue_head_init(&ax25->frag_queue);
-- 
2.7.4

