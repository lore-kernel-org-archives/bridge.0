Return-Path: <yuehaibing@huawei.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4ACE641817
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8F48D40879
From: YueHaibing <yuehaibing@huawei.com>
Date: Wed, 26 Jul 2023 22:31:41 +0800
Message-ID: <20230726143141.11704-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next] bridge: Remove unused declaration
	br_multicast_set_hash_max()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: roopa@nvidia.com, razor@blackwall.org, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, idosch@nvidia.com
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, YueHaibing <yuehaibing@huawei.com>, linux-kernel@vger.kernel.org

Since commit 19e3a9c90c53 ("net: bridge: convert multicast to generic rhashtable")
this is not used, so can remove it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 net/bridge/br_private.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 51e4ca54b537..a1f4acfa6994 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -974,7 +974,6 @@ int br_multicast_set_vlan_router(struct net_bridge_vlan *v, u8 mcast_router);
 int br_multicast_toggle(struct net_bridge *br, unsigned long val,
 			struct netlink_ext_ack *extack);
 int br_multicast_set_querier(struct net_bridge_mcast *brmctx, unsigned long val);
-int br_multicast_set_hash_max(struct net_bridge *br, unsigned long val);
 int br_multicast_set_igmp_version(struct net_bridge_mcast *brmctx,
 				  unsigned long val);
 #if IS_ENABLED(CONFIG_IPV6)
-- 
2.34.1

