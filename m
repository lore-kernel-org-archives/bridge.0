Return-Path: <elena.reshetova@intel.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=intel.com; i=@intel.com; q=dns/txt; s=intel;
	t=1489749260; x=1521285260;
	h=from:to:cc:subject:date:message-id:in-reply-to: references;
	bh=IECnr6V8T5KT9MXSidJrIiVsyZ8tMmD80axVxKKmysc=;
	b=FfLyvuso4yU/JgcbJFyaumjky0zHI9VbXbAjAJd3BpBb14bdd+dpZcey
	lnwrvfRxWriMud7ICHt/k60lcccMMQ==;
From: Elena Reshetova <elena.reshetova@intel.com>
Date: Fri, 17 Mar 2017 13:12:51 +0200
Message-Id: <1489749179-12063-11-git-send-email-elena.reshetova@intel.com>
In-Reply-To: <1489749179-12063-1-git-send-email-elena.reshetova@intel.com>
References: <1489749179-12063-1-git-send-email-elena.reshetova@intel.com>
Subject: [Bridge] [PATCH 10/18] net,
	atm: convert eg_cache_entry.use from atomic_t to refcount_t
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
 net/atm/mpoa_caches.c | 14 +++++++-------
 net/atm/mpoa_caches.h |  2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/atm/mpoa_caches.c b/net/atm/mpoa_caches.c
index 05e89e9..4ccaa16 100644
--- a/net/atm/mpoa_caches.c
+++ b/net/atm/mpoa_caches.c
@@ -339,7 +339,7 @@ static eg_cache_entry *eg_cache_get_by_cache_id(__be32 cache_id,
 	entry = mpc->eg_cache;
 	while (entry != NULL) {
 		if (entry->ctrl_info.cache_id == cache_id) {
-			atomic_inc(&entry->use);
+			refcount_inc(&entry->use);
 			read_unlock_irq(&mpc->egress_lock);
 			return entry;
 		}
@@ -360,7 +360,7 @@ static eg_cache_entry *eg_cache_get_by_tag(__be32 tag, struct mpoa_client *mpc)
 	entry = mpc->eg_cache;
 	while (entry != NULL) {
 		if (entry->ctrl_info.tag == tag) {
-			atomic_inc(&entry->use);
+			refcount_inc(&entry->use);
 			read_unlock_irqrestore(&mpc->egress_lock, flags);
 			return entry;
 		}
@@ -382,7 +382,7 @@ static eg_cache_entry *eg_cache_get_by_vcc(struct atm_vcc *vcc,
 	entry = mpc->eg_cache;
 	while (entry != NULL) {
 		if (entry->shortcut == vcc) {
-			atomic_inc(&entry->use);
+			refcount_inc(&entry->use);
 			read_unlock_irqrestore(&mpc->egress_lock, flags);
 			return entry;
 		}
@@ -402,7 +402,7 @@ static eg_cache_entry *eg_cache_get_by_src_ip(__be32 ipaddr,
 	entry = mpc->eg_cache;
 	while (entry != NULL) {
 		if (entry->latest_ip_addr == ipaddr) {
-			atomic_inc(&entry->use);
+			refcount_inc(&entry->use);
 			read_unlock_irq(&mpc->egress_lock);
 			return entry;
 		}
@@ -415,7 +415,7 @@ static eg_cache_entry *eg_cache_get_by_src_ip(__be32 ipaddr,
 
 static void eg_cache_put(eg_cache_entry *entry)
 {
-	if (atomic_dec_and_test(&entry->use)) {
+	if (refcount_dec_and_test(&entry->use)) {
 		memset(entry, 0, sizeof(eg_cache_entry));
 		kfree(entry);
 	}
@@ -468,7 +468,7 @@ static eg_cache_entry *eg_cache_add_entry(struct k_message *msg,
 	dprintk("adding an egress entry, ip = %pI4, this should be our IP\n",
 		&msg->content.eg_info.eg_dst_ip);
 
-	atomic_set(&entry->use, 1);
+	refcount_set(&entry->use, 1);
 	dprintk("new_eg_cache_entry: about to lock\n");
 	write_lock_irq(&client->egress_lock);
 	entry->next = client->eg_cache;
@@ -484,7 +484,7 @@ static eg_cache_entry *eg_cache_add_entry(struct k_message *msg,
 	dprintk("new_eg_cache_entry cache_id %u\n",
 		ntohl(entry->ctrl_info.cache_id));
 	dprintk("mps_ip = %pI4\n", &entry->ctrl_info.mps_ip);
-	atomic_inc(&entry->use);
+	refcount_inc(&entry->use);
 
 	write_unlock_irq(&client->egress_lock);
 	dprintk("new_eg_cache_entry: unlocked\n");
diff --git a/net/atm/mpoa_caches.h b/net/atm/mpoa_caches.h
index 38a4e7e..30fe348 100644
--- a/net/atm/mpoa_caches.h
+++ b/net/atm/mpoa_caches.h
@@ -59,7 +59,7 @@ typedef struct eg_cache_entry{
 	uint16_t             entry_state;
 	__be32             latest_ip_addr;    /* The src IP address of the last packet */
 	struct eg_ctrl_info  ctrl_info;
-	atomic_t             use;
+	refcount_t             use;
 } eg_cache_entry;
 
 struct eg_cache_ops{
-- 
2.7.4

