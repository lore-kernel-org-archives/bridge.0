Return-Path: <dsahern@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=Mzq1zLYCwX+TF3HzIeCxvxtiFE0GUTp6ppS7IAITapU=;
	b=tMa7dS9VQ6jZgdIJqjE2mJgYSEMVEML0BkTkxW2qsYQa5OB14UvH1b5OGdYrHluzq7
	5EU4X/n1JJprrU9WUL7ci3d3QfE3FixpKB1lVZUDGaQS9rZUqRqKmxVwhnqUQdfzGAX6
	6JgVfZz1w6EaXaXPLQOZxBVHQ2gppj8krf4UgVuWJbI/sJXoeqL2EHPEyxLrflFW32mS
	Nd3/ew8yUTIQuEs7LwY5Twaf40BkW4IpRmJnU6ymlj73JUpLX38ZZz8lQgeMy8lbbSxs
	E+asGHMo7h/LKbWUhVerSXZnFOQR3wKGIYM4UYs3yfLoMwkl8bWusLXiXqiqAUzFr1+r
	Q+UQ==
From: David Ahern <dsahern@gmail.com>
Date: Tue,  3 Oct 2017 21:58:53 -0700
Message-Id: <1507093134-20406-7-git-send-email-dsahern@gmail.com>
In-Reply-To: <1507093134-20406-1-git-send-email-dsahern@gmail.com>
References: <1507093134-20406-1-git-send-email-dsahern@gmail.com>
Subject: [Bridge] [PATCH net-next 6/7] net: bridge: Pass extack to down to
	netdev_master_upper_dev_link
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: j.vosburgh@gmail.com, bridge@lists.linux-foundation.org, idosch@mellanox.com, jiri@mellanox.com, vfalico@gmail.com, David Ahern <dsahern@gmail.com>, davem@davemloft.net

Pass extack arg to br_add_if. Add messages for a couple of failures
and pass arg to netdev_master_upper_dev_link.

Signed-off-by: David Ahern <dsahern@gmail.com>
---
 net/bridge/br_device.c  |  2 +-
 net/bridge/br_if.c      | 15 +++++++++++----
 net/bridge/br_ioctl.c   |  2 +-
 net/bridge/br_private.h |  3 ++-
 4 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index cb0131d70ab1..7acb77c9bd65 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -326,7 +326,7 @@ static int br_add_slave(struct net_device *dev, struct net_device *slave_dev,
 {
 	struct net_bridge *br = netdev_priv(dev);
 
-	return br_add_if(br, slave_dev);
+	return br_add_if(br, slave_dev, extack);
 }
 
 static int br_del_slave(struct net_device *dev, struct net_device *slave_dev)
diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index 0a3fd727048d..59a74a414e20 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -480,7 +480,8 @@ netdev_features_t br_features_recompute(struct net_bridge *br,
 }
 
 /* called with RTNL */
-int br_add_if(struct net_bridge *br, struct net_device *dev)
+int br_add_if(struct net_bridge *br, struct net_device *dev,
+	      struct netlink_ext_ack *extack)
 {
 	struct net_bridge_port *p;
 	int err = 0;
@@ -500,16 +501,22 @@ int br_add_if(struct net_bridge *br, struct net_device *dev)
 		return -EINVAL;
 
 	/* No bridging of bridges */
-	if (dev->netdev_ops->ndo_start_xmit == br_dev_xmit)
+	if (dev->netdev_ops->ndo_start_xmit == br_dev_xmit) {
+		NL_SET_ERR_MSG(extack,
+			       "Can not enslave a bridge to a bridge");
 		return -ELOOP;
+	}
 
 	/* Device is already being bridged */
 	if (br_port_exists(dev))
 		return -EBUSY;
 
 	/* No bridging devices that dislike that (e.g. wireless) */
-	if (dev->priv_flags & IFF_DONT_BRIDGE)
+	if (dev->priv_flags & IFF_DONT_BRIDGE) {
+		NL_SET_ERR_MSG(extack,
+			       "Device does not allow enslaving to a bridge");
 		return -EOPNOTSUPP;
+	}
 
 	p = new_nbp(br, dev);
 	if (IS_ERR(p))
@@ -540,7 +547,7 @@ int br_add_if(struct net_bridge *br, struct net_device *dev)
 
 	dev->priv_flags |= IFF_BRIDGE_PORT;
 
-	err = netdev_master_upper_dev_link(dev, br->dev, NULL, NULL, NULL);
+	err = netdev_master_upper_dev_link(dev, br->dev, NULL, NULL, extack);
 	if (err)
 		goto err5;
 
diff --git a/net/bridge/br_ioctl.c b/net/bridge/br_ioctl.c
index 66cd98772051..8f29103935a3 100644
--- a/net/bridge/br_ioctl.c
+++ b/net/bridge/br_ioctl.c
@@ -98,7 +98,7 @@ static int add_del_if(struct net_bridge *br, int ifindex, int isadd)
 		return -EINVAL;
 
 	if (isadd)
-		ret = br_add_if(br, dev);
+		ret = br_add_if(br, dev, NULL);
 	else
 		ret = br_del_if(br, dev);
 
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 020c709a017f..ab4df24f7bba 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -566,7 +566,8 @@ void br_flood(struct net_bridge *br, struct sk_buff *skb,
 void br_port_carrier_check(struct net_bridge_port *p);
 int br_add_bridge(struct net *net, const char *name);
 int br_del_bridge(struct net *net, const char *name);
-int br_add_if(struct net_bridge *br, struct net_device *dev);
+int br_add_if(struct net_bridge *br, struct net_device *dev,
+	      struct netlink_ext_ack *extack);
 int br_del_if(struct net_bridge *br, struct net_device *dev);
 int br_min_mtu(const struct net_bridge *br);
 netdev_features_t br_features_recompute(struct net_bridge *br,
-- 
2.1.4

