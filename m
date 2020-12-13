Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XFLX2wiBxLYOce+LWhMIewb2eWFh9MXAxVnj+ARxHho=;
 b=fMleEhAPzUtw6k75cjBGDlT0rlgf3ZsA7B9vHxgrQdZC0JunDUUgYG1di2UPYsTf5wNsO9aIG4uknDO9gGXzNk2vLO9BkgJggSAQdFQyEUMtlsE5o7eW+Wdn62anFcvtK/dwnV0S3AUp2SniFiO2R2UQEt5i2UBOC6ApZ4JTq2k=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Sun, 13 Dec 2020 04:40:14 +0200
Message-Id: <20201213024018.772586-3-vladimir.oltean@nxp.com>
In-Reply-To: <20201213024018.772586-1-vladimir.oltean@nxp.com>
References: <20201213024018.772586-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [PATCH v2 net-next 2/6] net: dsa: don't use
	switchdev_notifier_fdb_info in dsa_switchdev_event_work
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Andrew Lunn <andrew@lunn.ch>, Vivien Didelot <vivien.didelot@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org, Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, "David S. Miller" <davem@davemloft.net>
Cc: Jiri Pirko <jiri@resnulli.us>, Alexandra Winter <wintera@linux.ibm.com>, Ido Schimmel <idosch@idosch.org>, Russell King - ARM Linux admin <linux@armlinux.org.uk>, Marek Behun <marek.behun@nic.cz>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, Tobias Waldekranz <tobias@waldekranz.com>

Currently DSA doesn't add FDB entries on the CPU port, because it only
does so through switchdev, which is associated with a net_device, and
there are none of those for the CPU port.

But actually FDB addresses on the CPU port have some use cases of their
own, if the switchdev operations are initiated from within the DSA
layer. There is just one problem with the existing code: it passes a
structure in dsa_switchdev_event_work which was retrieved directly from
switchdev, so it contains a net_device. We need to generalize the
contents to something that covers the CPU port as well: the "ds, port"
tuple is fine for that.

Note that the new procedure for notifying the successful FDB offload is
inspired from the rocker model.

Also, nothing was being done if added_by_user was false. Let's check for
that a lot earlier, and don't actually bother to schedule the worker
for nothing.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Changes in v2:
Small cosmetic changes (reverse Christmas notation)

 net/dsa/dsa_priv.h |  12 ++++++
 net/dsa/slave.c    | 101 +++++++++++++++++++++++----------------------
 2 files changed, 63 insertions(+), 50 deletions(-)

diff --git a/net/dsa/dsa_priv.h b/net/dsa/dsa_priv.h
index 7c96aae9062c..c04225f74929 100644
--- a/net/dsa/dsa_priv.h
+++ b/net/dsa/dsa_priv.h
@@ -73,6 +73,18 @@ struct dsa_notifier_mtu_info {
 	int mtu;
 };
 
