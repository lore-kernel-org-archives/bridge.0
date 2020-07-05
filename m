Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c0d3.blue; s=2018;
 t=1593976221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bmg9uf6mYHkfh9utTYp2Nm+8c0oAt214toZIvaTa5jo=;
 b=PjLgNG9UZv+o/MTuf6PQhE/l0t88wYz61/qnGGPnCH4zPpWgk073ZxSkEBvjwiQVCsVMHO
 kd/NchNe1VK6ltz5xIgSRox0igKlcUsYpfWF7L5gEo1IVS2gWV3uYz4VlP4KrYZsEGh5qF
 FJ/Lhto/t+RSZmrneXJwYl3yeS26iDjswGtydlJHr0D1yvPJDw4rx0YFhaWZTbDqydIBII
 OVNFgYPNWSdH3abLjGoxJsccIMI3hm/atv/jVrmVNq2/Dfo0++/lq28tVbDTo6S4laZi6I
 TZirZcyo857w8BvLLCr7oh7XRl4qmjJfGgZdvAjDPI1f+ilnGgcPhZ/0YVrpPg==
Date: Sun,  5 Jul 2020 21:10:17 +0200
Message-Id: <20200705191017.10546-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net v2] bridge: mcast: Fix MLD2 Report IPv6 payload
	length check
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Martin Weinelt <martin@linuxlounge.net>, "David S . Miller" <davem@davemloft.net>

Commit e57f61858b7c ("net: bridge: mcast: fix stale nsrcs pointer in
igmp3/mld2 report handling") introduced a bug in the IPv6 header payload
length check which would potentially lead to rejecting a valid MLD2 Report:

The check needs to take into account the 2 bytes for the "Number of
Sources" field in the "Multicast Address Record" before reading it.
And not the size of a pointer to this field.

Fixes: e57f61858b7c ("net: bridge: mcast: fix stale nsrcs pointer in igmp3/mld2 report handling")
Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
Changelog v2:
* updated commit message, the issue is accidentally rejcting a valid and
  not accepting an invalid MLD2 Report

 net/bridge/br_multicast.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 83490bf73a13..4c4a93abde68 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1000,21 +1000,21 @@ static int br_ip6_multicast_mld2_report(struct net_bridge *br,
 	num = ntohs(icmp6h->icmp6_dataun.un_data16[1]);
 	len = skb_transport_offset(skb) + sizeof(*icmp6h);
 
 	for (i = 0; i < num; i++) {
 		__be16 *_nsrcs, __nsrcs;
 		u16 nsrcs;
 
 		nsrcs_offset = len + offsetof(struct mld2_grec, grec_nsrcs);
 
 		if (skb_transport_offset(skb) + ipv6_transport_len(skb) <
-		    nsrcs_offset + sizeof(_nsrcs))
+		    nsrcs_offset + sizeof(__nsrcs))
 			return -EINVAL;
 
 		_nsrcs = skb_header_pointer(skb, nsrcs_offset,
 					    sizeof(__nsrcs), &__nsrcs);
 		if (!_nsrcs)
 			return -EINVAL;
 
 		nsrcs = ntohs(*_nsrcs);
 		grec_len = struct_size(grec, grec_src, nsrcs);
 
-- 
2.27.0

