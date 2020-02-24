Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mChaMVvWNoAtZi1nGZc55W0b1jW6bAc+WtjlbD6LhY0=;
 b=TR5eC0USeU6oHi0apikX1wcNfk3mz1J8HDHbv0m2R5/3V7m8B7lB6BstgHCOw80Lhb
 v/wWZiuDFlyTWepMzzkvYTroUVlKIkhBky8nmVDqmUWQ0s963F45OgFicE7/TmqCh5KE
 fg9r761XKu3hAa/jWqyJ7vHmnEnc4uNjexd+A=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Mon, 24 Feb 2020 15:07:15 +0200
Message-Id: <20200224130715.1446935-1-nikolay@cumulusnetworks.com>
In-Reply-To: <08a2e28b-fcf5-b26c-da75-97df67f51c7c@cumulusnetworks.com>
References: <08a2e28b-fcf5-b26c-da75-97df67f51c7c@cumulusnetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net] net: bridge: fix stale eth hdr pointer in
	br_dev_xmit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, syzbot+18c8b623c66fc198c493@syzkaller.appspotmail.com, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net

In br_dev_xmit() we perform vlan filtering in br_allowed_ingress() but
if the packet has the vlan header inside (e.g. bridge with disabled
tx-vlan-offload) then the vlan filtering code will use skb_vlan_untag()
to extract the vid before filtering which in turn calls pskb_may_pull()
and we may end up with a stale eth pointer. Moreover the cached eth header
pointer will generally be wrong after that operation. Remove the eth header
caching and just use eth_hdr() directly, the compiler does the right thing
and calculates it only once so we don't lose anything.

Reported-by: syzbot+18c8b623c66fc198c493@syzkaller.appspotmail.com
Fixes: 057658cb33fb ("bridge: suppress arp pkts on BR_NEIGH_SUPPRESS ports")
Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 net/bridge/br_device.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index dc3d2c1dd9d5..0e3dbc5f3c34 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -34,7 +34,6 @@ netdev_tx_t br_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 	const struct nf_br_ops *nf_ops;
 	u8 state = BR_STATE_FORWARDING;
 	const unsigned char *dest;
-	struct ethhdr *eth;
 	u16 vid = 0;
 
 	rcu_read_lock();
@@ -54,15 +53,14 @@ netdev_tx_t br_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 	BR_INPUT_SKB_CB(skb)->frag_max_size = 0;
 
 	skb_reset_mac_header(skb);
-	eth = eth_hdr(skb);
 	skb_pull(skb, ETH_HLEN);
 
 	if (!br_allowed_ingress(br, br_vlan_group_rcu(br), skb, &vid, &state))
 		goto out;
 
 	if (IS_ENABLED(CONFIG_INET) &&
-	    (eth->h_proto == htons(ETH_P_ARP) ||
-	     eth->h_proto == htons(ETH_P_RARP)) &&
+	    (eth_hdr(skb)->h_proto == htons(ETH_P_ARP) ||
+	     eth_hdr(skb)->h_proto == htons(ETH_P_RARP)) &&
 	    br_opt_get(br, BROPT_NEIGH_SUPPRESS_ENABLED)) {
 		br_do_proxy_suppress_arp(skb, br, vid, NULL);
 	} else if (IS_ENABLED(CONFIG_IPV6) &&
-- 
2.24.1

