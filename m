Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id;
	bh=aap7YapHkQ7EBZvZtF83kbZwj+OdLitrTyIAs6QtZ0A=;
	b=dfBg9SJyoBjQPt+BOjEn/giqFMq0z7A15vwYMdtaTNPK40HxBj1zg31f2RL7ut2xeT
	bEL8xqmPTd5KtjiGyzLyoi6UlpN5asGbf20tKUWLTaVmEv3Utg/t7y6bGxPylc0+JvxM
	QXkuKZybgac6NJDZ10W9zTNWzrHmUgZf2FHGc=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Fri, 12 Oct 2018 13:41:16 +0300
Message-Id: <20181012104116.12751-1-nikolay@cumulusnetworks.com>
Subject: [Bridge] [PATCH net-next] net: bridge: add support for per-port
	vlan stats
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, davem@davemloft.net

This patch adds an option to have per-port vlan stats instead of the
default global stats. The option can be set only when there are no port
vlans in the bridge since we need to allocate the stats if it is set
when vlans are being added to ports (and respectively free them
when being deleted). Also bump RTNL_MAX_TYPE as the bridge is the
largest user of options. The current stats design allows us to add
these without any changes to the fast-path, it all comes down to
the per-vlan stats pointer which, if this option is enabled, will
be allocated for each port vlan instead of using the global bridge-wide
one.

CC: bridge@lists.linux-foundation.org
CC: Roopa Prabhu <roopa@cumulusnetworks.com>
Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 include/uapi/linux/if_link.h |  1 +
 net/bridge/br_netlink.c      | 14 ++++++++++-
 net/bridge/br_private.h      |  2 ++
 net/bridge/br_sysfs_br.c     | 17 +++++++++++++
 net/bridge/br_vlan.c         | 49 ++++++++++++++++++++++++++++++++++--
 net/core/rtnetlink.c         |  2 +-
 6 files changed, 81 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index 58faab897201..1debfa42cba1 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -287,6 +287,7 @@ enum {
 	IFLA_BR_MCAST_STATS_ENABLED,
 	IFLA_BR_MCAST_IGMP_VERSION,
 	IFLA_BR_MCAST_MLD_VERSION,
+	IFLA_BR_VLAN_STATS_PER_PORT,
 	__IFLA_BR_MAX,
 };
 
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index e5a5bc5d5232..3345f1984542 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -1034,6 +1034,7 @@ static const struct nla_policy br_policy[IFLA_BR_MAX + 1] = {
 	[IFLA_BR_MCAST_STATS_ENABLED] = { .type = NLA_U8 },
 	[IFLA_BR_MCAST_IGMP_VERSION] = { .type = NLA_U8 },
 	[IFLA_BR_MCAST_MLD_VERSION] = { .type = NLA_U8 },
+	[IFLA_BR_VLAN_STATS_PER_PORT] = { .type = NLA_U8 },
 };
 
 static int br_changelink(struct net_device *brdev, struct nlattr *tb[],
@@ -1114,6 +1115,14 @@ static int br_changelink(struct net_device *brdev, struct nlattr *tb[],
 		if (err)
 			return err;
 	}
+
+	if (data[IFLA_BR_VLAN_STATS_PER_PORT]) {
+		__u8 per_port = nla_get_u8(data[IFLA_BR_VLAN_STATS_PER_PORT]);
+
+		err = br_vlan_set_stats_per_port(br, per_port);
+		if (err)
+			return err;
+	}
 #endif
 
 	if (data[IFLA_BR_GROUP_FWD_MASK]) {
@@ -1327,6 +1336,7 @@ static size_t br_get_size(const struct net_device *brdev)
 	       nla_total_size(sizeof(__be16)) +	/* IFLA_BR_VLAN_PROTOCOL */
 	       nla_total_size(sizeof(u16)) +    /* IFLA_BR_VLAN_DEFAULT_PVID */
 	       nla_total_size(sizeof(u8)) +     /* IFLA_BR_VLAN_STATS_ENABLED */
+	       nla_total_size(sizeof(u8)) +	/* IFLA_BR_VLAN_STATS_PER_PORT */
 #endif
 	       nla_total_size(sizeof(u16)) +    /* IFLA_BR_GROUP_FWD_MASK */
 	       nla_total_size(sizeof(struct ifla_bridge_id)) +   /* IFLA_BR_ROOT_ID */
@@ -1417,7 +1427,9 @@ static int br_fill_info(struct sk_buff *skb, const struct net_device *brdev)
 	if (nla_put_be16(skb, IFLA_BR_VLAN_PROTOCOL, br->vlan_proto) ||
 	    nla_put_u16(skb, IFLA_BR_VLAN_DEFAULT_PVID, br->default_pvid) ||
 	    nla_put_u8(skb, IFLA_BR_VLAN_STATS_ENABLED,
-		       br_opt_get(br, BROPT_VLAN_STATS_ENABLED)))
+		       br_opt_get(br, BROPT_VLAN_STATS_ENABLED)) ||
+	    nla_put_u8(skb, IFLA_BR_VLAN_STATS_PER_PORT,
+		       br_opt_get(br, IFLA_BR_VLAN_STATS_PER_PORT)))
 		return -EMSGSIZE;
 #endif
 #ifdef CONFIG_BRIDGE_IGMP_SNOOPING
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 57229b9d800f..10ee39fdca5c 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -320,6 +320,7 @@ enum net_bridge_opts {
 	BROPT_HAS_IPV6_ADDR,
 	BROPT_NEIGH_SUPPRESS_ENABLED,
 	BROPT_MTU_SET_BY_USER,
+	BROPT_VLAN_STATS_PER_PORT,
 };
 
 struct net_bridge {
@@ -859,6 +860,7 @@ int br_vlan_filter_toggle(struct net_bridge *br, unsigned long val);
 int __br_vlan_set_proto(struct net_bridge *br, __be16 proto);
 int br_vlan_set_proto(struct net_bridge *br, unsigned long val);
 int br_vlan_set_stats(struct net_bridge *br, unsigned long val);
+int br_vlan_set_stats_per_port(struct net_bridge *br, unsigned long val);
 int br_vlan_init(struct net_bridge *br);
 int br_vlan_set_default_pvid(struct net_bridge *br, unsigned long val);
 int __br_vlan_set_default_pvid(struct net_bridge *br, u16 pvid);
diff --git a/net/bridge/br_sysfs_br.c b/net/bridge/br_sysfs_br.c
index c93c5724609e..60182bef6341 100644
--- a/net/bridge/br_sysfs_br.c
+++ b/net/bridge/br_sysfs_br.c
@@ -803,6 +803,22 @@ static ssize_t vlan_stats_enabled_store(struct device *d,
 	return store_bridge_parm(d, buf, len, br_vlan_set_stats);
 }
 static DEVICE_ATTR_RW(vlan_stats_enabled);
+
+static ssize_t vlan_stats_per_port_show(struct device *d,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct net_bridge *br = to_bridge(d);
+	return sprintf(buf, "%u\n", br_opt_get(br, BROPT_VLAN_STATS_PER_PORT));
+}
+
+static ssize_t vlan_stats_per_port_store(struct device *d,
+					 struct device_attribute *attr,
+					 const char *buf, size_t len)
+{
+	return store_bridge_parm(d, buf, len, br_vlan_set_stats_per_port);
+}
+static DEVICE_ATTR_RW(vlan_stats_per_port);
 #endif
 
 static struct attribute *bridge_attrs[] = {
@@ -856,6 +872,7 @@ static struct attribute *bridge_attrs[] = {
 	&dev_attr_vlan_protocol.attr,
 	&dev_attr_default_pvid.attr,
 	&dev_attr_vlan_stats_enabled.attr,
+	&dev_attr_vlan_stats_per_port.attr,
 #endif
 	NULL
 };
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 5942e03dd845..9b707234e4ae 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -190,6 +190,19 @@ static void br_vlan_put_master(struct net_bridge_vlan *masterv)
 	}
 }
 
