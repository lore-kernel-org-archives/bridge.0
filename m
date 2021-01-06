Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=phqppXF2ASkYJBnKfnD9JVsXRh5ajmKCs6dbXHVV5JE=;
 b=Y4SSa0hUBT6no6paikQ0JSBPvJcjLtwDagAfFikxLVGhTC9zZyKOjWpa9hlANtXRxl
 bBT7xckv+zZKIKNrUM9udLN0vglT5eLuBCTiwqHLvb2ZYSAeA7h4tn/TX+gIMTmUg2jE
 QR1iMj5LTLTlv+VU4+we9jdRLI7YsYtFRUgCRCcLdkoTJhJvqhlYXJtHb6k/4M+ttjmL
 6LmQi4lcwX6cdU5od3eA+VPY9YqcRu9r6NMg8ePgnaJWFiG889qfW6gkOLPTkno1iduS
 vCKN/xXt4Zz/iryOmx0wBR2eiEwqLc+YFMLkO6JEerIsWNVNkgSyDkAysp6N9IvfDfqr
 4Azg==
From: Vladimir Oltean <olteanv@gmail.com>
Date: Wed,  6 Jan 2021 11:51:35 +0200
Message-Id: <20210106095136.224739-7-olteanv@gmail.com>
In-Reply-To: <20210106095136.224739-1-olteanv@gmail.com>
References: <20210106095136.224739-1-olteanv@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH v4 net-next 6/7] net: dsa: listen for
	SWITCHDEV_{FDB, DEL}_ADD_TO_DEVICE on foreign bridge neighbors
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Andrew Lunn <andrew@lunn.ch>, Vivien Didelot <vivien.didelot@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org, Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, "David S. Miller" <davem@davemloft.net>
Cc: Jiri Pirko <jiri@resnulli.us>, Alexandra Winter <wintera@linux.ibm.com>, Ido Schimmel <idosch@idosch.org>, Russell King - ARM Linux admin <linux@armlinux.org.uk>, Marek Behun <marek.behun@nic.cz>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, UNGLinuxDriver@microchip.com, Tobias Waldekranz <tobias@waldekranz.com>

From: Vladimir Oltean <vladimir.oltean@nxp.com>

Some DSA switches (and not only) cannot learn source MAC addresses from
packets injected from the CPU. They only perform hardware address
learning from inbound traffic.

