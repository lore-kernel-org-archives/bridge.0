Return-Path: <yuehaibing@huawei.com>
From: YueHaibing <yuehaibing@huawei.com>
Date: Thu, 26 Apr 2018 11:07:05 +0800
Message-ID: <20180426030705.6632-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next] bridge: use hlist_entry_safe
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: stephen@networkplumber.org, davem@davemloft.net
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, YueHaibing <yuehaibing@huawei.com>

Use hlist_entry_safe() instead of open-coding it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 net/bridge/br_forward.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
index b4eed11..7a7fd67 100644
--- a/net/bridge/br_forward.c
+++ b/net/bridge/br_forward.c
@@ -274,8 +274,7 @@ void br_multicast_flood(struct net_bridge_mdb_entry *mdst,
 		struct net_bridge_port *port, *lport, *rport;
 
 		lport = p ? p->port : NULL;
-		rport = rp ? hlist_entry(rp, struct net_bridge_port, rlist) :
-			     NULL;
+		rport = hlist_entry_safe(rp, struct net_bridge_port, rlist);
 
 		if ((unsigned long)lport > (unsigned long)rport) {
 			port = lport;
-- 
2.7.0


