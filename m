Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Hlso+TjhoOXEn1JJNL+L6qyVARSaun65Oh1wEAAczk=;
 b=g5U4c2lQrPtov5e2rc+e2VTpSbkNe2F8K8/zuxjhg160AWs+0/76FLr1+WyxTVyyr1yMLtwf5OamjQbqH88clECaPnpicDyzGqoaCPqO/Tq16x5tLk/uEMeSeSivG/dbKXeavTJX2if9da5LzVepgu8mRWEtFW2fVdu/22phf5M=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Tue,  3 Aug 2021 17:36:23 +0300
Message-Id: <20210803143624.1135002-2-vladimir.oltean@nxp.com>
In-Reply-To: <20210803143624.1135002-1-vladimir.oltean@nxp.com>
References: <20210803143624.1135002-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next 1/2] net: make switchdev_bridge_port_{,
	unoffload} loosely coupled with the bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Arnd Bergmann <arnd@kernel.org>, bridge@lists.linux-foundation.org, Ido Schimmel <idosch@idosch.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Vivien Didelot <vivien.didelot@gmail.com>

With the introduction of explicit offloading API in switchdev in commit
2f5dc00f7a3e ("net: bridge: switchdev: let drivers inform which bridge
ports are offloaded"), we started having Ethernet switch drivers calling
directly into a function exported by net/bridge/br_switchdev.c, which is
a function exported by the bridge driver.

This means that drivers that did not have an explicit dependency on the
bridge before, like cpsw and am65-cpsw, now do - otherwise it is not
possible to call a symbol exported by a driver that can be built as
module unless you are a module too.

There was an attempt to solve the dependency issue in the form of commit
b0e81817629a ("net: build all switchdev drivers as modules when the
bridge is a module"). Grygorii Strashko, however, says about it:

| In my opinion, the problem is a bit bigger here than just fixing the
| build :(
|
| In case, of ^cpsw the switchdev mode is kinda optional and in many
| cases (especially for testing purposes, NFS) the multi-mac mode is
| still preferable mode.
|
| There were no such tight dependency between switchdev drivers and
| bridge core before and switchdev serviced as independent, notification
| based layer between them, so ^cpsw still can be "Y" and bridge can be
| "M". Now for mostly every kernel build configuration the CONFIG_BRIDGE
| will need to be set as "Y", or we will have to update drivers to
| support build with BRIDGE=n and maintain separate builds for
| networking vs non-networking testing.  But is this enough?  Wouldn't
| it cause 'chain reaction' required to add more and more "Y" options
| (like CONFIG_VLAN_8021Q)?
|
| PS. Just to be sure we on the same page - ARM builds will be forced
| (with this patch) to have CONFIG_TI_CPSW_SWITCHDEV=m and so all our
| automation testing will just fail with omap2plus_defconfig.

In the light of this, it would be desirable for some configurations to
avoid dependencies between switchdev drivers and the bridge, and have
the switchdev mode as completely optional within the driver.

Arnd Bergmann also tried to write a patch which better expressed the
build time dependency for Ethernet switch drivers where the switchdev
support is optional, like cpsw/am65-cpsw, and this made the drivers
follow the bridge (compile as module if the bridge is a module) only if
the optional switchdev support in the driver was enabled in the first
place:
https://patchwork.kernel.org/project/netdevbpf/patch/20210802144813.1152762-1-arnd@kernel.org/

but this still did not solve the fact that cpsw and am65-cpsw now must
be built as modules when the bridge is a module - it just expressed
correctly that optional dependency. But the new behavior is an apparent
regression from Grygorii's perspective.

So to support the use case where the Ethernet driver is built-in,
NET_SWITCHDEV (a bool option) is enabled, and the bridge is a module, we
need a framework that can handle the possible absence of the bridge from
the running system, i.e. runtime bloatware as opposed to build-time
bloatware.

Luckily we already have this framework, since switchdev has been using
it extensively. Events from the bridge side are transmitted to the
driver side using notifier chains - this was originally done so that
unrelated drivers could snoop for events emitted by the bridge towards
ports that are implemented by other drivers (think of a switch driver
with LAG offload that listens for switchdev events on a bonding/team
interface that it offloads).

There are also events which are transmitted from the driver side to the
bridge side, which again are modeled using notifiers.
SWITCHDEV_FDB_ADD_TO_BRIDGE is an example of this, and deals with
notifying the bridge that a MAC address has been dynamically learned.
So there is a precedent we can use for modeling the new framework.

The difference compared to SWITCHDEV_FDB_ADD_TO_BRIDGE is that the work
that the bridge needs to do when a port becomes offloaded is blocking in
its nature: replay VLANs, MDBs etc. The calling context is indeed
blocking (we are under rtnl_mutex), but the existing switchdev
notification chain that the bridge is subscribed to is only the atomic
one. So we need to subscribe the bridge to the blocking switchdev
notification chain too.

This patch:
- keeps the driver-side perception of the switchdev_bridge_port_{,un}offload
  unchanged
- moves the implementation of switchdev_bridge_port_{,un}offload from
  the bridge module into the switchdev module.
- makes everybody that is subscribed to the switchdev blocking notifier
  chain "hear" offload & unoffload events
- makes the bridge driver subscribe and handle those events
- moves the bridge driver's handling of those events into 2 new
  functions called br_switchdev_port_{,un}offload. These functions
  contain in fact the core of the logic that was previously in
  switchdev_bridge_port_{,un}offload, just that now we go through an
  extra indirection layer to reach them.

Unlike all the other switchdev notification structures, the structure
used to carry the bridge port information, struct
switchdev_notifier_brport_info, does not contain a "bool handled".
This is because in the current usage pattern, we always know that a
switchdev bridge port offloading event will be handled by the bridge,
because the switchdev_bridge_port_offload() call was initiated by a
NETDEV_CHANGEUPPER event in the first place, where info->upper_dev is a
bridge. So if the bridge wasn't loaded, then the CHANGEUPPER event
couldn't have happened.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c |  2 +-
 drivers/net/ethernet/ti/cpsw_new.c       |  2 +-
 include/linux/if_bridge.h                | 35 ----------------
 include/net/switchdev.h                  | 46 +++++++++++++++++++++
 net/bridge/br.c                          | 51 +++++++++++++++++++++++-
 net/bridge/br_private.h                  | 30 ++++++++++++++
 net/bridge/br_switchdev.c                | 36 +++++------------
 net/switchdev/switchdev.c                | 48 ++++++++++++++++++++++
 8 files changed, 185 insertions(+), 65 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 4f67d1a98c0d..fb5d2ac3f0d2 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -7,7 +7,6 @@
 
 #include <linux/clk.h>
 #include <linux/etherdevice.h>
-#include <linux/if_bridge.h>
 #include <linux/if_vlan.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
@@ -28,6 +27,7 @@
 #include <linux/sys_soc.h>
 #include <linux/dma/ti-cppi5.h>
 #include <linux/dma/k3-udma-glue.h>
+#include <net/switchdev.h>
 
 #include "cpsw_ale.h"
 #include "cpsw_sl.h"
diff --git a/drivers/net/ethernet/ti/cpsw_new.c b/drivers/net/ethernet/ti/cpsw_new.c
index b4f55ff4e84f..ae167223e87f 100644
--- a/drivers/net/ethernet/ti/cpsw_new.c
+++ b/drivers/net/ethernet/ti/cpsw_new.c
@@ -11,7 +11,6 @@
 #include <linux/module.h>
 #include <linux/irqreturn.h>
 #include <linux/interrupt.h>
-#include <linux/if_bridge.h>
 #include <linux/if_ether.h>
 #include <linux/etherdevice.h>
 #include <linux/net_tstamp.h>
@@ -29,6 +28,7 @@
 #include <linux/kmemleak.h>
 #include <linux/sys_soc.h>
 
+#include <net/switchdev.h>
 #include <net/page_pool.h>
 #include <net/pkt_cls.h>
 #include <net/devlink.h>
diff --git a/include/linux/if_bridge.h b/include/linux/if_bridge.h
index 21daed10322e..509e18c7e740 100644
--- a/include/linux/if_bridge.h
+++ b/include/linux/if_bridge.h
@@ -190,39 +190,4 @@ static inline clock_t br_get_ageing_time(const struct net_device *br_dev)
 }
 #endif
 
-#if IS_ENABLED(CONFIG_BRIDGE) && IS_ENABLED(CONFIG_NET_SWITCHDEV)
-
-int switchdev_bridge_port_offload(struct net_device *brport_dev,
-				  struct net_device *dev, const void *ctx,
-				  struct notifier_block *atomic_nb,
-				  struct notifier_block *blocking_nb,
-				  bool tx_fwd_offload,
-				  struct netlink_ext_ack *extack);
-void switchdev_bridge_port_unoffload(struct net_device *brport_dev,
-				     const void *ctx,
-				     struct notifier_block *atomic_nb,
-				     struct notifier_block *blocking_nb);
-
-#else
-
-static inline int
-switchdev_bridge_port_offload(struct net_device *brport_dev,
-			      struct net_device *dev, const void *ctx,
-			      struct notifier_block *atomic_nb,
-			      struct notifier_block *blocking_nb,
-			      bool tx_fwd_offload,
-			      struct netlink_ext_ack *extack)
-{
-	return -EINVAL;
-}
-
-static inline void
-switchdev_bridge_port_unoffload(struct net_device *brport_dev,
-				const void *ctx,
-				struct notifier_block *atomic_nb,
-				struct notifier_block *blocking_nb)
-{
-}
-#endif
-
 #endif
diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index 66468ff8cc0a..60d806b6a5ae 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -180,6 +180,14 @@ struct switchdev_obj_in_state_mrp {
 
 typedef int switchdev_obj_dump_cb_t(struct switchdev_obj *obj);
 
+struct switchdev_brport {
+	struct net_device *dev;
+	const void *ctx;
+	struct notifier_block *atomic_nb;
+	struct notifier_block *blocking_nb;
+	bool tx_fwd_offload;
+};
+
 enum switchdev_notifier_type {
 	SWITCHDEV_FDB_ADD_TO_BRIDGE = 1,
 	SWITCHDEV_FDB_DEL_TO_BRIDGE,
@@ -197,6 +205,9 @@ enum switchdev_notifier_type {
 	SWITCHDEV_VXLAN_FDB_ADD_TO_DEVICE,
 	SWITCHDEV_VXLAN_FDB_DEL_TO_DEVICE,
 	SWITCHDEV_VXLAN_FDB_OFFLOADED,
+
+	SWITCHDEV_BRPORT_OFFLOADED,
+	SWITCHDEV_BRPORT_UNOFFLOADED,
 };
 
 struct switchdev_notifier_info {
@@ -226,6 +237,11 @@ struct switchdev_notifier_port_attr_info {
 	bool handled;
 };
 
+struct switchdev_notifier_brport_info {
+	struct switchdev_notifier_info info; /* must be first */
+	const struct switchdev_brport brport;
+};
+
 static inline struct net_device *
 switchdev_notifier_info_to_dev(const struct switchdev_notifier_info *info)
 {
@@ -246,6 +262,17 @@ switchdev_fdb_is_dynamically_learned(const struct switchdev_notifier_fdb_info *f
 
 #ifdef CONFIG_NET_SWITCHDEV
 
+int switchdev_bridge_port_offload(struct net_device *brport_dev,
+				  struct net_device *dev, const void *ctx,
+				  struct notifier_block *atomic_nb,
+				  struct notifier_block *blocking_nb,
+				  bool tx_fwd_offload,
+				  struct netlink_ext_ack *extack);
+void switchdev_bridge_port_unoffload(struct net_device *brport_dev,
+				     const void *ctx,
+				     struct notifier_block *atomic_nb,
+				     struct notifier_block *blocking_nb);
+
 void switchdev_deferred_process(void);
 int switchdev_port_attr_set(struct net_device *dev,
 			    const struct switchdev_attr *attr,
@@ -316,6 +343,25 @@ int switchdev_handle_port_attr_set(struct net_device *dev,
 				      struct netlink_ext_ack *extack));
 #else
 
+static inline int
+switchdev_bridge_port_offload(struct net_device *brport_dev,
+			      struct net_device *dev, const void *ctx,
+			      struct notifier_block *atomic_nb,
+			      struct notifier_block *blocking_nb,
+			      bool tx_fwd_offload,
+			      struct netlink_ext_ack *extack)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void
+switchdev_bridge_port_unoffload(struct net_device *brport_dev,
+				const void *ctx,
+				struct notifier_block *atomic_nb,
+				struct notifier_block *blocking_nb)
+{
+}
+
 static inline void switchdev_deferred_process(void)
 {
 }
diff --git a/net/bridge/br.c b/net/bridge/br.c
index 8fb5dca5f8e0..d3a32c6813e0 100644
--- a/net/bridge/br.c
+++ b/net/bridge/br.c
@@ -201,6 +201,48 @@ static struct notifier_block br_switchdev_notifier = {
 	.notifier_call = br_switchdev_event,
 };
 
+/* called under rtnl_mutex */
+static int br_switchdev_blocking_event(struct notifier_block *nb,
+				       unsigned long event, void *ptr)
+{
+	struct netlink_ext_ack *extack = netdev_notifier_info_to_extack(ptr);
+	struct net_device *dev = switchdev_notifier_info_to_dev(ptr);
+	struct switchdev_notifier_brport_info *brport_info;
+	const struct switchdev_brport *b;
+	struct net_bridge_port *p;
+	int err = NOTIFY_DONE;
+
+	p = br_port_get_rtnl(dev);
+	if (!p)
+		goto out;
+
+	switch (event) {
+	case SWITCHDEV_BRPORT_OFFLOADED:
+		brport_info = ptr;
+		b = &brport_info->brport;
+
+		err = br_switchdev_port_offload(p, b->dev, b->ctx,
+						b->atomic_nb, b->blocking_nb,
+						b->tx_fwd_offload, extack);
+		err = notifier_from_errno(err);
+		break;
+	case SWITCHDEV_BRPORT_UNOFFLOADED:
+		brport_info = ptr;
+		b = &brport_info->brport;
+
+		br_switchdev_port_unoffload(p, b->ctx, b->atomic_nb,
+					    b->blocking_nb);
+		break;
+	}
+
+out:
+	return err;
+}
+
+static struct notifier_block br_switchdev_blocking_notifier = {
+	.notifier_call = br_switchdev_blocking_event,
+};
+
 /* br_boolopt_toggle - change user-controlled boolean option
  *
  * @br: bridge device
@@ -355,10 +397,14 @@ static int __init br_init(void)
 	if (err)
 		goto err_out4;
 
-	err = br_netlink_init();
+	err = register_switchdev_blocking_notifier(&br_switchdev_blocking_notifier);
 	if (err)
 		goto err_out5;
 
+	err = br_netlink_init();
+	if (err)
+		goto err_out6;
+
 	brioctl_set(br_ioctl_stub);
 
 #if IS_ENABLED(CONFIG_ATM_LANE)
@@ -373,6 +419,8 @@ static int __init br_init(void)
 
 	return 0;
 
+err_out6:
+	unregister_switchdev_blocking_notifier(&br_switchdev_blocking_notifier);
 err_out5:
 	unregister_switchdev_notifier(&br_switchdev_notifier);
 err_out4:
@@ -392,6 +440,7 @@ static void __exit br_deinit(void)
 {
 	stp_proto_unregister(&br_stp_proto);
 	br_netlink_fini();
+	unregister_switchdev_blocking_notifier(&br_switchdev_blocking_notifier);
 	unregister_switchdev_notifier(&br_switchdev_notifier);
 	unregister_netdevice_notifier(&br_device_notifier);
 	brioctl_set(NULL);
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index c939631428b9..c9bb710cf493 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -1880,6 +1880,17 @@ static inline void br_sysfs_delbr(struct net_device *dev) { return; }
 
 /* br_switchdev.c */
 #ifdef CONFIG_NET_SWITCHDEV
+int br_switchdev_port_offload(struct net_bridge_port *p,
+			      struct net_device *dev, const void *ctx,
+			      struct notifier_block *atomic_nb,
+			      struct notifier_block *blocking_nb,
+			      bool tx_fwd_offload,
+			      struct netlink_ext_ack *extack);
+
+void br_switchdev_port_unoffload(struct net_bridge_port *p, const void *ctx,
+				 struct notifier_block *atomic_nb,
+				 struct notifier_block *blocking_nb);
+
 bool br_switchdev_frame_uses_tx_fwd_offload(struct sk_buff *skb);
 
 void br_switchdev_frame_set_offload_fwd_mark(struct sk_buff *skb);
@@ -1908,6 +1919,25 @@ static inline void br_switchdev_frame_unmark(struct sk_buff *skb)
 	skb->offload_fwd_mark = 0;
 }
 #else
+static inline int
+br_switchdev_port_offload(struct net_bridge_port *p,
+			  struct net_device *dev, const void *ctx,
+			  struct notifier_block *atomic_nb,
+			  struct notifier_block *blocking_nb,
+			  bool tx_fwd_offload,
+			  struct netlink_ext_ack *extack)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void
+br_switchdev_port_unoffload(struct net_bridge_port *p, const void *ctx,
+			    struct notifier_block *atomic_nb,
+			    struct notifier_block *blocking_nb)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline bool br_switchdev_frame_uses_tx_fwd_offload(struct sk_buff *skb)
 {
 	return false;
diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index a3cd79e3e81c..97129f09a5bf 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -315,23 +315,16 @@ static void nbp_switchdev_unsync_objs(struct net_bridge_port *p,
 /* Let the bridge know that this port is offloaded, so that it can assign a
  * switchdev hardware domain to it.
  */
-int switchdev_bridge_port_offload(struct net_device *brport_dev,
-				  struct net_device *dev, const void *ctx,
-				  struct notifier_block *atomic_nb,
-				  struct notifier_block *blocking_nb,
-				  bool tx_fwd_offload,
-				  struct netlink_ext_ack *extack)
+int br_switchdev_port_offload(struct net_bridge_port *p,
+			      struct net_device *dev, const void *ctx,
+			      struct notifier_block *atomic_nb,
+			      struct notifier_block *blocking_nb,
+			      bool tx_fwd_offload,
+			      struct netlink_ext_ack *extack)
 {
 	struct netdev_phys_item_id ppid;
-	struct net_bridge_port *p;
 	int err;
 
-	ASSERT_RTNL();
-
-	p = br_port_get_rtnl(brport_dev);
-	if (!p)
-		return -ENODEV;
-
 	err = dev_get_port_parent_id(dev, &ppid, false);
 	if (err)
 		return err;
@@ -351,23 +344,12 @@ int switchdev_bridge_port_offload(struct net_device *brport_dev,
 
 	return err;
 }
-EXPORT_SYMBOL_GPL(switchdev_bridge_port_offload);
 
-void switchdev_bridge_port_unoffload(struct net_device *brport_dev,
-				     const void *ctx,
-				     struct notifier_block *atomic_nb,
-				     struct notifier_block *blocking_nb)
+void br_switchdev_port_unoffload(struct net_bridge_port *p, const void *ctx,
+				 struct notifier_block *atomic_nb,
+				 struct notifier_block *blocking_nb)
 {
-	struct net_bridge_port *p;
-
-	ASSERT_RTNL();
-
-	p = br_port_get_rtnl(brport_dev);
-	if (!p)
-		return;
-
 	nbp_switchdev_unsync_objs(p, ctx, atomic_nb, blocking_nb);
 
 	nbp_switchdev_del(p);
 }
-EXPORT_SYMBOL_GPL(switchdev_bridge_port_unoffload);
diff --git a/net/switchdev/switchdev.c b/net/switchdev/switchdev.c
index 0ae3478561f4..0b2c18efc079 100644
--- a/net/switchdev/switchdev.c
+++ b/net/switchdev/switchdev.c
@@ -809,3 +809,51 @@ int switchdev_handle_port_attr_set(struct net_device *dev,
 	return err;
 }
 EXPORT_SYMBOL_GPL(switchdev_handle_port_attr_set);
+
+int switchdev_bridge_port_offload(struct net_device *brport_dev,
+				  struct net_device *dev, const void *ctx,
+				  struct notifier_block *atomic_nb,
+				  struct notifier_block *blocking_nb,
+				  bool tx_fwd_offload,
+				  struct netlink_ext_ack *extack)
+{
+	struct switchdev_notifier_brport_info brport_info = {
+		.brport = {
+			.dev = dev,
+			.ctx = ctx,
+			.atomic_nb = atomic_nb,
+			.blocking_nb = blocking_nb,
+			.tx_fwd_offload = tx_fwd_offload,
+		},
+	};
+	int err;
+
+	ASSERT_RTNL();
+
+	err = call_switchdev_blocking_notifiers(SWITCHDEV_BRPORT_OFFLOADED,
+						brport_dev, &brport_info.info,
+						extack);
+	return notifier_to_errno(err);
+}
+EXPORT_SYMBOL_GPL(switchdev_bridge_port_offload);
+
+void switchdev_bridge_port_unoffload(struct net_device *brport_dev,
+				     const void *ctx,
+				     struct notifier_block *atomic_nb,
+				     struct notifier_block *blocking_nb)
+{
+	struct switchdev_notifier_brport_info brport_info = {
+		.brport = {
+			.ctx = ctx,
+			.atomic_nb = atomic_nb,
+			.blocking_nb = blocking_nb,
+		},
+	};
+
+	ASSERT_RTNL();
+
+	call_switchdev_blocking_notifiers(SWITCHDEV_BRPORT_UNOFFLOADED,
+					  brport_dev, &brport_info.info,
+					  NULL);
+}
+EXPORT_SYMBOL_GPL(switchdev_bridge_port_unoffload);
-- 
2.25.1

