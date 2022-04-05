Return-Path: <kevmitch@arista.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
 s=Arista-A; t=1649202723;
 bh=9kdpNgsn3CncHbqtialrLPvzG1lWo7Pqp9XRY5xEnjw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=fzQ19VBdiqY3CF/xb83ZjfywlR4HnCBIVvkwfXSMkR6Q1PUp9Uhyu0Qke0Zxy0d2Q
 pUC9JsUtR2pkI9ztPqSCCud9wbX+RIBeWPe3A7a/EzZhKP6v3rwlaGMqK0Mh6HH3Vv
 +K00t8zszUrg30lIoZBkN7Q12wBc8ynIu0vp5RwkROVgUVRuMcsyDzQTjJCU+N5oYb
 3aTtpyDry2c9WdRzW357mRn1Rn7TDJYF9vMuurIxYOgHXq9RQmr67WkHb3KFgqFY87
 /2+i1dNiUcMKbiqonv8tBt9D3CQDrHMFoSWA6F9nCZWplhfMMTG8eGaNyZZ+HZ1lI9
 utxxzKBvaoE2g==
From: Kevin Mitchell <kevmitch@arista.com>
Date: Tue,  5 Apr 2022 16:51:16 -0700
Message-Id: <20220405235117.269511-2-kevmitch@arista.com>
In-Reply-To: <20220405235117.269511-1-kevmitch@arista.com>
References: <20220405235117.269511-1-kevmitch@arista.com>
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH 1/1] netfilter: conntrack: skip verification of
	zero UDP checksum
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Cc: kevmitch@arista.com, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org, gal@nvidia.com, bridge@lists.linux-foundation.org, Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org, Jozsef Kadlecsik <kadlec@netfilter.org>, coreteam@netfilter.org, netfilter-devel@vger.kernel.org, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, "David S. Miller" <davem@davemloft.net>, Pablo Neira Ayuso <pablo@netfilter.org>

The checksum is optional for UDP packets in IPv4. However nf_reject
would previously require a valid checksum to illicit a response such as
ICMP_DEST_UNREACH.

Add some logic to nf_reject_verify_csum to determine if a UDP packet has
a zero checksum and should therefore not be verified. Explicitly require
a valid checksum for IPv6 consistent RFC 2460 and with the non-netfilter
stack (see udp6_csum_zero_error).

Signed-off-by: Kevin Mitchell <kevmitch@arista.com>
---
 include/net/netfilter/nf_reject.h        | 27 ++++++++++++++++++++----
 net/bridge/netfilter/nft_reject_bridge.c |  6 ++++--
 net/ipv4/netfilter/nf_reject_ipv4.c      |  6 ++++--
 net/ipv6/netfilter/nf_reject_ipv6.c      |  2 +-
 4 files changed, 32 insertions(+), 9 deletions(-)

diff --git a/include/net/netfilter/nf_reject.h b/include/net/netfilter/nf_reject.h
index 9051c3a0c8e7..f248c1ff8b22 100644
--- a/include/net/netfilter/nf_reject.h
+++ b/include/net/netfilter/nf_reject.h
@@ -5,12 +5,34 @@
 #include <linux/types.h>
 #include <uapi/linux/in.h>
 
