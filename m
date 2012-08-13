Return-Path: <jiri@resnulli.us>
From: Jiri Pirko <jiri@resnulli.us>
Message-Id: <1344871635-1052-15-git-send-email-jiri@resnulli.us>
In-Reply-To: <1344871635-1052-1-git-send-email-jiri@resnulli.us>
References: <1344871635-1052-1-git-send-email-jiri@resnulli.us>
Subject: [Bridge] [patch net-next 14/16] net: remove no longer used
	netdev_set_bond_master() and netdev_set_master()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Mon, 13 Aug 2012 15:27:58 -0000
To: netdev@vger.kernel.org
Cc: bridge@lists.linux-foundation.org, ursula.braun@de.ibm.com, john.r.fastabend@intel.com, edumazet@google.com, shemminger@vyatta.com, sean.hefty@intel.com, therbert@google.com, roland@kernel.org, linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org, fubar@us.ibm.com, fbl@redhat.com, hal.rosenstock@gmail.com, faisal.latif@intel.com, sony.chacko@qlogic.com, blaschka@linux.vnet.ibm.com, gregory.v.rose@intel.com, bhutchings@solarflare.com, xiyou.wangcong@gmail.com, jitendra.kalsaria@qlogic.com, divy@chelsio.com, linux-driver@qlogic.com, linux-kernel@vger.kernel.org, kaber@trash.net, joe@perches.com, linux390@de.ibm.com, davem@davemloft.net

Signed-off-by: Jiri Pirko <jiri@resnulli.us>
---
 include/linux/netdevice.h |    6 +----
 net/core/dev.c            |   63 ---------------------------------------------
 2 files changed, 1 insertion(+), 68 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index e7a07f8..757f627 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -886,8 +886,7 @@ struct netdev_fcoe_hbainfo {
  *	flow_id is a flow ID to be passed to rps_may_expire_flow() later.
  *	Return the filter ID on success, or a negative error code.
  *
- *	Slave management functions (for bridge, bonding, etc). User should
- *	call netdev_set_master() to set dev->master properly.
+ *	Slave management functions (for bridge, bonding, etc).
  * int (*ndo_add_slave)(struct net_device *dev, struct net_device *slave_dev);
  *	Called to make another netdev an underling.
  *
@@ -2625,9 +2624,6 @@ extern int netdev_unique_upper_dev_link(struct net_device *dev,
 					struct net_device *upper_dev);
 extern void netdev_upper_dev_unlink(struct net_device *dev,
 				    struct net_device *upper_dev);
-extern int		netdev_set_master(struct net_device *dev, struct net_device *master);
-extern int netdev_set_bond_master(struct net_device *dev,
-				  struct net_device *master);
 extern int skb_checksum_help(struct sk_buff *skb);
 extern struct sk_buff *skb_gso_segment(struct sk_buff *skb,
 	netdev_features_t features);
diff --git a/net/core/dev.c b/net/core/dev.c
index 68db1ac..c0f9adb 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4648,69 +4648,6 @@ void netdev_upper_dev_unlink(struct net_device *dev,
 }
 EXPORT_SYMBOL(netdev_upper_dev_unlink);
 
-/**
- *	netdev_set_master	-	set up master pointer
- *	@slave: slave device
- *	@master: new master device
- *
- *	Changes the master device of the slave. Pass %NULL to break the
- *	bonding. The caller must hold the RTNL semaphore. On a failure
- *	a negative errno code is returned. On success the reference counts
- *	are adjusted and the function returns zero.
- */
-int netdev_set_master(struct net_device *slave, struct net_device *master)
-{
-	struct net_device *old = slave->master;
-	int err;
-
-	ASSERT_RTNL();
-
-	if (master) {
-		if (old)
-			return -EBUSY;
-		err = netdev_unique_upper_dev_link(slave, master);
-		if (err)
-			return err;
-	}
-
-	slave->master = master;
-
-	if (old)
-		netdev_upper_dev_unlink(slave, master);
-
-	return 0;
-}
-EXPORT_SYMBOL(netdev_set_master);
-
-/**
- *	netdev_set_bond_master	-	set up bonding master/slave pair
- *	@slave: slave device
- *	@master: new master device
- *
- *	Changes the master device of the slave. Pass %NULL to break the
- *	bonding. The caller must hold the RTNL semaphore. On a failure
- *	a negative errno code is returned. On success %RTM_NEWLINK is sent
- *	to the routing socket and the function returns zero.
- */
-int netdev_set_bond_master(struct net_device *slave, struct net_device *master)
-{
-	int err;
-
-	ASSERT_RTNL();
-
-	err = netdev_set_master(slave, master);
-	if (err)
-		return err;
-	if (master)
-		slave->flags |= IFF_SLAVE;
-	else
-		slave->flags &= ~IFF_SLAVE;
-
-	rtmsg_ifinfo(RTM_NEWLINK, slave, IFF_SLAVE);
-	return 0;
-}
-EXPORT_SYMBOL(netdev_set_bond_master);
-
 static void dev_change_rx_flags(struct net_device *dev, int flags)
 {
 	const struct net_device_ops *ops = dev->netdev_ops;
-- 
1.7.10.4

