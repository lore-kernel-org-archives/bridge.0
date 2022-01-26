Return-Path: <nikolay@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=17BXUWiIYguEMGJokIrCTOxccvtI2kyM8Bai3DCFDYQ=;
 b=OznK617Nr2luBli1ad7a5RwxE5IiAbmq0F3vASgKKmFyWe4haBo/UqUwJawcS/RdX8j4Ga3P23H0SrdW1qjZjlqdt1zYz1fQXnOEodhYRkzS9Vrmoij/YqDUx52HayXdu+Mf1uKCEsAyjPA8lsgGdc5P6ViG7qUxT2CenzoHEfQZUoO4Yp8mVgWNwHSDBoXgWoMidjeF7RxwFlAgcoqlax+8vP3ZNbNleU40Gif0Io7zbJmDBax/lfCT8BEGOe8Ugu9p9iVfXIopAwYLd9R44dUCz73OwkkI+s7lVkQ5o4+lDJjBo36oTIIrzi5yuDBUjxjj2/znguy3u4MAX65b4Q==
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Date: Wed, 26 Jan 2022 15:10:25 +0200
Message-ID: <20220126131025.2500274-1-nikolay@nvidia.com>
In-Reply-To: <YfC37T23elbsAD0R@d3>
References: <YfC37T23elbsAD0R@d3>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net] net: bridge: vlan: fix single net device
	option dumping
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Benjamin Poirier <bpoirier@nvidia.com>, bridge@lists.linux-foundation.org, Nikolay Aleksandrov <nikolay@nvidia.com>, roopa@nvidia.com, kuba@kernel.org, davem@davemloft.net

When dumping vlan options for a single net device we send the same
entries infinitely because user-space expects a 0 return at the end but
we keep returning skb->len and restarting the dump on retry. Fix it by
returning the value from br_vlan_dump_dev() if it completed or there was
an error. The only case that must return skb->len is when the dump was
incomplete and needs to continue (-EMSGSIZE).

Reported-by: Benjamin Poirier <bpoirier@nvidia.com>
Fixes: 8dcea187088b ("net: bridge: vlan: add rtm definitions and dump support")
Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
 net/bridge/br_vlan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 84ba456a78cc..43201260e37b 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -2020,7 +2020,8 @@ static int br_vlan_rtm_dump(struct sk_buff *skb, struct netlink_callback *cb)
 			goto out_err;
 		}
 		err = br_vlan_dump_dev(dev, skb, cb, dump_flags);
-		if (err && err != -EMSGSIZE)
+		/* if the dump completed without an error we return 0 here */
+		if (err != -EMSGSIZE)
 			goto out_err;
 	} else {
 		for_each_netdev_rcu(net, dev) {
-- 
2.34.1

