Return-Path: <root@6wind.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Date: Tue, 28 Apr 2015 18:33:49 +0200
Message-Id: <1430238831-29966-3-git-send-email-nicolas.dichtel@6wind.com>
In-Reply-To: <1430238831-29966-1-git-send-email-nicolas.dichtel@6wind.com>
References: <1430238831-29966-1-git-send-email-nicolas.dichtel@6wind.com>
Subject: [Bridge] [PATCH net 2/3] bridge/nl: remove wrong use of NLM_F_MULTI
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Jiri Pirko <jiri@resnulli.us>, Sathya Perla <sathya.perla@emulex.com>, bridge@lists.linux-foundation.org, Ajit Khaparde <ajit.khaparde@emulex.com>, John Fastabend <john.r.fastabend@intel.com>, Scott Feldman <sfeldma@gmail.com>, intel-wired-lan@lists.osuosl.org, Jeff Kirsher <jeffrey.t.kirsher@intel.com>, dmitry.tarnyaginuug.ch@6wind.com, Nicolas Dichtel <nicolas.dichtel@6wind.com>, Subbu Seetharaman <subbu.seetharaman@emulex.com>, davem@davemloft.net

NLM_F_MULTI must be used only when a NLMSG_DONE message is sent. In fact,
it is sent only at the end of a dump.

Libraries like libnl will wait forever for NLMSG_DONE.

Fixes: e5a55a898720 ("net: create generic bridge ops")
Fixes: 815cccbf10b2 ("ixgbe: add setlink, getlink support to ixgbe and ixgbevf")
CC: John Fastabend <john.r.fastabend@intel.com>
CC: Sathya Perla <sathya.perla@emulex.com>
CC: Subbu Seetharaman <subbu.seetharaman@emulex.com>
CC: Ajit Khaparde <ajit.khaparde@emulex.com>
CC: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
CC: intel-wired-lan@lists.osuosl.org
CC: Jiri Pirko <jiri@resnulli.us>
CC: Scott Feldman <sfeldma@gmail.com>
CC: Stephen Hemminger <stephen@networkplumber.org>
CC: bridge@lists.linux-foundation.org
Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
---
 drivers/net/ethernet/emulex/benet/be_main.c   |  5 +++--
 drivers/net/ethernet/intel/i40e/i40e_main.c   |  7 ++++---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  4 ++--
 drivers/net/ethernet/rocker/rocker.c          |  5 +++--
 include/linux/netdevice.h                     |  6 ++++--
 include/linux/rtnetlink.h                     |  2 +-
 net/bridge/br_netlink.c                       |  4 ++--
 net/bridge/br_private.h                       |  2 +-
 net/core/rtnetlink.c                          | 12 +++++++-----
 9 files changed, 27 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/emulex/benet/be_main.c b/drivers/net/ethernet/emulex/benet/be_main.c
index fb0bc3c3620e..a6dcbf850c1f 100644
--- a/drivers/net/ethernet/emulex/benet/be_main.c
+++ b/drivers/net/ethernet/emulex/benet/be_main.c
@@ -4846,7 +4846,8 @@ err:
 }
 
 static int be_ndo_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
-				 struct net_device *dev, u32 filter_mask)
+				 struct net_device *dev, u32 filter_mask,
+				 int nlflags)
 {
 	struct be_adapter *adapter = netdev_priv(dev);
 	int status = 0;
@@ -4868,7 +4869,7 @@ static int be_ndo_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
 	return ndo_dflt_bridge_getlink(skb, pid, seq, dev,
 				       hsw_mode == PORT_FWD_TYPE_VEPA ?
 				       BRIDGE_MODE_VEPA : BRIDGE_MODE_VEB,
-				       0, 0);
+				       0, 0, nlflags);
 }
 
 #ifdef CONFIG_BE2NET_VXLAN
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 24481cd7e59a..a54c14491e3b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -8053,10 +8053,10 @@ static int i40e_ndo_bridge_setlink(struct net_device *dev,
 #ifdef HAVE_BRIDGE_FILTER
 static int i40e_ndo_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
 				   struct net_device *dev,
-				   u32 __always_unused filter_mask)
+				   u32 __always_unused filter_mask, int nlflags)
 #else
 static int i40e_ndo_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
