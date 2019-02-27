Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=CGC5288aeDnGMAvwttKUw53qJk7EfFD9Gkif20wQhNs=;
	b=Adl0hWXGRaegsDZvEEe6hj1WEIeKWdS4AuhXO9aGYC8/BypwCai4NE7oji23SNRKmy
	X8Go5eqxpOAJvg/iaLgFUQYNtT17dRsVqbhD3QsLzNZOGbFa+YeiqVsTbIittT5nnSja
	e4X0AqdE6QLXN8MfzxCxOh3PP3GOdpb28bROmy7R0lUO4wSRwlAxUx1SKRYQ9xEOCen/
	ttk0clPZscen3dddNvJLmqFX5+HV/gbtZ9W1S14M8VhvsS9dqM+YspFklHomg6xJL+IX
	W7YL2zZgMO9lI+gpPT/iRDzfIgQ2YQ1ia/wY9ftGLszQ5qyNrciJtW8RAUH/ZzmNPuzk
	Lq0w==
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Tue, 26 Feb 2019 17:14:26 -0800
Message-Id: <20190227011427.16487-8-f.fainelli@gmail.com>
In-Reply-To: <20190227011427.16487-1-f.fainelli@gmail.com>
References: <20190227011427.16487-1-f.fainelli@gmail.com>
Subject: [Bridge] [PATCH net-next v2 7/8] net: switchdev: Replace port attr
	set SDO with a notification
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>, andrew@lunn.ch, Florian Fainelli <f.fainelli@gmail.com>, "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, open list <linux-kernel@vger.kernel.org>, vivien.didelot@gmail.com, Ido Schimmel <idosch@mellanox.com>, jiri@mellanox.com, "David S. Miller" <davem@davemloft.net>

Drop switchdev_ops.switchdev_port_attr_set. Drop the uses of this field
from all clients, which were migrated to use switchdev notification in
the previous patches.

Add a new function switchdev_port_attr_notify() that sends the switchdev
notifications SWITCHDEV_PORT_ATTR_SET and calls the blocking (process)
notifier chain.

We have one odd case within net/bridge/br_switchdev.c with the
SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS attribute identifier that
requires executing from atomic context, we deal with that one
specifically.

Drop __switchdev_port_attr_set() and update switchdev_port_attr_set()
likewise.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 net/bridge/br_switchdev.c |  7 +++++-
 net/switchdev/switchdev.c | 53 ++++++++++++++++++---------------------
 2 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index af57c4a2b78a..b7988d49d708 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -67,12 +67,17 @@ int br_switchdev_set_port_flag(struct net_bridge_port *p,
 		.id = SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS,
 		.u.brport_flags = mask,
 	};
+	struct switchdev_notifier_port_attr_info info = {
+		.attr = &attr,
+	};
 	int err;
 
 	if (mask & ~BR_PORT_FLAGS_HW_OFFLOAD)
 		return 0;
 
-	err = switchdev_port_attr_set(p->dev, &attr);
+	/* We run from atomic context here */
+	err = call_switchdev_notifiers(SWITCHDEV_PORT_ATTR_SET, p->dev,
+				       &info.info, NULL);
 	if (err == -EOPNOTSUPP)
 		return 0;
 
diff --git a/net/switchdev/switchdev.c b/net/switchdev/switchdev.c
index 3560c19aa7e2..d81cfcee9ad9 100644
--- a/net/switchdev/switchdev.c
+++ b/net/switchdev/switchdev.c
@@ -174,39 +174,32 @@ static int switchdev_deferred_enqueue(struct net_device *dev,
 	return 0;
 }
 
-static int __switchdev_port_attr_set(struct net_device *dev,
-				     const struct switchdev_attr *attr,
-				     struct switchdev_trans *trans)
+static int switchdev_port_attr_notify(enum switchdev_notifier_type nt,
+				      struct net_device *dev,
+				      const struct switchdev_attr *attr,
+				      struct switchdev_trans *trans)
 {
-	const struct switchdev_ops *ops = dev->switchdev_ops;
-	struct net_device *lower_dev;
-	struct list_head *iter;
-	int err = -EOPNOTSUPP;
-
-	if (ops && ops->switchdev_port_attr_set) {
-		err = ops->switchdev_port_attr_set(dev, attr, trans);
-		goto done;
-	}
-
-	if (attr->flags & SWITCHDEV_F_NO_RECURSE)
-		goto done;
+	int err;
+	int rc;
 
-	/* Switch device port(s) may be stacked under
-	 * bond/team/vlan dev, so recurse down to set attr on
-	 * each port.
-	 */
+	struct switchdev_notifier_port_attr_info attr_info = {
+		.attr = attr,
+		.trans = trans,
+		.handled = false,
+	};
 
-	netdev_for_each_lower_dev(dev, lower_dev, iter) {
-		err = __switchdev_port_attr_set(lower_dev, attr, trans);
-		if (err)
-			break;
+	rc = call_switchdev_blocking_notifiers(nt, dev,
+					       &attr_info.info, NULL);
+	err = notifier_to_errno(rc);
+	if (err) {
+		WARN_ON(!attr_info.handled);
+		return err;
 	}
 
-done:
-	if (err == -EOPNOTSUPP && attr->flags & SWITCHDEV_F_SKIP_EOPNOTSUPP)
-		err = 0;
+	if (!attr_info.handled)
+		return -EOPNOTSUPP;
 
-	return err;
+	return 0;
 }
 
 static int switchdev_port_attr_set_now(struct net_device *dev,
@@ -225,7 +218,8 @@ static int switchdev_port_attr_set_now(struct net_device *dev,
 	 */
 
 	trans.ph_prepare = true;
-	err = __switchdev_port_attr_set(dev, attr, &trans);
+	err = switchdev_port_attr_notify(SWITCHDEV_PORT_ATTR_SET, dev, attr,
+					 &trans);
 	if (err) {
 		/* Prepare phase failed: abort the transaction.  Any
 		 * resources reserved in the prepare phase are
@@ -244,7 +238,8 @@ static int switchdev_port_attr_set_now(struct net_device *dev,
 	 */
 
 	trans.ph_prepare = false;
-	err = __switchdev_port_attr_set(dev, attr, &trans);
+	err = switchdev_port_attr_notify(SWITCHDEV_PORT_ATTR_SET, dev, attr,
+					 &trans);
 	WARN(err, "%s: Commit of attribute (id=%d) failed.\n",
 	     dev->name, attr->id);
 	switchdev_trans_items_warn_destroy(dev, &trans);
-- 
2.17.1

