Return-Path: <yanaijie@huawei.com>
From: Jason Yan <yanaijie@huawei.com>
Message-ID: <20200506061616.18929-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next] net: bridge: return false in
	br_mrp_enabled()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Wed, 06 May 2020 06:17:13 -0000
To: roopa@cumulusnetworks.com, nikolay@cumulusnetworks.com, davem@davemloft.net, kuba@kernel.org, bridge@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jason Yan <yanaijie@huawei.com>

Fix the following coccicheck warning:

net/bridge/br_private.h:1334:8-9: WARNING: return of 0/1 in function
'br_mrp_enabled' with return type bool

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 net/bridge/br_private.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index c35647cb138a..78d3a951180d 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -1331,7 +1331,7 @@ static inline int br_mrp_process(struct net_bridge_port *p, struct sk_buff *skb)
 
 static inline bool br_mrp_enabled(struct net_bridge *br)
 {
-	return 0;
+	return false;
 }
 
 static inline void br_mrp_port_del(struct net_bridge *br,
-- 
2.21.1

