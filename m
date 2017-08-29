Return-Path: <>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id;
	bh=Dtl+if+v7rUCzXuonLC5JtLqPa8EuDuRpwdDflk0wHo=;
	b=cqIGcMzmofzqJ161mpPV6scnwWJv/UePNB/HJB6poCIeNgFqDIIigePJJ4yV2nWw7B
	e/kQzYMeVpXVoShKIQTuVY0rERQLdj9pMZQv+lEAqLoC/GCk0gUYxTMpDg9Obth4wDx2
	jffNSYrWZoqPm7kgz4XZBpZ6KHskaE+eXIvpo=
From: Roopa Prabhu <roopa@cumulusnetworks.com>
Date: Tue, 29 Aug 2017 13:16:57 -0700
Message-Id: <1504037817-38107-1-git-send-email-roopa@cumulusnetworks.com>
Subject: [Bridge] [PATCH net-next v3] bridge: fdb add and delete tracepoints
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: davem@davemloft.net
Cc: nikolay@cumulusnetworks.com, netdev@vger.kernel.org, f.fainelli@gmail.com, bridge@lists.linux-foundation.org

From: Roopa Prabhu <roopa@cumulusnetworks.com>

A few useful tracepoints to trace bridge forwarding
database updates.

Signed-off-by: Roopa Prabhu <roopa@cumulusnetworks.com>
---
v2: address comments from florian
v3: remove stray character '=' in print (pointed out by florian)

 include/trace/events/bridge.h |   98 +++++++++++++++++++++++++++++++++++++++++
 net/bridge/br_fdb.c           |    7 +++
 net/core/net-traces.c         |    6 +++
 3 files changed, 111 insertions(+)
 create mode 100644 include/trace/events/bridge.h

diff --git a/include/trace/events/bridge.h b/include/trace/events/bridge.h
new file mode 100644
index 0000000..0f1cde0
--- /dev/null
+++ b/include/trace/events/bridge.h
@@ -0,0 +1,98 @@
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM bridge
+
+#if !defined(_TRACE_BRIDGE_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_BRIDGE_H
+
+#include <linux/netdevice.h>
+#include <linux/tracepoint.h>
+
+#include "../../../net/bridge/br_private.h"
+
+TRACE_EVENT(br_fdb_add,
+
+	TP_PROTO(struct ndmsg *ndm, struct net_device *dev,
+		 const unsigned char *addr, u16 vid, u16 nlh_flags),
+
+	TP_ARGS(ndm, dev, addr, vid, nlh_flags),
+
+	TP_STRUCT__entry(
+		__field(u8, ndm_flags)
+		__string(dev, dev->name)
+		__array(unsigned char, addr, ETH_ALEN)
+		__field(u16, vid)
+		__field(u16, nlh_flags)
+	),
+
+	TP_fast_assign(
+		__assign_str(dev, dev->name);
+		memcpy(__entry->addr, addr, ETH_ALEN);
+		__entry->vid = vid;
+		__entry->nlh_flags = nlh_flags;
+		__entry->ndm_flags = ndm->ndm_flags;
+	),
+
+	TP_printk("dev %s addr %02x:%02x:%02x:%02x:%02x:%02x vid %u nlh_flags %04x ndm_flags %02x",
+		  __get_str(dev), __entry->addr[0], __entry->addr[1],
+		  __entry->addr[2], __entry->addr[3], __entry->addr[4],
+		  __entry->addr[5], __entry->vid,
+		  __entry->nlh_flags, __entry->ndm_flags)
+);
+
+TRACE_EVENT(br_fdb_external_learn_add,
+
+	TP_PROTO(struct net_bridge *br, struct net_bridge_port *p,
+		 const unsigned char *addr, u16 vid),
+
+	TP_ARGS(br, p, addr, vid),
+
+	TP_STRUCT__entry(
+		__string(br_dev, br->dev->name)
+		__string(dev, p ? p->dev->name : "null")
+		__array(unsigned char, addr, ETH_ALEN)
+		__field(u16, vid)
+	),
+
+	TP_fast_assign(
+		__assign_str(br_dev, br->dev->name);
+		__assign_str(dev, p ? p->dev->name : "null");
+		memcpy(__entry->addr, addr, ETH_ALEN);
+		__entry->vid = vid;
+	),
+
+	TP_printk("br_dev %s port %s addr %02x:%02x:%02x:%02x:%02x:%02x vid %u",
+		  __get_str(br_dev), __get_str(dev), __entry->addr[0],
+		  __entry->addr[1], __entry->addr[2], __entry->addr[3],
+		  __entry->addr[4], __entry->addr[5], __entry->vid)
+);
+
+TRACE_EVENT(fdb_delete,
+
+	TP_PROTO(struct net_bridge *br, struct net_bridge_fdb_entry *f),
+
+	TP_ARGS(br, f),
+
+	TP_STRUCT__entry(
+		__string(br_dev, br->dev->name)
+		__string(dev, f->dst ? f->dst->dev->name : "null")
+		__array(unsigned char, addr, ETH_ALEN)
+		__field(u16, vid)
+	),
+
+	TP_fast_assign(
+		__assign_str(br_dev, br->dev->name);
+		__assign_str(dev, f->dst ? f->dst->dev->name : "null");
+		memcpy(__entry->addr, f->addr.addr, ETH_ALEN);
+		__entry->vid = f->vlan_id;
+	),
+
+	TP_printk("br_dev %s dev %s addr %02x:%02x:%02x:%02x:%02x:%02x vid %u",
+		  __get_str(br_dev), __get_str(dev), __entry->addr[0],
+		  __entry->addr[1], __entry->addr[2], __entry->addr[3],
+		  __entry->addr[4], __entry->addr[5], __entry->vid)
+);
+
+#endif /* _TRACE_BRIDGE_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index a79b648..be5e1da 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -25,6 +25,7 @@
 #include <asm/unaligned.h>
 #include <linux/if_vlan.h>
 #include <net/switchdev.h>
