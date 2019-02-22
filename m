Return-Path: <liuhangbin@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=r4Yx9fRpmv7GzZ3sYiiGHfYdV5cj2xhoIMtaPA3H4eo=;
	b=J/9JuPiZN+NwyOtJU5Ru5t2/RmnHpRiRuO3wMVlamNIQmILZZ+gF3ohGPO/R9zqdE9
	QNUdaEaBnSD2/DpuZrCxPOx3+Y/EcC6cF4ZTicX0h7fNb7K/xvzXQgra01fhm49/RH2t
	waVVyVdq7NscNQt+tDhSUT05FF33F/UN8zzPK7PiDE+CKaaIGasUzCR0erUF+92s03FM
	IZg7RR8U06C3M9x5VPKgRCW0gE2QRgyT/tOz48S9XjfCxFJt/HNQVa6rpDGwVSWAiPtq
	zXsIDSYNh1Xf9yQ9ZZU0qQ0GXYz/wdWRj1JS4a8O/SD3h1gbnUy6W1Ei1LCRES8f1dyg
	swsA==
From: Hangbin Liu <liuhangbin@gmail.com>
Date: Fri, 22 Feb 2019 21:22:32 +0800
Message-Id: <20190222132232.24123-1-liuhangbin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net] Revert "bridge: do not add port to router list
	when receives query with source 0.0.0.0"
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, stable@vger.kernel.org, yinxu@redhat.com, Hangbin Liu <liuhangbin@gmail.com>, Sebastian Gottschall <s.gottschall@newmedia-net.de>, davem@davemloft.net

This reverts commit 5a2de63fd1a5 ("bridge: do not add port to router list
when receives query with source 0.0.0.0") and commit 0fe5119e267f ("net:
bridge: remove ipv6 zero address check in mcast queries")

The reason is RFC 4541 is not a standard but suggestive. Currently we
will elect 0.0.0.0 as Querier if there is no ip address configured on
bridge. If we do not add the port which recives query with source
0.0.0.0 to router list, the IGMP reports will not be about to forward
to Querier, IGMP data will also not be able to forward to dest.

As Nikolay suggested, revert this change first and add a boolopt api
to disable none-zero election in future if needed.

Reported-by: Linus Lüssing <linus.luessing@c0d3.blue>
Reported-by: Sebastian Gottschall <s.gottschall@newmedia-net.de>
Fixes: 5a2de63fd1a5 ("bridge: do not add port to router list when receives query with source 0.0.0.0")
Fixes: 0fe5119e267f ("net: bridge: remove ipv6 zero address check in mcast queries")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 net/bridge/br_multicast.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 3aeff0895669..ac92b2eb32b1 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1204,14 +1204,7 @@ static void br_multicast_query_received(struct net_bridge *br,
 		return;
 
 	br_multicast_update_query_timer(br, query, max_delay);
-
-	/* Based on RFC4541, section 2.1.1 IGMP Forwarding Rules,
-	 * the arrival port for IGMP Queries where the source address
-	 * is 0.0.0.0 should not be added to router port list.
-	 */
-	if ((saddr->proto == htons(ETH_P_IP) && saddr->u.ip4) ||
-	    saddr->proto == htons(ETH_P_IPV6))
-		br_multicast_mark_router(br, port);
+	br_multicast_mark_router(br, port);
 }
 
 static void br_ip4_multicast_query(struct net_bridge *br,
-- 
2.19.2

