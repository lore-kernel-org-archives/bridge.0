Return-Path: <igor.mitsyanko.os@quantenna.com>
From: Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>
Date: Fri,  9 Mar 2018 19:03:07 -0800
Message-Id: <20180310030308.12947-5-igor.mitsyanko.os@quantenna.com>
In-Reply-To: <20180310030308.12947-1-igor.mitsyanko.os@quantenna.com>
References: <20180310030308.12947-1-igor.mitsyanko.os@quantenna.com>
Subject: [Bridge] [RFC PATCH net-next 4/5] bridge: provide sysfs and netlink
	interface to set BR_FLOOD_OFFLOAD
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org, netdev@vger.kernel.org
Cc: ivecera@redhat.com, igor.mitsyanko.os@quantenna.com, jiri@resnulli.us, sergey.matyukevich.os@quantenna.com, ashevchenko@quantenna.com, smaksimenko@quantenna.com, dlebed@quantenna.com

Allow to modify BR_FLOOD_OFFLOAD flag value through both sysfs and
netlink interface.

Signed-off-by: Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>
---
 include/uapi/linux/if_link.h | 1 +
 net/bridge/br_netlink.c      | 8 +++++++-
 net/bridge/br_sysfs_if.c     | 2 ++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index 11d0c0e..5d3eb7f 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -333,6 +333,7 @@ enum {
 	IFLA_BRPORT_BCAST_FLOOD,
 	IFLA_BRPORT_GROUP_FWD_MASK,
 	IFLA_BRPORT_NEIGH_SUPPRESS,
+	IFLA_BRPORT_FLOOD_OFFLOAD,
 	__IFLA_BRPORT_MAX
 };
 #define IFLA_BRPORT_MAX (__IFLA_BRPORT_MAX - 1)
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 015f465c..26f7c51 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -213,7 +213,9 @@ static int br_port_fill_attrs(struct sk_buff *skb,
 							BR_VLAN_TUNNEL)) ||
 	    nla_put_u16(skb, IFLA_BRPORT_GROUP_FWD_MASK, p->group_fwd_mask) ||
 	    nla_put_u8(skb, IFLA_BRPORT_NEIGH_SUPPRESS,
-		       !!(p->flags & BR_NEIGH_SUPPRESS)))
+		       !!(p->flags & BR_NEIGH_SUPPRESS)) ||
+	    nla_put_u8(skb, IFLA_BRPORT_FLOOD_OFFLOAD,
+		       !!(p->flags & BR_FLOOD_OFFLOAD)))
 		return -EMSGSIZE;
 
 	timerval = br_timer_value(&p->message_age_timer);
@@ -763,6 +765,10 @@ static int br_setport(struct net_bridge_port *p, struct nlattr *tb[])
 	if (err)
 		return err;
 
+	err = br_set_port_flag(p, tb, IFLA_BRPORT_FLOOD_OFFLOAD, BR_FLOOD_OFFLOAD);
+	if (err)
+		return err;
+
 	if (br_vlan_tunnel_old && !(p->flags & BR_VLAN_TUNNEL))
 		nbp_vlan_tunnel_info_flush(p);
 
diff --git a/net/bridge/br_sysfs_if.c b/net/bridge/br_sysfs_if.c
index 9bdd177..3be600d 100644
--- a/net/bridge/br_sysfs_if.c
+++ b/net/bridge/br_sysfs_if.c
@@ -199,6 +199,7 @@ BRPORT_ATTR_FLAG(proxyarp_wifi, BR_PROXYARP_WIFI);
 BRPORT_ATTR_FLAG(multicast_flood, BR_MCAST_FLOOD);
 BRPORT_ATTR_FLAG(broadcast_flood, BR_BCAST_FLOOD);
 BRPORT_ATTR_FLAG(neigh_suppress, BR_NEIGH_SUPPRESS);
+BRPORT_ATTR_FLAG(flood_offload, BR_FLOOD_OFFLOAD);
 
 #ifdef CONFIG_BRIDGE_IGMP_SNOOPING
 static ssize_t show_multicast_router(struct net_bridge_port *p, char *buf)
@@ -250,6 +251,7 @@ static const struct brport_attribute *brport_attrs[] = {
 	&brport_attr_broadcast_flood,
 	&brport_attr_group_fwd_mask,
 	&brport_attr_neigh_suppress,
+	&brport_attr_flood_offload,
 	NULL
 };
 
-- 
2.9.5

