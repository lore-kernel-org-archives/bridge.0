Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=BPXOkZ0JV/Q+w6Sg5kbtEDOtggJHQiPc7K2+eBclq6Q=;
	b=Himydgvr7zodOMgnbpmYXILCMTfdj5k7mPRx6feZRb3MTeSuIiV4kc5VqafXLDGeTJ
	aZfWj5Qm9PJCWt+Cec8l391i8F4puxvIxKzFeNTBjvyaVQYE5XywtWhtsxfrM/dCwWrT
	FMYw5v2SiGelJAqZ7TbMiu0V8Z2XG24x+cDiQ=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Thu, 22 Nov 2018 06:29:25 +0200
Message-Id: <20181122042925.8878-3-nikolay@cumulusnetworks.com>
In-Reply-To: <20181122042925.8878-1-nikolay@cumulusnetworks.com>
References: <20181122042925.8878-1-nikolay@cumulusnetworks.com>
Subject: [Bridge] [PATCH net-next 2/2] net: bridge: add no_linklocal_learn
	bool option
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, andrew@lunn.ch, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net

Use the new boolopt API to add an option which disables learning from
link-local packets. The default is kept as before and learning is
enabled. This is a simple map from a boolopt bit to a bridge private
flag that is tested before learning.

Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 include/uapi/linux/if_bridge.h |  3 +++
 net/bridge/br.c                | 10 +++++++---
 net/bridge/br_input.c          |  4 +++-
 net/bridge/br_private.h        |  1 +
 net/bridge/br_sysfs_br.c       | 22 ++++++++++++++++++++++
 5 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
index 6dc02c03bdf8..773e476a8e54 100644
--- a/include/uapi/linux/if_bridge.h
+++ b/include/uapi/linux/if_bridge.h
@@ -294,10 +294,13 @@ struct br_mcast_stats {
 };
 
 /* bridge boolean options
+ * BR_BOOLOPT_NO_LL_LEARN - disable learning from link-local packets
+ *
  * IMPORTANT: if adding a new option do not forget to handle
  *            it in br_boolopt_toggle/get and bridge sysfs
  */
 enum br_boolopt_id {
+	BR_BOOLOPT_NO_LL_LEARN,
 	BR_BOOLOPT_MAX
 };
 
diff --git a/net/bridge/br.c b/net/bridge/br.c
index 290b0adbf6d6..5b78a6385bd6 100644
--- a/net/bridge/br.c
+++ b/net/bridge/br.c
@@ -189,6 +189,10 @@ int br_boolopt_toggle(struct net_bridge *br, enum br_boolopt_id opt, bool on)
 	int err = -ENOENT;
 
 	switch (opt) {
+	case BR_BOOLOPT_NO_LL_LEARN:
+		err = 0;
+		br_opt_toggle(br, BROPT_NO_LL_LEARN, on);
+		break;
 	default:
 		break;
 	}
@@ -198,14 +202,14 @@ int br_boolopt_toggle(struct net_bridge *br, enum br_boolopt_id opt, bool on)
 
 int br_boolopt_get(const struct net_bridge *br, enum br_boolopt_id opt)
 {
-	int optval = 0;
-
 	switch (opt) {
+	case BR_BOOLOPT_NO_LL_LEARN:
+		return br_opt_get(br, BROPT_NO_LL_LEARN);
 	default:
 		break;
 	}
 
-	return optval;
+	return 0;
 }
 
 int br_boolopt_multi_toggle(struct net_bridge *br,
diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index 3ddca11f44c2..5ea7e56119c1 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -188,7 +188,9 @@ static void __br_handle_local_finish(struct sk_buff *skb)
 	u16 vid = 0;
 
 	/* check if vlan is allowed, to avoid spoofing */
-	if (p->flags & BR_LEARNING && br_should_learn(p, skb, &vid))
+	if ((p->flags & BR_LEARNING) &&
+	    !br_opt_get(p->br, BROPT_NO_LL_LEARN) &&
+	    br_should_learn(p, skb, &vid))
 		br_fdb_update(p->br, p, eth_hdr(skb)->h_source, vid, false);
 }
 
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 0f051730ed4f..390848acff08 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -328,6 +328,7 @@ enum net_bridge_opts {
 	BROPT_NEIGH_SUPPRESS_ENABLED,
 	BROPT_MTU_SET_BY_USER,
 	BROPT_VLAN_STATS_PER_PORT,
+	BROPT_NO_LL_LEARN,
 };
 
 struct net_bridge {
diff --git a/net/bridge/br_sysfs_br.c b/net/bridge/br_sysfs_br.c
index 60182bef6341..5a03033ccd27 100644
--- a/net/bridge/br_sysfs_br.c
+++ b/net/bridge/br_sysfs_br.c
@@ -328,6 +328,27 @@ static ssize_t flush_store(struct device *d,
 }
 static DEVICE_ATTR_WO(flush);
 
+static ssize_t no_linklocal_learn_show(struct device *d,
+				       struct device_attribute *attr,
+				       char *buf)
+{
+	struct net_bridge *br = to_bridge(d);
+	return sprintf(buf, "%d\n", br_boolopt_get(br, BR_BOOLOPT_NO_LL_LEARN));
+}
+
+static int set_no_linklocal_learn(struct net_bridge *br, unsigned long val)
+{
+	return br_boolopt_toggle(br, BR_BOOLOPT_NO_LL_LEARN, !!val);
+}
+
+static ssize_t no_linklocal_learn_store(struct device *d,
+					struct device_attribute *attr,
+					const char *buf, size_t len)
+{
+	return store_bridge_parm(d, buf, len, set_no_linklocal_learn);
+}
+static DEVICE_ATTR_RW(no_linklocal_learn);
+
 #ifdef CONFIG_BRIDGE_IGMP_SNOOPING
 static ssize_t multicast_router_show(struct device *d,
 				     struct device_attribute *attr, char *buf)
@@ -841,6 +862,7 @@ static struct attribute *bridge_attrs[] = {
 	&dev_attr_gc_timer.attr,
 	&dev_attr_group_addr.attr,
 	&dev_attr_flush.attr,
+	&dev_attr_no_linklocal_learn.attr,
 #ifdef CONFIG_BRIDGE_IGMP_SNOOPING
 	&dev_attr_multicast_router.attr,
 	&dev_attr_multicast_snooping.attr,
-- 
2.17.2

