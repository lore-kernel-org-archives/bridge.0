Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cLshL1qy2NWFVL3YMKKQ9DjLnzo1vTCjeiGuQjkekDY=;
 b=gUlcnVXhi18kYG1Srs+mVbGk2OpckgyGwERFFVf7L2ki1oDHWg1OskxZC4x2IPjacu
 bSTMtqIpIMoTP9zXiEKFnJpaVfH8JuHSmntxjzF3vn6BlwEPLaEry6PP+pMfX7LwMtWz
 Q4tPkiiwczOyD7Ea5Z363HLNBJUh/jzUw+RQE=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Sat,  5 Sep 2020 11:24:09 +0300
Message-Id: <20200905082410.2230253-15-nikolay@cumulusnetworks.com>
In-Reply-To: <20200905082410.2230253-1-nikolay@cumulusnetworks.com>
References: <20200905082410.2230253-1-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next v3 14/15] net: bridge: mcast: improve
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
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, bridge@lists.linux-foundation.org, davem@davemloft.net, roopa@nvidia.com

When an IGMPv3/MLDv2 query is received and we're operating in such mode
then we need to avoid updating group timers if the suppress flag is set.
Also we should update only timers for groups in exclude mode.

v3: add IPv6/MLDv2 support

Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 net/bridge/br_multicast.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 2ded3f3c51c0..f146e00cea66 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -2196,7 +2196,8 @@ static void br_ip4_multicast_query(struct net_bridge *br,
 		}
 	} else if (transport_len >= sizeof(*ih3)) {
 		ih3 = igmpv3_query_hdr(skb);
-		if (ih3->nsrcs)
+		if (ih3->nsrcs ||
+		    (br->multicast_igmp_version == 3 && group && ih3->suppress))
 			goto out;
 
 		max_delay = ih3->code ?
@@ -2231,7 +2232,9 @@ static void br_ip4_multicast_query(struct net_bridge *br,
 	     pp = &p->next) {
 		if (timer_pending(&p->timer) ?
 		    time_after(p->timer.expires, now + max_delay) :
-		    try_to_del_timer_sync(&p->timer) >= 0)
+		    try_to_del_timer_sync(&p->timer) >= 0 &&
+		    (br->multicast_igmp_version == 2 ||
+		     p->filter_mode == MCAST_EXCLUDE))
 			mod_timer(&p->timer, now + max_delay);
 	}
 
@@ -2281,6 +2284,10 @@ static int br_ip6_multicast_query(struct net_bridge *br,
 		mld2q = (struct mld2_query *)icmp6_hdr(skb);
 		if (!mld2q->mld2q_nsrcs)
 			group = &mld2q->mld2q_mca;
+		if (br->multicast_mld_version == 2 &&
+		    !ipv6_addr_any(&mld2q->mld2q_mca) &&
+		    mld2q->mld2q_suppress)
+			goto out;
 
 		max_delay = max(msecs_to_jiffies(mldv2_mrc(mld2q)), 1UL);
 	}
@@ -2314,7 +2321,9 @@ static int br_ip6_multicast_query(struct net_bridge *br,
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

