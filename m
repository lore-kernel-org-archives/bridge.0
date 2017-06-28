Return-Path: <elena.reshetova@intel.com>
From: Elena Reshetova <elena.reshetova@intel.com>
Date: Wed, 28 Jun 2017 14:55:01 +0300
Message-Id: <1498650906-12907-13-git-send-email-elena.reshetova@intel.com>
In-Reply-To: <1498650906-12907-1-git-send-email-elena.reshetova@intel.com>
References: <1498650906-12907-1-git-send-email-elena.reshetova@intel.com>
Subject: [Bridge] [PATCH 12/17] net: convert unix_address.refcnt from
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
 include/net/af_unix.h | 3 ++-
 net/unix/af_unix.c    | 8 ++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index fd60ecc..3a385e4 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -4,6 +4,7 @@
 #include <linux/socket.h>
 #include <linux/un.h>
 #include <linux/mutex.h>
+#include <linux/refcount.h>
 #include <net/sock.h>
 
 void unix_inflight(struct user_struct *user, struct file *fp);
@@ -21,7 +22,7 @@ extern spinlock_t unix_table_lock;
 extern struct hlist_head unix_socket_table[2 * UNIX_HASH_SIZE];
 
 struct unix_address {
-	atomic_t	refcnt;
+	refcount_t	refcnt;
 	int		len;
 	unsigned int	hash;
 	struct sockaddr_un name[0];
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index c885254..b9ee766 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -212,7 +212,7 @@ EXPORT_SYMBOL_GPL(unix_peer_get);
 
 static inline void unix_release_addr(struct unix_address *addr)
 {
-	if (atomic_dec_and_test(&addr->refcnt))
+	if (refcount_dec_and_test(&addr->refcnt))
 		kfree(addr);
 }
 
@@ -864,7 +864,7 @@ static int unix_autobind(struct socket *sock)
 		goto out;
 
 	addr->name->sun_family = AF_UNIX;
-	atomic_set(&addr->refcnt, 1);
+	refcount_set(&addr->refcnt, 1);
 
 retry:
 	addr->len = sprintf(addr->name->sun_path+1, "%05x", ordernum) + 1 + sizeof(short);
@@ -1040,7 +1040,7 @@ static int unix_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
 	memcpy(addr->name, sunaddr, addr_len);
 	addr->len = addr_len;
 	addr->hash = hash ^ sk->sk_type;
-	atomic_set(&addr->refcnt, 1);
+	refcount_set(&addr->refcnt, 1);
 
 	if (sun_path[0]) {
 		addr->hash = UNIX_HASH_SIZE;
@@ -1335,7 +1335,7 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 
 	/* copy address information from listening to new sock*/
 	if (otheru->addr) {
-		atomic_inc(&otheru->addr->refcnt);
+		refcount_inc(&otheru->addr->refcnt);
 		newu->addr = otheru->addr;
 	}
 	if (otheru->path.dentry) {
-- 
2.7.4

