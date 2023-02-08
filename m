Return-Path: <yang.lee@linux.alibaba.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C1FE981D7D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EB2A681CFE
From: Yang Li <yang.lee@linux.alibaba.com>
Date: Wed,  8 Feb 2023 08:56:26 +0800
Message-Id: <20230208005626.56847-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH -next] net: bridge: clean up one inconsistent
	indenting
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, razor@blackwall.org, bridge@lists.linux-foundation.org, Abaci Robot <abaci@linux.alibaba.com>, linux-kernel@vger.kernel.org, edumazet@google.com, Yang Li <yang.lee@linux.alibaba.com>, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com

./net/bridge/br_netlink_tunnel.c:317:4-27: code aligned with following code on line 318

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3977
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 net/bridge/br_netlink_tunnel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/br_netlink_tunnel.c b/net/bridge/br_netlink_tunnel.c
index 17abf092f7ca..eff949bfdd83 100644
--- a/net/bridge/br_netlink_tunnel.c
+++ b/net/bridge/br_netlink_tunnel.c
@@ -315,7 +315,7 @@ int br_process_vlan_tunnel_info(const struct net_bridge *br,
 
 			if (curr_change)
 				*changed = curr_change;
-			 __vlan_tunnel_handle_range(p, &v_start, &v_end, v,
+			__vlan_tunnel_handle_range(p, &v_start, &v_end, v,
 						    curr_change);
 		}
 		if (v_start && v_end)
-- 
2.20.1.7.g153144c

