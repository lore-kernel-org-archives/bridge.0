Return-Path: <elena.reshetova@intel.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=intel.com; i=@intel.com; q=dns/txt; s=intel;
	t=1489749252; x=1521285252;
	h=from:to:cc:subject:date:message-id:in-reply-to: references;
	bh=9zOIsBr+x29Tua9m8V8BUe4sjsygeCgLqhEX5+BZutE=;
	b=eVIxij7CKB07mE+iQiRdTngamhZQcwgbfbl4JmrOjclkiKGH0H+aXSzd
	kmC8KxBf8AXRgFDAoEysf9BAXIhymg==;
From: Elena Reshetova <elena.reshetova@intel.com>
Date: Fri, 17 Mar 2017 13:12:50 +0200
Message-Id: <1489749179-12063-10-git-send-email-elena.reshetova@intel.com>
In-Reply-To: <1489749179-12063-1-git-send-email-elena.reshetova@intel.com>
References: <1489749179-12063-1-git-send-email-elena.reshetova@intel.com>
Subject: [Bridge] [PATCH 09/18] net,
	atm: convert in_cache_entry.use from atomic_t to refcount_t
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: peterz@infradead.org, jchapman@katalix.com, Elena Reshetova <elena.reshetova@intel.com>, johan.hedberg@gmail.com, linux-x25@vger.kernel.org, bridge@lists.linux-foundation.org, jmorris@namei.org, 3chas3@gmail.com, Hans Liljestrand <ishkamiel@gmail.com>, keescook@chromium.org, marcel@holtmann.org, jhs@mojatatu.com, kuznet@ms2.inr.ac.ru, linux-hams@vger.kernel.org, David Windsor <dwindsor@gmail.com>, yoshfuji@linux-ipv6.org, linux-decnet-user@lists.sourceforge.net, linux-kernel@vger.kernel.org, ralf@linux-mips.org, kaber@trash.net, linux-bluetooth@vger.kernel.org, davem@davemloft.net

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
 net/atm/mpoa_caches.c | 12 ++++++------
 net/atm/mpoa_caches.h |  3 ++-
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/net/atm/mpoa_caches.c b/net/atm/mpoa_caches.c
index a89fdeb..05e89e9 100644
--- a/net/atm/mpoa_caches.c
+++ b/net/atm/mpoa_caches.c
@@ -40,7 +40,7 @@ static in_cache_entry *in_cache_get(__be32 dst_ip,
 	entry = client->in_cache;
 	while (entry != NULL) {
 		if (entry->ctrl_info.in_dst_ip == dst_ip) {
-			atomic_inc(&entry->use);
+			refcount_inc(&entry->use);
 			read_unlock_bh(&client->ingress_lock);
 			return entry;
 		}
@@ -61,7 +61,7 @@ static in_cache_entry *in_cache_get_with_mask(__be32 dst_ip,
 	entry = client->in_cache;
 	while (entry != NULL) {
 		if ((entry->ctrl_info.in_dst_ip & mask) == (dst_ip & mask)) {
-			atomic_inc(&entry->use);
+			refcount_inc(&entry->use);
 			read_unlock_bh(&client->ingress_lock);
 			return entry;
 		}
@@ -82,7 +82,7 @@ static in_cache_entry *in_cache_get_by_vcc(struct atm_vcc *vcc,
 	entry = client->in_cache;
 	while (entry != NULL) {
 		if (entry->shortcut == vcc) {
-			atomic_inc(&entry->use);
+			refcount_inc(&entry->use);
 			read_unlock_bh(&client->ingress_lock);
 			return entry;
 		}
@@ -105,7 +105,7 @@ static in_cache_entry *in_cache_add_entry(__be32 dst_ip,
 
 	dprintk("adding an ingress entry, ip = %pI4\n", &dst_ip);
 
-	atomic_set(&entry->use, 1);
+	refcount_set(&entry->use, 1);
 	dprintk("new_in_cache_entry: about to lock\n");
 	write_lock_bh(&client->ingress_lock);
 	entry->next = client->in_cache;
@@ -121,7 +121,7 @@ static in_cache_entry *in_cache_add_entry(__be32 dst_ip,
 	entry->count = 1;
 	entry->entry_state = INGRESS_INVALID;
 	entry->ctrl_info.holding_time = HOLDING_TIME_DEFAULT;
-	atomic_inc(&entry->use);
+	refcount_inc(&entry->use);
 
 	write_unlock_bh(&client->ingress_lock);
 	dprintk("new_in_cache_entry: unlocked\n");
@@ -178,7 +178,7 @@ static int cache_hit(in_cache_entry *entry, struct mpoa_client *mpc)
 
 static void in_cache_put(in_cache_entry *entry)
 {
-	if (atomic_dec_and_test(&entry->use)) {
+	if (refcount_dec_and_test(&entry->use)) {
 		memset(entry, 0, sizeof(in_cache_entry));
 		kfree(entry);
 	}
diff --git a/net/atm/mpoa_caches.h b/net/atm/mpoa_caches.h
index 8e5f78c..38a4e7e 100644
--- a/net/atm/mpoa_caches.h
+++ b/net/atm/mpoa_caches.h
@@ -6,6 +6,7 @@
 #include <linux/atm.h>
 #include <linux/atmdev.h>
 #include <linux/atmmpc.h>
+#include <linux/refcount.h>
 
 struct mpoa_client;
 
@@ -25,7 +26,7 @@ typedef struct in_cache_entry {
 	struct   atm_vcc *shortcut;
 	uint8_t  MPS_ctrl_ATM_addr[ATM_ESA_LEN];
 	struct   in_ctrl_info ctrl_info;
-	atomic_t use;
+	refcount_t use;
 } in_cache_entry;
 
 struct in_cache_ops{
-- 
2.7.4

