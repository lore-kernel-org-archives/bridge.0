Return-Path: <razor@blackwall.org>
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Tue,  6 Oct 2015 14:12:00 +0200
Message-Id: <1444133522-16907-7-git-send-email-razor@blackwall.org>
In-Reply-To: <1444133522-16907-1-git-send-email-razor@blackwall.org>
References: <1444133522-16907-1-git-send-email-razor@blackwall.org>
Subject: [Bridge] [PATCH net-next 6/8] bridge: netlink: export port's timer
	values
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

Add the following attributes in order to export port's timer values:
IFLA_BRPORT_MESSAGE_AGE_TIMER, IFLA_BRPORT_FORWARD_DELAY_TIMER and
IFLA_BRPORT_HOLD_TIMER.

Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 include/uapi/linux/if_link.h |  3 +++
 net/bridge/br_netlink.c      | 14 ++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index 1d6aeb1bbe95..9c17f605e013 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -300,6 +300,9 @@ enum {
 	IFLA_BRPORT_NO,
 	IFLA_BRPORT_TOPOLOGY_CHANGE_ACK,
 	IFLA_BRPORT_CONFIG_PENDING,
+	IFLA_BRPORT_MESSAGE_AGE_TIMER,
+	IFLA_BRPORT_FORWARD_DELAY_TIMER,
+	IFLA_BRPORT_HOLD_TIMER,
 	__IFLA_BRPORT_MAX
 };
 #define IFLA_BRPORT_MAX (__IFLA_BRPORT_MAX - 1)
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 433d632ad7d0..04b0e5072686 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -135,6 +135,9 @@ static inline size_t br_port_info_size(void)
 		+ nla_total_size(sizeof(u16))	/* IFLA_BRPORT_NO */
 		+ nla_total_size(sizeof(u8))	/* IFLA_BRPORT_TOPOLOGY_CHANGE_ACK */
 		+ nla_total_size(sizeof(u8))	/* IFLA_BRPORT_CONFIG_PENDING */
+		+ nla_total_size(sizeof(u64))	/* IFLA_BRPORT_MESSAGE_AGE_TIMER */
+		+ nla_total_size(sizeof(u64))	/* IFLA_BRPORT_FORWARD_DELAY_TIMER */
+		+ nla_total_size(sizeof(u64))	/* IFLA_BRPORT_HOLD_TIMER */
 		+ 0;
 }
 
@@ -156,6 +159,7 @@ static int br_port_fill_attrs(struct sk_buff *skb,
 			      const struct net_bridge_port *p)
 {
 	u8 mode = !!(p->flags & BR_HAIRPIN_MODE);
+	u64 timerval;
 
 	if (nla_put_u8(skb, IFLA_BRPORT_STATE, p->state) ||
 	    nla_put_u16(skb, IFLA_BRPORT_PRIORITY, p->priority) ||
@@ -182,6 +186,16 @@ static int br_port_fill_attrs(struct sk_buff *skb,
 	    nla_put_u8(skb, IFLA_BRPORT_CONFIG_PENDING, p->config_pending))
 		return -EMSGSIZE;
 
+	timerval = br_timer_value(&p->message_age_timer);
+	if (nla_put_u64(skb, IFLA_BRPORT_MESSAGE_AGE_TIMER, timerval))
+		return -EMSGSIZE;
+	timerval = br_timer_value(&p->forward_delay_timer);
+	if (nla_put_u64(skb, IFLA_BRPORT_FORWARD_DELAY_TIMER, timerval))
+		return -EMSGSIZE;
+	timerval = br_timer_value(&p->hold_timer);
+	if (nla_put_u64(skb, IFLA_BRPORT_HOLD_TIMER, timerval))
+		return -EMSGSIZE;
+
 	return 0;
 }
 
-- 
2.4.3

