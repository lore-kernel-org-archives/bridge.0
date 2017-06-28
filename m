Return-Path: <elena.reshetova@intel.com>
From: Elena Reshetova <elena.reshetova@intel.com>
Date: Wed, 28 Jun 2017 14:55:06 +0300
Message-Id: <1498650906-12907-18-git-send-email-elena.reshetova@intel.com>
In-Reply-To: <1498650906-12907-1-git-send-email-elena.reshetova@intel.com>
References: <1498650906-12907-1-git-send-email-elena.reshetova@intel.com>
Subject: [Bridge] [PATCH 17/17] net: convert packet_fanout.sk_ref from
	atomic_t to refcount_t
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: keescook@chromium.org, peterz@infradead.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, jmorris@namei.org, Hans Liljestrand <ishkamiel@gmail.com>, kuznet@ms2.inr.ac.ru, kaber@trash.net, Elena Reshetova <elena.reshetova@intel.com>, David Windsor <dwindsor@gmail.com>

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
 net/packet/af_packet.c | 8 ++++----
 net/packet/internal.h  | 4 +++-
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 87d7867..5c78d6a 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -1742,7 +1742,7 @@ static int fanout_add(struct sock *sk, u16 id, u16 type_flags)
 		match->flags = flags;
 		INIT_LIST_HEAD(&match->list);
 		spin_lock_init(&match->lock);
-		atomic_set(&match->sk_ref, 0);
+		refcount_set(&match->sk_ref, 0);
 		fanout_init_data(match);
 		match->prot_hook.type = po->prot_hook.type;
 		match->prot_hook.dev = po->prot_hook.dev;
@@ -1756,10 +1756,10 @@ static int fanout_add(struct sock *sk, u16 id, u16 type_flags)
 	    match->prot_hook.type == po->prot_hook.type &&
 	    match->prot_hook.dev == po->prot_hook.dev) {
 		err = -ENOSPC;
-		if (atomic_read(&match->sk_ref) < PACKET_FANOUT_MAX) {
+		if (refcount_read(&match->sk_ref) < PACKET_FANOUT_MAX) {
 			__dev_remove_pack(&po->prot_hook);
 			po->fanout = match;
-			atomic_inc(&match->sk_ref);
+			refcount_set(&match->sk_ref, refcount_read(&match->sk_ref) + 1);
 			__fanout_link(sk, po);
 			err = 0;
 		}
@@ -1788,7 +1788,7 @@ static struct packet_fanout *fanout_release(struct sock *sk)
 	if (f) {
 		po->fanout = NULL;
 
-		if (atomic_dec_and_test(&f->sk_ref))
+		if (refcount_dec_and_test(&f->sk_ref))
 			list_del(&f->list);
 		else
 			f = NULL;
diff --git a/net/packet/internal.h b/net/packet/internal.h
index 9ee4631..94d1d40 100644
--- a/net/packet/internal.h
+++ b/net/packet/internal.h
@@ -1,6 +1,8 @@
 #ifndef __PACKET_INTERNAL_H__
 #define __PACKET_INTERNAL_H__
 
+#include <linux/refcount.h>
+
 struct packet_mclist {
 	struct packet_mclist	*next;
 	int			ifindex;
@@ -86,7 +88,7 @@ struct packet_fanout {
 	struct list_head	list;
 	struct sock		*arr[PACKET_FANOUT_MAX];
 	spinlock_t		lock;
-	atomic_t		sk_ref;
+	refcount_t		sk_ref;
 	struct packet_type	prot_hook ____cacheline_aligned_in_smp;
 };
 
-- 
2.7.4

