Return-Path: <troglobit@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:organization:content-transfer-encoding;
 bh=c2Hxf+Qd4VDlf3RyTcZ7u6PSE6ckvu4bfuQ6dUJjbnI=;
 b=dUNS3ltsPrnQGHh8Qf2VDr2VwLlBywJMd8CzsUSUVQtAzwupM2mqlPeuT3AWAGOMSj
 yvg0DBq5zwVVyWyOADLHtTHJQobKUiLz5Pxo6H1gdQ7epVI1VvvIlFQo48J9lixiWTSQ
 NjxX1hEeC6LHMkfcXHvnVCsE7+5Fwjm/sS7NbNINMiRUXkID17v7gAceggPr0Ig5LHmV
 IPPbGJ8SCmjY3ful/7pM26xjH3WSg5VpxABl+sGKdRRAf8GR56yDXdjTYAGo0rKtTfdK
 hw9F65Lc3XDw6Lpc+k3/MzH+Xh14LtESEtAlX6rO8pHaZaS+/sRITde0PYRfmlEIyHDk
 VV6Q==
From: Joachim Wiberg <troglobit@gmail.com>
Date: Mon, 11 Apr 2022 15:38:26 +0200
Message-Id: <20220411133837.318876-3-troglobit@gmail.com>
In-Reply-To: <20220411133837.318876-1-troglobit@gmail.com>
References: <20220411133837.318876-1-troglobit@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH RFC net-next 02/13] net: bridge: rename
	br_switchdev_set_port_flag() to .._dev_flag()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Vladimir Oltean <vladimir.oltean@nxp.com>, Joachim Wiberg <troglobit@gmail.com>, Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, Tobias Waldekranz <tobias@waldekranz.com>

The br_switchdev_set_port_flag() function only uses the `p->dev` member
of the port, and we also want to reuse it for the bridge itself. Change
the first argument and the name of the function to match.

Signed-off-by: Joachim Wiberg <troglobit@gmail.com>
---
 net/bridge/br_netlink.c   | 2 +-
 net/bridge/br_private.h   | 4 ++--
 net/bridge/br_switchdev.c | 8 ++++----
 net/bridge/br_sysfs_if.c  | 2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 200ad05b296f..7fca8ff13ec7 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -942,7 +942,7 @@ static int br_setport(struct net_bridge_port *p, struct nlattr *tb[],
 
 	changed_mask = old_flags ^ p->flags;
 
-	err = br_switchdev_set_port_flag(p, p->flags, changed_mask, extack);
+	err = br_switchdev_set_dev_flag(p->dev, p->flags, changed_mask, extack);
 	if (err) {
 		p->flags = old_flags;
 		return err;
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 683bd0ee4c64..6c230be6fbf5 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -2038,7 +2038,7 @@ void nbp_switchdev_frame_mark(const struct net_bridge_port *p,
 			      struct sk_buff *skb);
 bool nbp_switchdev_allowed_egress(const struct net_bridge_port *p,
 				  const struct sk_buff *skb);
-int br_switchdev_set_port_flag(struct net_bridge_port *p,
+int br_switchdev_set_dev_flag(struct net_device *dev,
 			       unsigned long flags,
 			       unsigned long mask,
 			       struct netlink_ext_ack *extack);
@@ -2108,7 +2108,7 @@ static inline bool nbp_switchdev_allowed_egress(const struct net_bridge_port *p,
 	return true;
 }
 
-static inline int br_switchdev_set_port_flag(struct net_bridge_port *p,
+static inline int br_switchdev_set_dev_flag(struct net_device *dev,
 					     unsigned long flags,
 					     unsigned long mask,
 					     struct netlink_ext_ack *extack)
diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index 8cc44c367231..3b4df63e96a6 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -74,13 +74,13 @@ bool nbp_switchdev_allowed_egress(const struct net_bridge_port *p,
 #define BR_PORT_FLAGS_HW_OFFLOAD (BR_LEARNING | BR_FLOOD | \
 				  BR_MCAST_FLOOD | BR_BCAST_FLOOD | BR_PORT_LOCKED)
 
-int br_switchdev_set_port_flag(struct net_bridge_port *p,
+int br_switchdev_set_dev_flag(struct net_device *dev,
 			       unsigned long flags,
 			       unsigned long mask,
 			       struct netlink_ext_ack *extack)
 {
 	struct switchdev_attr attr = {
-		.orig_dev = p->dev,
+		.orig_dev = dev,
 	};
 	struct switchdev_notifier_port_attr_info info = {
 		.attr = &attr,
@@ -96,7 +96,7 @@ int br_switchdev_set_port_flag(struct net_bridge_port *p,
 	attr.u.brport_flags.mask = mask;
 
 	/* We run from atomic context here */
-	err = call_switchdev_notifiers(SWITCHDEV_PORT_ATTR_SET, p->dev,
+	err = call_switchdev_notifiers(SWITCHDEV_PORT_ATTR_SET, dev,
 				       &info.info, extack);
 	err = notifier_to_errno(err);
 	if (err == -EOPNOTSUPP)
@@ -112,7 +112,7 @@ int br_switchdev_set_port_flag(struct net_bridge_port *p,
 	attr.id = SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS;
 	attr.flags = SWITCHDEV_F_DEFER;
 
-	err = switchdev_port_attr_set(p->dev, &attr, extack);
+	err = switchdev_port_attr_set(dev, &attr, extack);
 	if (err) {
 		if (extack && !extack->_msg)
 			NL_SET_ERR_MSG_MOD(extack,
diff --git a/net/bridge/br_sysfs_if.c b/net/bridge/br_sysfs_if.c
index 07fa76080512..c222c68105f1 100644
--- a/net/bridge/br_sysfs_if.c
+++ b/net/bridge/br_sysfs_if.c
@@ -69,7 +69,7 @@ static int store_flag(struct net_bridge_port *p, unsigned long v,
 		flags &= ~mask;
 
 	if (flags != p->flags) {
-		err = br_switchdev_set_port_flag(p, flags, mask, &extack);
+		err = br_switchdev_set_dev_flag(p->dev, flags, mask, &extack);
 		if (err) {
 			netdev_err(p->dev, "%s\n", extack._msg);
 			return err;
-- 
2.25.1

