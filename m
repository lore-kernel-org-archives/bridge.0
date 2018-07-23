Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=Yhhjc9K9Iu57qW8FBaWJCzlTiql/5znyNsxucSHsNnA=;
	b=gv6F6NgpEYmYzIsjPnWZr5FUdMr/JUMK++/JHhKDrc2ffq3qT2ZtBnHkGjEAvXn9FQ
	w9lanGbVXwc9SnKxPxelzur3fruOBKsWm4RrPUnVtlCeXWMvE9kY0G6i9IFl+ayvWOOk
	Ft83KIdW0xO/QFzNSzS2KQqWaKGgevl3MV1Y4=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Mon, 23 Jul 2018 11:16:59 +0300
Message-Id: <20180723081659.21986-3-nikolay@cumulusnetworks.com>
In-Reply-To: <20180723081659.21986-1-nikolay@cumulusnetworks.com>
References: <20180723081659.21986-1-nikolay@cumulusnetworks.com>
Subject: [Bridge] [PATCH 2/2 net-next v3] net: bridge: add support for
	backup port
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, wkok@cumulusnetworks.com, anuradhak@cumulusnetworks.com, davem@davemloft.net

This patch adds a new port attribute - IFLA_BRPORT_BACKUP_PORT, which
allows to set a backup port to be used for known unicast traffic if the
port has gone carrier down. The backup pointer is rcu protected and set
only under RTNL, a counter is maintained so when deleting a port we know
how many other ports reference it as a backup and we remove it from all.
Also the pointer is in the first cache line which is hot at the time of
the check and thus in the common case we only add one more test.
The backup port will be used only for the non-flooding case since
it's a part of the bridge and the flooded packets will be forwarded to it
anyway. To remove the forwarding just send a 0/non-existing backup port.
This is used to avoid numerous scalability problems when using MLAG most
notably if we have thousands of fdbs one would need to change all of them
on port carrier going down which takes too long and causes a storm of fdb
notifications (and again when the port comes back up). In a Multi-chassis
Link Aggregation setup usually hosts are connected to two different
switches which act as a single logical switch. Those switches usually have
a control and backup link between them called peerlink which might be used
for communication in case a host loses connectivity to one of them.
We need a fast way to failover in case a host port goes down and currently
none of the solutions (like bond) cannot fulfill the requirements because
the participating ports are actually the "master" devices and must have the
same peerlink as their backup interface and at the same time all of them
must participate in the bridge device. As Roopa noted it's normal practice
in routing called fast re-route where a precalculated backup path is used
when the main one is down.
Another use case of this is with EVPN, having a single vxlan device which
is backup of every port. Due to the nature of master devices it's not
currently possible to use one device as a backup for many and still have
all of them participate in the bridge (which is master itself).
More detailed information about MLAG is available at the link below.
https://docs.cumulusnetworks.com/display/DOCS/Multi-Chassis+Link+Aggregation+-+MLAG

Further explanation and a diagram by Roopa:
Two switches acting in a MLAG pair are connected by the peerlink
interface which is a bridge port.

the config on one of the switches looks like the below. The other
switch also has a similar config.
eth0 is connected to one port on the server. And the server is
connected to both switches.

br0 -- team0---eth0
      |
      -- switch-peerlink

Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
v3: No code changes, added Roopa's explanation and diagram

 include/uapi/linux/if_link.h |  1 +
 net/bridge/br_forward.c      | 16 ++++++++++++-
 net/bridge/br_if.c           | 53 ++++++++++++++++++++++++++++++++++++++++++++
 net/bridge/br_netlink.c      | 30 ++++++++++++++++++++++++-
 net/bridge/br_private.h      |  3 +++
 net/bridge/br_sysfs_if.c     | 33 +++++++++++++++++++++++++++
 6 files changed, 134 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index 8759cfb8aa2e..01b5069a73a5 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -334,6 +334,7 @@ enum {
 	IFLA_BRPORT_GROUP_FWD_MASK,
 	IFLA_BRPORT_NEIGH_SUPPRESS,
 	IFLA_BRPORT_ISOLATED,
+	IFLA_BRPORT_BACKUP_PORT,
 	__IFLA_BRPORT_MAX
 };
 #define IFLA_BRPORT_MAX (__IFLA_BRPORT_MAX - 1)
diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
index 9019f326fe81..5372e2042adf 100644
--- a/net/bridge/br_forward.c
+++ b/net/bridge/br_forward.c
@@ -142,7 +142,20 @@ static int deliver_clone(const struct net_bridge_port *prev,
 void br_forward(const struct net_bridge_port *to,
 		struct sk_buff *skb, bool local_rcv, bool local_orig)
 {
-	if (to && should_deliver(to, skb)) {
+	if (unlikely(!to))
+		goto out;
+
+	/* redirect to backup link if the destination port is down */
+	if (rcu_access_pointer(to->backup_port) && !netif_carrier_ok(to->dev)) {
+		struct net_bridge_port *backup_port;
+
+		backup_port = rcu_dereference(to->backup_port);
+		if (unlikely(!backup_port))
+			goto out;
+		to = backup_port;
+	}
+
+	if (should_deliver(to, skb)) {
 		if (local_rcv)
 			deliver_clone(to, skb, local_orig);
 		else
@@ -150,6 +163,7 @@ void br_forward(const struct net_bridge_port *to,
 		return;
 	}
 
+out:
 	if (!local_rcv)
 		kfree_skb(skb);
 }
diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index e7c8d55212aa..0363f1bdc401 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -170,6 +170,58 @@ void br_manage_promisc(struct net_bridge *br)
 	}
 }
 
+int nbp_backup_change(struct net_bridge_port *p,
+		      struct net_device *backup_dev)
+{
+	struct net_bridge_port *old_backup = rtnl_dereference(p->backup_port);
+	struct net_bridge_port *backup_p = NULL;
+
+	ASSERT_RTNL();
+
+	if (backup_dev) {
+		if (!br_port_exists(backup_dev))
+			return -ENOENT;
+
+		backup_p = br_port_get_rtnl(backup_dev);
+		if (backup_p->br != p->br)
+			return -EINVAL;
+	}
+
+	if (p == backup_p)
+		return -EINVAL;
+
+	if (old_backup == backup_p)
+		return 0;
+
+	/* if the backup link is already set, clear it */
+	if (old_backup)
+		old_backup->backup_redirected_cnt--;
+
+	if (backup_p)
+		backup_p->backup_redirected_cnt++;
+	rcu_assign_pointer(p->backup_port, backup_p);
+
+	return 0;
+}
+
+static void nbp_backup_clear(struct net_bridge_port *p)
+{
+	nbp_backup_change(p, NULL);
+	if (p->backup_redirected_cnt) {
+		struct net_bridge_port *cur_p;
+
+		list_for_each_entry(cur_p, &p->br->port_list, list) {
+			struct net_bridge_port *backup_p;
+
+			backup_p = rtnl_dereference(cur_p->backup_port);
+			if (backup_p == p)
+				nbp_backup_change(cur_p, NULL);
+		}
+	}
+
+	WARN_ON(rcu_access_pointer(p->backup_port) || p->backup_redirected_cnt);
+}
+
 static void nbp_update_port_count(struct net_bridge *br)
 {
 	struct net_bridge_port *p;
@@ -295,6 +347,7 @@ static void del_nbp(struct net_bridge_port *p)
 	nbp_vlan_flush(p);
 	br_fdb_delete_by_port(br, p, 0, 1);
 	switchdev_deferred_process();
+	nbp_backup_clear(p);
 
 	nbp_update_port_count(br);
 
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 9f5eb05b0373..ec2b58a09f76 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -169,13 +169,15 @@ static inline size_t br_nlmsg_size(struct net_device *dev, u32 filter_mask)
 		+ nla_total_size(1) /* IFLA_OPERSTATE */
 		+ nla_total_size(br_port_info_size()) /* IFLA_PROTINFO */
 		+ nla_total_size(br_get_link_af_size_filtered(dev,
-				 filter_mask)); /* IFLA_AF_SPEC */
+				 filter_mask)) /* IFLA_AF_SPEC */
+		+ nla_total_size(4); /* IFLA_BRPORT_BACKUP_PORT */
 }
 
 static int br_port_fill_attrs(struct sk_buff *skb,
 			      const struct net_bridge_port *p)
 {
 	u8 mode = !!(p->flags & BR_HAIRPIN_MODE);
+	struct net_bridge_port *backup_p;
 	u64 timerval;
 
 	if (nla_put_u8(skb, IFLA_BRPORT_STATE, p->state) ||
@@ -237,6 +239,14 @@ static int br_port_fill_attrs(struct sk_buff *skb,
 		return -EMSGSIZE;
 #endif
 
+	/* we might be called only with br->lock */
+	rcu_read_lock();
+	backup_p = rcu_dereference(p->backup_port);
+	if (backup_p)
+		nla_put_u32(skb, IFLA_BRPORT_BACKUP_PORT,
+			    backup_p->dev->ifindex);
+	rcu_read_unlock();
+
 	return 0;
 }
 
@@ -663,6 +673,7 @@ static const struct nla_policy br_port_policy[IFLA_BRPORT_MAX + 1] = {
 	[IFLA_BRPORT_GROUP_FWD_MASK] = { .type = NLA_U16 },
 	[IFLA_BRPORT_NEIGH_SUPPRESS] = { .type = NLA_U8 },
 	[IFLA_BRPORT_ISOLATED]	= { .type = NLA_U8 },
+	[IFLA_BRPORT_BACKUP_PORT] = { .type = NLA_U32 },
 };
 
 /* Change the state of the port and notify spanning tree */
@@ -817,6 +828,23 @@ static int br_setport(struct net_bridge_port *p, struct nlattr *tb[])
 	if (err)
 		return err;
 
+	if (tb[IFLA_BRPORT_BACKUP_PORT]) {
+		struct net_device *backup_dev = NULL;
+		u32 backup_ifindex;
+
+		backup_ifindex = nla_get_u32(tb[IFLA_BRPORT_BACKUP_PORT]);
+		if (backup_ifindex) {
+			backup_dev = __dev_get_by_index(dev_net(p->dev),
+							backup_ifindex);
+			if (!backup_dev)
+				return -ENOENT;
+		}
+
+		err = nbp_backup_change(p, backup_dev);
+		if (err)
+			return err;
+	}
+
 	br_port_flags_change(p, old_flags ^ p->flags);
 	return 0;
 }
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index cf0005d2a4d0..11ed2029985f 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -237,6 +237,7 @@ struct net_bridge_port {
 #ifdef CONFIG_BRIDGE_VLAN_FILTERING
 	struct net_bridge_vlan_group	__rcu *vlgrp;
 #endif
+	struct net_bridge_port		__rcu *backup_port;
 
 	/* STP */
 	u8				priority;
@@ -281,6 +282,7 @@ struct net_bridge_port {
 	int				offload_fwd_mark;
 #endif
 	u16				group_fwd_mask;
+	u16				backup_redirected_cnt;
 };
 
 #define kobj_to_brport(obj)	container_of(obj, struct net_bridge_port, kobj)
@@ -597,6 +599,7 @@ netdev_features_t br_features_recompute(struct net_bridge *br,
 					netdev_features_t features);
 void br_port_flags_change(struct net_bridge_port *port, unsigned long mask);
 void br_manage_promisc(struct net_bridge *br);
+int nbp_backup_change(struct net_bridge_port *p, struct net_device *backup_dev);
 
 /* br_input.c */
 int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb);
diff --git a/net/bridge/br_sysfs_if.c b/net/bridge/br_sysfs_if.c
index 4ac940067754..7c87a2fe5248 100644
--- a/net/bridge/br_sysfs_if.c
+++ b/net/bridge/br_sysfs_if.c
@@ -191,6 +191,38 @@ static int store_group_fwd_mask(struct net_bridge_port *p,
 static BRPORT_ATTR(group_fwd_mask, 0644, show_group_fwd_mask,
 		   store_group_fwd_mask);
 
+static ssize_t show_backup_port(struct net_bridge_port *p, char *buf)
+{
+	struct net_bridge_port *backup_p;
+	int ret = 0;
+
+	rcu_read_lock();
+	backup_p = rcu_dereference(p->backup_port);
+	if (backup_p)
+		ret = sprintf(buf, "%s\n", backup_p->dev->name);
+	rcu_read_unlock();
+
+	return ret;
+}
+
+static int store_backup_port(struct net_bridge_port *p, char *buf)
+{
+	struct net_device *backup_dev = NULL;
+	char *nl = strchr(buf, '\n');
+
+	if (nl)
+		*nl = '\0';
+
+	if (strlen(buf) > 0) {
+		backup_dev = __dev_get_by_name(dev_net(p->dev), buf);
+		if (!backup_dev)
+			return -ENOENT;
+	}
+
+	return nbp_backup_change(p, backup_dev);
+}
+static BRPORT_ATTR_RAW(backup_port, 0644, show_backup_port, store_backup_port);
+
 BRPORT_ATTR_FLAG(hairpin_mode, BR_HAIRPIN_MODE);
 BRPORT_ATTR_FLAG(bpdu_guard, BR_BPDU_GUARD);
 BRPORT_ATTR_FLAG(root_block, BR_ROOT_BLOCK);
@@ -254,6 +286,7 @@ static const struct brport_attribute *brport_attrs[] = {
 	&brport_attr_group_fwd_mask,
 	&brport_attr_neigh_suppress,
 	&brport_attr_isolated,
+	&brport_attr_backup_port,
 	NULL
 };
 
-- 
2.11.0

