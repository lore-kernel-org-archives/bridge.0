Return-Path: <liuhangbin@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=uP74WpUfIxkFQrw13QDTf0eyIC/o9Ip6dzTaEPhVPzY=;
 b=HXX1pftRzORTj8Px5lEdsuaix32dXDrAzRrLMT4qb8+nQ19QkoDo8IfUJcH4WFm2M2
 aP3znHPiJ5Z/OgRt4qlU3oMrhzz4HzGOAGwAg1kLxCIyEDDPI7NnhBtaMKrHSIRsN62O
 w5bA1Y8ada/17UO6bUAl6Tt94fm9GpBGooLZS5L57b0Ob0BqBs9q8VtXOa+s4HtkIH2n
 ui7iyGpclZKWSTd+JOUTkRwnuSRDiTCAxdKg0ASSHQHlie+1syy4orPzNuORgS2XKcC8
 VpH5mcKmTw/rdk3BNIWWyhkebhZALuh4LG3OoNx1SIAYToi/UEOSyhp02XFZsrT7zIAi
 YbZg==
From: Hangbin Liu <liuhangbin@gmail.com>
Date: Wed, 20 Oct 2021 10:36:04 +0800
Message-Id: <20211020023604.695416-1-liuhangbin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net] net: bridge: mcast: QRI must be less than QI
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Nikolay Aleksandrov <nikolay@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>, roopa@nvidia.com, kuba@kernel.org, davem@davemloft.net

Based on RFC3376 8.3:
The number of seconds represented by the [Query Response Interval]
must be less than the [Query Interval].

Fixes: d902eee43f19 ("bridge: Add multicast count/interval sysfs entries")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 net/bridge/br_multicast.c    | 27 +++++++++++++++++++++++++++
 net/bridge/br_netlink.c      |  8 ++++++--
 net/bridge/br_private.h      |  4 ++++
 net/bridge/br_sysfs_br.c     |  6 ++----
 net/bridge/br_vlan_options.c |  8 ++++++--
 5 files changed, 45 insertions(+), 8 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index f3d751105343..1a865d08a87f 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -4522,6 +4522,33 @@ int br_multicast_set_mld_version(struct net_bridge_mcast *brmctx,
 }
 #endif
 
