Return-Path: <WINTERA@de.ibm.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=KiWb4Ct4RjsEggy6D6xJhqDA2kRzT2DHK+IqY8DlhIk=;
 b=BGJmDblwIeveKcmRAH0FlXwPVbkVZgXvG5FEyMaGEIFNK94bQ2ERvfvIIGz8T+4Lw8PV
 uLQ2ywcU+8kPEKUo/5TMORVCX52w60rAVdojWMjE6tmVj2NiNOOwdZeZuAVVzCEftzS1
 RxG/PiYNSDB0VR8N0ZCZd4mNCt4v5VnRryGr5usGCZzpxfWpQHXdAeaOLkdIYFlrBZ7h
 SNEU48oxTyS4oRGTvi2264WctK1tKxb5akc/a0CHFV9SKxa1xrmn7naDM0QiTPYMg2DL
 CZSFJ1jI7ic2VjggInm2LkBmOy728cKxWCWZtb91LDNxu/0Rjvd9YDkogWYl0UdRDbmX Ag== 
From: Alexandra Winter <wintera@linux.ibm.com>
Date: Wed, 23 Jun 2021 15:34:26 +0200
Message-Id: <20210623133426.2613847-3-wintera@linux.ibm.com>
In-Reply-To: <20210623133426.2613847-1-wintera@linux.ibm.com>
References: <20210623133426.2613847-1-wintera@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 2/2] net/bridge: Update uc addr on
	LEARNING_SYNC bp
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: roopa@nvidia.com, nikolay@nvidia.com, bridge@lists.linux-foundation.org, davem@davemloft.net, kuba@kernel.org, jwi@linux.ibm.com
Cc: Alexandra Winter <wintera@linux.ibm.com>

Whenever a unicast fdb entry is added or deleted in the software
bridge's fdb, synchronize it to the hardware fdb of a bridgeport
device, if the bridgeport has the attribute LEARNING_SYNC and is not
isolated from the target of the changed fdb entry.

To inform HW, that messages with a specific unicast target address
should be sent to the software bridge via this bridgeport, simply
register this address with the device.

Without this patch smart NICs attached to a bridgeport of a software
bridge can already do their own learning on the messages that the
SW bridge sends out via this port. And otherwise accept/flood all
unknown target messages to the SW bridge (promiscuous port).
This patch gives the attached HW the chance to update its fdb, even
when it does not see the respective message, because it is forwarded
to another piece of HW attached to another bridgeport. Or when the NIC
is not capable of learning or flooding.

An alternative solution would be to subscribe to the
SWITCHDEV_FDB_ADD/DEL_TO_DEVICE switchdev notifiers in the respective
device drivers. But as there's no HW-specific part in this
implementation, it was felt that this should rather be implemented in
the common layer of the bridge code.

Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
---
 net/bridge/br_fdb.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index 698b79747d32..2075b5da6db3 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -567,6 +567,32 @@ int br_fdb_insert(struct net_bridge *br, struct net_bridge_port *source,
 	return ret;
 }
 
+static void br_fdb_learning_sync(struct net_bridge *br,
+				 const struct net_bridge_fdb_entry *fdb,
+				 int type)
+{
+	struct net_bridge_port *p;
+
+	if (!fdb->dst)
+		return;
+	list_for_each_entry(p, &br->port_list, list) {
+		if ((p->flags & BR_LEARNING_SYNC) && p != fdb->dst &&
+		    (!(p->flags & BR_ISOLATED) ||
+		     !(fdb->dst->flags & BR_ISOLATED))) {
+			switch (type) {
+			case RTM_DELNEIGH:
+				dev_uc_del(p->dev, fdb->key.addr.addr);
+				break;
+			case RTM_NEWNEIGH:
+				dev_uc_add(p->dev, fdb->key.addr.addr);
+				break;
+			default:
+				break;
+			}
+		}
+	}
+}
+
 /* returns true if the fdb was modified */
 static bool __fdb_mark_active(struct net_bridge_fdb_entry *fdb)
 {
@@ -603,6 +629,7 @@ void br_fdb_update(struct net_bridge *br, struct net_bridge_port *source,
 			if (unlikely(source != fdb->dst &&
 				     !test_bit(BR_FDB_STICKY, &fdb->flags))) {
 				br_switchdev_fdb_notify(fdb, RTM_DELNEIGH);
+				br_fdb_learning_sync(br, fdb, RTM_DELNEIGH);
 				fdb->dst = source;
 				fdb_modified = true;
 				/* Take over HW learned entry */
@@ -799,6 +826,7 @@ static void fdb_notify(struct net_bridge *br,
 		goto errout;
 	}
 	rtnl_notify(skb, net, 0, RTNLGRP_NEIGH, NULL, GFP_ATOMIC);
+	br_fdb_learning_sync(br, fdb, type);
 	return;
 errout:
 	rtnl_set_sk_err(net, RTNLGRP_NEIGH, err);
-- 
2.25.1