+#include <trace/events/bridge.h>
 #include "br_private.h"
 
 static struct kmem_cache *br_fdb_cache __read_mostly;
@@ -171,6 +172,8 @@ static void fdb_del_hw_addr(struct net_bridge *br, const unsigned char *addr)
 
 static void fdb_delete(struct net_bridge *br, struct net_bridge_fdb_entry *f)
 {
+	trace_fdb_delete(br, f);
+
 	if (f->is_static)
 		fdb_del_hw_addr(br, f->addr.addr);
 
@@ -870,6 +873,8 @@ int br_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
 	struct net_bridge *br = NULL;
 	int err = 0;
 
+	trace_br_fdb_add(ndm, dev, addr, vid, nlh_flags);
+
 	if (!(ndm->ndm_state & (NUD_PERMANENT|NUD_NOARP|NUD_REACHABLE))) {
 		pr_info("bridge: RTM_NEWNEIGH with invalid state %#x\n", ndm->ndm_state);
 		return -EINVAL;
@@ -1066,6 +1071,8 @@ int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
 	bool modified = false;
 	int err = 0;
 
+	trace_br_fdb_external_learn_add(br, p, addr, vid);
+
 	spin_lock_bh(&br->hash_lock);
 
 	head = &br->hash[br_mac_hash(addr, vid)];
diff --git a/net/core/net-traces.c b/net/core/net-traces.c
index 4f1468c..4a0292c 100644
--- a/net/core/net-traces.c
+++ b/net/core/net-traces.c
@@ -37,6 +37,12 @@
 #include <trace/events/fib6.h>
 EXPORT_TRACEPOINT_SYMBOL_GPL(fib6_table_lookup);
 #endif
+#if IS_ENABLED(CONFIG_BRIDGE)
+#include <trace/events/bridge.h>
+EXPORT_TRACEPOINT_SYMBOL_GPL(br_fdb_add);
+EXPORT_TRACEPOINT_SYMBOL_GPL(br_fdb_external_learn_add);
+EXPORT_TRACEPOINT_SYMBOL_GPL(fdb_delete);
+#endif
 
 EXPORT_TRACEPOINT_SYMBOL_GPL(kfree_skb);
 
-- 
1.7.10.4

