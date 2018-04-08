Return-Path: <laszlth@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:mime-version:content-disposition
	:user-agent; bh=h2d8ZenHu0ODqP7/R4KYZ9olYHQhW03nLef2NpXNGqU=;
	b=RzvAEnSo9TrZnwAXAdQ9LbsTniYaUKoi+TjgllHKGv7w+cQkzlTwcaKZuS2n5jWcHh
	cwbN4vcWucoLJX9Lsby9yFQ7ELiOpk5BKcWMwczSXiyQmeIchNhnNn8vaJrF3xKUM0Ca
	Rsx1q8exhW3qTvlxaF+OqbqJx+w74jjjBea2uF7vZ0g92n/cVKQeif32L5IGILCIim34
	kywN+5TRn65SLnQzkzyXQwVsG06pgwbPhopEVetkBHhOmuGGL5sLogYgCQb3TPj/tIIe
	mGco7my0SQc7ZQCiAviNt1xKkdhZDYhCP/FtrLoJcyy32aR//nP3Ld8BIKNra+1O3joI
	GyjA==
From: Laszlo Toth <laszlth@gmail.com>
Message-ID: <20180408174934.GA3895@laszlth>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Bridge] [PATCH] net: bridge: add missing NULL checks
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Sun, 08 Apr 2018 17:49:39 -0000
To: Stephen Hemminger <stephen@networkplumber.org>, "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org

br_port_get_rtnl() can return NULL

Signed-off-by: Laszlo Toth <laszlth@gmail.com>
---
 net/bridge/br_netlink.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 015f465c..cbec11f 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -939,14 +939,17 @@ static int br_port_slave_changelink(struct net_device *brdev,
 				    struct nlattr *data[],
 				    struct netlink_ext_ack *extack)
 {
+	struct net_bridge_port *port = br_port_get_rtnl(dev);
 	struct net_bridge *br = netdev_priv(brdev);
 	int ret;
 
 	if (!data)
 		return 0;
+	if (!port)
+		return -EINVAL;
 
 	spin_lock_bh(&br->lock);
-	ret = br_setport(br_port_get_rtnl(dev), data);
+	ret = br_setport(port, data);
 	spin_unlock_bh(&br->lock);
 
 	return ret;
@@ -956,7 +959,12 @@ static int br_port_fill_slave_info(struct sk_buff *skb,
 				   const struct net_device *brdev,
 				   const struct net_device *dev)
 {
-	return br_port_fill_attrs(skb, br_port_get_rtnl(dev));
+	struct net_bridge_port *port = br_port_get_rtnl(dev);
+
+	if (!port)
+		return -EINVAL;
+
+	return br_port_fill_attrs(skb, port);
 }
 
 static size_t br_port_get_slave_size(const struct net_device *brdev,
-- 
2.7.4

