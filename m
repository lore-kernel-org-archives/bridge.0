Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=K4tsQolRiTJlNf5YBGe3vXJoYvSY3RmCQu//d2605Mw=;
 b=Yz8PvsW5GOaZ1l01Mb4Zz7cachcTSNTwK60Em12EGVnDJT/JHBIbBrB4nwAR+uFbTs
 jVpZTsf4527twvOe1o3W/prtoPMsv+qtW5TU1YO+EXhbNDQ5UjvZr3NzYNBDsxlj3Vxr
 kHOwnA5ncmqZvYjCazx3PVn5zwgnm8omPT2k4=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Mon, 13 Jan 2020 17:52:32 +0200
Message-Id: <20200113155233.20771-8-nikolay@cumulusnetworks.com>
In-Reply-To: <20200113155233.20771-1-nikolay@cumulusnetworks.com>
References: <20200113155233.20771-1-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 7/8] net: bridge: vlan: add rtnetlink
	group and notify support
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net

Add a new rtnetlink group for bridge vlan notifications - RTNLGRP_BRVLAN
and add support for sending vlan notifications (both single and ranges).
No functional changes intended, the notification support will be used by
later patches.

Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 include/uapi/linux/rtnetlink.h |  2 +
 net/bridge/br_private.h        | 11 +++++
 net/bridge/br_vlan.c           | 79 ++++++++++++++++++++++++++++++++++
 3 files changed, 92 insertions(+)

diff --git a/include/uapi/linux/rtnetlink.h b/include/uapi/linux/rtnetlink.h
index e06e3e09a1b4..fe9136f87a97 100644
--- a/include/uapi/linux/rtnetlink.h
+++ b/include/uapi/linux/rtnetlink.h
@@ -728,6 +728,8 @@ enum rtnetlink_groups {
 #define RTNLGRP_IPV6_MROUTE_R	RTNLGRP_IPV6_MROUTE_R
 	RTNLGRP_NEXTHOP,
 #define RTNLGRP_NEXTHOP		RTNLGRP_NEXTHOP
+	RTNLGRP_BRVLAN,
+#define RTNLGRP_BRVLAN		RTNLGRP_BRVLAN
 	__RTNLGRP_MAX
 };
 #define RTNLGRP_MAX	(__RTNLGRP_MAX - 1)
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index ee3871dea68f..ba162c8197da 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -960,6 +960,10 @@ int br_vlan_bridge_event(struct net_device *dev, unsigned long event,
 			 void *ptr);
 void br_vlan_rtnl_init(void);
 void br_vlan_rtnl_uninit(void);
+void br_vlan_notify(const struct net_bridge *br,
+		    const struct net_bridge_port *p,
+		    u16 vid, u16 vid_range,
+		    int cmd);
 
 static inline struct net_bridge_vlan_group *br_vlan_group(
 					const struct net_bridge *br)
@@ -1166,6 +1170,13 @@ static inline void br_vlan_rtnl_init(void)
 static inline void br_vlan_rtnl_uninit(void)
 {
 }
+
+static inline void br_vlan_notify(const struct net_bridge *br,
+				  const struct net_bridge_port *p,
+				  u16 vid, u16 vid_range,
+				  int cmd)
+{
+}
 #endif
 
 struct nf_br_ops {
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 4f911742bf5f..46818362d6b7 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -1540,6 +1540,85 @@ static bool br_vlan_fill_vids(struct sk_buff *skb, u16 vid, u16 vid_range,
 	return false;
 }
 
+static size_t rtnl_vlan_nlmsg_size(void)
+{
+	return NLMSG_ALIGN(sizeof(struct br_vlan_msg))
+		+ nla_total_size(0) /* BRIDGE_VLANDB_ENTRY */
+		+ nla_total_size(sizeof(u16)) /* BRIDGE_VLANDB_ENTRY_RANGE */
+		+ nla_total_size(sizeof(struct bridge_vlan_info)); /* BRIDGE_VLANDB_ENTRY_INFO */
+}
+
+void br_vlan_notify(const struct net_bridge *br,
+		    const struct net_bridge_port *p,
+		    u16 vid, u16 vid_range,
+		    int cmd)
+{
+	struct net_bridge_vlan_group *vg;
+	struct net_bridge_vlan *v;
+	struct br_vlan_msg *bvm;
+	struct nlmsghdr *nlh;
+	struct sk_buff *skb;
+	int err = -ENOBUFS;
+	struct net *net;
+	u16 flags = 0;
+	int ifindex;
+
+	/* right now notifications are done only with rtnl held */
+	ASSERT_RTNL();
+
+	if (p) {
+		ifindex = p->dev->ifindex;
+		vg = nbp_vlan_group(p);
+		net = dev_net(p->dev);
+	} else {
+		ifindex = br->dev->ifindex;
+		vg = br_vlan_group(br);
+		net = dev_net(br->dev);
+	}
+
+	skb = nlmsg_new(rtnl_vlan_nlmsg_size(), GFP_KERNEL);
+	if (!skb)
+		goto out_err;
+
+	err = -EMSGSIZE;
+	nlh = nlmsg_put(skb, 0, 0, cmd, sizeof(*bvm), 0);
+	if (!nlh)
+		goto out_err;
+	bvm = nlmsg_data(nlh);
+	memset(bvm, 0, sizeof(*bvm));
+	bvm->family = AF_BRIDGE;
+	bvm->ifindex = ifindex;
+
+	switch (cmd) {
+	case RTM_NEWVLAN:
+		/* need to find the vlan due to flags/options */
+		v = br_vlan_find(vg, vid);
+		if (!v || !br_vlan_should_use(v))
+			goto out_kfree;
+
+		flags = v->flags;
+		if (br_get_pvid(vg) == v->vid)
+			flags |= BRIDGE_VLAN_INFO_PVID;
+		break;
+	case RTM_DELVLAN:
+		break;
+	default:
+		goto out_kfree;
+	}
+
+	if (!br_vlan_fill_vids(skb, vid, vid_range, flags))
+		goto out_err;
+
+	nlmsg_end(skb, nlh);
+	rtnl_notify(skb, net, 0, RTNLGRP_BRVLAN, NULL, GFP_KERNEL);
+	return;
+
+out_err:
+	rtnl_set_sk_err(net, RTNLGRP_BRVLAN, err);
+out_kfree:
+	kfree_skb(skb);
+}
+
 /* check if v_curr can enter a range ending in range_end */
 static bool br_vlan_can_enter_range(const struct net_bridge_vlan *v_curr,
 				    const struct net_bridge_vlan *range_end)
-- 
2.21.0

