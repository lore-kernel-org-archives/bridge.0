Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ylXTkKnP8F765h1iV6deSBEGxEMvHyfG/yoaLoV5+ec=;
 b=QbNvZc5kYjk7xyUSgO4WUdkGPWtaOV18CuuE8/GlL2Pmakr+f4u7N8ShZGdrI9ieks
 LZIWgVjFVwLhtAHVR2oAgl9wWNdyxHhOhBRu2jiMgJVdJTgYS+lIPIsIxBMAKfALjNqg
 Ax68bOfjx3fQnKiaz43HoaR8yMmVR8WzceAJsI8YgzhQzOZ84yjW4j/76y2OLAPI22Qs
 uSn/lGHXeXaQN7LEcJz/R741CLARI7vK8M6oDl7ngOWXrRRIoNegRx8vzFvBh1bcjQSn
 YqazStUsLcliEAHgIw10P7bZFnRnTVhmM6c4DYHal5UrbIUfSb36mbUSugEOLvl7i5R9
 EGDg==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Fri, 13 Aug 2021 18:00:01 +0300
Message-Id: <20210813150002.673579-6-razor@blackwall.org>
In-Reply-To: <20210813150002.673579-1-razor@blackwall.org>
References: <20210813150002.673579-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 5/6] net: bridge: mcast: dump ipv6 querier
	state
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: bridge@lists.linux-foundation.org, Nikolay Aleksandrov <nikolay@nvidia.com>, roopa@nvidia.com

From: Nikolay Aleksandrov <nikolay@nvidia.com>

Add support for dumping global IPv6 querier state, we dump the state
only if our own querier is enabled or there has been another external
querier which has won the election. For the bridge global state we use
a new attribute IFLA_BR_MCAST_QUERIER_STATE and embed the state inside.
The structure is:
  [IFLA_BR_MCAST_QUERIER_STATE]
   `[BRIDGE_QUERIER_IPV6_ADDRESS] - ip address of the querier
   `[BRIDGE_QUERIER_IPV6_PORT]    - bridge port ifindex where the querier
                                    was seen (set only if external querier)
   `[BRIDGE_QUERIER_IPV6_OTHER_TIMER]   -  other querier timeout

IPv4 and IPv6 attributes are embedded at the same level of
IFLA_BR_MCAST_QUERIER_STATE. If we didn't dump anything we cancel the nest
and return.

Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
 include/uapi/linux/if_bridge.h |  3 +++
 net/bridge/br_multicast.c      | 36 ++++++++++++++++++++++++++++++----
 2 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
index e0fff67fcd88..eceaad200bf6 100644
--- a/include/uapi/linux/if_bridge.h
+++ b/include/uapi/linux/if_bridge.h
@@ -777,6 +777,9 @@ enum {
 	BRIDGE_QUERIER_IP_PORT,
 	BRIDGE_QUERIER_IP_OTHER_TIMER,
 	BRIDGE_QUERIER_PAD,
+	BRIDGE_QUERIER_IPV6_ADDRESS,
+	BRIDGE_QUERIER_IPV6_PORT,
+	BRIDGE_QUERIER_IPV6_OTHER_TIMER,
 	__BRIDGE_QUERIER_MAX
 };
 #define BRIDGE_QUERIER_MAX (__BRIDGE_QUERIER_MAX - 1)
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 4513bc13b6d3..0e5d6ba03457 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -2943,15 +2943,15 @@ int br_multicast_dump_querier_state(struct sk_buff *skb,
 	struct net_bridge_port *p;
 	struct nlattr *nest;
 
-	if (!brmctx->multicast_querier &&
-	    !timer_pending(&brmctx->ip4_other_query.timer))
-		return 0;
-
 	nest = nla_nest_start(skb, nest_attr);
 	if (!nest)
 		return -EMSGSIZE;
 
 	rcu_read_lock();
+	if (!brmctx->multicast_querier &&
+	    !timer_pending(&brmctx->ip4_other_query.timer))
+		goto out_v6;
+
 	br_multicast_read_querier(&brmctx->ip4_querier, &querier);
 	if (nla_put_in_addr(skb, BRIDGE_QUERIER_IP_ADDRESS,
 			    querier.addr.src.ip4)) {
@@ -2968,8 +2968,36 @@ int br_multicast_dump_querier_state(struct sk_buff *skb,
 		rcu_read_unlock();
 		goto out_err;
 	}
+
+out_v6:
+#if IS_ENABLED(CONFIG_IPV6)
+	if (!brmctx->multicast_querier &&
+	    !timer_pending(&brmctx->ip6_other_query.timer))
+		goto out;
+
+	br_multicast_read_querier(&brmctx->ip6_querier, &querier);
+	if (nla_put_in6_addr(skb, BRIDGE_QUERIER_IPV6_ADDRESS,
+			     &querier.addr.src.ip6)) {
+		rcu_read_unlock();
+		goto out_err;
+	}
+
+	p = __br_multicast_get_querier_port(brmctx->br, &querier);
+	if (timer_pending(&brmctx->ip6_other_query.timer) &&
+	    (nla_put_u64_64bit(skb, BRIDGE_QUERIER_IPV6_OTHER_TIMER,
+			       br_timer_value(&brmctx->ip6_other_query.timer),
+			       BRIDGE_QUERIER_PAD) ||
+	     (p && nla_put_u32(skb, BRIDGE_QUERIER_IPV6_PORT,
+			       p->dev->ifindex)))) {
+		rcu_read_unlock();
+		goto out_err;
+	}
+out:
+#endif
 	rcu_read_unlock();
 	nla_nest_end(skb, nest);
+	if (!nla_len(nest))
+		nla_nest_cancel(skb, nest);
 
 	return 0;
 
-- 
2.31.1

