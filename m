Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dUkOP7QksTdvVdV7xF5imq5aam17tvE4PnomgW4NShk=;
 b=CV1+WPCNVsN7M4sOno25ko5DOvprwYghWT4jJPxZ9j6AMfffm51SKQMdkmgQFG9kxDV6DluXaxgbaBdSEoC0GgZ6J4fnlfY2az/jMJBxN24tdm8zCGpKr3RNRFVpXOUyRsgvmBhlbKHzOQBTVJNfpiQzDbb772ekw2UzOtNLF38=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Mon, 12 Jul 2021 18:21:32 +0300
Message-Id: <20210712152142.800651-15-vladimir.oltean@nxp.com>
In-Reply-To: <20210712152142.800651-1-vladimir.oltean@nxp.com>
References: <20210712152142.800651-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [RFC PATCH v3 net-next 14/24] net: bridge: unexport
	call_switchdev_blocking_notifiers
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, bridge@lists.linux-foundation.org, Ido Schimmel <idosch@idosch.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Vivien Didelot <vivien.didelot@gmail.com>, Tobias Waldekranz <tobias@waldekranz.com>

As opposed to the atomic call_switchdev_notifiers(), the blocking
variant is not called by anyone outside switchdev.c. So unexport it.

Note that we need to move it above the first caller,
switchdev_port_attr_notify(), to avoid a forward-declaration.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 include/net/switchdev.h   | 12 ------------
 net/switchdev/switchdev.c | 28 ++++++++++++++--------------
 2 files changed, 14 insertions(+), 26 deletions(-)

diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index e4cac9218ce1..68face5dca91 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -258,9 +258,6 @@ int call_switchdev_notifiers(unsigned long val, struct net_device *dev,
 
 int register_switchdev_blocking_notifier(struct notifier_block *nb);
 int unregister_switchdev_blocking_notifier(struct notifier_block *nb);
-int call_switchdev_blocking_notifiers(unsigned long val, struct net_device *dev,
-				      struct switchdev_notifier_info *info,
-				      struct netlink_ext_ack *extack);
 
 void switchdev_port_fwd_mark_set(struct net_device *dev,
 				 struct net_device *group_dev,
@@ -340,15 +337,6 @@ unregister_switchdev_blocking_notifier(struct notifier_block *nb)
 	return 0;
 }
 
-static inline int
-call_switchdev_blocking_notifiers(unsigned long val,
-				  struct net_device *dev,
-				  struct switchdev_notifier_info *info,
-				  struct netlink_ext_ack *extack)
-{
-	return NOTIFY_DONE;
-}
-
 static inline int
 switchdev_handle_port_obj_add(struct net_device *dev,
 			struct switchdev_notifier_port_obj_info *port_obj_info,
diff --git a/net/switchdev/switchdev.c b/net/switchdev/switchdev.c
index 070698dd19bc..7b20b4b50474 100644
--- a/net/switchdev/switchdev.c
+++ b/net/switchdev/switchdev.c
@@ -22,6 +22,9 @@
 static LIST_HEAD(deferred);
 static DEFINE_SPINLOCK(deferred_lock);
 
+static ATOMIC_NOTIFIER_HEAD(switchdev_notif_chain);
+static BLOCKING_NOTIFIER_HEAD(switchdev_blocking_notif_chain);
+
 typedef void switchdev_deferred_func_t(struct net_device *dev,
 				       const void *data);
 
@@ -32,6 +35,17 @@ struct switchdev_deferred_item {
 	unsigned long data[];
 };
 
+static int
+call_switchdev_blocking_notifiers(unsigned long val, struct net_device *dev,
+				  struct switchdev_notifier_info *info,
+				  struct netlink_ext_ack *extack)
+{
+	info->dev = dev;
+	info->extack = extack;
+	return blocking_notifier_call_chain(&switchdev_blocking_notif_chain,
+					    val, info);
+}
+
 static struct switchdev_deferred_item *switchdev_deferred_dequeue(void)
 {
 	struct switchdev_deferred_item *dfitem;
@@ -306,9 +320,6 @@ int switchdev_port_obj_del(struct net_device *dev,
 }
 EXPORT_SYMBOL_GPL(switchdev_port_obj_del);
 
-static ATOMIC_NOTIFIER_HEAD(switchdev_notif_chain);
-static BLOCKING_NOTIFIER_HEAD(switchdev_blocking_notif_chain);
-
 /**
  *	register_switchdev_notifier - Register notifier
  *	@nb: notifier_block
@@ -367,17 +378,6 @@ int unregister_switchdev_blocking_notifier(struct notifier_block *nb)
 }
 EXPORT_SYMBOL_GPL(unregister_switchdev_blocking_notifier);
 
-int call_switchdev_blocking_notifiers(unsigned long val, struct net_device *dev,
-				      struct switchdev_notifier_info *info,
-				      struct netlink_ext_ack *extack)
-{
-	info->dev = dev;
-	info->extack = extack;
-	return blocking_notifier_call_chain(&switchdev_blocking_notif_chain,
-					    val, info);
-}
-EXPORT_SYMBOL_GPL(call_switchdev_blocking_notifiers);
-
 static int __switchdev_handle_port_obj_add(struct net_device *dev,
 			struct switchdev_notifier_port_obj_info *port_obj_info,
 			bool (*check_cb)(const struct net_device *dev),
-- 
2.25.1

