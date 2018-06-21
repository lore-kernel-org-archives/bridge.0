Return-Path: <garrmcnu@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=PBJi5chp3HZzw5kkLKHlKCBDe5LsJc9Lk7cWakQM+Uc=;
	b=ddIpZeRccOMiiKGlwy/00tO4UnBlZYaBk1i7ZlgEKakiRkplbpjCC0+k+l2VrPnDIL
	CfSF2AU4YzzHLrnZiZIhQsGMe8LxbITzbZJnqGvAppFomDXGYn5Rm9YoXtcb6Kv5DHnA
	k+lch0MmFzOClMzqT0FmImfFxAeKiDyFeR40rMRzNau6Q5aqmdNOo0F4finASRN14bY2
	R7B09W2VZJk8yz2I6661X8yw63+N62fhVWtoei6QV0w+YnvCY8Dv6XN9GfyCZgBpe/vQ
	etS2lIKiUvLMQzHr1BdBFmKhUkEfNhFzT1OiaLYDCPWmeKmFCpTBrJhMOoy7KxnMoIxo
	q78w==
From: Garry McNulty <garrmcnu@gmail.com>
Date: Thu, 21 Jun 2018 21:14:27 +0100
Message-Id: <20180621201427.4961-1-garrmcnu@gmail.com>
Subject: [Bridge] [PATCH] net: bridge: fix potential null pointer
	dereference on return from br_port_get_rtnl()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: jiri@resnulli.us, nikolay@cumulusnetworks.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Garry McNulty <garrmcnu@gmail.com>, davem@davemloft.net

br_port_get_rtnl() can return NULL if the network device is not a bridge
port (IFF_BRIDGE_PORT flag not set). br_port_slave_changelink() and
br_port_fill_slave_info() callbacks dereference this pointer without
checking. Currently this is not a problem because slave devices always
set this flag. Add null check in case these conditions ever change.

Detected by CoverityScan, CID 1339613 ("Dereference null return value")

Signed-off-by: Garry McNulty <garrmcnu@gmail.com>
---
 net/bridge/br_netlink.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 9f5eb05b0373..b3ad135b7157 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -947,13 +947,14 @@ static int br_port_slave_changelink(struct net_device *brdev,
 				    struct netlink_ext_ack *extack)
 {
 	struct net_bridge *br = netdev_priv(brdev);
+	struct net_bridge_port *p = br_port_get_rtnl(dev);
 	int ret;
 
-	if (!data)
+	if (!data || !p)
 		return 0;
 
 	spin_lock_bh(&br->lock);
-	ret = br_setport(br_port_get_rtnl(dev), data);
+	ret = br_setport(p, data);
 	spin_unlock_bh(&br->lock);
 
 	return ret;
@@ -963,7 +964,9 @@ static int br_port_fill_slave_info(struct sk_buff *skb,
 				   const struct net_device *brdev,
 				   const struct net_device *dev)
 {
-	return br_port_fill_attrs(skb, br_port_get_rtnl(dev));
+	struct net_bridge_port *p = br_port_get_rtnl(dev);
+
+	return p ? br_port_fill_attrs(skb, p) : -EINVAL;
 }
 
 static size_t br_port_get_slave_size(const struct net_device *brdev,
-- 
2.14.4

