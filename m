Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E876960AB9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DED54605EE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wg1mWc61Hw6IW5zwpY2Knmt0z1IF8BtEB4HMuYHmjFE=;
 b=K6iSljmJru1XzOvue/lm4aqNQ2Zrj73jk1q9KOBMTd4KKdHVFtTp2e5tsX8DsSiUab2zaHvoOqm6g8NZWPTitJ47Pag9LSZt5wxkQueutoxg7g6kHgaMGfBGHxlvXlQbef4a802/X8zZw7O9tzZ8XqwkbBj9960VwU9Qov3atNLg9GJg/bRrjwk3OCH86FebfZdlAeMr07YAseE3q3MkSK0LzpokegDcxNi+m9dpQTyU6IeV2V6wIap/JetZpcfLJmIhCk1lGijlIWK47rkpCLJmkPFJaT6gLtA/AxtgfNsBo/Nt0XWFiLwzAh+zJaoEBmNukxNJKMEgDtzOAjRmaw==
From: Ido Schimmel <idosch@nvidia.com>
Date: Thu, 10 Nov 2022 10:54:22 +0200
Message-Id: <20221110085422.521059-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next] bridge: Add missing parentheses
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: petrm@nvidia.com, mlxsw@nvidia.com, razor@blackwall.org, Ido Schimmel <idosch@nvidia.com>, edumazet@google.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

No changes in generated code.

Reported-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/bridge/br_input.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index d04d2205ad4e..3027e8f6be15 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -121,7 +121,7 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
 			   test_bit(BR_FDB_LOCAL, &fdb_src->flags)) {
 			/* FDB mismatch. Drop the packet without roaming. */
 			goto drop;
-		} else if test_bit(BR_FDB_LOCKED, &fdb_src->flags) {
+		} else if (test_bit(BR_FDB_LOCKED, &fdb_src->flags)) {
 			/* FDB match, but entry is locked. Refresh it and drop
 			 * the packet.
 			 */
-- 
2.37.3

