Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=ifXkdhN3Db+p5XK7EE964Sj4BgFX95LGnnu/9MTO3AQ=;
	b=FsYeMIVaQTi184L9QS3dyayfbHkLaF+MIV8eKc1hnhmcFAnD34bbTrHG5IRsXxmY4M
	7lonOXTuMeJ/LsuTz4y9zmqci/zeCenkts5V9WqKdJykwuQJcUHcvIIVrDhmJeJim8vH
	ICul48Zb9Qb9eWnqN2gwq+WxAruk3zPVXbdD17lDAGOLfeDd0ibYOfiivWnJcxQ9hbEc
	R86YbnseK/IUD8BI8C2AopV8YGDYEgUtQASVp2A13GvDUJ/kuJJSYLwSMWcwmGz13PLD
	ZBjUsGmrFiyccBkN6+Jmrwl9O3dAQJkjBZB9PYTy66D/nWSnevTM+zz4DMJiafPwP2kK
	UNYw==
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Sun, 10 Feb 2019 15:40:06 -0800
Message-Id: <20190210234007.16173-9-f.fainelli@gmail.com>
In-Reply-To: <20190210234007.16173-1-f.fainelli@gmail.com>
References: <20190210234007.16173-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next v3 8/9] net: switchdev: Replace port attr
	get/set SDO with a notification
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: devel@driverdev.osuosl.org, andrew@lunn.ch, Florian Fainelli <f.fainelli@gmail.com>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, idosch@mellanox.com, jiri@mellanox.com, vivien.didelot@gmail.com

Drop switchdev_ops.switchdev_port_attr_get and _set. Drop the uses of
this field from all clients, which were migrated to use switchdev
notification in the previous patches.

Add a new function switchdev_port_attr_notify() that sends the switchdev
notifications SWITCHDEV_PORT_ATTR_GET and _SET.

Update switchdev_port_attr_get() to dispatch to this new function. Drop
__switchdev_port_attr_set() and update switchdev_port_attr_set()
likewise.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 net/switchdev/switchdev.c | 107 +++++++++++++-------------------------
 1 file changed, 37 insertions(+), 70 deletions(-)

diff --git a/net/switchdev/switchdev.c b/net/switchdev/switchdev.c
index 7e1357db33d7..8fc3db2179f5 100644
--- a/net/switchdev/switchdev.c
+++ b/net/switchdev/switchdev.c
@@ -174,81 +174,31 @@ static int switchdev_deferred_enqueue(struct net_device *dev,
 	return 0;
 }
 
-/**
- *	switchdev_port_attr_get - Get port attribute
- *
- *	@dev: port device
- *	@attr: attribute to get
- */
-int switchdev_port_attr_get(struct net_device *dev, struct switchdev_attr *attr)
+static int switchdev_port_attr_notify(enum switchdev_notifier_type nt,
+				      struct net_device *dev,
+				      struct switchdev_attr *attr,
+				      struct switchdev_trans *trans)
 {
-	const struct switchdev_ops *ops = dev->switchdev_ops;
-	struct net_device *lower_dev;
-	struct list_head *iter;
-	struct switchdev_attr first = {
-		.id = SWITCHDEV_ATTR_ID_UNDEFINED
-	};
-	int err = -EOPNOTSUPP;
+	int err;
+	int rc;
 
-	if (ops && ops->switchdev_port_attr_get)
-		return ops->switchdev_port_attr_get(dev, attr);
+	struct switchdev_notifier_port_attr_info attr_info = {
+		.attr = attr,
+		.trans = trans,
+		.handled = false,
+	};
 
-	if (attr->flags & SWITCHDEV_F_NO_RECURSE)
+	rc = call_switchdev_blocking_notifiers(nt, dev, &attr_info.info, NULL);
+	err = notifier_to_errno(rc);
+	if (err) {
+		WARN_ON(!attr_info.handled);
 		return err;
-
-	/* Switch device port(s) may be stacked under
-	 * bond/team/vlan dev, so recurse down to get attr on
-	 * each port.  Return -ENODATA if attr values don't
-	 * compare across ports.
-	 */
-
-	netdev_for_each_lower_dev(dev, lower_dev, iter) {
-		err = switchdev_port_attr_get(lower_dev, attr);
-		if (err)
-			break;
-		if (first.id == SWITCHDEV_ATTR_ID_UNDEFINED)
-			first = *attr;
-		else if (memcmp(&first, attr, sizeof(*attr)))
-			return -ENODATA;
-	}
-
-	return err;
-}
-EXPORT_SYMBOL_GPL(switchdev_port_attr_get);
-
-static int __switchdev_port_attr_set(struct net_device *dev,
-				     const struct switchdev_attr *attr,
-				     struct switchdev_trans *trans)
-{
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
-
-	/* Switch device port(s) may be stacked under
-	 * bond/team/vlan dev, so recurse down to set attr on
-	 * each port.
-	 */
-
-	netdev_for_each_lower_dev(dev, lower_dev, iter) {
-		err = __switchdev_port_attr_set(lower_dev, attr, trans);
-		if (err)
-			break;
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
@@ -267,7 +217,9 @@ static int switchdev_port_attr_set_now(struct net_device *dev,
 	 */
 
 	trans.ph_prepare = true;
-	err = __switchdev_port_attr_set(dev, attr, &trans);
+	err = switchdev_port_attr_notify(SWITCHDEV_PORT_ATTR_SET,
+					 dev, (struct switchdev_attr *)attr,
+					 &trans);
 	if (err) {
 		/* Prepare phase failed: abort the transaction.  Any
 		 * resources reserved in the prepare phase are
@@ -286,7 +238,9 @@ static int switchdev_port_attr_set_now(struct net_device *dev,
 	 */
 
 	trans.ph_prepare = false;
-	err = __switchdev_port_attr_set(dev, attr, &trans);
+	err = switchdev_port_attr_notify(SWITCHDEV_PORT_ATTR_SET,
+					 dev, (struct switchdev_attr *)attr,
+					 &trans);
 	WARN(err, "%s: Commit of attribute (id=%d) failed.\n",
 	     dev->name, attr->id);
 	switchdev_trans_items_warn_destroy(dev, &trans);
@@ -338,6 +292,19 @@ int switchdev_port_attr_set(struct net_device *dev,
 }
 EXPORT_SYMBOL_GPL(switchdev_port_attr_set);
 
+/**
+ *	switchdev_port_attr_get - Get port attribute
+ *
+ *	@dev: port device
+ *	@attr: attribute to get
+ */
+int switchdev_port_attr_get(struct net_device *dev, struct switchdev_attr *attr)
+{
+	return switchdev_port_attr_notify(SWITCHDEV_PORT_ATTR_GET, dev,
+					  attr, NULL);
+}
+EXPORT_SYMBOL_GPL(switchdev_port_attr_get);
+
 static size_t switchdev_obj_size(const struct switchdev_obj *obj)
 {
 	switch (obj->id) {
-- 
2.19.1

