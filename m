Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XWAMcGQgcWJL3j09SfjKb/XvvQ805bCMahly93jAMwg=;
 b=fslx44Dp1STX8Hakf2R6egp847gLkkW65fDlNgVYZ6QpnpYvhpUwGZ6Fu13ibGgRJp
 Z2HFHwjOpYfGTFVx+GN84UNVFbVFEOFRuAeUJcJuTBbZCcebyb9GkJw/Vy41OLCueBr1
 ky/+e9L73QNnYTNcvWW60TxhF3UWJk5s+E0lFZ9R2m9NNkyI2N/t/d6qgIgzMRkdKqSO
 HI9/2mTzlQtAMosvDTtBeSsfdGmUFALSJMM3nzrIEtOGDUsZvxBn4nBzEDrTRNGvBPBB
 5jrAx/6Br/r/sQJSV4DGLsbXg7nAyYabfYV+195pRP02k5AasTigKSD8Y2rbvm86WHIo
 dPKQ==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Mon, 19 Jul 2021 20:06:33 +0300
Message-Id: <20210719170637.435541-12-razor@blackwall.org>
In-Reply-To: <20210719170637.435541-1-razor@blackwall.org>
References: <20210719170637.435541-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 11/15] net: bridge: multicast: include
	router port vlan id in notifications
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

Use the port multicast context to check if the router port is a vlan and
in case it is include its vlan id in the notification.

Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
 include/uapi/linux/if_bridge.h |  1 +
 net/bridge/br_mdb.c            | 29 ++++++++++++++++++++++-------
 net/bridge/br_multicast.c      |  4 ++--
 net/bridge/br_private.h        |  2 +-
 4 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
index 57a63a1572e0..1f7513300cfe 100644
--- a/include/uapi/linux/if_bridge.h
+++ b/include/uapi/linux/if_bridge.h
@@ -629,6 +629,7 @@ enum {
 	MDBA_ROUTER_PATTR_TYPE,
 	MDBA_ROUTER_PATTR_INET_TIMER,
 	MDBA_ROUTER_PATTR_INET6_TIMER,
+	MDBA_ROUTER_PATTR_VID,
 	__MDBA_ROUTER_PATTR_MAX
 };
 #define MDBA_ROUTER_PATTR_MAX (__MDBA_ROUTER_PATTR_MAX - 1)
diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index 5319587198eb..d3383a47a2f2 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -781,12 +781,12 @@ void br_mdb_notify(struct net_device *dev,
 
 static int nlmsg_populate_rtr_fill(struct sk_buff *skb,
 				   struct net_device *dev,
-				   int ifindex, u32 pid,
+				   int ifindex, u16 vid, u32 pid,
 				   u32 seq, int type, unsigned int flags)
 {
+	struct nlattr *nest, *port_nest;
 	struct br_port_msg *bpm;
 	struct nlmsghdr *nlh;
-	struct nlattr *nest;
 
 	nlh = nlmsg_put(skb, pid, seq, type, sizeof(*bpm), 0);
 	if (!nlh)
@@ -800,8 +800,18 @@ static int nlmsg_populate_rtr_fill(struct sk_buff *skb,
 	if (!nest)
 		goto cancel;
 
-	if (nla_put_u32(skb, MDBA_ROUTER_PORT, ifindex))
+	port_nest = nla_nest_start_noflag(skb, MDBA_ROUTER_PORT);
+	if (!port_nest)
+		goto end;
+	if (nla_put_nohdr(skb, sizeof(u32), &ifindex)) {
+		nla_nest_cancel(skb, port_nest);
 		goto end;
+	}
+	if (vid && nla_put_u16(skb, MDBA_ROUTER_PATTR_VID, vid)) {
+		nla_nest_cancel(skb, port_nest);
+		goto end;
+	}
+	nla_nest_end(skb, port_nest);
 
 	nla_nest_end(skb, nest);
 	nlmsg_end(skb, nlh);
@@ -817,23 +827,28 @@ static int nlmsg_populate_rtr_fill(struct sk_buff *skb,
 static inline size_t rtnl_rtr_nlmsg_size(void)
 {
 	return NLMSG_ALIGN(sizeof(struct br_port_msg))
-		+ nla_total_size(sizeof(__u32));
+		+ nla_total_size(sizeof(__u32))
+		+ nla_total_size(sizeof(u16));
 }
 
-void br_rtr_notify(struct net_device *dev, struct net_bridge_port *port,
+void br_rtr_notify(struct net_device *dev, struct net_bridge_mcast_port *pmctx,
 		   int type)
 {
 	struct net *net = dev_net(dev);
 	struct sk_buff *skb;
 	int err = -ENOBUFS;
 	int ifindex;
+	u16 vid;
 
-	ifindex = port ? port->dev->ifindex : 0;
+	ifindex = pmctx ? pmctx->port->dev->ifindex : 0;
+	vid = pmctx && br_multicast_port_ctx_is_vlan(pmctx) ? pmctx->vlan->vid :
+							      0;
 	skb = nlmsg_new(rtnl_rtr_nlmsg_size(), GFP_ATOMIC);
 	if (!skb)
 		goto errout;
 
-	err = nlmsg_populate_rtr_fill(skb, dev, ifindex, 0, 0, type, NTF_SELF);
+	err = nlmsg_populate_rtr_fill(skb, dev, ifindex, vid, 0, 0, type,
+				      NTF_SELF);
 	if (err < 0) {
 		kfree_skb(skb);
 		goto errout;
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 9d4a18a711e4..fb5e5df571fd 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -2979,7 +2979,7 @@ static void br_multicast_add_router(struct net_bridge_mcast *brmctx,
 	 * IPv4 or IPv6 multicast router.
 	 */
 	if (br_multicast_no_router_otherpf(pmctx, rlist)) {
-		br_rtr_notify(pmctx->port->br->dev, pmctx->port, RTM_NEWMDB);
+		br_rtr_notify(pmctx->port->br->dev, pmctx, RTM_NEWMDB);
 		br_port_mc_router_state_change(pmctx->port, true);
 	}
 }
@@ -4078,7 +4078,7 @@ br_multicast_rport_del_notify(struct net_bridge_mcast_port *pmctx, bool deleted)
 		return;
 #endif
 
-	br_rtr_notify(pmctx->port->br->dev, pmctx->port, RTM_DELMDB);
+	br_rtr_notify(pmctx->port->br->dev, pmctx, RTM_DELMDB);
 	br_port_mc_router_state_change(pmctx->port, false);
 
 	/* don't allow timer refresh */
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 00b93fcc7870..5515b6c37322 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -885,7 +885,7 @@ int br_mdb_hash_init(struct net_bridge *br);
 void br_mdb_hash_fini(struct net_bridge *br);
 void br_mdb_notify(struct net_device *dev, struct net_bridge_mdb_entry *mp,
 		   struct net_bridge_port_group *pg, int type);
-void br_rtr_notify(struct net_device *dev, struct net_bridge_port *port,
+void br_rtr_notify(struct net_device *dev, struct net_bridge_mcast_port *pmctx,
 		   int type);
 void br_multicast_del_pg(struct net_bridge_mdb_entry *mp,
 			 struct net_bridge_port_group *pg,
-- 
2.31.1

