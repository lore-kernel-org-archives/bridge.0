Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c0d3.blue; s=2018;
	t=1545405327; h=from:from:sender:reply-to:subject:subject:date:date:
	message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	content-type:content-type:
	content-transfer-encoding:content-transfer-encoding:
	in-reply-to:in-reply-to:references:references;
	bh=+MESqb8y/Ovmq8x7mqvPcI8wCsbQROuFrMoXhprkHf8=;
	b=BSATfpaLRzjuw65JepqObOdmkmohenjS52ZpHA1trDvronq10XirD2UdFEnTku4aV4AB0k
	UysdUOe4Dw+lt5+IGw4FWhqDOn5mAp7IUWclATPKpqx7M+zUo9y2OFNL9DCY6SfHgZJNXr
	XBJhytUE2hfT1srql3zxmuIgf0/puv1tRscqGmcHPIOpWjjASkgT0Z5mtYiaixhcXJpi0m
	HUoxZbR+/hLwiH2gb8Ve8Tp3BKESVsLKkAR0uI+b3wn40diurDj7KOjIQ8M4bTwCYDiCBu
	evIYOORxvP3o8JOeOJ1LcasBGxuQsTKp2alXAZpLJtYO4rNjSPgnEstfsiq/Gg==
Date: Fri, 21 Dec 2018 16:15:10 +0100
Message-Id: <20181221151511.14923-4-linus.luessing@c0d3.blue>
In-Reply-To: <20181221151511.14923-1-linus.luessing@c0d3.blue>
References: <20181221151511.14923-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 3/4] bridge: join all-snoopers multicast
	address
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: b.a.t.m.a.n@lists.open-mesh.org, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, "David S . Miller" <davem@davemloft.net>

Next to snooping IGMP/MLD queries RFC4541, section 2.1.1.a) recommends
to snoop multicast router advertisements to detect multicast routers.

Multicast router advertisements are sent to an "all-snoopers"
multicast address. To be able to receive them reliably, we need to
join this group.

Otherwise other snooping switches might refrain from forwarding these
advertisements to us.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 include/uapi/linux/in.h   |  9 +++---
 net/bridge/br_multicast.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++-
 net/ipv6/mcast.c          |  2 ++
 3 files changed, 78 insertions(+), 5 deletions(-)

diff --git a/include/uapi/linux/in.h b/include/uapi/linux/in.h
index f6052e70bf40..7ab685cacb8f 100644
--- a/include/uapi/linux/in.h
+++ b/include/uapi/linux/in.h
@@ -292,10 +292,11 @@ struct sockaddr_in {
 #define	IN_LOOPBACK(a)		((((long int) (a)) & 0xff000000) == 0x7f000000)
 
 /* Defines for Multicast INADDR */
-#define INADDR_UNSPEC_GROUP   	0xe0000000U	/* 224.0.0.0   */
-#define INADDR_ALLHOSTS_GROUP 	0xe0000001U	/* 224.0.0.1   */
-#define INADDR_ALLRTRS_GROUP    0xe0000002U	/* 224.0.0.2 */
-#define INADDR_MAX_LOCAL_GROUP  0xe00000ffU	/* 224.0.0.255 */
+#define INADDR_UNSPEC_GROUP		0xe0000000U	/* 224.0.0.0   */
+#define INADDR_ALLHOSTS_GROUP		0xe0000001U	/* 224.0.0.1   */
+#define INADDR_ALLRTRS_GROUP		0xe0000002U	/* 224.0.0.2 */
+#define INADDR_ALLSNOOPERS_GROUP	0xe000006aU	/* 224.0.0.106 */
+#define INADDR_MAX_LOCAL_GROUP		0xe00000ffU	/* 224.0.0.255 */
 #endif
 
 /* <asm/byteorder.h> contains the htonl type stuff.. */
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 156c4905639e..2366f4a2780e 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1780,6 +1780,68 @@ void br_multicast_init(struct net_bridge *br)
 	INIT_HLIST_HEAD(&br->mdb_list);
 }
 
