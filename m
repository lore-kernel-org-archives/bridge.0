Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=05EssCmbNBM6TH7qNGJDPpUfoHSktkvYwWjZGlJ+2Iw=;
	b=hRdYabFSEa9mNQlTUupbsfDVysh8S3Yz1eB2g62Qe8gF/0R5ugJhYqibbzlxMi9HBt
	FZ2YOOuVLuhubdPYs1sBg+3e1uOwwoYvApOby1OYA6lsL7hddR68G1Akpy3+Pfan5iAg
	lNZEvvhYzwkkD3DUFLPO+MVYtzmv8KS9yydsI=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Wed, 17 Aug 2016 12:53:10 +0200
Message-Id: <1471431190-27442-3-git-send-email-nikolay@cumulusnetworks.com>
In-Reply-To: <1471431190-27442-1-git-send-email-nikolay@cumulusnetworks.com>
References: <1471431190-27442-1-git-send-email-nikolay@cumulusnetworks.com>
Subject: [Bridge] [PATCH net-next 2/2] net: bridge: export vlan flags with
	the stats
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net

Use one of the vlan xstats padding fields to export the vlan flags. This is
needed in order to be able to distinguish between master (bridge) and port
vlan entries in user-space when dumping the bridge vlan stats.

Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 include/uapi/linux/if_bridge.h | 2 +-
 net/bridge/br_netlink.c        | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
index c186f64fffca..ab92bca6d448 100644
--- a/include/uapi/linux/if_bridge.h
+++ b/include/uapi/linux/if_bridge.h
@@ -140,7 +140,7 @@ struct bridge_vlan_xstats {
 	__u64 tx_bytes;
 	__u64 tx_packets;
 	__u16 vid;
-	__u16 pad1;
+	__u16 flags;
 	__u32 pad2;
 };
 
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 493ab9b3d51a..872d4c0deb59 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -1321,6 +1321,7 @@ static int br_fill_linkxstats(struct sk_buff *skb,
 				continue;
 			memset(&vxi, 0, sizeof(vxi));
 			vxi.vid = v->vid;
+			vxi.flags = v->flags;
 			br_vlan_get_stats(v, &stats);
 			vxi.rx_bytes = stats.rx_bytes;
 			vxi.rx_packets = stats.rx_packets;
-- 
2.1.4

