Return-Path: <elena.reshetova@intel.com>
From: Elena Reshetova <elena.reshetova@intel.com>
Date: Tue,  4 Jul 2017 15:53:18 +0300
Message-Id: <1499172811-16271-24-git-send-email-elena.reshetova@intel.com>
In-Reply-To: <1499172811-16271-1-git-send-email-elena.reshetova@intel.com>
References: <1499172811-16271-1-git-send-email-elena.reshetova@intel.com>
Subject: [Bridge] [PATCH 23/36] net,
	rds: convert rds_message.m_refcount from atomic_t to refcount_t
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
 net/rds/message.c | 12 ++++++------
 net/rds/rds.h     |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/rds/message.c b/net/rds/message.c
index 49bfb51..4318cc9 100644
--- a/net/rds/message.c
+++ b/net/rds/message.c
@@ -48,8 +48,8 @@ static unsigned int	rds_exthdr_size[__RDS_EXTHDR_MAX] = {
 
 void rds_message_addref(struct rds_message *rm)
 {
-	rdsdebug("addref rm %p ref %d\n", rm, atomic_read(&rm->m_refcount));
-	atomic_inc(&rm->m_refcount);
+	rdsdebug("addref rm %p ref %d\n", rm, refcount_read(&rm->m_refcount));
+	refcount_inc(&rm->m_refcount);
 }
 EXPORT_SYMBOL_GPL(rds_message_addref);
 
@@ -83,9 +83,9 @@ static void rds_message_purge(struct rds_message *rm)
 
 void rds_message_put(struct rds_message *rm)
 {
-	rdsdebug("put rm %p ref %d\n", rm, atomic_read(&rm->m_refcount));
-	WARN(!atomic_read(&rm->m_refcount), "danger refcount zero on %p\n", rm);
-	if (atomic_dec_and_test(&rm->m_refcount)) {
+	rdsdebug("put rm %p ref %d\n", rm, refcount_read(&rm->m_refcount));
+	WARN(!refcount_read(&rm->m_refcount), "danger refcount zero on %p\n", rm);
+	if (refcount_dec_and_test(&rm->m_refcount)) {
 		BUG_ON(!list_empty(&rm->m_sock_item));
 		BUG_ON(!list_empty(&rm->m_conn_item));
 		rds_message_purge(rm);
@@ -206,7 +206,7 @@ struct rds_message *rds_message_alloc(unsigned int extra_len, gfp_t gfp)
 	rm->m_used_sgs = 0;
 	rm->m_total_sgs = extra_len / sizeof(struct scatterlist);
 
-	atomic_set(&rm->m_refcount, 1);
+	refcount_set(&rm->m_refcount, 1);
 	INIT_LIST_HEAD(&rm->m_sock_item);
 	INIT_LIST_HEAD(&rm->m_conn_item);
 	spin_lock_init(&rm->m_rs_lock);
diff --git a/net/rds/rds.h b/net/rds/rds.h
index ea72d6e..516bcc8 100644
--- a/net/rds/rds.h
+++ b/net/rds/rds.h
@@ -356,7 +356,7 @@ static inline u32 rds_rdma_cookie_offset(rds_rdma_cookie_t cookie)
 #define RDS_MSG_FLUSH		8
 
 struct rds_message {
-	atomic_t		m_refcount;
+	refcount_t		m_refcount;
 	struct list_head	m_sock_item;
 	struct list_head	m_conn_item;
 	struct rds_incoming	m_inc;
-- 
2.7.4

