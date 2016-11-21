Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=Bj14j3WzmiWv/s+br0Om46LmpQ5hGnXUkuR5epNDREE=;
	b=CnNo4nIiNX59lVNR2ZElyUjKSjW0MRMBTuGCMoj/2mEmsdA7JLe501qlXdcvQU5Ixz
	Q2xC/aL27Oc7LF50EFGsF8QiBwOTPOMjgfy0LS17PjOIDly7aHcoWDw99KsCvGbIzb7N
	2IwjsaqpXwUKDyMvDI9Pgdrry9iZkwKS2iPB82HNEoofemfvEjMpiSobAbLKlV4Clm2r
	gnqbOy2ITpT+eCuozdl9KStEI/UB76LXZ164/2AT+/rEoYsj3MLCbucUU4wTwq6Mmiho
	oL7ZxqBBSFxGrC6btkqca2me8NZQxVNMTCaZC+H51pVD/1ar0PYb/cnRJxTtnZgfeKkh
	ksbg==
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Mon, 21 Nov 2016 11:09:24 -0800
Message-Id: <20161121190925.14530-3-f.fainelli@gmail.com>
In-Reply-To: <20161121190925.14530-1-f.fainelli@gmail.com>
References: <20161121190925.14530-1-f.fainelli@gmail.com>
Subject: [Bridge] [RFC net-next 2/3] net: dsa: Propagate VLAN add/del to CPU
	port(s)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: idosch@mellanox.com, andrew@lunn.ch, Florian Fainelli <f.fainelli@gmail.com>, vivien.didelot@savoirfairelinux.com, bridge@lists.linux-foundation.org, jiri@mellanox.com, davem@davemloft.net

Now that the bridge layer can call into switchdev to signal programming
requests targeting the bridge master device itself, allow the switch
drivers to implement separate programming of downstream and
upstream/management ports.

Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 net/dsa/slave.c | 45 +++++++++++++++++++++++++++++++++------------
 1 file changed, 33 insertions(+), 12 deletions(-)

diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index d0c7bce88743..18288261b964 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -223,35 +223,30 @@ static int dsa_slave_set_mac_address(struct net_device *dev, void *a)
 	return 0;
 }
 
-static int dsa_slave_port_vlan_add(struct net_device *dev,
+static int dsa_slave_port_vlan_add(struct dsa_switch *ds, int port,
 				   const struct switchdev_obj_port_vlan *vlan,
 				   struct switchdev_trans *trans)
 {
-	struct dsa_slave_priv *p = netdev_priv(dev);
-	struct dsa_switch *ds = p->parent;
 
 	if (switchdev_trans_ph_prepare(trans)) {
 		if (!ds->ops->port_vlan_prepare || !ds->ops->port_vlan_add)
 			return -EOPNOTSUPP;
 
-		return ds->ops->port_vlan_prepare(ds, p->port, vlan, trans);
+		return ds->ops->port_vlan_prepare(ds, port, vlan, trans);
 	}
 
-	ds->ops->port_vlan_add(ds, p->port, vlan, trans);
+	ds->ops->port_vlan_add(ds, port, vlan, trans);
 
 	return 0;
 }
 
-static int dsa_slave_port_vlan_del(struct net_device *dev,
+static int dsa_slave_port_vlan_del(struct dsa_switch *ds, int port,
 				   const struct switchdev_obj_port_vlan *vlan)
 {
-	struct dsa_slave_priv *p = netdev_priv(dev);
-	struct dsa_switch *ds = p->parent;
-
 	if (!ds->ops->port_vlan_del)
 		return -EOPNOTSUPP;
 
-	return ds->ops->port_vlan_del(ds, p->port, vlan);
+	return ds->ops->port_vlan_del(ds, port, vlan);
 }
 
 static int dsa_slave_port_vlan_dump(struct net_device *dev,
@@ -465,8 +460,21 @@ static int dsa_slave_port_obj_add(struct net_device *dev,
 				  const struct switchdev_obj *obj,
 				  struct switchdev_trans *trans)
 {
+	struct dsa_slave_priv *p = netdev_priv(dev);
+	struct dsa_switch *ds = p->parent;
+	int port = p->port;
 	int err;
 
+	/* Here we may be called with an orig_dev which is different from dev,
+	 * on purpose, to receive request coming from e.g the bridge master
+	 * device. Although there are no network device associated with CPU/DSA
+	 * ports, we may still have programming operation for these ports.
+	 */
+	if (obj->orig_dev == p->bridge_dev) {
+		ds = ds->dst->ds[0];
+		port = ds->dst->cpu_port;
+	}
+
 	/* For the prepare phase, ensure the full set of changes is feasable in
 	 * one go in order to signal a failure properly. If an operation is not
 	 * supported, return -EOPNOTSUPP.
@@ -483,7 +491,7 @@ static int dsa_slave_port_obj_add(struct net_device *dev,
 					     trans);
 		break;
 	case SWITCHDEV_OBJ_ID_PORT_VLAN:
-		err = dsa_slave_port_vlan_add(dev,
+		err = dsa_slave_port_vlan_add(ds, port,
 					      SWITCHDEV_OBJ_PORT_VLAN(obj),
 					      trans);
 		break;
@@ -498,8 +506,21 @@ static int dsa_slave_port_obj_add(struct net_device *dev,
 static int dsa_slave_port_obj_del(struct net_device *dev,
 				  const struct switchdev_obj *obj)
 {
+	struct dsa_slave_priv *p = netdev_priv(dev);
+	struct dsa_switch *ds = p->parent;
+	int port = p->port;
 	int err;
 
+	/* Here we may be called with an orig_dev which is different from dev,
+	 * on purpose, to receive request coming from e.g the bridge master
+	 * device. Although there are no network device associated with CPU/DSA
+	 * ports, we may still have programming operation for these ports.
+	 */
+	if (obj->orig_dev == p->bridge_dev) {
+		ds = ds->dst->ds[0];
+		port = ds->dst->cpu_port;
+	}
+
 	switch (obj->id) {
 	case SWITCHDEV_OBJ_ID_PORT_FDB:
 		err = dsa_slave_port_fdb_del(dev,
@@ -509,7 +530,7 @@ static int dsa_slave_port_obj_del(struct net_device *dev,
 		err = dsa_slave_port_mdb_del(dev, SWITCHDEV_OBJ_PORT_MDB(obj));
 		break;
 	case SWITCHDEV_OBJ_ID_PORT_VLAN:
-		err = dsa_slave_port_vlan_del(dev,
+		err = dsa_slave_port_vlan_del(ds, port,
 					      SWITCHDEV_OBJ_PORT_VLAN(obj));
 		break;
 	default:
-- 
2.9.3

