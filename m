Return-Path: <wcang@sfc.wide.ad.jp>
Message-ID: <50CA6DA5.1020101@sfc.wide.ad.jp>
Date: Fri, 14 Dec 2012 08:07:01 +0800
From: Ang Way Chuang <wcang@sfc.wide.ad.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Bridge] [PATCH] bridge: Bug fix for incorrect interpretation of
 MLDv2 maximum response code
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <shemminger@vyatta.com>, bridge@lists.linux-foundation.org

This patch fixes the incorrect interpretation of endianness of MLDv2 maximum response
code within bridge's multicast snooping code.

Signed-off-by: Ang Way Chuang <wcang@sfc.wide.ad.jp>
---
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 977c3ee..29c6283 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1172,7 +1172,7 @@ static int br_ip6_multicast_query(struct net_bridge *br,
 		mld2q = (struct mld2_query *)icmp6_hdr(skb);
 		if (!mld2q->mld2q_nsrcs)
 			group = &mld2q->mld2q_mca;
-		max_delay = mld2q->mld2q_mrc ? MLDV2_MRC(mld2q->mld2q_mrc) : 1;
+		max_delay = mld2q->mld2q_mrc ? MLDV2_MRC(ntohs(mld2q->mld2q_mrc)) : 1;
 	}
 
 	if (!group)
