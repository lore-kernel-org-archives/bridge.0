Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=f+/2GADqMNtpYIwPAKPmBkOi5mwefLPM9Y7jtBr04oE=;
 b=L4iZokOIOSXwxmnN6jVX9IV9GMnghMUoX4vh5ITbgwx+qUBy9EF3X//ad3TIiurn4f
 c8T3M2E7xRVwBa1irhFnyEwsEsYUnMFMepcyX9twpBPUBWHki1L5qY/xUEuOHq7h0ass
 5TpYgX36SwZTmtfZOri385qE7cSrR8VDLfZWo=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Mon, 13 Jan 2020 17:52:29 +0200
Message-Id: <20200113155233.20771-5-nikolay@cumulusnetworks.com>
In-Reply-To: <20200113155233.20771-1-nikolay@cumulusnetworks.com>
References: <20200113155233.20771-1-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 4/8] net: bridge: vlan: add new rtm
	message support
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

Add initial RTM_NEWVLAN support which can only create vlans, operating
similar to the current br_afspec(). We will use it later to also change
per-vlan options. Old-style (flag-based) vlan ranges are not allowed
when using RTM messages, we will introduce vlan ranges later via a new
nested attribute which would allow us to have all the information about a
range encapsulated into a single nl attribute.

Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 net/bridge/br_netlink.c |  12 ++---
 net/bridge/br_private.h |   6 +++
 net/bridge/br_vlan.c    | 110 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 122 insertions(+), 6 deletions(-)

diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 75a7ecf95d7f..b3da4f46dc64 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -561,12 +561,12 @@ static int br_vlan_info(struct net_bridge *br, struct net_bridge_port *p,
 	return err;
 }
 
