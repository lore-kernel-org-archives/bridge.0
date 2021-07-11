Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=m+ppdXaepSm57DIGWDBCLlBbyDz4JtRjsnYacqgtWjM=;
 b=fnQhTuQfvikn8wsBlfQW8wa3TbTUdvL0BRKK1SsYvIwdDSwNo5zRHUXHIZiOrK1j0E
 DyOKpo7teKbeuC/1PSB5SYfWmdurOnmS2ML5Z3ywee1IsWq5zt134nq8CTF6o2Wpgagk
 vECivnNM30xVlMiDEndXTNjjyh24f6Uzcd5NrEZJRcUg4/anj/GxVspV+dI7IWBqik86
 utcc1VgQn9CSpmE3l212ly279r+QKBnk+8jfqmMAgn+bx31+Mus5OX/xNlcarV+grdl5
 Q+InIy7uEBcuh9LioRmh5VeBkXK1vglUBKECuZ3uu5JdQ8W2jW1QLLuft4wHStY4mr7Y
 b+MA==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Sun, 11 Jul 2021 12:56:29 +0300
Message-Id: <20210711095629.2986949-3-razor@blackwall.org>
In-Reply-To: <20210711095629.2986949-1-razor@blackwall.org>
References: <20210711095629.2986949-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net 2/2] net: bridge: multicast: fix MRD
	advertisement router port marking race
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: bridge@lists.linux-foundation.org, Nikolay Aleksandrov <nikolay@nvidia.com>, stable@vger.kernel.org, roopa@nvidia.com

From: Nikolay Aleksandrov <nikolay@nvidia.com>

When an MRD advertisement is received on a bridge port with multicast
snooping enabled, we mark it as a router port automatically, that
includes adding that port to the router port list. The multicast lock
protects that list, but it is not acquired in the MRD advertisement case
leading to a race condition, we need to take it to fix the race.

Cc: stable@vger.kernel.org
Cc: linus.luessing@c0d3.blue
Fixes: 4b3087c7e37f ("bridge: Snoop Multicast Router Advertisements")
Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
 net/bridge/br_multicast.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 3bbbc6d7b7c3..d0434dc8c03b 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -3277,7 +3277,9 @@ static int br_ip4_multicast_mrd_rcv(struct net_bridge *br,
 	    igmp_hdr(skb)->type != IGMP_MRDISC_ADV)
 		return -ENOMSG;
 
+	spin_lock(&br->multicast_lock);
 	br_ip4_multicast_mark_router(br, port);
+	spin_unlock(&br->multicast_lock);
 
 	return 0;
 }
@@ -3345,7 +3347,9 @@ static void br_ip6_multicast_mrd_rcv(struct net_bridge *br,
 	if (icmp6_hdr(skb)->icmp6_type != ICMPV6_MRDISC_ADV)
 		return;
 
+	spin_lock(&br->multicast_lock);
 	br_ip6_multicast_mark_router(br, port);
+	spin_unlock(&br->multicast_lock);
 }
 
 static int br_multicast_ipv6_rcv(struct net_bridge *br,
-- 
2.31.1