-				   struct net_device *dev)
+				   struct net_device *dev, int nlflags)
 #endif /* HAVE_BRIDGE_FILTER */
 {
 	struct i40e_netdev_priv *np = netdev_priv(dev);
@@ -8078,7 +8078,8 @@ static int i40e_ndo_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
 	if (!veb)
 		return 0;
 
-	return ndo_dflt_bridge_getlink(skb, pid, seq, dev, veb->bridge_mode);
+	return ndo_dflt_bridge_getlink(skb, pid, seq, dev, veb->bridge_mode,
+				       nlflags);
 }
 #endif /* HAVE_BRIDGE_ATTRIBS */
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index d3f4b0ceb3f7..5be12a00e1f4 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -8044,7 +8044,7 @@ static int ixgbe_ndo_bridge_setlink(struct net_device *dev,
 
 static int ixgbe_ndo_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
 				    struct net_device *dev,
-				    u32 filter_mask)
+				    u32 filter_mask, int nlflags)
 {
 	struct ixgbe_adapter *adapter = netdev_priv(dev);
 
@@ -8052,7 +8052,7 @@ static int ixgbe_ndo_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
 		return 0;
 
 	return ndo_dflt_bridge_getlink(skb, pid, seq, dev,
-				       adapter->bridge_mode, 0, 0);
+				       adapter->bridge_mode, 0, 0, nlflags);
 }
 
 static void *ixgbe_fwd_add(struct net_device *pdev, struct net_device *vdev)