-static int br_process_vlan_info(struct net_bridge *br,
-				struct net_bridge_port *p, int cmd,
-				struct bridge_vlan_info *vinfo_curr,
-				struct bridge_vlan_info **vinfo_last,
-				bool *changed,
-				struct netlink_ext_ack *extack)
+int br_process_vlan_info(struct net_bridge *br,
+			 struct net_bridge_port *p, int cmd,
+			 struct bridge_vlan_info *vinfo_curr,
+			 struct bridge_vlan_info **vinfo_last,
+			 bool *changed,
+			 struct netlink_ext_ack *extack)
 {
 	if (!br_vlan_valid_id(vinfo_curr->vid, extack))
 		return -EINVAL;
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 1c00411ae938..ee3871dea68f 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -1237,6 +1237,12 @@ int br_setlink(struct net_device *dev, struct nlmsghdr *nlmsg, u16 flags,
 int br_dellink(struct net_device *dev, struct nlmsghdr *nlmsg, u16 flags);
 int br_getlink(struct sk_buff *skb, u32 pid, u32 seq, struct net_device *dev,
 	       u32 filter_mask, int nlflags);
+int br_process_vlan_info(struct net_bridge *br,
+			 struct net_bridge_port *p, int cmd,
+			 struct bridge_vlan_info *vinfo_curr,
+			 struct bridge_vlan_info **vinfo_last,
+			 bool *changed,
+			 struct netlink_ext_ack *extack);
 
 #ifdef CONFIG_SYSFS
 /* br_sysfs_if.c */
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 0135a67f50a7..b8f52a7616c4 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -1644,13 +1644,123 @@ static int br_vlan_rtm_dump(struct sk_buff *skb, struct netlink_callback *cb)
 	return err;
 }
 
+static const struct nla_policy br_vlan_db_policy[BRIDGE_VLANDB_ENTRY_MAX + 1] = {
+	[BRIDGE_VLANDB_ENTRY_INFO]	= { .type = NLA_EXACT_LEN,
+					    .len = sizeof(struct bridge_vlan_info) },
+};
+
+static int br_vlan_rtm_process_one(struct net_device *dev,
+				   const struct nlattr *attr,
+				   int cmd, struct netlink_ext_ack *extack)
+{
+	struct bridge_vlan_info *vinfo, *vinfo_last = NULL;
+	struct nlattr *tb[BRIDGE_VLANDB_ENTRY_MAX + 1];
+	struct net_bridge_vlan_group *vg;
+	struct net_bridge_port *p = NULL;
+	int err = 0, cmdmap = 0;
+	struct net_bridge *br;
+	bool changed = false;
+
+	if (netif_is_bridge_master(dev)) {
+		br = netdev_priv(dev);
+		vg = br_vlan_group(br);
+	} else {
+		p = br_port_get_rtnl(dev);
+		if (WARN_ON(!p))
+			return -ENODEV;
+		br = p->br;
+		vg = nbp_vlan_group(p);
+	}
+
+	if (WARN_ON(!vg))
+		return -ENODEV;
+
+	err = nla_parse_nested(tb, BRIDGE_VLANDB_ENTRY_MAX, attr,
+			       br_vlan_db_policy, extack);
+	if (err)
+		return err;
+
+	if (!tb[BRIDGE_VLANDB_ENTRY_INFO]) {
+		NL_SET_ERR_MSG_MOD(extack, "Missing vlan entry info");
+		return -EINVAL;
+	}
+
+	vinfo = nla_data(tb[BRIDGE_VLANDB_ENTRY_INFO]);
+	if (vinfo->flags & (BRIDGE_VLAN_INFO_RANGE_BEGIN |
+			    BRIDGE_VLAN_INFO_RANGE_END)) {
+		NL_SET_ERR_MSG_MOD(extack, "Old-style vlan ranges are not allowed when using RTM vlan calls");
+		return -EINVAL;
+	}
+	if (!br_vlan_valid_id(vinfo->vid, extack))
+		return -EINVAL;
+
+	switch (cmd) {
+	case RTM_NEWVLAN:
+		cmdmap = RTM_SETLINK;
+		break;
+	}
+
+	err = br_process_vlan_info(br, p, cmdmap, vinfo, &vinfo_last, &changed,
+				   extack);
+	if (changed)
+		br_ifinfo_notify(cmdmap, br, p);
+
+	return err;
+}
+
+static int br_vlan_rtm_process(struct sk_buff *skb, struct nlmsghdr *nlh,
+			       struct netlink_ext_ack *extack)
+{
+	struct net *net = sock_net(skb->sk);
+	int err = -EINVAL, vlans = 0;
+	struct br_vlan_msg *bvm;
+	struct net_device *dev;
+	struct nlattr *attr;
+	int rem;
+
+	if (nlh->nlmsg_len < nlmsg_msg_size(sizeof(*bvm))) {
+		NL_SET_ERR_MSG_MOD(extack, "Invalid header for vlan request");
+		return -EINVAL;
+	}
+
+	bvm = nlmsg_data(nlh);
+	dev = __dev_get_by_index(net, bvm->ifindex);
+	if (!dev)
+		return -ENODEV;
+
+	if (!netif_is_bridge_master(dev) && !netif_is_bridge_port(dev)) {
+		NL_SET_ERR_MSG_MOD(extack, "The device is not a valid bridge or bridge port");
+		return -EINVAL;
+	}
+
+	nlmsg_for_each_attr(attr, nlh, sizeof(*bvm), rem) {
+		if (nla_type(attr) != BRIDGE_VLANDB_ENTRY)
+			continue;
+
+		vlans++;
+		err = br_vlan_rtm_process_one(dev, attr, nlh->nlmsg_type,
+					      extack);
+		if (err)
+			break;
+	}
+	if (!vlans) {
+		NL_SET_ERR_MSG_MOD(extack, "No vlans found to process");
+		err = -EINVAL;
+	}
+
+	return err;
+}
+
 void br_vlan_rtnl_init(void)
 {
 	rtnl_register_module(THIS_MODULE, PF_BRIDGE, RTM_GETVLAN, NULL,
 			     br_vlan_rtm_dump, 0);
+	rtnl_register_module(THIS_MODULE, PF_BRIDGE, RTM_NEWVLAN,
+			     br_vlan_rtm_process, NULL, 0);
 }
 
 void br_vlan_rtnl_uninit(void)
 {
 	rtnl_unregister(PF_BRIDGE, RTM_GETVLAN);
+	rtnl_unregister(PF_BRIDGE, RTM_NEWVLAN);
 }
-- 
2.21.0

