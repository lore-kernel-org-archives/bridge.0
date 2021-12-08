Return-Path: <sakiwit@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=W9TCKJjdcDwhOK3FQzFGUkG2xpUReurMabSg9HD7/JE=;
 b=EoUEiWQ4wE3l9p2dmaEbEuNRzbe5YfmD4IH+Y76naydoZtE4CHrjKVCFuryTsZT9Gl
 KoGXFs8VDW9u7H/DHlJZwBBdUa8bQJJHneyhxnXpAvVG6feYYLuXk2GwcBMB6AoPmQTI
 LjvEvME1t8Zi7WjJjpAoq/Mx+qJVdmuJe6GQMUv3DJ/wGMHnNE7Izm37qD1lnCGDS4e/
 pXQ2so8d5UC9AhGKYYEWkCTWXYT1SnFSsjEk4vW98AeLBDYh0zQDbDknh2fP5w6eebO+
 jj3cMmwN7/KGMWtjlwKT7Z3IUoHcvWbV/UG/EABbuXN0C8EKuxBRXXBqWcxss5zSN/7y
 hmKg==
From: =?UTF-8?q?J=CE=B5an=20Sacren?= <sakiwit@gmail.com>
Date: Wed,  8 Dec 2021 00:20:21 -0700
Message-Id: <20211208024732.142541-1-sakiwit@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next] net: bridge: netfilter: fix code
	indentation
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de, roopa@nvidia.com, nikolay@nvidia.com, davem@davemloft.net, kuba@kernel.org, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, bridge@lists.linux-foundation.org, netdev@vger.kernel.org

From: Jean Sacren <sakiwit@gmail.com>

Remove the extra space to the left of assignment statement.

Signed-off-by: Jean Sacren <sakiwit@gmail.com>
---
 net/bridge/netfilter/nf_conntrack_bridge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/netfilter/nf_conntrack_bridge.c b/net/bridge/netfilter/nf_conntrack_bridge.c
index fdbed3158555..4a79d25c6391 100644
--- a/net/bridge/netfilter/nf_conntrack_bridge.c
+++ b/net/bridge/netfilter/nf_conntrack_bridge.c
@@ -380,7 +380,7 @@ static unsigned int nf_ct_bridge_confirm(struct sk_buff *skb)
 		protoff = skb_network_offset(skb) + ip_hdrlen(skb);
 		break;
 	case htons(ETH_P_IPV6): {
-		 unsigned char pnum = ipv6_hdr(skb)->nexthdr;
+		unsigned char pnum = ipv6_hdr(skb)->nexthdr;
 		__be16 frag_off;
 
 		protoff = ipv6_skip_exthdr(skb, sizeof(struct ipv6hdr), &pnum,
