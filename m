Return-Path: <elena.reshetova@intel.com>
From: Elena Reshetova <elena.reshetova@intel.com>
Date: Tue,  4 Jul 2017 15:53:29 +0300
Message-Id: <1499172811-16271-35-git-send-email-elena.reshetova@intel.com>
In-Reply-To: <1499172811-16271-1-git-send-email-elena.reshetova@intel.com>
References: <1499172811-16271-1-git-send-email-elena.reshetova@intel.com>
Subject: [Bridge] [PATCH 34/36] net,
	ax25: convert ax25_uid_assoc.refcount from atomic_t to refcount_t
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
 include/net/ax25.h  | 8 ++++----
 net/ax25/ax25_uid.c | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/net/ax25.h b/include/net/ax25.h
index e602f81..edd82f0 100644
--- a/include/net/ax25.h
+++ b/include/net/ax25.h
@@ -11,7 +11,7 @@
 #include <linux/timer.h>
 #include <linux/list.h>
 #include <linux/slab.h>
-#include <linux/atomic.h>
+#include <linux/refcount.h>
 #include <net/neighbour.h>
 #include <net/sock.h>
 
@@ -158,7 +158,7 @@ enum {
 
 typedef struct ax25_uid_assoc {
 	struct hlist_node	uid_node;
-	atomic_t		refcount;
+	refcount_t		refcount;
 	kuid_t			uid;
 	ax25_address		call;
 } ax25_uid_assoc;
@@ -167,11 +167,11 @@ typedef struct ax25_uid_assoc {
 	hlist_for_each_entry(__ax25, list, uid_node)
 
 #define ax25_uid_hold(ax25) \
-	atomic_inc(&((ax25)->refcount))
+	refcount_inc(&((ax25)->refcount))
 
 static inline void ax25_uid_put(ax25_uid_assoc *assoc)
 {
-	if (atomic_dec_and_test(&assoc->refcount)) {
+	if (refcount_dec_and_test(&assoc->refcount)) {
 		kfree(assoc);
 	}
 }
diff --git a/net/ax25/ax25_uid.c b/net/ax25/ax25_uid.c
index 0403b0d..83b035f 100644
--- a/net/ax25/ax25_uid.c
+++ b/net/ax25/ax25_uid.c
@@ -107,7 +107,7 @@ int ax25_uid_ioctl(int cmd, struct sockaddr_ax25 *sax)
 		if ((ax25_uid = kmalloc(sizeof(*ax25_uid), GFP_KERNEL)) == NULL)
 			return -ENOMEM;
 
-		atomic_set(&ax25_uid->refcount, 1);
+		refcount_set(&ax25_uid->refcount, 1);
 		ax25_uid->uid  = sax25_kuid;
 		ax25_uid->call = sax->sax25_call;
 
-- 
2.7.4