+static void br_ip4_multicast_join_snoopers(struct net_bridge *br)
+{
+	struct in_device *in_dev = in_dev_get(br->dev);
+
+	if (!in_dev)
+		return;
+
+	ip_mc_inc_group(in_dev, htonl(INADDR_ALLSNOOPERS_GROUP));
+	in_dev_put(in_dev);
+}
+
+#if IS_ENABLED(CONFIG_IPV6)
+static void br_ip6_multicast_join_snoopers(struct net_bridge *br)
+{
+	struct in6_addr addr;
+
+	ipv6_addr_set(&addr, htonl(0xff020000), 0, 0, htonl(0x6a));
+	ipv6_dev_mc_inc(br->dev, &addr);
+}
+#else
+static inline void br_ip6_multicast_join_snoopers(struct net_bridge *br)
+{
+}
+#endif
+
+static void br_multicast_join_snoopers(struct net_bridge *br)
+{
+	br_ip4_multicast_join_snoopers(br);
+	br_ip6_multicast_join_snoopers(br);
+}
+
+static void br_ip4_multicast_leave_snoopers(struct net_bridge *br)
+{
+	struct in_device *in_dev = in_dev_get(br->dev);
+
+	if (WARN_ON(!in_dev))
+		return;
+
+	ip_mc_dec_group(in_dev, htonl(INADDR_ALLSNOOPERS_GROUP));
+	in_dev_put(in_dev);
+}
+
+#if IS_ENABLED(CONFIG_IPV6)
+static void br_ip6_multicast_leave_snoopers(struct net_bridge *br)
+{
+	struct in6_addr addr;
+
+	ipv6_addr_set(&addr, htonl(0xff020000), 0, 0, htonl(0x6a));
+	ipv6_dev_mc_dec(br->dev, &addr);
+}
+#else
+static inline void br_ip6_multicast_leave_snoopers(struct net_bridge *br)
+{
+}
+#endif
+
+static void br_multicast_leave_snoopers(struct net_bridge *br)
+{
+	br_ip4_multicast_leave_snoopers(br);
+	br_ip6_multicast_leave_snoopers(br);
+}
+
 static void __br_multicast_open(struct net_bridge *br,
 				struct bridge_mcast_own_query *query)
 {
@@ -1793,6 +1855,9 @@ static void __br_multicast_open(struct net_bridge *br,
 
 void br_multicast_open(struct net_bridge *br)
 {
+	if (br_opt_get(br, BROPT_MULTICAST_ENABLED))
+		br_multicast_join_snoopers(br);
+
 	__br_multicast_open(br, &br->ip4_own_query);
 #if IS_ENABLED(CONFIG_IPV6)
 	__br_multicast_open(br, &br->ip6_own_query);
@@ -1808,6 +1873,9 @@ void br_multicast_stop(struct net_bridge *br)
 	del_timer_sync(&br->ip6_other_query.timer);
 	del_timer_sync(&br->ip6_own_query.timer);
 #endif
+
+	if (br_opt_get(br, BROPT_MULTICAST_ENABLED))
+		br_multicast_leave_snoopers(br);
 }
 
 void br_multicast_dev_del(struct net_bridge *br)
@@ -1943,8 +2011,10 @@ int br_multicast_toggle(struct net_bridge *br, unsigned long val)
 
 	br_mc_disabled_update(br->dev, val);
 	br_opt_toggle(br, BROPT_MULTICAST_ENABLED, !!val);
-	if (!br_opt_get(br, BROPT_MULTICAST_ENABLED))
+	if (!br_opt_get(br, BROPT_MULTICAST_ENABLED)) {
+		br_multicast_leave_snoopers(br);
 		goto unlock;
+	}
 
 	if (!netif_running(br->dev))
 		goto unlock;
diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index 21f6deb2aec9..42f3f5cd349f 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -940,6 +940,7 @@ int ipv6_dev_mc_inc(struct net_device *dev, const struct in6_addr *addr)
 {
 	return __ipv6_dev_mc_inc(dev, addr, MCAST_EXCLUDE);
 }
+EXPORT_SYMBOL(ipv6_dev_mc_inc);
 
 /*
  *	device multicast group del
@@ -987,6 +988,7 @@ int ipv6_dev_mc_dec(struct net_device *dev, const struct in6_addr *addr)
 
 	return err;
 }
+EXPORT_SYMBOL(ipv6_dev_mc_dec);
 
 /*
  *	check if the interface/address pair is valid
-- 
2.11.0

