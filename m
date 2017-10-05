Return-Path: <dsahern@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=KGcKxgyE9xkvTJhPYW8aqT60bbRa3jW0uDXqn2ARTAQ=;
	b=iHyqslZST9Vvk5we3KbzyEuwvTjID1RaNbIA5nk8b58yus8Dtvndgz8bz1rxfQVaBI
	L13mLzvO2O8scUT28yfQWCfrRHHnaFt2Y/i//xgSqq2dNwK4kylXACjzT6dfVm7xYUxN
	X7CXunyBLABE+d3r4ANORfqkIWWzYxAcFqtILTIYDuhwXyKDibRvD0leOjg8mh0/njsP
	ObHbPcw4E4qLf5zRe25vt6VZ7Vd53q93S+ibjxZwirIjpiYOp4fnTnw6hXomjMzmAqx/
	OtaxB/abaui2vF122m4NLRML+uGueIgSr1jVoeHyUeqoR1L2RoaJWMzy2Qs4kKQyM5IO
	sUVQ==
From: David Ahern <dsahern@gmail.com>
Date: Wed,  4 Oct 2017 17:48:48 -0700
Message-Id: <1507164531-17732-5-git-send-email-dsahern@gmail.com>
In-Reply-To: <1507164531-17732-1-git-send-email-dsahern@gmail.com>
References: <1507164531-17732-1-git-send-email-dsahern@gmail.com>
Subject: [Bridge] [PATCH v2 net-next 4/7] net: vrf: Add extack messages for
	enslave errors
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

Signed-off-by: David Ahern <dsahern@gmail.com>
---
 drivers/net/vrf.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index 77d0655a0250..0b54f553228e 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -772,8 +772,11 @@ static int do_vrf_add_slave(struct net_device *dev, struct net_device *port_dev,
 	/* do not allow loopback device to be enslaved to a VRF.
 	 * The vrf device acts as the loopback for the vrf.
 	 */
-	if (port_dev == dev_net(dev)->loopback_dev)
+	if (port_dev == dev_net(dev)->loopback_dev) {
+		NL_SET_ERR_MSG(extack,
+			       "Can not enslave loopback device to a VRF");
 		return -EOPNOTSUPP;
+	}
 
 	port_dev->priv_flags |= IFF_L3MDEV_SLAVE;
 	ret = netdev_master_upper_dev_link(port_dev, dev, NULL, NULL, extack);
@@ -792,7 +795,13 @@ static int do_vrf_add_slave(struct net_device *dev, struct net_device *port_dev,
 static int vrf_add_slave(struct net_device *dev, struct net_device *port_dev,
 			 struct netlink_ext_ack *extack)
 {
-	if (netif_is_l3_master(port_dev) || netif_is_l3_slave(port_dev))
+	if (netif_is_l3_master(port_dev)) {
+		NL_SET_ERR_MSG(extack,
+			       "Can not enslave an L3 master device to a VRF");
+		return -EINVAL;
+	}
+
+	if (netif_is_l3_slave(port_dev))
 		return -EINVAL;
 
 	return do_vrf_add_slave(dev, port_dev, extack);
-- 
2.1.4