This can be problematic when we have a bridge spanning some DSA switch
ports and some non-DSA ports (which we'll call "foreign interfaces" from
DSA's perspective).

There are 2 classes of problems created by the lack of learning on
CPU-injected traffic:
- excessive flooding, due to the fact that DSA treats those addresses as
  unknown
- the risk of stale routes, which can lead to temporary packet loss

To illustrate the second class, consider the following situation, which
is common in production equipment (wireless access points, where there
is a WLAN interface and an Ethernet switch, and these form a single
bridging domain).

 AP 1:
 +------------------------------------------------------------------------+
 |                                          br0                           |
 +------------------------------------------------------------------------+
 +------------+ +------------+ +------------+ +------------+ +------------+
 |    swp0    | |    swp1    | |    swp2    | |    swp3    | |    wlan0   |
 +------------+ +------------+ +------------+ +------------+ +------------+
       |                                                       ^        ^
       |                                                       |        |
       |                                                       |        |
       |                                                    Client A  Client B
       |
       |
       |
 +------------+ +------------+ +------------+ +------------+ +------------+
 |    swp0    | |    swp1    | |    swp2    | |    swp3    | |    wlan0   |
 +------------+ +------------+ +------------+ +------------+ +------------+
 +------------------------------------------------------------------------+
 |                                          br0                           |
 +------------------------------------------------------------------------+
 AP 2

- br0 of AP 1 will know that Clients A and B are reachable via wlan0
- the hardware fdb of a DSA switch driver today is not kept in sync with
  the software entries on other bridge ports, so it will not know that
  clients A and B are reachable via the CPU port UNLESS the hardware
  switch itself performs SA learning from traffic injected from the CPU.
  Nonetheless, a substantial number of switches don't.
- the hardware fdb of the DSA switch on AP 2 may autonomously learn that
  Client A and B are reachable through swp0. Therefore, the software br0
  of AP 2 also may or may not learn this. In the example we're
  illustrating, some Ethernet traffic has been going on, and br0 from AP
  2 has indeed learnt that it can reach Client B through swp0.

One of the wireless clients, say Client B, disconnects from AP 1 and
roams to AP 2. The topology now looks like this:

 AP 1:
 +------------------------------------------------------------------------+
 |                                          br0                           |
 +------------------------------------------------------------------------+
 +------------+ +------------+ +------------+ +------------+ +------------+
 |    swp0    | |    swp1    | |    swp2    | |    swp3    | |    wlan0   |
 +------------+ +------------+ +------------+ +------------+ +------------+
       |                                                            ^
       |                                                            |
       |                                                         Client A
       |
       |
       |                                                         Client B
       |                                                            |
       |                                                            v
 +------------+ +------------+ +------------+ +------------+ +------------+
 |    swp0    | |    swp1    | |    swp2    | |    swp3    | |    wlan0   |
 +------------+ +------------+ +------------+ +------------+ +------------+
 +------------------------------------------------------------------------+
 |                                          br0                           |
 +------------------------------------------------------------------------+
 AP 2

- br0 of AP 1 still knows that Client A is reachable via wlan0 (no change)
- br0 of AP 1 will (possibly) know that Client B has left wlan0. There
  are cases where it might never find out though. Either way, DSA today
  does not process that notification in any way.
- the hardware FDB of the DSA switch on AP 1 may learn autonomously that
  Client B can be reached via swp0, if it receives any packet with
  Client 1's source MAC address over Ethernet.
- the hardware FDB of the DSA switch on AP 2 still thinks that Client B
  can be reached via swp0. It does not know that it has roamed to wlan0,
  because it doesn't perform SA learning from the CPU port.

Now Client A contacts Client B.
AP 1 routes the packet fine towards swp0 and delivers it on the Ethernet
segment.
AP 2 sees a frame on swp0 and its fdb says that the destination is swp0.
Hairpinning is disabled => drop.

This problem comes from the fact that these switches have a 'blind spot'
for addresses coming from software bridging. The generic solution is not
to assume that hardware learning can be enabled somehow, but to listen
to more bridge learning events. It turns out that the bridge driver does
learn in software from all inbound frames, in __br_handle_local_finish.
A proper SWITCHDEV_FDB_ADD_TO_DEVICE notification is emitted for the
addresses serviced by the bridge on 'foreign' interfaces. The software
bridge also does the right thing on migration, by notifying that the old
entry is deleted, so that does not need to be special-cased in DSA. When
it is deleted, we just need to delete our static FDB entry towards the
CPU too, and wait.

The problem is that DSA currently only cares about SWITCHDEV_FDB_ADD_TO_DEVICE
events received on its own interfaces, such as static FDB entries.

Luckily we can change that, and DSA can listen to all switchdev FDB
add/del events in the system and figure out if those events were emitted
by a bridge that spans at least one of DSA's own ports. In case that is
true, DSA will also offload that address towards its own CPU port, in
the eventuality that there might be bridge clients attached to the DSA
switch who want to talk to the station connected to the foreign
interface.

In terms of implementation, we need to keep the fdb_info->added_by_user
check for the case where the switchdev event was targeted directly at a
DSA switch port. But we don't need to look at that flag for snooped
events. So the check is currently too late, we need to move it earlier.
This also simplifies the code a bit, since we avoid uselessly allocating
and freeing switchdev_work.

We could probably do some improvements in the future. For example,
multi-bridge support is rudimentary at the moment. If there are two
bridges spanning a DSA switch's ports, and both of them need to service
the same MAC address, then what will happen is that the migration of one
of those stations will trigger the deletion of the FDB entry from the
CPU port while it is still used by other bridge. That could be improved
with reference counting but is left for another time.

This behavior needs to be enabled at driver level by setting
ds->assisted_learning_on_cpu_port = true. This is because we don't want
to inflict a potential performance penalty (accesses through
MDIO/I2C/SPI are expensive) to hardware that really doesn't need it
because address learning on the CPU port works there.

Reported-by: DENG Qingfang <dqfext@gmail.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
Changes in v4:
None.

Changes in v3:
- s/learning_broken/assisted_learning/
- don't call dev_hold unless it's a DSA slave interface, to avoid broken
  refcounting

Changes in v2:
Made the behavior conditional.

 include/net/dsa.h |  5 ++++
 net/dsa/slave.c   | 66 +++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 60 insertions(+), 11 deletions(-)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index 4e60d2610f20..6b74690bd8d4 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -319,6 +319,11 @@ struct dsa_switch {
 	 */
 	bool			untag_bridge_pvid;
 
+	/* Let DSA manage the FDB entries towards the CPU, based on the
+	 * software bridge database.
+	 */
+	bool			assisted_learning_on_cpu_port;
+
 	/* In case vlan_filtering_is_global is set, the VLAN awareness state
 	 * should be retrieved from here and not from the per-port settings.
 	 */
diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index 37dffe5bc46f..456576f75a50 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -2109,6 +2109,28 @@ static void dsa_slave_switchdev_event_work(struct work_struct *work)
 		dev_put(dp->slave);
 }
 
+static int dsa_lower_dev_walk(struct net_device *lower_dev,
+			      struct netdev_nested_priv *priv)
+{
+	if (dsa_slave_dev_check(lower_dev)) {
+		priv->data = (void *)netdev_priv(lower_dev);
+		return 1;
+	}
+
+	return 0;
+}
+
+static struct dsa_slave_priv *dsa_slave_dev_lower_find(struct net_device *dev)
+{
+	struct netdev_nested_priv priv = {
+		.data = NULL,
+	};
+
+	netdev_walk_all_lower_dev_rcu(dev, dsa_lower_dev_walk, &priv);
+
+	return (struct dsa_slave_priv *)priv.data;
+}
+
 /* Called under rcu_read_lock() */
 static int dsa_slave_switchdev_event(struct notifier_block *unused,
 				     unsigned long event, void *ptr)
@@ -2127,10 +2149,37 @@ static int dsa_slave_switchdev_event(struct notifier_block *unused,
 		return notifier_from_errno(err);
 	case SWITCHDEV_FDB_ADD_TO_DEVICE:
 	case SWITCHDEV_FDB_DEL_TO_DEVICE:
-		if (!dsa_slave_dev_check(dev))
-			return NOTIFY_DONE;
+		fdb_info = ptr;
 
-		dp = dsa_slave_to_port(dev);
+		if (dsa_slave_dev_check(dev)) {
+			if (!fdb_info->added_by_user)
+				return NOTIFY_OK;
+
+			dp = dsa_slave_to_port(dev);
+		} else {
+			/* Snoop addresses learnt on foreign interfaces
+			 * bridged with us, for switches that don't
+			 * automatically learn SA from CPU-injected traffic
+			 */
+			struct net_device *br_dev;
+			struct dsa_slave_priv *p;
+
+			br_dev = netdev_master_upper_dev_get_rcu(dev);
+			if (!br_dev)
+				return NOTIFY_DONE;
+
+			if (!netif_is_bridge_master(br_dev))
+				return NOTIFY_DONE;
+
+			p = dsa_slave_dev_lower_find(br_dev);
+			if (!p)
+				return NOTIFY_DONE;
+
+			dp = p->dp->cpu_dp;
+
+			if (!dp->ds->assisted_learning_on_cpu_port)
+				return NOTIFY_DONE;
+		}
 
 		if (!dp->ds->ops->port_fdb_add || !dp->ds->ops->port_fdb_del)
 			return NOTIFY_DONE;
@@ -2145,18 +2194,13 @@ static int dsa_slave_switchdev_event(struct notifier_block *unused,
 		switchdev_work->port = dp->index;
 		switchdev_work->event = event;
 
-		fdb_info = ptr;
-
-		if (!fdb_info->added_by_user) {
-			kfree(switchdev_work);
-			return NOTIFY_OK;
-		}
-
 		ether_addr_copy(switchdev_work->addr,
 				fdb_info->addr);
 		switchdev_work->vid = fdb_info->vid;
 
-		dev_hold(dev);
+		/* Hold a reference on the slave for dsa_fdb_offload_notify */
+		if (dsa_is_user_port(dp->ds, dp->index))
+			dev_hold(dev);
 		dsa_schedule_work(&switchdev_work->work);
 		break;
 	default:
-- 
2.25.1

