Return-Path: <colin.king@canonical.com>
From: Colin King <colin.king@canonical.com>
Date: Fri, 18 Jun 2021 11:01:55 +0100
Message-Id: <20210618100155.101386-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH] net: bridge: remove redundant continue statement
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Roopa Prabhu <roopa@nvidia.com>, "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, bridge@lists.linux-foundation.org, netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The continue statement at the end of a for-loop has no effect,
invert the if expression and remove the continue.

Addresses-Coverity: ("Continue has no effect")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 net/bridge/br_vlan.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index da3256a3eed0..8789a57af543 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -113,9 +113,7 @@ static void __vlan_add_list(struct net_bridge_vlan *v)
 	headp = &vg->vlan_list;
 	list_for_each_prev(hpos, headp) {
 		vent = list_entry(hpos, struct net_bridge_vlan, vlist);
-		if (v->vid < vent->vid)
-			continue;
-		else
+		if (v->vid >= vent->vid)
 			break;
 	}
 	list_add_rcu(&v->vlist, hpos);
-- 
2.31.1