+/* RFC3376 8.3: The number of seconds represented by the
+ * [Query Response Interval] must be less than the [Query Interval].
+ */
+int br_multicast_set_qi(struct net_bridge_mcast *brmctx, unsigned long val,
+			struct netlink_ext_ack *extack)
+{
+	if (val > brmctx->multicast_query_response_interval) {
+		brmctx->multicast_query_interval = val;
+		return 0;
+	} else {
+		NL_SET_ERR_MSG(extack, "Invalid QI, must greater than QRI");
+		return -EINVAL;
+	}
+}
+
+int br_multicast_set_qri(struct net_bridge_mcast *brmctx, unsigned long val,
+			 struct netlink_ext_ack *extack)
+{
+	if (val < brmctx->multicast_query_interval) {
+		brmctx->multicast_query_response_interval = val;
+		return 0;
+	} else {
+		NL_SET_ERR_MSG(extack, "Invalid QRI, must less than QI");
+		return -EINVAL;
+	}
+}
+
 /**
  * br_multicast_list_adjacent - Returns snooped multicast addresses
  * @dev:	The bridge port adjacent to which to retrieve addresses
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 5c6c4305ed23..2b32d7d2ce31 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -1357,13 +1357,17 @@ static int br_changelink(struct net_device *brdev, struct nlattr *tb[],
 	if (data[IFLA_BR_MCAST_QUERY_INTVL]) {
 		u64 val = nla_get_u64(data[IFLA_BR_MCAST_QUERY_INTVL]);
 
-		br->multicast_ctx.multicast_query_interval = clock_t_to_jiffies(val);
+		err = br_multicast_set_qi(&br->multicast_ctx, clock_t_to_jiffies(val), extack);
+		if (err)
+			return err;
 	}
 
 	if (data[IFLA_BR_MCAST_QUERY_RESPONSE_INTVL]) {
 		u64 val = nla_get_u64(data[IFLA_BR_MCAST_QUERY_RESPONSE_INTVL]);
 
-		br->multicast_ctx.multicast_query_response_interval = clock_t_to_jiffies(val);
+		err = br_multicast_set_qri(&br->multicast_ctx, clock_t_to_jiffies(val), extack);
+		if (err)
+			return err;
 	}
 
 	if (data[IFLA_BR_MCAST_STARTUP_QUERY_INTVL]) {
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 37ca76406f1e..5019c601f689 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -906,6 +906,10 @@ int br_multicast_set_igmp_version(struct net_bridge_mcast *brmctx,
 int br_multicast_set_mld_version(struct net_bridge_mcast *brmctx,
 				 unsigned long val);
 #endif
+int br_multicast_set_qi(struct net_bridge_mcast *brmctx, unsigned long val,
+			struct netlink_ext_ack *extack);
+int br_multicast_set_qri(struct net_bridge_mcast *brmctx, unsigned long val,
+			 struct netlink_ext_ack *extack);
 struct net_bridge_mdb_entry *
 br_mdb_ip_get(struct net_bridge *br, struct br_ip *dst);
 struct net_bridge_mdb_entry *
diff --git a/net/bridge/br_sysfs_br.c b/net/bridge/br_sysfs_br.c
index d9a89ddd0331..f794652f8592 100644
--- a/net/bridge/br_sysfs_br.c
+++ b/net/bridge/br_sysfs_br.c
@@ -658,8 +658,7 @@ static ssize_t multicast_query_interval_show(struct device *d,
 static int set_query_interval(struct net_bridge *br, unsigned long val,
 			      struct netlink_ext_ack *extack)
 {
-	br->multicast_ctx.multicast_query_interval = clock_t_to_jiffies(val);
-	return 0;
+	return br_multicast_set_qi(&br->multicast_ctx, clock_t_to_jiffies(val), extack);
 }
 
 static ssize_t multicast_query_interval_store(struct device *d,
@@ -682,8 +681,7 @@ static ssize_t multicast_query_response_interval_show(
 static int set_query_response_interval(struct net_bridge *br, unsigned long val,
 				       struct netlink_ext_ack *extack)
 {
-	br->multicast_ctx.multicast_query_response_interval = clock_t_to_jiffies(val);
-	return 0;
+	return br_multicast_set_qri(&br->multicast_ctx, clock_t_to_jiffies(val), extack);
 }
 
 static ssize_t multicast_query_response_interval_store(
diff --git a/net/bridge/br_vlan_options.c b/net/bridge/br_vlan_options.c
index 8ffd4ed2563c..71e94ff9d926 100644
--- a/net/bridge/br_vlan_options.c
+++ b/net/bridge/br_vlan_options.c
@@ -521,14 +521,18 @@ static int br_vlan_process_global_one_opts(const struct net_bridge *br,
 		u64 val;
 
 		val = nla_get_u64(tb[BRIDGE_VLANDB_GOPTS_MCAST_QUERY_INTVL]);
-		v->br_mcast_ctx.multicast_query_interval = clock_t_to_jiffies(val);
+		err = br_multicast_set_qi(&v->br_mcast_ctx, clock_t_to_jiffies(val), extack);
+		if (err)
+			return err;
 		*changed = true;
 	}
 	if (tb[BRIDGE_VLANDB_GOPTS_MCAST_QUERY_RESPONSE_INTVL]) {
 		u64 val;
 
 		val = nla_get_u64(tb[BRIDGE_VLANDB_GOPTS_MCAST_QUERY_RESPONSE_INTVL]);
-		v->br_mcast_ctx.multicast_query_response_interval = clock_t_to_jiffies(val);
+		err = br_multicast_set_qri(&v->br_mcast_ctx, clock_t_to_jiffies(val), extack);
+		if (err)
+			return err;
 		*changed = true;
 	}
 	if (tb[BRIDGE_VLANDB_GOPTS_MCAST_STARTUP_QUERY_INTVL]) {
-- 
2.31.1

