Return-Path: <>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id;
	bh=avEPlIgYzWXuN4vDVe7scBPphM/BsipqfPFyCt7Ki98=;
	b=EZJcXyywhrumc+nXbUZBtMu48vHiZAuBNET9+rVSgl+YmNXPzftVDhBWA/G9/IFTQG
	VrTCwfNXEVYKvUaKke4naTi+5UiXjisb6uacxRmqiywVLwEfb9Gadq8KgTzppeEaM/1o
	5XdftLYD4oCOaw6hMud9AB+acrPBSOxOjlyLQ=
From: Roopa Prabhu <roopa@cumulusnetworks.com>
Date: Wed, 30 Aug 2017 22:18:13 -0700
Message-Id: <1504156693-24692-1-git-send-email-roopa@cumulusnetworks.com>
Subject: [Bridge] [PATCH net-next] bridge: add tracepoint in br_fdb_update
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: davem@davemloft.net
Cc: nikolay@cumulusnetworks.com, netdev@vger.kernel.org, f.fainelli@gmail.com, bridge@lists.linux-foundation.org, andrew@lunn.ch

From: Roopa Prabhu <roopa@cumulusnetworks.com>

This extends bridge fdb table tracepoints to also cover
learned fdb entries in the br_fdb_update path. Note that
unlike other tracepoints I have moved this to when the fdb
is modified because this is in the datapath and can generate
a lot of noise in the trace output. br_fdb_update is also called
from added_by_user context in the NTF_USE case which is already
traced ..hence the !added_by_user check.

Signed-off-by: Roopa Prabhu <roopa@cumulusnetworks.com>
---
 include/trace/events/bridge.h | 31 +++++++++++++++++++++++++++++++
 net/bridge/br_fdb.c           |  5 ++++-
 net/core/net-traces.c         |  1 +
 3 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/bridge.h b/include/trace/events/bridge.h
index 0f1cde0..1bee3e7 100644
--- a/include/trace/events/bridge.h
+++ b/include/trace/events/bridge.h
@@ -92,6 +92,37 @@ TRACE_EVENT(fdb_delete,
 		  __entry->addr[4], __entry->addr[5], __entry->vid)
 );
 
+TRACE_EVENT(br_fdb_update,
+
+	TP_PROTO(struct net_bridge *br, struct net_bridge_port *source,
+		 const unsigned char *addr, u16 vid, bool added_by_user),
+
+	TP_ARGS(br, source, addr, vid, added_by_user),
+
+	TP_STRUCT__entry(
+		__string(br_dev, br->dev->name)
+		__string(dev, source->dev->name)
+		__array(unsigned char, addr, ETH_ALEN)
+		__field(u16, vid)
+		__field(bool, added_by_user)
+	),
+
+	TP_fast_assign(
+		__assign_str(br_dev, br->dev->name);
+		__assign_str(dev, source->dev->name);
+		memcpy(__entry->addr, addr, ETH_ALEN);
+		__entry->vid = vid;
+		__entry->added_by_user = added_by_user;
+	),
+
+	TP_printk("br_dev %s source %s addr %02x:%02x:%02x:%02x:%02x:%02x vid %u added_by_user %d",
+		  __get_str(br_dev), __get_str(dev), __entry->addr[0],
+		  __entry->addr[1], __entry->addr[2], __entry->addr[3],
+		  __entry->addr[4], __entry->addr[5], __entry->vid,
+		  __entry->added_by_user)
+);
+
+
 #endif /* _TRACE_BRIDGE_H */
 
 /* This part must be outside protection */
diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index be5e1da..4ea5c8b 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -583,8 +583,10 @@ void br_fdb_update(struct net_bridge *br, struct net_bridge_port *source,
 				fdb->updated = now;
 			if (unlikely(added_by_user))
 				fdb->added_by_user = 1;
-			if (unlikely(fdb_modified))
+			if (unlikely(fdb_modified)) {
+				trace_br_fdb_update(br, source, addr, vid, added_by_user);
 				fdb_notify(br, fdb, RTM_NEWNEIGH);
+			}
 		}
 	} else {
 		spin_lock(&br->hash_lock);
@@ -593,6 +595,7 @@ void br_fdb_update(struct net_bridge *br, struct net_bridge_port *source,
 			if (fdb) {
 				if (unlikely(added_by_user))
 					fdb->added_by_user = 1;
+				trace_br_fdb_update(br, source, addr, vid, added_by_user);
 				fdb_notify(br, fdb, RTM_NEWNEIGH);
 			}
 		}
diff --git a/net/core/net-traces.c b/net/core/net-traces.c
index 4a0292c..1132820 100644
--- a/net/core/net-traces.c
+++ b/net/core/net-traces.c
@@ -42,6 +42,7 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(fib6_table_lookup);
 EXPORT_TRACEPOINT_SYMBOL_GPL(br_fdb_add);
 EXPORT_TRACEPOINT_SYMBOL_GPL(br_fdb_external_learn_add);
 EXPORT_TRACEPOINT_SYMBOL_GPL(fdb_delete);
+EXPORT_TRACEPOINT_SYMBOL_GPL(br_fdb_update);
 #endif
 
 EXPORT_TRACEPOINT_SYMBOL_GPL(kfree_skb);
-- 
2.1.4

