Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=dpzgkftfAJDEP/hrQTOpfwIerZ4kN6J1J4cTswNeov8=;
	b=XBDvP7sUhpP4WZsypsL2LRBqWrvfGK8pZKpVLsJkt6cqeFaBxQ4uOju3qzizyd0yMt
	IO2UbBv1sTPw444bu+dy0+CARZQghl2IB934b2MXwtrJrKDFIeH/O+10afr0/24kazeL
	ja5SFD1o5ovXTKBW1EyIZ1I4+GuCKHwTcOHUc=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Thu, 22 Nov 2018 06:29:24 +0200
Message-Id: <20181122042925.8878-2-nikolay@cumulusnetworks.com>
In-Reply-To: <20181122042925.8878-1-nikolay@cumulusnetworks.com>
References: <20181122042925.8878-1-nikolay@cumulusnetworks.com>
Subject: [Bridge] [PATCH net-next 1/2] net: bridge: add support for
	user-controlled bool options
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

We have been adding many new bridge options, a big number of which are
boolean but still take up netlink attribute ids and waste space in the skb.
Recently we discussed learning from link-local packets[1] and decided
yet another new boolean option will be needed, thus introducing this API
to save some bridge nl space.
The API supports changing the value of multiple boolean options at once
via the br_boolopt_multi struct which has an optmask (which options to
set, bit per opt) and optval (options' new values). Future boolean
options will only be added to the br_boolopt_id enum and then will have
to be handled in br_boolopt_toggle/get. The API will automatically
add the ability to change and export them via netlink, sysfs can use the
single boolopt function versions to do the same. The behaviour with
failing/succeeding is the same as with normal netlink option changing.

If an option requires mapping to internal kernel flag or needs special
configuration to be enabled then it should be handled in
br_boolopt_toggle. It should also be able to retrieve an option's current
state via br_boolopt_get.

[1] https://www.spinics.net/lists/netdev/msg532698.html

Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 include/uapi/linux/if_bridge.h | 18 +++++++++
 include/uapi/linux/if_link.h   |  1 +
 net/bridge/br.c                | 68 ++++++++++++++++++++++++++++++++++
 net/bridge/br_netlink.c        | 17 ++++++++-
 net/bridge/br_private.h        |  6 +++
 net/core/rtnetlink.c           |  2 +-
 6 files changed, 110 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
index e41eda3c71f1..6dc02c03bdf8 100644
--- a/include/uapi/linux/if_bridge.h
+++ b/include/uapi/linux/if_bridge.h
@@ -292,4 +292,22 @@ struct br_mcast_stats {
 	__u64 mcast_bytes[BR_MCAST_DIR_SIZE];
 	__u64 mcast_packets[BR_MCAST_DIR_SIZE];
 };
+
+/* bridge boolean options
+ * IMPORTANT: if adding a new option do not forget to handle
+ *            it in br_boolopt_toggle/get and bridge sysfs
+ */
+enum br_boolopt_id {
+	BR_BOOLOPT_MAX
+};
+
+/* struct br_boolopt_multi - change multiple bridge boolean options
+ *
+ * @optval: new option values (bit per option)
+ * @optmask: options to change (bit per option)
+ */
+struct br_boolopt_multi {
+	__u32 optval;
+	__u32 optmask;
+};
 #endif /* _UAPI_LINUX_IF_BRIDGE_H */
diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index f42c069d81db..d6533828123a 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -288,6 +288,7 @@ enum {
 	IFLA_BR_MCAST_IGMP_VERSION,
 	IFLA_BR_MCAST_MLD_VERSION,
 	IFLA_BR_VLAN_STATS_PER_PORT,
+	IFLA_BR_MULTI_BOOLOPT,
 	__IFLA_BR_MAX,
 };
 
diff --git a/net/bridge/br.c b/net/bridge/br.c
index 360ad66c21e9..290b0adbf6d6 100644
--- a/net/bridge/br.c
+++ b/net/bridge/br.c
@@ -175,6 +175,74 @@ static struct notifier_block br_switchdev_notifier = {
 	.notifier_call = br_switchdev_event,
 };
 
+/* br_boolopt_toggle - change user-controlled boolean option
+ *
+ * @br: bridge device
+ * @opt: id of the option to change
+ * @on: new option value
+ *
+ * Changes the value of the respective boolean option to @on taking care of
+ * any internal option value mapping and configuration.
+ */
+int br_boolopt_toggle(struct net_bridge *br, enum br_boolopt_id opt, bool on)
+{
+	int err = -ENOENT;
+
+	switch (opt) {
+	default:
+		break;
+	}
+
+	return err;
+}
+
+int br_boolopt_get(const struct net_bridge *br, enum br_boolopt_id opt)
+{
+	int optval = 0;
+
+	switch (opt) {
+	default:
+		break;
+	}
+
+	return optval;
+}
+
+int br_boolopt_multi_toggle(struct net_bridge *br,
+			    struct br_boolopt_multi *bm)
+{
+	unsigned long bitmap = bm->optmask;
+	int err = 0;
+	int opt_id;
+
+	for_each_set_bit(opt_id, &bitmap, BR_BOOLOPT_MAX) {
+		bool on = !!(bm->optval & BIT(opt_id));
+
+		err = br_boolopt_toggle(br, opt_id, on);
+		if (err) {
+			br_debug(br, "boolopt multi-toggle error: option: %d current: %d new: %d error: %d\n",
+				 opt_id, br_boolopt_get(br, opt_id), on, err);
+			break;
+		}
+	}
+
+	return err;
+}
+
+void br_boolopt_multi_get(const struct net_bridge *br,
+			  struct br_boolopt_multi *bm)
+{
+	u32 optval = 0;
+	int opt_id;
+
+	for (opt_id = 0; opt_id < BR_BOOLOPT_MAX; opt_id++)
+		optval |= (br_boolopt_get(br, opt_id) << opt_id);
+
+	bm->optval = optval;
+	bm->optmask = 0;
+}
+
+/* private bridge options, controlled by the kernel */
 void br_opt_toggle(struct net_bridge *br, enum net_bridge_opts opt, bool on)
 {
 	bool cur = !!br_opt_get(br, opt);
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 3345f1984542..11325dc2e90a 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -1035,6 +1035,8 @@ static const struct nla_policy br_policy[IFLA_BR_MAX + 1] = {
 	[IFLA_BR_MCAST_IGMP_VERSION] = { .type = NLA_U8 },
 	[IFLA_BR_MCAST_MLD_VERSION] = { .type = NLA_U8 },
 	[IFLA_BR_VLAN_STATS_PER_PORT] = { .type = NLA_U8 },
+	[IFLA_BR_MULTI_BOOLOPT] = { .type = NLA_EXACT_LEN,
+				    .len = sizeof(struct br_boolopt_multi) },
 };
 
 static int br_changelink(struct net_device *brdev, struct nlattr *tb[],
@@ -1296,6 +1298,15 @@ static int br_changelink(struct net_device *brdev, struct nlattr *tb[],
 	}
 #endif
 
+	if (data[IFLA_BR_MULTI_BOOLOPT]) {
+		struct br_boolopt_multi *bm;
+
+		bm = nla_data(data[IFLA_BR_MULTI_BOOLOPT]);
+		err = br_boolopt_multi_toggle(br, bm);
+		if (err)
+			return err;
+	}
+
 	return 0;
 }
 
@@ -1374,6 +1385,7 @@ static size_t br_get_size(const struct net_device *brdev)
 	       nla_total_size(sizeof(u8)) +     /* IFLA_BR_NF_CALL_IP6TABLES */
 	       nla_total_size(sizeof(u8)) +     /* IFLA_BR_NF_CALL_ARPTABLES */
 #endif
+	       nla_total_size(sizeof(struct br_boolopt_multi)) + /* IFLA_BR_MULTI_BOOLOPT */
 	       0;
 }
 
@@ -1387,6 +1399,7 @@ static int br_fill_info(struct sk_buff *skb, const struct net_device *brdev)
 	u32 stp_enabled = br->stp_enabled;
 	u16 priority = (br->bridge_id.prio[0] << 8) | br->bridge_id.prio[1];
 	u8 vlan_enabled = br_vlan_enabled(br->dev);
+	struct br_boolopt_multi bm;
 	u64 clockval;
 
 	clockval = br_timer_value(&br->hello_timer);
@@ -1403,6 +1416,7 @@ static int br_fill_info(struct sk_buff *skb, const struct net_device *brdev)
 	if (nla_put_u64_64bit(skb, IFLA_BR_GC_TIMER, clockval, IFLA_BR_PAD))
 		return -EMSGSIZE;
 
+	br_boolopt_multi_get(br, &bm);
 	if (nla_put_u32(skb, IFLA_BR_FORWARD_DELAY, forward_delay) ||
 	    nla_put_u32(skb, IFLA_BR_HELLO_TIME, hello_time) ||
 	    nla_put_u32(skb, IFLA_BR_MAX_AGE, age_time) ||
@@ -1420,7 +1434,8 @@ static int br_fill_info(struct sk_buff *skb, const struct net_device *brdev)
 	    nla_put_u8(skb, IFLA_BR_TOPOLOGY_CHANGE, br->topology_change) ||
 	    nla_put_u8(skb, IFLA_BR_TOPOLOGY_CHANGE_DETECTED,
 		       br->topology_change_detected) ||
-	    nla_put(skb, IFLA_BR_GROUP_ADDR, ETH_ALEN, br->group_addr))
+	    nla_put(skb, IFLA_BR_GROUP_ADDR, ETH_ALEN, br->group_addr) ||
+	    nla_put(skb, IFLA_BR_MULTI_BOOLOPT, sizeof(bm), &bm))
 		return -EMSGSIZE;
 
 #ifdef CONFIG_BRIDGE_VLAN_FILTERING
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index bc2653738fc3..0f051730ed4f 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -507,6 +507,12 @@ static inline int br_opt_get(const struct net_bridge *br,
 	return test_bit(opt, &br->options);
 }
 
+int br_boolopt_toggle(struct net_bridge *br, enum br_boolopt_id opt, bool on);
+int br_boolopt_get(const struct net_bridge *br, enum br_boolopt_id opt);
+int br_boolopt_multi_toggle(struct net_bridge *br,
+			    struct br_boolopt_multi *bm);
+void br_boolopt_multi_get(const struct net_bridge *br,
+			  struct br_boolopt_multi *bm);
 void br_opt_toggle(struct net_bridge *br, enum net_bridge_opts opt, bool on);
 
 /* br_device.c */
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 86f2d9cbdae3..a498bb41c9aa 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -59,7 +59,7 @@
 #include <net/rtnetlink.h>
 #include <net/net_namespace.h>
 
-#define RTNL_MAX_TYPE		49
+#define RTNL_MAX_TYPE		50
 #define RTNL_SLAVE_MAX_TYPE	36
 
 struct rtnl_link {
-- 
2.17.2

