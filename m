Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=qCMhE+IyUNZpEb0UQLMt2yWkZywg/6AiYdFZuGY7RYo=;
	b=fxsnnsW8cpD6k092sXOhtgpGpBkjSqp35ceZ5w2aseVgDIlLLpLwM/+vS0pUlgZ+LN
	45so0yu+/FWoBPE7wQ/qQzC0U5jM9qDW7dEzJUlZ59jM8jZ6+rifQ0PEoA6sw6Ep2yO7
	2uVYOIHMcdqT/I3gcy+SYPC++nIcVK6FOnRWY=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Sat, 27 Oct 2018 12:07:47 +0300
Message-Id: <20181027090747.22104-1-nikolay@cumulusnetworks.com>
In-Reply-To: <90c5f2fe-1743-6b17-2e44-eba58cdbbb35@cumulusnetworks.com>
References: <90c5f2fe-1743-6b17-2e44-eba58cdbbb35@cumulusnetworks.com>
Subject: [Bridge] [PATCH net] net: bridge: remove ipv6 zero address check in
	mcast queries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, yinxu@redhat.com, liuhangbin@gmail.com, davem@davemloft.net

Recently a check was added which prevents marking of routers with zero
source address, but for IPv6 that cannot happen as the relevant RFCs
actually forbid such packets:
RFC 2710 (MLDv1):
"To be valid, the Query message MUST
 come from a link-local IPv6 Source Address, be at least 24 octets
 long, and have a correct MLD checksum."

Same goes for RFC 3810.

And also it can be seen as a requirement in ipv6_mc_check_mld_query()
which is used by the bridge to validate the message before processing
it. Thus any queries with :: source address won't be processed anyway.
So just remove the check for zero IPv6 source address from the query
processing function.

Fixes: 5a2de63fd1a5 ("bridge: do not add port to router list when receives query with source 0.0.0.0")
Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 net/bridge/br_multicast.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 41cdafbf2ebe..6bac0d6b7b94 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1428,8 +1428,7 @@ static void br_multicast_query_received(struct net_bridge *br,
 	 * is 0.0.0.0 should not be added to router port list.
 	 */
 	if ((saddr->proto == htons(ETH_P_IP) && saddr->u.ip4) ||
-	    (saddr->proto == htons(ETH_P_IPV6) &&
-	     !ipv6_addr_any(&saddr->u.ip6)))
+	    saddr->proto == htons(ETH_P_IPV6))
 		br_multicast_mark_router(br, port);
 }
 
-- 
2.17.2