+static void nbp_vlan_rcu_free(struct rcu_head *rcu)
+{
+	struct net_bridge_vlan *v;
+
+	v = container_of(rcu, struct net_bridge_vlan, rcu);
+	WARN_ON(br_vlan_is_master(v));
+	/* if we had per-port stats configured then free them here */
+	if (v->brvlan->stats != v->stats)
+		free_percpu(v->stats);
+	v->stats = NULL;
+	kfree(v);
+}
+
 /* This is the shared VLAN add function which works for both ports and bridge
  * devices. There are four possible calls to this function in terms of the
  * vlan entry type:
@@ -245,7 +258,15 @@ static int __vlan_add(struct net_bridge_vlan *v, u16 flags)
 		if (!masterv)
 			goto out_filt;
 		v->brvlan = masterv;
-		v->stats = masterv->stats;
+		if (br_opt_get(br, BROPT_VLAN_STATS_PER_PORT)) {
+			v->stats = netdev_alloc_pcpu_stats(struct br_vlan_stats);
+			if (!v->stats) {
+				err = -ENOMEM;
+				goto out_filt;
+			}
+		} else {
+			v->stats = masterv->stats;
+		}
 	} else {
 		err = br_switchdev_port_vlan_add(dev, v->vid, flags);
 		if (err && err != -EOPNOTSUPP)
@@ -329,7 +350,7 @@ static int __vlan_del(struct net_bridge_vlan *v)
 		rhashtable_remove_fast(&vg->vlan_hash, &v->vnode,
 				       br_vlan_rht_params);
 		__vlan_del_list(v);
-		kfree_rcu(v, rcu);
+		call_rcu(&v->rcu, nbp_vlan_rcu_free);
 	}
 
 	br_vlan_put_master(masterv);
@@ -830,6 +851,30 @@ int br_vlan_set_stats(struct net_bridge *br, unsigned long val)
 	return 0;
 }
 
+int br_vlan_set_stats_per_port(struct net_bridge *br, unsigned long val)
+{
+	struct net_bridge_port *p;
+
+	/* allow to change the option if there are no port vlans configured */
+	list_for_each_entry(p, &br->port_list, list) {
+		struct net_bridge_vlan_group *vg = nbp_vlan_group(p);
+
+		if (vg->num_vlans)
+			return -EBUSY;
+	}
+
+	switch (val) {
+	case 0:
+	case 1:
+		br_opt_toggle(br, BROPT_VLAN_STATS_PER_PORT, !!val);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static bool vlan_default_pvid(struct net_bridge_vlan_group *vg, u16 vid)
 {
 	struct net_bridge_vlan *v;
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 46328a10034a..0958c7be2c22 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -59,7 +59,7 @@
 #include <net/rtnetlink.h>
 #include <net/net_namespace.h>
 
-#define RTNL_MAX_TYPE		48
+#define RTNL_MAX_TYPE		49
 #define RTNL_SLAVE_MAX_TYPE	36
 
 struct rtnl_link {
-- 
2.17.2

