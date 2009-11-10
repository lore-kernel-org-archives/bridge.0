From: Patrick Mullaney <pmullaney@novell.com>
Date: Tue, 10 Nov 2009 17:27:57 -0500
Message-ID: <20091110222757.24100.16046.stgit@mimic.site>
In-Reply-To: <20091110222632.24100.14884.stgit@mimic.site>
References: <20091110222632.24100.14884.stgit@mimic.site>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Bridge] [PATCH 2/4] macvlan: allow in-kernel modules to create and
	manage	macvlan devices
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: alacrityvm-devel@lists.sourceforge.net
Cc: arnd@arndb.de, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, evb@yahoogroups.com

The macvlan driver didn't allow for creation/deletion of devices
by other in-kernel modules. This patch provides common routines
for both in-kernel and netlink based management. This patch
also enables macvlan device support for gro for lower level
devices that support gro.

Signed-off-by: Patrick Mullaney <pmullaney@novell.com>
---

 drivers/net/macvlan.c   |   72 +++++++++++++++++++++++++++++++----------------
 include/linux/macvlan.h |    6 ++++
 2 files changed, 53 insertions(+), 25 deletions(-)

diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index 0a389b8..6b98b26 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -208,7 +208,7 @@ static const struct header_ops macvlan_hard_header_ops = {
 	.cache_update	= eth_header_cache_update,
 };
 
-static int macvlan_open(struct net_device *dev)
+int macvlan_open(struct net_device *dev)
 {
 	struct macvlan_dev *vlan = netdev_priv(dev);
 	struct net_device *lowerdev = vlan->lowerdev;
@@ -235,7 +235,7 @@ out:
 	return err;
 }
 
-static int macvlan_stop(struct net_device *dev)
+int macvlan_stop(struct net_device *dev)
 {
 	struct macvlan_dev *vlan = netdev_priv(dev);
 	struct net_device *lowerdev = vlan->lowerdev;
@@ -316,7 +316,7 @@ static struct lock_class_key macvlan_netdev_addr_lock_key;
 #define MACVLAN_FEATURES \
 	(NETIF_F_SG | NETIF_F_ALL_CSUM | NETIF_F_HIGHDMA | NETIF_F_FRAGLIST | \
 	 NETIF_F_GSO | NETIF_F_TSO | NETIF_F_UFO | NETIF_F_GSO_ROBUST | \
-	 NETIF_F_TSO_ECN | NETIF_F_TSO6)
+	 NETIF_F_TSO_ECN | NETIF_F_TSO6 | NETIF_F_GRO)
 
 #define MACVLAN_STATE_MASK \
 	((1<<__LINK_STATE_NOCARRIER) | (1<<__LINK_STATE_DORMANT))
@@ -440,7 +440,7 @@ static void macvlan_port_destroy(struct net_device *dev)
 	kfree(port);
 }
 
-static void macvlan_transfer_operstate(struct net_device *dev)
+void macvlan_transfer_operstate(struct net_device *dev)
 {
 	struct macvlan_dev *vlan = netdev_priv(dev);
 	const struct net_device *lowerdev = vlan->lowerdev;
@@ -458,6 +458,7 @@ static void macvlan_transfer_operstate(struct net_device *dev)
 			netif_carrier_off(dev);
 	}
 }
+EXPORT_SYMBOL_GPL(macvlan_transfer_operstate);
 
 int macvlan_validate(struct nlattr *tb[], struct nlattr *data[])
 {
@@ -471,11 +472,47 @@ int macvlan_validate(struct nlattr *tb[], struct nlattr *data[])
 }
 EXPORT_SYMBOL_GPL(macvlan_validate);
 
-int macvlan_newlink(struct net_device *dev,
-		    struct nlattr *tb[], struct nlattr *data[])
+int macvlan_link_lowerdev(struct net_device *dev,
+						  struct net_device *lowerdev)
 {
 	struct macvlan_dev *vlan = netdev_priv(dev);
 	struct macvlan_port *port;
+	int err = 0;
+
+	if (lowerdev->macvlan_port == NULL) {
+		err = macvlan_port_create(lowerdev);
+		if (err < 0)
+			return err;
+	}
+	port = lowerdev->macvlan_port;
+
+	vlan->lowerdev = lowerdev;
+	vlan->dev      = dev;
+	vlan->port     = port;
+	vlan->receive  = netif_rx;
+
+	macvlan_init(dev);
+
+	list_add_tail(&vlan->list, &port->vlans);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(macvlan_link_lowerdev);
+
+void macvlan_unlink_lowerdev(struct net_device *dev)
+{
+	struct macvlan_dev *vlan = netdev_priv(dev);
+	struct macvlan_port *port = vlan->port;
+
+	list_del(&vlan->list);
+
+	if (list_empty(&port->vlans))
+		macvlan_port_destroy(port->dev);
+}
+EXPORT_SYMBOL_GPL(macvlan_unlink_lowerdev);
+
+int macvlan_newlink(struct net_device *dev,
+		    struct nlattr *tb[], struct nlattr *data[])
+{
 	struct net_device *lowerdev;
 	int err;
 
@@ -502,23 +539,14 @@ int macvlan_newlink(struct net_device *dev,
 	if (!tb[IFLA_ADDRESS])
 		random_ether_addr(dev->dev_addr);
 
-	if (lowerdev->macvlan_port == NULL) {
-		err = macvlan_port_create(lowerdev);
-		if (err < 0)
-			return err;
-	}
-	port = lowerdev->macvlan_port;
-
-	vlan->lowerdev = lowerdev;
-	vlan->dev      = dev;
-	vlan->port     = port;
-	vlan->receive  = netif_rx;
+	err = macvlan_link_lowerdev(dev, lowerdev);
+	if (err < 0)
+		return err;
 
 	err = register_netdevice(dev);
 	if (err < 0)
 		return err;
 
-	list_add_tail(&vlan->list, &port->vlans);
 	macvlan_transfer_operstate(dev);
 	return 0;
 }
@@ -526,14 +554,8 @@ EXPORT_SYMBOL_GPL(macvlan_newlink);
 
 void macvlan_dellink(struct net_device *dev)
 {
-	struct macvlan_dev *vlan = netdev_priv(dev);
-	struct macvlan_port *port = vlan->port;
-
-	list_del(&vlan->list);
+	macvlan_unlink_lowerdev(dev);
 	unregister_netdevice(dev);
-
-	if (list_empty(&port->vlans))
-		macvlan_port_destroy(port->dev);
 }
 EXPORT_SYMBOL_GPL(macvlan_dellink);
 
diff --git a/include/linux/macvlan.h b/include/linux/macvlan.h
index 3f3c6c3..cf8738a 100644
--- a/include/linux/macvlan.h
+++ b/include/linux/macvlan.h
@@ -24,6 +24,12 @@ struct macvlan_dev {
 };
 
 extern int macvlan_start_xmit(struct sk_buff *skb, struct net_device *dev);
+extern int macvlan_link_lowerdev(struct net_device *dev,
+						  struct net_device *lowerdev);
+
+extern void macvlan_unlink_lowerdev(struct net_device *dev);
+
+extern void macvlan_transfer_operstate(struct net_device *dev);
 
 extern void macvlan_setup(struct net_device *dev);
 

