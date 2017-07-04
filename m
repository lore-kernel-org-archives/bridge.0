Return-Path: <elena.reshetova@intel.com>
From: Elena Reshetova <elena.reshetova@intel.com>
Date: Tue,  4 Jul 2017 15:53:27 +0300
Message-Id: <1499172811-16271-33-git-send-email-elena.reshetova@intel.com>
In-Reply-To: <1499172811-16271-1-git-send-email-elena.reshetova@intel.com>
References: <1499172811-16271-1-git-send-email-elena.reshetova@intel.com>
Subject: [Bridge] [PATCH 32/36] net,
	sctp: convert sctp_transport.refcnt from atomic_t to refcount_t
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
 net/sctp/transport.c       | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/net/sctp/structs.h b/include/net/sctp/structs.h
index 0dfc5c1..6a0d372 100644
--- a/include/net/sctp/structs.h
+++ b/include/net/sctp/structs.h
@@ -735,7 +735,7 @@ struct sctp_transport {
 	struct rhlist_head node;
 
 	/* Reference counting. */
-	atomic_t refcnt;
+	refcount_t refcnt;
 		/* RTO-Pending : A flag used to track if one of the DATA
 		 *		chunks sent to this address is currently being
 		 *		used to compute a RTT. If this flag is 0,
diff --git a/net/sctp/transport.c b/net/sctp/transport.c
index 7cdd6bc..80a97c8 100644
--- a/net/sctp/transport.c
+++ b/net/sctp/transport.c
@@ -99,7 +99,7 @@ static struct sctp_transport *sctp_transport_init(struct net *net,
 	/* Initialize the 64-bit random nonce sent with heartbeat. */
 	get_random_bytes(&peer->hb_nonce, sizeof(peer->hb_nonce));
 
-	atomic_set(&peer->refcnt, 1);
+	refcount_set(&peer->refcnt, 1);
 
 	return peer;
 }
@@ -172,7 +172,7 @@ static void sctp_transport_destroy_rcu(struct rcu_head *head)
  */
 static void sctp_transport_destroy(struct sctp_transport *transport)
 {
-	if (unlikely(atomic_read(&transport->refcnt))) {
+	if (unlikely(refcount_read(&transport->refcnt))) {
 		WARN(1, "Attempt to destroy undead transport %p!\n", transport);
 		return;
 	}
@@ -311,7 +311,7 @@ void sctp_transport_route(struct sctp_transport *transport,
 /* Hold a reference to a transport.  */
 int sctp_transport_hold(struct sctp_transport *transport)
 {
-	return atomic_add_unless(&transport->refcnt, 1, 0);
+	return refcount_inc_not_zero(&transport->refcnt);
 }
 
 /* Release a reference to a transport and clean up
@@ -319,7 +319,7 @@ int sctp_transport_hold(struct sctp_transport *transport)
  */
 void sctp_transport_put(struct sctp_transport *transport)
 {
-	if (atomic_dec_and_test(&transport->refcnt))
+	if (refcount_dec_and_test(&transport->refcnt))
 		sctp_transport_destroy(transport);
 }
 
-- 
2.7.4

