Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=r6eGbI5T1ZbJb6/fIDxJvPsg6g6XzCNDGMhxMVE7KiU=;
 b=X6RzaWHtb8yw8tbOiXobIbN96Xov1DyWcra3y7BxsqYJIKK9CLufCSZpy2J8aMdKbs
 5Y6bktsicSNuNRz6Cnf75Z0KkpykgkzwA4PGU2NfD4+pAzb9bRzwXHhTAndAlWyaYOYP
 e6qsYvV65es4JA4IrH1k3j5VLlPeokS5YbluFKwBKO9eyUHru/pV+haJPDblDIxPdiw2
 I8AmJnHIjId0RmylS6Vn2mKiFFmlMiOc1217nq9p3wYchSyiVi8R0/paCjVKybhdzKl8
 +uhCH7ihO2USs2Y55WZ3jn8LC2spYriGFELWL06G8TsMp7MimZ4RM9yFO0Lty8/mLOOB
 Z5rw==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Wed, 20 Jan 2021 16:51:54 +0200
Message-Id: <20210120145203.1109140-6-razor@blackwall.org>
In-Reply-To: <20210120145203.1109140-1-razor@blackwall.org>
References: <20210120145203.1109140-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 05/14] net: bridge: multicast: add EHT
	structures and definitions
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@nvidia.com>, kuba@kernel.org, bridge@lists.linux-foundation.org, davem@davemloft.net, roopa@nvidia.com

From: Nikolay Aleksandrov <nikolay@nvidia.com>

Add EHT structures for tracking hosts and sources per group. We keep one
set for each host which has all of the host's S,G entries, and one set for
each multicast source which has all hosts that have joined that S,G. For
each host, source entry we record the filter_mode and we keep an expiry
timer. There is also one global expiry timer per source set, it is
updated with each set entry update, it will be later used to lower the
set's timer instead of lowering each entry's timer separately.

Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
 net/bridge/br_multicast.c         |  1 +
 net/bridge/br_private.h           |  2 ++
 net/bridge/br_private_mcast_eht.h | 50 +++++++++++++++++++++++++++++++
 3 files changed, 53 insertions(+)
 create mode 100644 net/bridge/br_private_mcast_eht.h

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index f8b685ae56d4..3aaa6adbff82 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -33,6 +33,7 @@
 #endif
 
 #include "br_private.h"
+#include "br_private_mcast_eht.h"
 
 static const struct rhashtable_params br_mdb_rht_params = {
 	.head_offset = offsetof(struct net_bridge_mdb_entry, rhnode),
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index d62c6e1af64a..0bf4c544a5da 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -252,6 +252,8 @@ struct net_bridge_port_group {
 	struct timer_list		timer;
 	struct timer_list		rexmit_timer;
 	struct hlist_node		mglist;
+	struct rb_root			eht_set_tree;
+	struct rb_root			eht_host_tree;
 
 	struct rhash_head		rhnode;
 	struct net_bridge_mcast_gc	mcast_gc;
diff --git a/net/bridge/br_private_mcast_eht.h b/net/bridge/br_private_mcast_eht.h
new file mode 100644
index 000000000000..0c9c4267969d
--- /dev/null
+++ b/net/bridge/br_private_mcast_eht.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later
+ * Copyright (c) 2020, Nikolay Aleksandrov <nikolay@nvidia.com>
+ */
+#ifndef _BR_PRIVATE_MCAST_EHT_H_
+#define _BR_PRIVATE_MCAST_EHT_H_
+
+union net_bridge_eht_addr {
+	__be32				ip4;
+#if IS_ENABLED(CONFIG_IPV6)
+	struct in6_addr			ip6;
+#endif
+};
+
+/* single host's list of set entries and filter_mode */
+struct net_bridge_group_eht_host {
+	struct rb_node			rb_node;
+
+	union net_bridge_eht_addr	h_addr;
+	struct hlist_head		set_entries;
+	unsigned int			num_entries;
+	unsigned char			filter_mode;
+	struct net_bridge_port_group	*pg;
+};
+
+/* (host, src entry) added to a per-src set and host's list */
+struct net_bridge_group_eht_set_entry {
+	struct rb_node			rb_node;
+	struct hlist_node		host_list;
+
+	union net_bridge_eht_addr	h_addr;
+	struct timer_list		timer;
+	struct net_bridge		*br;
+	struct net_bridge_group_eht_set	*eht_set;
+	struct net_bridge_group_eht_host *h_parent;
+	struct net_bridge_mcast_gc	mcast_gc;
+};
+
+/* per-src set */
+struct net_bridge_group_eht_set {
+	struct rb_node			rb_node;
+
+	union net_bridge_eht_addr	src_addr;
+	struct rb_root			entry_tree;
+	struct timer_list		timer;
+	struct net_bridge_port_group	*pg;
+	struct net_bridge		*br;
+	struct net_bridge_mcast_gc	mcast_gc;
+};
+
+#endif /* _BR_PRIVATE_MCAST_EHT_H_ */
-- 
2.29.2

