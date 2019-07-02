Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=jZeZkNBqQvCAlH/hG07VtX1l/wTFKdXlR218Y21cdaA=;
	b=VfM/JxZtMLXdHJ304kMnAg+hNAShLmLB+f4aXwzJ40luxY0rk5+bKx12dupRbLqRIC
	TwCGJTdwyrt1kqFtmp/6+lGZmtXRf//2toowM4iGF9qtZ4XL8nzCGwKj5Xwb0gF7Rdf7
	ZDakyGjX7DTyaxGt/YkAd5+o1aNYkoZICShuk=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Tue,  2 Jul 2019 15:00:19 +0300
Message-Id: <20190702120021.13096-3-nikolay@cumulusnetworks.com>
In-Reply-To: <20190702120021.13096-1-nikolay@cumulusnetworks.com>
References: <20190702120021.13096-1-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net 2/4] net: bridge: mcast: fix stale ipv6 hdr
	pointer when handling v6 query
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: martin@linuxlounge.net, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, yoshfuji@linux-ipv6.org, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, davem@davemloft.net

We get a pointer to the ipv6 hdr in br_ip6_multicast_query but we may
call pskb_may_pull afterwards and end up using a stale pointer.
So use the header directly, it's just 1 place where it's needed.

Fixes: 08b202b67264 ("bridge br_multicast: IPv6 MLD support.")
Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 net/bridge/br_multicast.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index f37897e7b97b..3d8deac2353d 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1279,7 +1279,6 @@ static int br_ip6_multicast_query(struct net_bridge *br,
 				  u16 vid)
 {
 	unsigned int transport_len = ipv6_transport_len(skb);
-	const struct ipv6hdr *ip6h = ipv6_hdr(skb);
 	struct mld_msg *mld;
 	struct net_bridge_mdb_entry *mp;
 	struct mld2_query *mld2q;
@@ -1323,7 +1322,7 @@ static int br_ip6_multicast_query(struct net_bridge *br,
 
 	if (is_general_query) {
 		saddr.proto = htons(ETH_P_IPV6);
-		saddr.u.ip6 = ip6h->saddr;
+		saddr.u.ip6 = ipv6_hdr(skb)->saddr;
 
 		br_multicast_query_received(br, port, &br->ip6_other_query,
 					    &saddr, max_delay);
-- 
2.21.0

