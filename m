Return-Path: <joe@perches.com>
From: Joe Perches <joe@perches.com>
Date: Sat, 31 Mar 2018 00:05:19 -0700
Message-Id: <df70bafdca663db034626f4f1525826ea263bf2c.1522479607.git.joe@perches.com>
In-Reply-To: <cover.1522479607.git.joe@perches.com>
References: <cover.1522479607.git.joe@perches.com>
Subject: [Bridge] [PATCH 04/12] bridge: netfilter: Use the new global
	ether_<foo>_addr arrays
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>, Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, coreteam@netfilter.org, netfilter-devel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>

Remove the local consts and use the new globals.

Signed-off-by: Joe Perches <joe@perches.com>
---
 net/bridge/netfilter/ebt_stp.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/bridge/netfilter/ebt_stp.c b/net/bridge/netfilter/ebt_stp.c
index 3140eb912d7e..2b7479cc0140 100644
--- a/net/bridge/netfilter/ebt_stp.c
+++ b/net/bridge/netfilter/ebt_stp.c
@@ -153,8 +153,6 @@ ebt_stp_mt(const struct sk_buff *skb, struct xt_action_param *par)
 static int ebt_stp_mt_check(const struct xt_mtchk_param *par)
 {
 	const struct ebt_stp_info *info = par->matchinfo;
-	const u8 bridge_ula[6] = {0x01, 0x80, 0xc2, 0x00, 0x00, 0x00};
-	const u8 msk[6] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 	const struct ebt_entry *e = par->entryinfo;
 
 	if (info->bitmask & ~EBT_STP_MASK || info->invflags & ~EBT_STP_MASK ||
@@ -162,8 +160,8 @@ static int ebt_stp_mt_check(const struct xt_mtchk_param *par)
 		return -EINVAL;
 	/* Make sure the match only receives stp frames */
 	if (!par->nft_compat &&
-	    (!ether_addr_equal(e->destmac, bridge_ula) ||
-	     !ether_addr_equal(e->destmsk, msk) ||
+	    (!ether_addr_equal(e->destmac, ether_stp_addr) ||
+	     !ether_addr_equal(e->destmsk, ether_broadcast_addr) ||
 	     !(e->bitmask & EBT_DESTMAC)))
 		return -EINVAL;
 
-- 
2.15.0