-static inline bool nf_reject_verify_csum(__u8 proto)
+static inline bool nf_reject_verify_csum(struct sk_buff *skb, int dataoff,
+					  __u8 proto)
 {
 	/* Skip protocols that don't use 16-bit one's complement checksum
 	 * of the entire payload.
 	 */
 	switch (proto) {
+		/* Protocols with optional checksums. */
+		case IPPROTO_UDP: {
+			const struct udphdr *udp_hdr;
+			struct udphdr _udp_hdr;
+
+			/* Checksum is required in IPv6
+			 * see RFC 2460 section 8.1
+			 */
+			if (skb->protocol == htons(ETH_P_IPV6))
+				return true;
+
+			udp_hdr = skb_header_pointer(skb, dataoff,
+						     sizeof(_udp_hdr),
+						     &_udp_hdr);
+			if (!udp_hdr || udp_hdr->check)
+				return true;
+
+			return false;
+		}
+		case IPPROTO_GRE:
+
 		/* Protocols with other integrity checks. */
 		case IPPROTO_AH:
 		case IPPROTO_ESP:
@@ -19,9 +41,6 @@ static inline bool nf_reject_verify_csum(__u8 proto)
 		/* Protocols with partial checksums. */
 		case IPPROTO_UDPLITE:
 		case IPPROTO_DCCP:
-
-		/* Protocols with optional checksums. */
-		case IPPROTO_GRE:
 			return false;
 	}
 	return true;
diff --git a/net/bridge/netfilter/nft_reject_bridge.c b/net/bridge/netfilter/nft_reject_bridge.c
index deae2c9a0f69..e6d62de95378 100644
--- a/net/bridge/netfilter/nft_reject_bridge.c
+++ b/net/bridge/netfilter/nft_reject_bridge.c
@@ -111,6 +111,7 @@ static void nft_reject_br_send_v4_unreach(struct net *net,
 	unsigned int len;
 	__wsum csum;
 	u8 proto;
+	int dataoff;
 
 	if (!nft_bridge_iphdr_validate(oldskb))
 		return;
@@ -129,9 +130,10 @@ static void nft_reject_br_send_v4_unreach(struct net *net,
 		return;
 
 	proto = ip_hdr(oldskb)->protocol;
+	dataoff = ip_hdrlen(oldskb);
 
 	if (!skb_csum_unnecessary(oldskb) &&
-	    nf_reject_verify_csum(proto) &&
+	    nf_reject_verify_csum(oldskb, dataoff, proto) &&
 	    nf_ip_checksum(oldskb, hook, ip_hdrlen(oldskb), proto))
 		return;
 
@@ -234,7 +236,7 @@ static bool reject6_br_csum_ok(struct sk_buff *skb, int hook)
 	if (thoff < 0 || thoff >= skb->len || (fo & htons(~0x7)) != 0)
 		return false;
 
-	if (!nf_reject_verify_csum(proto))
+	if (!nf_reject_verify_csum(skb, thoff, proto))
 		return true;
 
 	return nf_ip6_checksum(skb, hook, thoff, proto) == 0;
diff --git a/net/ipv4/netfilter/nf_reject_ipv4.c b/net/ipv4/netfilter/nf_reject_ipv4.c
index 93b07739807b..7a83fe1c2675 100644
--- a/net/ipv4/netfilter/nf_reject_ipv4.c
+++ b/net/ipv4/netfilter/nf_reject_ipv4.c
@@ -189,6 +189,7 @@ void nf_send_unreach(struct sk_buff *skb_in, int code, int hook)
 {
 	struct iphdr *iph = ip_hdr(skb_in);
 	u8 proto = iph->protocol;
+	int dataoff = ip_hdrlen(skb_in);
 
 	if (iph->frag_off & htons(IP_OFFSET))
 		return;
@@ -196,12 +197,13 @@ void nf_send_unreach(struct sk_buff *skb_in, int code, int hook)
 	if (hook == NF_INET_PRE_ROUTING && nf_reject_fill_skb_dst(skb_in))
 		return;
 
-	if (skb_csum_unnecessary(skb_in) || !nf_reject_verify_csum(proto)) {
+	if (skb_csum_unnecessary(skb_in) ||
+	    !nf_reject_verify_csum(skb_in, dataoff, proto)) {
 		icmp_send(skb_in, ICMP_DEST_UNREACH, code, 0);
 		return;
 	}
 
-	if (nf_ip_checksum(skb_in, hook, ip_hdrlen(skb_in), proto) == 0)
+	if (nf_ip_checksum(skb_in, hook, dataoff, proto) == 0)
 		icmp_send(skb_in, ICMP_DEST_UNREACH, code, 0);
 }
 EXPORT_SYMBOL_GPL(nf_send_unreach);
diff --git a/net/ipv6/netfilter/nf_reject_ipv6.c b/net/ipv6/netfilter/nf_reject_ipv6.c
index 4aef6baaa55e..ac9574c6068f 100644
--- a/net/ipv6/netfilter/nf_reject_ipv6.c
+++ b/net/ipv6/netfilter/nf_reject_ipv6.c
@@ -253,7 +253,7 @@ static bool reject6_csum_ok(struct sk_buff *skb, int hook)
 	if (thoff < 0 || thoff >= skb->len || (fo & htons(~0x7)) != 0)
 		return false;
 
-	if (!nf_reject_verify_csum(proto))
+	if (!nf_reject_verify_csum(skb, thoff, proto))
 		return true;
 
 	return nf_ip6_checksum(skb, hook, thoff, proto) == 0;
-- 
2.35.1

