Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=60eud/MMXDfFi0hIEM2kNY7t5d2Lnc9/SnnHIqe2TUo=;
	b=NOOxqGqpt5VcoTqHNSmW8/O2eMAlzgbrNxX61obuB4+Npvi2xUHxu2uWK6OK9oWzuw
	10jWRR3PhHrUK5Y2xkJgqEj/y+GlZunxbX9nrLCLPjHLxnx17C2wR+VLtZrX/S6KVmN6
	oMAnj7OJQOFh9CzPEmkcBTRJqoPeUg0FEjKHs=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Fri, 30 Mar 2018 13:46:19 +0300
Message-Id: <20180330104619.31479-3-nikolay@cumulusnetworks.com>
In-Reply-To: <20180330104619.31479-1-nikolay@cumulusnetworks.com>
References: <20180330104619.31479-1-nikolay@cumulusnetworks.com>
Subject: [Bridge] [PATCH net-next 2/2] net: bridge: disable bridge MTU auto
	tuning if it was set manually
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, 3chas3@gmail.com, davem@davemloft.net

As Roopa noted today the biggest source of problems when configuring
bridge and ports is that the bridge MTU keeps changing automatically on
port events (add/del/changemtu). That leads to inconsistent behaviour
and network config software needs to chase the MTU and fix it on each
such event. Let's improve on that situation and allow for the user to
set any MTU within ETH_MIN/MAX limits, but once manually configured it
is the user's responsibility to keep it correct afterwards.

In case the MTU isn't manually set - the behaviour reverts to the
previous and the bridge follows the minimum MTU.

Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 net/bridge/br.c         |  2 +-
 net/bridge/br_device.c  |  5 ++---
 net/bridge/br_if.c      | 36 +++++++++++++++++++++---------------
 net/bridge/br_private.h |  3 ++-
 4 files changed, 26 insertions(+), 20 deletions(-)

diff --git a/net/bridge/br.c b/net/bridge/br.c
index 565ff055813b..671d13c10f6f 100644
--- a/net/bridge/br.c
+++ b/net/bridge/br.c
@@ -52,7 +52,7 @@ static int br_device_event(struct notifier_block *unused, unsigned long event, v
 
 	switch (event) {
 	case NETDEV_CHANGEMTU:
-		dev_set_mtu(br->dev, br_mtu(br, false));
+		br_mtu_auto_adjust(br);
 		break;
 
 	case NETDEV_CHANGEADDR:
diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index edb9967eb165..e682a668ce57 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -225,11 +225,10 @@ static int br_change_mtu(struct net_device *dev, int new_mtu)
 {
 	struct net_bridge *br = netdev_priv(dev);
 
-	if (new_mtu > br_mtu(br, br_vlan_enabled(dev)))
-		return -EINVAL;
-
 	dev->mtu = new_mtu;
 
+	/* this flag will be cleared if the MTU was automatically adjusted */
+	br->mtu_set_by_user = true;
 #if IS_ENABLED(CONFIG_BRIDGE_NETFILTER)
 	/* remember the MTU in the rtable for PMTU */
 	dst_metric_set(&br->fake_rtable.dst, RTAX_MTU, new_mtu);
diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index 7d5dc5a91084..82c1a6f430b3 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -424,28 +424,34 @@ int br_del_bridge(struct net *net, const char *name)
 	return ret;
 }
 
-/* MTU of the bridge pseudo-device: ETH_DATA_LEN if there are no ports, the
- * minimum of the ports if @max is false or the maximum if it's true
- */
-int br_mtu(const struct net_bridge *br, bool max)
+/* MTU of the bridge pseudo-device: ETH_DATA_LEN or the minimum of the ports */
+static int br_mtu_min(const struct net_bridge *br)
 {
 	const struct net_bridge_port *p;
 	int ret_mtu = 0;
 
-	ASSERT_RTNL();
-
-	list_for_each_entry(p, &br->port_list, list) {
-		if (!max) {
-			if (!ret_mtu || ret_mtu > p->dev->mtu)
-				ret_mtu = p->dev->mtu;
-		} else if (p->dev->mtu > ret_mtu) {
+	list_for_each_entry(p, &br->port_list, list)
+		if (!ret_mtu || ret_mtu > p->dev->mtu)
 			ret_mtu = p->dev->mtu;
-		}
-	}
 
 	return ret_mtu ? ret_mtu : ETH_DATA_LEN;
 }
 
+void br_mtu_auto_adjust(struct net_bridge *br)
+{
+	ASSERT_RTNL();
+
+	/* if the bridge MTU was manually configured don't mess with it */
+	if (br->mtu_set_by_user)
+		return;
+
+	/* change to the minimum MTU and clear the flag which was set by
+	 * the bridge ndo_change_mtu callback
+	 */
+	dev_set_mtu(br->dev, br_mtu_min(br));
+	br->mtu_set_by_user = false;
+}
+
 static void br_set_gso_limits(struct net_bridge *br)
 {
 	unsigned int gso_max_size = GSO_MAX_SIZE;
@@ -597,7 +603,7 @@ int br_add_if(struct net_bridge *br, struct net_device *dev,
 	if (changed_addr)
 		call_netdevice_notifiers(NETDEV_CHANGEADDR, br->dev);
 
-	dev_set_mtu(br->dev, br_mtu(br, false));
+	br_mtu_auto_adjust(br);
 	br_set_gso_limits(br);
 
 	kobject_uevent(&p->kobj, KOBJ_ADD);
@@ -644,7 +650,7 @@ int br_del_if(struct net_bridge *br, struct net_device *dev)
 	 */
 	del_nbp(p);
 
-	dev_set_mtu(br->dev, br_mtu(br, false));
+	br_mtu_auto_adjust(br);
 	br_set_gso_limits(br);
 
 	spin_lock_bh(&br->lock);
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 586f84b9670d..a7cb3ece5031 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -410,6 +410,7 @@ struct net_bridge {
 	int offload_fwd_mark;
 #endif
 	bool				neigh_suppress_enabled;
+	bool				mtu_set_by_user;
 	struct hlist_head		fdb_list;
 };
 
@@ -578,7 +579,7 @@ int br_del_bridge(struct net *net, const char *name);
 int br_add_if(struct net_bridge *br, struct net_device *dev,
 	      struct netlink_ext_ack *extack);
 int br_del_if(struct net_bridge *br, struct net_device *dev);
-int br_mtu(const struct net_bridge *br, bool max);
+void br_mtu_auto_adjust(struct net_bridge *br);
 netdev_features_t br_features_recompute(struct net_bridge *br,
 					netdev_features_t features);
 void br_port_flags_change(struct net_bridge_port *port, unsigned long mask);
-- 
2.11.0

