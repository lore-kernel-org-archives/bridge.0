Return-Path: <santoshprasadnayak@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=from:to:cc:subject:date:message-id:x-mailer;
	bh=58hswqmYdvjrRMEYGy6nVO0NjKWDSwDysaHw7EmQWXQ=;
	b=iEU36iFNBeZuYzpsiTl2GNma9dLX66aIPFhPIJMqXjDluyORy7/4Ti6pFlgHkaDZT7
	3unY9KRloIntv3lLvfaIHFyaemBkXWq8cULg26EsnLm/y6yPl4IvqClRM0n4zunxo+CC
	vbFeJOWL9J0agB+QkdcIpfC6Gcw40QXIHzXLA=
From: santosh nayak <santoshprasadnayak@gmail.com>
Date: Thu,  1 Mar 2012 14:47:46 +0530
Message-Id: <1330593466-19317-1-git-send-email-santoshprasadnayak@gmail.com>
Subject: [Bridge] [PATCH 3/3] netfilter: Remove redundant code.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bart.de.schuymer@pandora.be
Cc: Santosh Nayak <santoshprasadnayak@gmail.com>, coreteam@netfilter.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net, netfilter@vger.kernel.org, netfilter-devel@vger.kernel.org, shemminger@vyatta.com, pablo@netfilter.org

From: Santosh Nayak <santoshprasadnayak@gmail.com>

Remove the redundant code.

Signed-off-by: Santosh Nayak <santoshprasadnayak@gmail.com>
---
 net/bridge/netfilter/ebtables.c |   18 ++++++------------
 1 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebtables.c
index 9c0f177..1efc234 100644
--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -226,10 +226,8 @@ unsigned int ebt_do_table (unsigned int hook, struct sk_buff *skb,
 
 		if (EBT_MATCH_ITERATE(point, ebt_do_match, skb, &acpar) != 0)
 			goto letscontinue;
-		if (acpar.hotdrop) {
-			read_unlock_bh(&table->lock);
-			return NF_DROP;
-		}
+		if (acpar.hotdrop)
+			goto out;
 
 		/* increase counter */
 		(*(counter_base + i)).pcnt++;
@@ -253,10 +251,8 @@ unsigned int ebt_do_table (unsigned int hook, struct sk_buff *skb,
 			read_unlock_bh(&table->lock);
 			return NF_ACCEPT;
 		}
-		if (verdict == EBT_DROP) {
-			read_unlock_bh(&table->lock);
-			return NF_DROP;
-		}
+		if (verdict == EBT_DROP)
+			goto out;
 		if (verdict == EBT_RETURN) {
 letsreturn:
 #ifdef CONFIG_NETFILTER_DEBUG
@@ -281,8 +277,7 @@ letsreturn:
 #ifdef CONFIG_NETFILTER_DEBUG
 		if (verdict < 0) {
 			BUGPRINT("bogus standard verdict\n");
-			read_unlock_bh(&table->lock);
-			return NF_DROP;
+			goto out;
 		}
 #endif
 		/* jump to a udc */
@@ -294,8 +289,7 @@ letsreturn:
 #ifdef CONFIG_NETFILTER_DEBUG
 		if (chaininfo->distinguisher) {
 			BUGPRINT("jump to non-chain\n");
-			read_unlock_bh(&table->lock);
-			return NF_DROP;
+			goto out;
 		}
 #endif
 		nentries = chaininfo->nentries;
-- 
1.7.4.4

