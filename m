Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=LPJbNsl/uINmkZPr/vZ+3ji3t1MfT0BGoVO/IakGxhk=;
	b=H8sFU9V6vND9Ld+TXG73VVH9sadXCGdAZXkhLGnn+3WamA4smKRNIUjTRSkxxM80uZ
	J0VsRKc5NGBou3Zd9trunEfiDL6v5MRkGx3QG0+07wfnh+d4fg1qP8VNp1rZcvEcU2k1
	HlTDJH4xTrUzLm98thAVDqeASf/S5HH0F4/44=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Fri, 30 Mar 2018 13:46:18 +0300
Message-Id: <20180330104619.31479-2-nikolay@cumulusnetworks.com>
In-Reply-To: <20180330104619.31479-1-nikolay@cumulusnetworks.com>
References: <20180330104619.31479-1-nikolay@cumulusnetworks.com>
Subject: [Bridge] [PATCH net-next 1/2] net: bridge: set min MTU on port
	events and allow user to set max
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

Recently the bridge was changed to automatically set maximum MTU on port
events (add/del/changemtu) when vlan filtering is enabled, but that
actually changes behaviour in a way which breaks some setups and can lead
to packet drops. In order to still allow that maximum to be set while being
compatible, we add the ability for the user to tune the bridge MTU up to
the maximum when vlan filtering is enabled, but that has to be done
explicitly and all port events (add/del/changemtu) lead to resetting that
MTU to the minimum as before.

Suggested-by: Roopa Prabhu <roopa@cumulusnetworks.com>
Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 net/bridge/br.c         |  2 +-
 net/bridge/br_device.c  |  3 ++-
 net/bridge/br_if.c      | 43 ++++++++++++++-----------------------------
 net/bridge/br_private.h |  2 +-
 4 files changed, 18 insertions(+), 32 deletions(-)

diff --git a/net/bridge/br.c b/net/bridge/br.c
index 26e1616b2c90..565ff055813b 100644
--- a/net/bridge/br.c
+++ b/net/bridge/br.c
@@ -52,7 +52,7 @@ static int br_device_event(struct notifier_block *unused, unsigned long event, v
 
 	switch (event) {
 	case NETDEV_CHANGEMTU:
-		dev_set_mtu(br->dev, br_mtu(br));
+		dev_set_mtu(br->dev, br_mtu(br, false));
 		break;
 
 	case NETDEV_CHANGEADDR:
diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index 278fc999d355..edb9967eb165 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -224,7 +224,8 @@ static void br_get_stats64(struct net_device *dev,
 static int br_change_mtu(struct net_device *dev, int new_mtu)
 {
 	struct net_bridge *br = netdev_priv(dev);
-	if (new_mtu > br_mtu(br))
+
+	if (new_mtu > br_mtu(br, br_vlan_enabled(dev)))
 		return -EINVAL;
 
 	dev->mtu = new_mtu;
diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index 87b2afd455c7..7d5dc5a91084 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -424,41 +424,26 @@ int br_del_bridge(struct net *net, const char *name)
 	return ret;
 }
 
-static bool min_mtu(int a, int b)
-{
-	return a < b ? 1 : 0;
-}
-
-static bool max_mtu(int a, int b)
-{
-	return a > b ? 1 : 0;
-}
-
-/* MTU of the bridge pseudo-device: ETH_DATA_LEN or the minimum of the ports */
-static int __br_mtu(const struct net_bridge *br, bool (compare_fn)(int, int))
+/* MTU of the bridge pseudo-device: ETH_DATA_LEN if there are no ports, the
+ * minimum of the ports if @max is false or the maximum if it's true
+ */
+int br_mtu(const struct net_bridge *br, bool max)
 {
 	const struct net_bridge_port *p;
-	int mtu = 0;
+	int ret_mtu = 0;
 
 	ASSERT_RTNL();
 
-	if (list_empty(&br->port_list))
-		mtu = ETH_DATA_LEN;
-	else {
-		list_for_each_entry(p, &br->port_list, list) {
-			if (!mtu || compare_fn(p->dev->mtu, mtu))
-				mtu = p->dev->mtu;
+	list_for_each_entry(p, &br->port_list, list) {
+		if (!max) {
+			if (!ret_mtu || ret_mtu > p->dev->mtu)
+				ret_mtu = p->dev->mtu;
+		} else if (p->dev->mtu > ret_mtu) {
+			ret_mtu = p->dev->mtu;
 		}
 	}
-	return mtu;
-}
 
-int br_mtu(const struct net_bridge *br)
-{
-	if (br_vlan_enabled(br->dev))
-		return __br_mtu(br, max_mtu);
-	else
-		return __br_mtu(br, min_mtu);
+	return ret_mtu ? ret_mtu : ETH_DATA_LEN;
 }
 
 static void br_set_gso_limits(struct net_bridge *br)
@@ -612,7 +597,7 @@ int br_add_if(struct net_bridge *br, struct net_device *dev,
 	if (changed_addr)
 		call_netdevice_notifiers(NETDEV_CHANGEADDR, br->dev);
 
-	dev_set_mtu(br->dev, br_mtu(br));
+	dev_set_mtu(br->dev, br_mtu(br, false));
 	br_set_gso_limits(br);
 
 	kobject_uevent(&p->kobj, KOBJ_ADD);
@@ -659,7 +644,7 @@ int br_del_if(struct net_bridge *br, struct net_device *dev)
 	 */
 	del_nbp(p);
 
-	dev_set_mtu(br->dev, br_mtu(br));
+	dev_set_mtu(br->dev, br_mtu(br, false));
 	br_set_gso_limits(br);
 
 	spin_lock_bh(&br->lock);
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 048d5b51813b..586f84b9670d 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -578,7 +578,7 @@ int br_del_bridge(struct net *net, const char *name);
 int br_add_if(struct net_bridge *br, struct net_device *dev,
 	      struct netlink_ext_ack *extack);
 int br_del_if(struct net_bridge *br, struct net_device *dev);
-int br_mtu(const struct net_bridge *br);
+int br_mtu(const struct net_bridge *br, bool max);
 netdev_features_t br_features_recompute(struct net_bridge *br,
 					netdev_features_t features);
 void br_port_flags_change(struct net_bridge_port *port, unsigned long mask);
-- 
2.11.0

