Return-Path: <cera@cera.cz>
From: Ivan Vecera <cera@cera.cz>
Date: Fri, 20 Jan 2017 17:46:21 +0100
Message-Id: <20170120164621.19539-1-cera@cera.cz>
Subject: [Bridge] [PATCH net] bridge: netlink: call br_changelink() during
	br_dev_newlink()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: jiri@mellanox.com, bridge@lists.linux-foundation.org, davem@davemloft.net

Any bridge options specified during link creation (e.g. ip link add)
are ignored as br_dev_newlink() does not process them.
Use br_changelink() to do it.

Signed-off-by: Ivan Vecera <cera@cera.cz>
---
 net/bridge/br_netlink.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 71c7453..7109b38 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -781,20 +781,6 @@ static int br_validate(struct nlattr *tb[], struct nlattr *data[])
 	return 0;
 }
 
-static int br_dev_newlink(struct net *src_net, struct net_device *dev,
-			  struct nlattr *tb[], struct nlattr *data[])
-{
-	struct net_bridge *br = netdev_priv(dev);
-
-	if (tb[IFLA_ADDRESS]) {
-		spin_lock_bh(&br->lock);
-		br_stp_change_bridge_id(br, nla_data(tb[IFLA_ADDRESS]));
-		spin_unlock_bh(&br->lock);
-	}
-
-	return register_netdevice(dev);
-}
-
 static int br_port_slave_changelink(struct net_device *brdev,
 				    struct net_device *dev,
 				    struct nlattr *tb[],
@@ -1115,6 +1101,25 @@ static int br_changelink(struct net_device *brdev, struct nlattr *tb[],
 	return 0;
 }
 
+static int br_dev_newlink(struct net *src_net, struct net_device *dev,
+			  struct nlattr *tb[], struct nlattr *data[])
+{
+	struct net_bridge *br = netdev_priv(dev);
+	int err;
+
+	if (tb[IFLA_ADDRESS]) {
+		spin_lock_bh(&br->lock);
+		br_stp_change_bridge_id(br, nla_data(tb[IFLA_ADDRESS]));
+		spin_unlock_bh(&br->lock);
+	}
+
+	err = br_changelink(dev, tb, data);
+	if (err)
+		return err;
+
+	return register_netdevice(dev);
+}
+
 static size_t br_get_size(const struct net_device *brdev)
 {
 	return nla_total_size(sizeof(u32)) +	/* IFLA_BR_FORWARD_DELAY  */
-- 
2.10.2

