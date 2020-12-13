Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5NNYZEuAbyh5UJmXLCpQb6qOyS82108lYP7VSN+s2xg=;
 b=ruLdulRUo5QocesI+5GneG4/GYss7UF2Cfd9eYT41Mdq6XEbCPngKFYXU+90Lhl2/bI+4qY8ZDDsghdfvwulHce63dnnCqhpYh0HKChy3ijMwh22sIgddKgNN+bA8qbX8lVo9UXjLcbxsW9rRzWy/mzwIhWvdSShtN+uwAA0aqA=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Sun, 13 Dec 2020 04:40:15 +0200
Message-Id: <20201213024018.772586-4-vladimir.oltean@nxp.com>
In-Reply-To: <20201213024018.772586-1-vladimir.oltean@nxp.com>
References: <20201213024018.772586-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [PATCH v2 net-next 3/6] net: dsa: move switchdev event
	implementation under the same switch/case statement
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

We'll need to start listening to SWITCHDEV_FDB_{ADD,DEL}_TO_DEVICE
events even for interfaces where dsa_slave_dev_check returns false, so
we need that check inside the switch-case statement for SWITCHDEV_FDB_*.

This movement also avoids a useless allocation / free of switchdev_work
on the untreated "default event" case.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Changes in v2:
None.

 net/dsa/slave.c | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index 5079308a0206..99907e76770b 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -2116,31 +2116,29 @@ static int dsa_slave_switchdev_event(struct notifier_block *unused,
 	struct dsa_port *dp;
 	int err;
 
-	if (event == SWITCHDEV_PORT_ATTR_SET) {
+	switch (event) {
+	case SWITCHDEV_PORT_ATTR_SET:
 		err = switchdev_handle_port_attr_set(dev, ptr,
 						     dsa_slave_dev_check,
 						     dsa_slave_port_attr_set);
 		return notifier_from_errno(err);
-	}
-
-	if (!dsa_slave_dev_check(dev))
-		return NOTIFY_DONE;
+	case SWITCHDEV_FDB_ADD_TO_DEVICE:
+	case SWITCHDEV_FDB_DEL_TO_DEVICE:
+		if (!dsa_slave_dev_check(dev))
+			return NOTIFY_DONE;
 
-	dp = dsa_slave_to_port(dev);
+		dp = dsa_slave_to_port(dev);
 
-	switchdev_work = kzalloc(sizeof(*switchdev_work), GFP_ATOMIC);
-	if (!switchdev_work)
-		return NOTIFY_BAD;
+		switchdev_work = kzalloc(sizeof(*switchdev_work), GFP_ATOMIC);
+		if (!switchdev_work)
+			return NOTIFY_BAD;
 
-	INIT_WORK(&switchdev_work->work,
-		  dsa_slave_switchdev_event_work);
-	switchdev_work->ds = dp->ds;
-	switchdev_work->port = dp->index;
-	switchdev_work->event = event;
+		INIT_WORK(&switchdev_work->work,
+			  dsa_slave_switchdev_event_work);
+		switchdev_work->ds = dp->ds;
+		switchdev_work->port = dp->index;
+		switchdev_work->event = event;
 
-	switch (event) {
-	case SWITCHDEV_FDB_ADD_TO_DEVICE:
-	case SWITCHDEV_FDB_DEL_TO_DEVICE:
 		fdb_info = ptr;
 
 		if (!fdb_info->added_by_user) {
@@ -2153,13 +2151,12 @@ static int dsa_slave_switchdev_event(struct notifier_block *unused,
 		switchdev_work->vid = fdb_info->vid;
 
 		dev_hold(dev);
+		dsa_schedule_work(&switchdev_work->work);
 		break;
 	default:
-		kfree(switchdev_work);
 		return NOTIFY_DONE;
 	}
 
-	dsa_schedule_work(&switchdev_work->work);
 	return NOTIFY_OK;
 }
 
-- 
2.25.1

