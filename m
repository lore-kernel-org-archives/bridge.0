Return-Path: <vvs@parallels.com>
Message-ID: <534FB7D2.3020705@parallels.com>
Date: Thu, 17 Apr 2014 15:15:30 +0400
From: Vasily Averin <vvs@parallels.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Bridge] [PATCH 1/1] superfluous skb->nfct check in
	br_nf_dev_queue_xmit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, Patrick McHardy <kaber@trash.net>

skb->nfct check in br_nf_dev_queue_xmit() does not work if conntracks
are not loaded on the node. This check does not allow to fragment skb
combined from incoming fragments, as results this skb will be dropped
silently in br_dev_queue_push_xmit()

This check was added in commit c197facc8ea08062f8f949aade6a33649ee06771
netfilter: bridge: allow fragmentation of VLAN packets traversing a bridge

I believe this check is superfluous and should be removed.

Signed-off-by: Vasily Averin <vvs@openvz.org>
---
 net/bridge/br_netfilter.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bridge/br_netfilter.c b/net/bridge/br_netfilter.c
index 80e1b0f..6a8407c 100644
--- a/net/bridge/br_netfilter.c
+++ b/net/bridge/br_netfilter.c
@@ -864,7 +864,7 @@ static int br_nf_dev_queue_xmit(struct sk_buff *skb)
 {
 	int ret;
 
-	if (skb->nfct != NULL && skb->protocol == htons(ETH_P_IP) &&
+	if (skb->protocol == htons(ETH_P_IP) &&
 	    skb->len + nf_bridge_mtu_reduction(skb) > skb->dev->mtu &&
 	    !skb_is_gso(skb)) {
 		if (br_parse_ip_options(skb))
-- 
1.7.5.4


