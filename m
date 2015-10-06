Return-Path: <razor@blackwall.org>
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Tue,  6 Oct 2015 14:12:02 +0200
Message-Id: <1444133522-16907-9-git-send-email-razor@blackwall.org>
In-Reply-To: <1444133522-16907-1-git-send-email-razor@blackwall.org>
References: <1444133522-16907-1-git-send-email-razor@blackwall.org>
Subject: [Bridge] [PATCH net-next 8/8] bridge: netlink: add support for
	port's multicast_router attribute
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: bridge@lists.linux-foundation.org, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, roopa@cumulusnetworks.com, shm@cumulusnetworks.com, davem@davemloft.net

From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

Add IFLA_BRPORT_MULTICAST_ROUTER to allow setting/getting port's
multicast_router via netlink.

Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 include/uapi/linux/if_link.h |  1 +
 net/bridge/br_netlink.c      | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index fcea39a56095..e3b6217f34f1 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -304,6 +304,7 @@ enum {
 	IFLA_BRPORT_FORWARD_DELAY_TIMER,
 	IFLA_BRPORT_HOLD_TIMER,
 	IFLA_BRPORT_FLUSH,
+	IFLA_BRPORT_MULTICAST_ROUTER,
 	__IFLA_BRPORT_MAX
 };
 #define IFLA_BRPORT_MAX (__IFLA_BRPORT_MAX - 1)
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 6468166d6bdc..d78b4429505a 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -138,6 +138,9 @@ static inline size_t br_port_info_size(void)
 		+ nla_total_size(sizeof(u64))	/* IFLA_BRPORT_MESSAGE_AGE_TIMER */
 		+ nla_total_size(sizeof(u64))	/* IFLA_BRPORT_FORWARD_DELAY_TIMER */
 		+ nla_total_size(sizeof(u64))	/* IFLA_BRPORT_HOLD_TIMER */
+#ifdef CONFIG_BRIDGE_IGMP_SNOOPING
+		+ nla_total_size(sizeof(u8))	/* IFLA_BRPORT_MULTICAST_ROUTER */
+#endif
 		+ 0;
 }
 
@@ -196,6 +199,12 @@ static int br_port_fill_attrs(struct sk_buff *skb,
 	if (nla_put_u64(skb, IFLA_BRPORT_HOLD_TIMER, timerval))
 		return -EMSGSIZE;
 
+#ifdef CONFIG_BRIDGE_IGMP_SNOOPING
+	if (nla_put_u8(skb, IFLA_BRPORT_MULTICAST_ROUTER,
+		       p->multicast_router))
+		return -EMSGSIZE;
+#endif
+
 	return 0;
 }
 
@@ -560,6 +569,7 @@ static const struct nla_policy br_port_policy[IFLA_BRPORT_MAX + 1] = {
 	[IFLA_BRPORT_UNICAST_FLOOD] = { .type = NLA_U8 },
 	[IFLA_BRPORT_PROXYARP]	= { .type = NLA_U8 },
 	[IFLA_BRPORT_PROXYARP_WIFI] = { .type = NLA_U8 },
+	[IFLA_BRPORT_MULTICAST_ROUTER] = { .type = NLA_U8 },
 };
 
 /* Change the state of the port and notify spanning tree */
@@ -634,6 +644,15 @@ static int br_setport(struct net_bridge_port *p, struct nlattr *tb[])
 	if (tb[IFLA_BRPORT_FLUSH])
 		br_fdb_delete_by_port(p->br, p, 0, 0);
 
+#ifdef CONFIG_BRIDGE_IGMP_SNOOPING
+	if (tb[IFLA_BRPORT_MULTICAST_ROUTER]) {
+		u8 mcast_router = nla_get_u8(tb[IFLA_BRPORT_MULTICAST_ROUTER]);
+
+		err = br_multicast_set_port_router(p, mcast_router);
+		if (err)
+			return err;
+	}
+#endif
 	br_port_flags_change(p, old_flags ^ p->flags);
 	return 0;
 }
-- 
2.4.3

