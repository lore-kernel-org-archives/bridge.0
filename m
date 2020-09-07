Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gcib5npC4llvtu4+LbYVHXG0s/irec0HvJtAMaXEsuA=;
 b=ZIDfZGPxAQkTQXSDtB8+PJTEtY90uoFIXO2gmEPLNfFxIq2Ap68yD4hTccf7IGV9Jw
 CMuLilXTrkxtZ/1D9jLiADgI8Pan2WqWwTwbjYoCuofFsJcstLEws0SoGBcbLTELv7w/
 YAL8GyevJzPUZYcv2Uf7vn+JiHAOPAc4IyB7Q=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Mon,  7 Sep 2020 12:56:18 +0300
Message-Id: <20200907095619.11216-15-nikolay@cumulusnetworks.com>
In-Reply-To: <20200907095619.11216-1-nikolay@cumulusnetworks.com>
References: <20200907095619.11216-1-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next v4 14/15] net: bridge: mcast: improve
	IGMPv3/MLDv2 query processing
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, kuba@kernel.org, bridge@lists.linux-foundation.org, davem@davemloft.net, roopa@nvidia.com

When an IGMPv3/MLDv2 query is received and we're operating in such mode
then we need to avoid updating group timers if the suppress flag is set.
Also we should update only timers for groups in exclude mode.

v3: add IPv6/MLDv2 support

Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 net/bridge/br_multicast.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 6cfac6cbaf3b..0bf791ed0f56 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -2194,7 +2194,8 @@ static void br_ip4_multicast_query(struct net_bridge *br,
 		}
 	} else if (transport_len >= sizeof(*ih3)) {
 		ih3 = igmpv3_query_hdr(skb);
-		if (ih3->nsrcs)
+		if (ih3->nsrcs ||
+		    (br->multicast_igmp_version == 3 && group && ih3->suppress))
 			goto out;
 
 		max_delay = ih3->code ?
@@ -2229,7 +2230,9 @@ static void br_ip4_multicast_query(struct net_bridge *br,
 	     pp = &p->next) {
 		if (timer_pending(&p->timer) ?
 		    time_after(p->timer.expires, now + max_delay) :
-		    try_to_del_timer_sync(&p->timer) >= 0)
+		    try_to_del_timer_sync(&p->timer) >= 0 &&
+		    (br->multicast_igmp_version == 2 ||
+		     p->filter_mode == MCAST_EXCLUDE))
 			mod_timer(&p->timer, now + max_delay);
 	}
 
@@ -2279,6 +2282,10 @@ static int br_ip6_multicast_query(struct net_bridge *br,
 		mld2q = (struct mld2_query *)icmp6_hdr(skb);
 		if (!mld2q->mld2q_nsrcs)
 			group = &mld2q->mld2q_mca;
+		if (br->multicast_mld_version == 2 &&
+		    !ipv6_addr_any(&mld2q->mld2q_mca) &&
+		    mld2q->mld2q_suppress)
+			goto out;
 
 		max_delay = max(msecs_to_jiffies(mldv2_mrc(mld2q)), 1UL);
 	}
@@ -2312,7 +2319,9 @@ static int br_ip6_multicast_query(struct net_bridge *br,
 	     pp = &p->next) {
 		if (timer_pending(&p->timer) ?
 		    time_after(p->timer.expires, now + max_delay) :
-		    try_to_del_timer_sync(&p->timer) >= 0)
+		    try_to_del_timer_sync(&p->timer) >= 0 &&
+		    (br->multicast_mld_version == 1 ||
+		     p->filter_mode == MCAST_EXCLUDE))
 			mod_timer(&p->timer, now + max_delay);
 	}
 
-- 
2.25.4

