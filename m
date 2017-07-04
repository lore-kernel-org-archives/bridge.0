Return-Path: <elena.reshetova@intel.com>
From: Elena Reshetova <elena.reshetova@intel.com>
Date: Tue,  4 Jul 2017 15:53:24 +0300
Message-Id: <1499172811-16271-30-git-send-email-elena.reshetova@intel.com>
In-Reply-To: <1499172811-16271-1-git-send-email-elena.reshetova@intel.com>
References: <1499172811-16271-1-git-send-email-elena.reshetova@intel.com>
Subject: [Bridge] [PATCH 29/36] net,
	sctp: convert sctp_auth_bytes.refcnt from atomic_t to refcount_t
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
 include/net/sctp/auth.h | 5 +++--
 net/sctp/auth.c         | 4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/net/sctp/auth.h b/include/net/sctp/auth.h
index 171244b..e5c57d0 100644
--- a/include/net/sctp/auth.h
+++ b/include/net/sctp/auth.h
@@ -31,6 +31,7 @@
 #define __sctp_auth_h__
 
 #include <linux/list.h>
+#include <linux/refcount.h>
 
 struct sctp_endpoint;
 struct sctp_association;
@@ -53,7 +54,7 @@ struct sctp_hmac {
  * over SCTP-AUTH
  */
 struct sctp_auth_bytes {
-	atomic_t refcnt;
+	refcount_t refcnt;
 	__u32 len;
 	__u8  data[];
 };
@@ -76,7 +77,7 @@ static inline void sctp_auth_key_hold(struct sctp_auth_bytes *key)
 	if (!key)
 		return;
 
-	atomic_inc(&key->refcnt);
+	refcount_inc(&key->refcnt);
 }
 
 void sctp_auth_key_put(struct sctp_auth_bytes *key);
diff --git a/net/sctp/auth.c b/net/sctp/auth.c
index 8ffa598..e001b01 100644
--- a/net/sctp/auth.c
+++ b/net/sctp/auth.c
@@ -63,7 +63,7 @@ void sctp_auth_key_put(struct sctp_auth_bytes *key)
 	if (!key)
 		return;
 
-	if (atomic_dec_and_test(&key->refcnt)) {
+	if (refcount_dec_and_test(&key->refcnt)) {
 		kzfree(key);
 		SCTP_DBG_OBJCNT_DEC(keys);
 	}
@@ -84,7 +84,7 @@ static struct sctp_auth_bytes *sctp_auth_create_key(__u32 key_len, gfp_t gfp)
 		return NULL;
 
 	key->len = key_len;
-	atomic_set(&key->refcnt, 1);
+	refcount_set(&key->refcnt, 1);
 	SCTP_DBG_OBJCNT_INC(keys);
 
 	return key;
-- 
2.7.4

