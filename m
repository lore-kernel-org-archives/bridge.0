Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=rZxXJwYxAkIqlWW9ToIz/na+DdIIiww4zlldV7I6DQs=;
	b=DEDZzKI1BfUChE7VxFL1xEBeKS8Rsoxa6scPRnQ2ZzB5udwViwKhAc5x+NWTWQnEnQ
	rghJcys2Rmw6QSbRod913RrTUu7EuHZTrATMiHc51YS2hzVgguFWMLcfO7sWBhaoyUrf
	kDNBwASMPmZHsxqM9bpH7S7zZQWP2JPiPZHXjW0j0pkXT/1+lwDOles+1F5UdfMmT20k
	SJKIuDBEQe5sprqXYDgzfQuOrfpEg3OYYLbTLxpK5bEDomVVlGqYlyf/3nLWSMDMBZCE
	Hj+x/KWRsZM+ZX0i+ODNKFbKRqpLpsKBmZ7xs2POyFtV+JoeIup5fKZgMZ5B1MKK191T
	+tcA==
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Tue,  5 Feb 2019 14:13:08 -0800
Message-Id: <20190205221311.18476-10-f.fainelli@gmail.com>
In-Reply-To: <20190205221311.18476-1-f.fainelli@gmail.com>
References: <20190205221311.18476-1-f.fainelli@gmail.com>
Subject: [Bridge] [PATCH net-next v2 09/12] netdevsim: Implement
	ndo_get_port_parent_id()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>, Florian Fainelli <f.fainelli@gmail.com>, "open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>, "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, open list <linux-kernel@vger.kernel.org>, Ido Schimmel <idosch@mellanox.com>, "open list:NETRONOME ETHERNET DRIVERS" <oss-drivers@netronome.com>, "David S. Miller" <davem@davemloft.net>

netdevsim only supports SWITCHDEV_ATTR_ID_PORT_PARENT_ID, which makes it a
great candidate to be converted to use the ndo_get_port_parent_id() NDO
instead of implementing switchdev_port_attr_get().

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/netdevsim/netdev.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 8d8e2b3f263e..84de37478624 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -148,26 +148,16 @@ static struct device_type nsim_dev_type = {
 	.release = nsim_dev_release,
 };
 
-static int
-nsim_port_attr_get(struct net_device *dev, struct switchdev_attr *attr)
+static int nsim_get_port_parent_id(struct net_device *dev,
+				   struct netdev_phys_item_id *ppid)
 {
 	struct netdevsim *ns = netdev_priv(dev);
 
-	switch (attr->id) {
-	case SWITCHDEV_ATTR_ID_PORT_PARENT_ID:
-		attr->u.ppid.id_len = sizeof(ns->sdev->switch_id);
-		memcpy(&attr->u.ppid.id, &ns->sdev->switch_id,
-		       attr->u.ppid.id_len);
-		return 0;
-	default:
-		return -EOPNOTSUPP;
-	}
+	ppid->id_len = sizeof(ns->sdev->switch_id);
+	memcpy(&ppid->id, &ns->sdev->switch_id, ppid->id_len);
+	return 0;
 }
 
-static const struct switchdev_ops nsim_switchdev_ops = {
-	.switchdev_port_attr_get	= nsim_port_attr_get,
-};
-
 static int nsim_init(struct net_device *dev)
 {
 	char sdev_ddir_name[10], sdev_link_name[32];
@@ -214,7 +204,6 @@ static int nsim_init(struct net_device *dev)
 		goto err_bpf_uninit;
 
 	SET_NETDEV_DEV(dev, &ns->dev);
-	SWITCHDEV_SET_OPS(dev, &nsim_switchdev_ops);
 
 	err = nsim_devlink_setup(ns);
 	if (err)
@@ -493,6 +482,7 @@ static const struct net_device_ops nsim_netdev_ops = {
 	.ndo_setup_tc		= nsim_setup_tc,
 	.ndo_set_features	= nsim_set_features,
 	.ndo_bpf		= nsim_bpf,
+	.ndo_get_port_parent_id	= nsim_get_port_parent_id,
 };
 
 static void nsim_setup(struct net_device *dev)
-- 
2.17.1

