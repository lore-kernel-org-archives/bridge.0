Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SLOrV6s97Ry0iwdu3RpTJSfKFrcfcJmqEfZC/VKfwFk=;
 b=dlq6wYn855QwR8iGdp04H45PmM5H6c5BGsFxDQaf/0O34zOjL0O1sE3aPozO5M60jct+67G0jmVOGHMgEsRnwD5DzVcoE35GRlEOjNVSs211kiG1pVF0Oh83KwUC7Jc7bk+/gV1zhPBbBxnSbZmoPuevM+cUUxQoRSnHDzlnXoA=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Thu, 15 Oct 2020 20:33:55 +0300
Message-Id: <20201015173355.564934-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [RFC PATCH] net: bridge: call br_multicast_del_port before
	the port leaves
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, bridge@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Switchdev drivers often have different VLAN semantics than the bridge.
For example, consider this:

ip link add br0 type bridge
ip link set swp0 master br0
bridge mdb add dev br0 port swp0 grp 01:02:03:04:05:06 permanent
ip link del br0
[   26.085816] mscc_felix 0000:00:00.5 swp0: failed (err=-2) to del object (id=2)

This is because the mscc_ocelot driver, when VLAN awareness is disabled,
classifies all traffic to the port-based VLAN (pvid). The pvid is 0 when
the port is standalone, and it is inherited from the bridge default pvid
(which is 1 by default, but it may take other values) when it joins the
VLAN-unaware bridge, and then the pvid resets to 0 when the port leaves
the bridge again.

Now because the mscc_ocelot switch classifies all traffic to its private
pvid, it needs to translate between the vid that the mdb comes with, and
the vid that will actually be programmed into hardware. The bridge uses
the vid of 0 in VLAN-unaware mode, while the hardware uses the pvid
inherited from the bridge, that's the difference.

So what will happen is:

Step 1 (addition):
br_mdb_notify(RTM_NEWMDB)
-> ocelot_port_mdb_add(mdb->addr=01:02:03:04:05:06, mdb->vid=0)
   -> mdb->vid is remapped from 0 to 1 and installed into ocelot->multicast

Step 2 (removal):
del_nbp
-> netdev_upper_dev_unlink(dev, br->dev)
   -> ocelot_port_bridge_leave
      -> ocelot_port_set_pvid(ocelot, port, 0)
-> br_multicast_del_port is called and the switchdev notifier is
   deferred for some time later
   -> ocelot_port_mdb_del(mdb->addr=01:02:03:04:05:06, mdb->vid=0)
      -> mdb->vid is remapped from 0 to 0, the port pvid (!!!)
      -> the remapped mdb (addr=01:02:03:04:05:06, vid=0) is not found
         inside the ocelot->multicast list, and -ENOENT is returned

So the problem is that mscc_ocelot assumes that the port is removed
_after_ the multicast entries have been deleted. And this is not an
unreasonable assumption, presumably it isn't the only switchdev that
needs to remap the vid. So we can reorder the teardown path in order
for that assumption to hold true.

Since br_mdb_notify() issues a SWITCHDEV_F_DEFER operation, we must move
the call not only before netdev_upper_dev_unlink(), but in fact before
switchdev_deferred_process().

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 net/bridge/br_if.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index a0e9a7937412..cdbeaf203b0b 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -344,6 +344,7 @@ static void del_nbp(struct net_bridge_port *p)
 
 	nbp_vlan_flush(p);
 	br_fdb_delete_by_port(br, p, 0, 1);
+	br_multicast_del_port(p);
 	switchdev_deferred_process();
 	nbp_backup_clear(p);
 
@@ -355,8 +356,6 @@ static void del_nbp(struct net_bridge_port *p)
 
 	netdev_rx_handler_unregister(dev);
 
-	br_multicast_del_port(p);
-
 	kobject_uevent(&p->kobj, KOBJ_REMOVE);
 	kobject_del(&p->kobj);
 
-- 
2.25.1

