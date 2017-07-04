Return-Path: <elena.reshetova@intel.com>
From: Elena Reshetova <elena.reshetova@intel.com>
Date: Tue,  4 Jul 2017 15:53:25 +0300
Message-Id: <1499172811-16271-31-git-send-email-elena.reshetova@intel.com>
In-Reply-To: <1499172811-16271-1-git-send-email-elena.reshetova@intel.com>
References: <1499172811-16271-1-git-send-email-elena.reshetova@intel.com>
Subject: [Bridge] [PATCH 30/36] net,
	sctp: convert sctp_datamsg.refcnt from atomic_t to refcount_t
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
 include/net/sctp/structs.h | 2 +-
 net/sctp/chunk.c           | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/net/sctp/structs.h b/include/net/sctp/structs.h
index 07c11fe..4d7c855 100644
--- a/include/net/sctp/structs.h
+++ b/include/net/sctp/structs.h
@@ -496,7 +496,7 @@ struct sctp_datamsg {
 	/* Chunks waiting to be submitted to lower layer. */
 	struct list_head chunks;
 	/* Reference counting. */
-	atomic_t refcnt;
+	refcount_t refcnt;
 	/* When is this message no longer interesting to the peer? */
 	unsigned long expires_at;
 	/* Did the messenge fail to send? */
diff --git a/net/sctp/chunk.c b/net/sctp/chunk.c
index 81466f6..1323d41 100644
--- a/net/sctp/chunk.c
+++ b/net/sctp/chunk.c
@@ -49,7 +49,7 @@
 /* Initialize datamsg from memory. */
 static void sctp_datamsg_init(struct sctp_datamsg *msg)
 {
-	atomic_set(&msg->refcnt, 1);
+	refcount_set(&msg->refcnt, 1);
 	msg->send_failed = 0;
 	msg->send_error = 0;
 	msg->can_delay = 1;
@@ -136,13 +136,13 @@ static void sctp_datamsg_destroy(struct sctp_datamsg *msg)
 /* Hold a reference. */
 static void sctp_datamsg_hold(struct sctp_datamsg *msg)
 {
-	atomic_inc(&msg->refcnt);
+	refcount_inc(&msg->refcnt);
 }
 
 /* Release a reference. */
 void sctp_datamsg_put(struct sctp_datamsg *msg)
 {
-	if (atomic_dec_and_test(&msg->refcnt))
+	if (refcount_dec_and_test(&msg->refcnt))
 		sctp_datamsg_destroy(msg);
 }
 
-- 
2.7.4

