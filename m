Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E5D01616A7
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 317D9616A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mUBz3SNGRtZLHFv2gMuTh4u3NUMpfV/b/lJ/ml+HcG8=;
 b=Il7Pih+MEdd06TGaaR6S3tMQuA/myOypRwu/9kEOXsSZzO8Hh7i2BspovX+15Rgh49KJlv/EUioDLhBQe98ASjp5LWHjj8ecBTiOYw6zGugY2V+b11dhAUv5mrEfX5UmmbpuuCvRRl+xMPqcjLc4v+Ofyg9I56Twj9NbB/w7L2ItfOgvGh/0X/uplaTA99vXg5zmuQ9TK/patVu/JDi8lcBNeTosv1VhtaC/eEkaedK/eihULQYfUZa351FU9h7IRZHgKzGxsQxz6C0up100n/7kIAlLisxyyKwGwwJEiBoAjlu3rngq9XZMyfN/k2IIykbM6MujGUBXh0HI4oXIaQ==
From: Ido Schimmel <idosch@nvidia.com>
Date: Wed, 19 Apr 2023 18:34:52 +0300
Message-Id: <20230419153500.2655036-2-idosch@nvidia.com>
In-Reply-To: <20230419153500.2655036-1-idosch@nvidia.com>
References: <20230419153500.2655036-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next v2 1/9] bridge: Reorder neighbor
	suppression check when flooding
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: mlxsw@nvidia.com, razor@blackwall.org, Ido Schimmel <idosch@nvidia.com>, edumazet@google.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

The bridge does not flood ARP / NS packets for which a reply was sent to
bridge ports that have neighbor suppression enabled.

Subsequent patches are going to add per-{Port, VLAN} neighbor
suppression, which is going to make it more expensive to check whether
neighbor suppression is enabled since a VLAN lookup will be required.

Therefore, instead of unnecessarily performing this lookup for every
packet, only perform it for ARP / NS packets for which a reply was sent.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_forward.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
index 02bb620d3b8d..0fe133fa214c 100644
--- a/net/bridge/br_forward.c
+++ b/net/bridge/br_forward.c
@@ -224,8 +224,8 @@ void br_flood(struct net_bridge *br, struct sk_buff *skb,
 		/* Do not flood to ports that enable proxy ARP */
 		if (p->flags & BR_PROXYARP)
 			continue;
-		if ((p->flags & (BR_PROXYARP_WIFI | BR_NEIGH_SUPPRESS)) &&
-		    BR_INPUT_SKB_CB(skb)->proxyarp_replied)
+		if (BR_INPUT_SKB_CB(skb)->proxyarp_replied &&
+		    (p->flags & (BR_PROXYARP_WIFI | BR_NEIGH_SUPPRESS)))
 			continue;
 
 		prev = maybe_deliver(prev, p, skb, local_orig);
-- 
2.37.3