+struct dsa_switchdev_event_work {
+	struct dsa_switch *ds;
+	int port;
+	struct work_struct work;
+	unsigned long event;
+	/* Specific for SWITCHDEV_FDB_ADD_TO_DEVICE and
+	 * SWITCHDEV_FDB_DEL_TO_DEVICE
+	 */
+	unsigned char addr[ETH_ALEN];
+	u16 vid;
+};
+
 struct dsa_slave_priv {
 	/* Copy of CPU port xmit for faster access in slave transmit hot path */
 	struct sk_buff *	(*xmit)(struct sk_buff *skb,
diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index 4a0498bf6c65..5079308a0206 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -2047,72 +2047,63 @@ static int dsa_slave_netdevice_event(struct notifier_block *nb,
 	return NOTIFY_DONE;
 }
 
-struct dsa_switchdev_event_work {
-	struct work_struct work;
-	struct switchdev_notifier_fdb_info fdb_info;
-	struct net_device *dev;
-	unsigned long event;
-};
+static void
+dsa_fdb_offload_notify(struct dsa_switchdev_event_work *switchdev_work)
+{
+	struct dsa_switch *ds = switchdev_work->ds;
+	struct switchdev_notifier_fdb_info info;
+	struct dsa_port *dp;
+
+	if (!dsa_is_user_port(ds, switchdev_work->port))
+		return;
+
+	info.addr = switchdev_work->addr;
+	info.vid = switchdev_work->vid;
+	info.offloaded = true;
+	dp = dsa_to_port(ds, switchdev_work->port);
+	call_switchdev_notifiers(SWITCHDEV_FDB_OFFLOADED,
+				 dp->slave, &info.info, NULL);
+}
 
 static void dsa_slave_switchdev_event_work(struct work_struct *work)
 {
 	struct dsa_switchdev_event_work *switchdev_work =
 		container_of(work, struct dsa_switchdev_event_work, work);
-	struct net_device *dev = switchdev_work->dev;
-	struct switchdev_notifier_fdb_info *fdb_info;
-	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_switch *ds = switchdev_work->ds;
+	struct dsa_port *dp;
 	int err;
 
+	dp = dsa_to_port(ds, switchdev_work->port);
+
 	rtnl_lock();
 	switch (switchdev_work->event) {
 	case SWITCHDEV_FDB_ADD_TO_DEVICE:
-		fdb_info = &switchdev_work->fdb_info;
-		if (!fdb_info->added_by_user)
-			break;
-
-		err = dsa_port_fdb_add(dp, fdb_info->addr, fdb_info->vid);
+		err = dsa_port_fdb_add(dp, switchdev_work->addr,
+				       switchdev_work->vid);
 		if (err) {
-			netdev_dbg(dev, "fdb add failed err=%d\n", err);
+			dev_dbg(ds->dev, "port %d fdb add failed err=%d\n",
+				dp->index, err);
 			break;
 		}
-		fdb_info->offloaded = true;
-		call_switchdev_notifiers(SWITCHDEV_FDB_OFFLOADED, dev,
-					 &fdb_info->info, NULL);
+		dsa_fdb_offload_notify(switchdev_work);
 		break;
 
 	case SWITCHDEV_FDB_DEL_TO_DEVICE:
-		fdb_info = &switchdev_work->fdb_info;
-		if (!fdb_info->added_by_user)
-			break;
-
-		err = dsa_port_fdb_del(dp, fdb_info->addr, fdb_info->vid);
+		err = dsa_port_fdb_del(dp, switchdev_work->addr,
+				       switchdev_work->vid);
 		if (err) {
-			netdev_dbg(dev, "fdb del failed err=%d\n", err);
-			dev_close(dev);
+			dev_dbg(ds->dev, "port %d fdb del failed err=%d\n",
+				dp->index, err);
+			if (dsa_is_user_port(ds, dp->index))
+				dev_close(dp->slave);
 		}
 		break;
 	}
 	rtnl_unlock();
 
-	kfree(switchdev_work->fdb_info.addr);
 	kfree(switchdev_work);
-	dev_put(dev);
-}
-
-static int
-dsa_slave_switchdev_fdb_work_init(struct dsa_switchdev_event_work *
-				  switchdev_work,
-				  const struct switchdev_notifier_fdb_info *
-				  fdb_info)
-{
-	memcpy(&switchdev_work->fdb_info, fdb_info,
-	       sizeof(switchdev_work->fdb_info));
-	switchdev_work->fdb_info.addr = kzalloc(ETH_ALEN, GFP_ATOMIC);
-	if (!switchdev_work->fdb_info.addr)
-		return -ENOMEM;
-	ether_addr_copy((u8 *)switchdev_work->fdb_info.addr,
-			fdb_info->addr);
-	return 0;
+	if (dsa_is_user_port(ds, dp->index))
+		dev_put(dp->slave);
 }
 
 /* Called under rcu_read_lock() */
@@ -2120,7 +2111,9 @@ static int dsa_slave_switchdev_event(struct notifier_block *unused,
 				     unsigned long event, void *ptr)
 {
 	struct net_device *dev = switchdev_notifier_info_to_dev(ptr);
+	const struct switchdev_notifier_fdb_info *fdb_info;
 	struct dsa_switchdev_event_work *switchdev_work;
+	struct dsa_port *dp;
 	int err;
 
 	if (event == SWITCHDEV_PORT_ATTR_SET) {
@@ -2133,20 +2126,32 @@ static int dsa_slave_switchdev_event(struct notifier_block *unused,
 	if (!dsa_slave_dev_check(dev))
 		return NOTIFY_DONE;
 
+	dp = dsa_slave_to_port(dev);
+
 	switchdev_work = kzalloc(sizeof(*switchdev_work), GFP_ATOMIC);
 	if (!switchdev_work)
 		return NOTIFY_BAD;
 
 	INIT_WORK(&switchdev_work->work,
 		  dsa_slave_switchdev_event_work);
-	switchdev_work->dev = dev;
+	switchdev_work->ds = dp->ds;
+	switchdev_work->port = dp->index;
 	switchdev_work->event = event;
 
 	switch (event) {
 	case SWITCHDEV_FDB_ADD_TO_DEVICE:
 	case SWITCHDEV_FDB_DEL_TO_DEVICE:
-		if (dsa_slave_switchdev_fdb_work_init(switchdev_work, ptr))
-			goto err_fdb_work_init;
+		fdb_info = ptr;
+
+		if (!fdb_info->added_by_user) {
+			kfree(switchdev_work);
+			return NOTIFY_OK;
+		}
+
+		ether_addr_copy(switchdev_work->addr,
+				fdb_info->addr);
+		switchdev_work->vid = fdb_info->vid;
+
 		dev_hold(dev);
 		break;
 	default:
@@ -2156,10 +2161,6 @@ static int dsa_slave_switchdev_event(struct notifier_block *unused,
 
 	dsa_schedule_work(&switchdev_work->work);
 	return NOTIFY_OK;
-
-err_fdb_work_init:
-	kfree(switchdev_work);
-	return NOTIFY_BAD;
 }
 
 static int dsa_slave_switchdev_blocking_event(struct notifier_block *unused,
-- 
2.25.1