diff --git a/drivers/net/ethernet/rocker/rocker.c b/drivers/net/ethernet/rocker/rocker.c
index a570a60533be..ec251531bd9f 100644
--- a/drivers/net/ethernet/rocker/rocker.c
+++ b/drivers/net/ethernet/rocker/rocker.c
@@ -4176,14 +4176,15 @@ static int rocker_port_bridge_setlink(struct net_device *dev,
 
 static int rocker_port_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
 				      struct net_device *dev,
-				      u32 filter_mask)
+				      u32 filter_mask, int nlflags)
 {
 	struct rocker_port *rocker_port = netdev_priv(dev);
 	u16 mode = BRIDGE_MODE_UNDEF;
 	u32 mask = BR_LEARNING | BR_LEARNING_SYNC;
 
 	return ndo_dflt_bridge_getlink(skb, pid, seq, dev, mode,
-				       rocker_port->brport_flags, mask);
+				       rocker_port->brport_flags, mask,
+				       nlflags);
 }
 
 static int rocker_port_get_phys_port_name(struct net_device *dev,
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index dbad4d728b4b..1899c74a7127 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -977,7 +977,8 @@ typedef u16 (*select_queue_fallback_t)(struct net_device *dev,
  * int (*ndo_bridge_setlink)(struct net_device *dev, struct nlmsghdr *nlh,
  *			     u16 flags)
  * int (*ndo_bridge_getlink)(struct sk_buff *skb, u32 pid, u32 seq,
- *			     struct net_device *dev, u32 filter_mask)
+ *			     struct net_device *dev, u32 filter_mask,
+ *			     int nlflags)
  * int (*ndo_bridge_dellink)(struct net_device *dev, struct nlmsghdr *nlh,
  *			     u16 flags);
  *
@@ -1173,7 +1174,8 @@ struct net_device_ops {
 	int			(*ndo_bridge_getlink)(struct sk_buff *skb,
 						      u32 pid, u32 seq,
 						      struct net_device *dev,
-						      u32 filter_mask);
+						      u32 filter_mask,
+						      int nlflags);
 	int			(*ndo_bridge_dellink)(struct net_device *dev,
 						      struct nlmsghdr *nlh,
 						      u16 flags);
diff --git a/include/linux/rtnetlink.h b/include/linux/rtnetlink.h
index 2da5d1081ad9..7b8e260c4a27 100644
--- a/include/linux/rtnetlink.h
+++ b/include/linux/rtnetlink.h
@@ -122,5 +122,5 @@ extern int ndo_dflt_fdb_del(struct ndmsg *ndm,
 
 extern int ndo_dflt_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
 				   struct net_device *dev, u16 mode,
-				   u32 flags, u32 mask);
+				   u32 flags, u32 mask, int nlflags);
 #endif	/* __LINUX_RTNETLINK_H */
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 0e4ddb81610d..4b5c236998ff 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -394,7 +394,7 @@ errout:
  * Dump information about all ports, in response to GETLINK
  */
 int br_getlink(struct sk_buff *skb, u32 pid, u32 seq,
-	       struct net_device *dev, u32 filter_mask)
+	       struct net_device *dev, u32 filter_mask, int nlflags)
 {
 	struct net_bridge_port *port = br_port_get_rtnl(dev);
 
@@ -402,7 +402,7 @@ int br_getlink(struct sk_buff *skb, u32 pid, u32 seq,
 	    !(filter_mask & RTEXT_FILTER_BRVLAN_COMPRESSED))
 		return 0;
 
-	return br_fill_ifinfo(skb, port, pid, seq, RTM_NEWLINK, NLM_F_MULTI,
+	return br_fill_ifinfo(skb, port, pid, seq, RTM_NEWLINK, nlflags,
 			      filter_mask, dev);
 }
 
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 6ca0251cb478..3362c29400f1 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -828,7 +828,7 @@ void br_ifinfo_notify(int event, struct net_bridge_port *port);
 int br_setlink(struct net_device *dev, struct nlmsghdr *nlmsg, u16 flags);
 int br_dellink(struct net_device *dev, struct nlmsghdr *nlmsg, u16 flags);
 int br_getlink(struct sk_buff *skb, u32 pid, u32 seq, struct net_device *dev,
-	       u32 filter_mask);
+	       u32 filter_mask, int nlflags);
 
 #ifdef CONFIG_SYSFS
 /* br_sysfs_if.c */
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 358d52a38533..666e0928ba40 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -2854,7 +2854,7 @@ static int brport_nla_put_flag(struct sk_buff *skb, u32 flags, u32 mask,
 
 int ndo_dflt_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
 			    struct net_device *dev, u16 mode,
-			    u32 flags, u32 mask)
+			    u32 flags, u32 mask, int nlflags)
 {
 	struct nlmsghdr *nlh;
 	struct ifinfomsg *ifm;
@@ -2863,7 +2863,7 @@ int ndo_dflt_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
 	u8 operstate = netif_running(dev) ? dev->operstate : IF_OPER_DOWN;
 	struct net_device *br_dev = netdev_master_upper_dev_get(dev);
 
-	nlh = nlmsg_put(skb, pid, seq, RTM_NEWLINK, sizeof(*ifm), NLM_F_MULTI);
+	nlh = nlmsg_put(skb, pid, seq, RTM_NEWLINK, sizeof(*ifm), nlflags);
 	if (nlh == NULL)
 		return -EMSGSIZE;
 
@@ -2969,7 +2969,8 @@ static int rtnl_bridge_getlink(struct sk_buff *skb, struct netlink_callback *cb)
 		if (br_dev && br_dev->netdev_ops->ndo_bridge_getlink) {
 			if (idx >= cb->args[0] &&
 			    br_dev->netdev_ops->ndo_bridge_getlink(
-				    skb, portid, seq, dev, filter_mask) < 0)
+				    skb, portid, seq, dev, filter_mask,
+				    NLM_F_MULTI) < 0)
 				break;
 			idx++;
 		}
@@ -2977,7 +2978,8 @@ static int rtnl_bridge_getlink(struct sk_buff *skb, struct netlink_callback *cb)
 		if (ops->ndo_bridge_getlink) {
 			if (idx >= cb->args[0] &&
 			    ops->ndo_bridge_getlink(skb, portid, seq, dev,
-						    filter_mask) < 0)
+						    filter_mask,
+						    NLM_F_MULTI) < 0)
 				break;
 			idx++;
 		}
@@ -3018,7 +3020,7 @@ static int rtnl_bridge_notify(struct net_device *dev)
 		goto errout;
 	}
 
-	err = dev->netdev_ops->ndo_bridge_getlink(skb, 0, 0, dev, 0);
+	err = dev->netdev_ops->ndo_bridge_getlink(skb, 0, 0, dev, 0, 0);
 	if (err < 0)
 		goto errout;
 
-- 
2.2.2

