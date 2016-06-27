Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id;
	bh=JzIoqbvPALuqhXWpvh/jpfdsoJtUZUKK3tVThIs3yXQ=;
	b=OVw/UIuEP/TPXwgXI4Tezf5aVeq7h9qOsNhnHhv79a8Fuk8ySp+PT6sUdN9ZfPuKqr
	o5j++anJ6Fp4kvDvcuYbOz4XKHSYFNd6l6shkRhrja2KUGi+k3n1DVUAaQVmqc45f6+/
	4D4Q4CcBG09hYjvQWmPswBa5zqSt0M8MSStNE=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Mon, 27 Jun 2016 18:34:42 +0200
Message-Id: <1467045282-21612-1-git-send-email-nikolay@cumulusnetworks.com>
Subject: [Bridge] [PATCH net] net: bridge: fix vlan stats continue counter
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net

I made a dumb off-by-one mistake when I added the vlan stats counter
dumping code. The increment should happen before the check, not after
otherwise we miss one entry when we continue dumping.

Fixes: a60c090361ea ("bridge: netlink: export per-vlan stats")
Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 net/bridge/br_netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index a5343c7232bf..85e89f693589 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -1273,7 +1273,7 @@ static int br_fill_linkxstats(struct sk_buff *skb, const struct net_device *dev,
 		struct bridge_vlan_xstats vxi;
 		struct br_vlan_stats stats;
 
-		if (vl_idx++ < *prividx)
+		if (++vl_idx < *prividx)
 			continue;
 		memset(&vxi, 0, sizeof(vxi));
 		vxi.vid = v->vid;
-- 
2.1.4

