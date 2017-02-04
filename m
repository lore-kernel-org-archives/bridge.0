Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=iQYoYM8X1LqW4g/mGCfgjXV09fmDxSlweY74Wjc7gzc=;
	b=JmKMEZIIYgVALy9a2DtmIoJzACmkhSAW3E3Jo1Dxli1Mra/E8KziGXkqAIh5uZA0AG
	e3SLsZCMdwRWMb+IRJAlnHfs2yL/PRjku1GRXKI490nMRr8qHe/v8WZBR1Mv4wAVcHN2
	ki46U6Jmi3V+mdXkEOIcMWNgyFaYJQbFOqZr8=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Sat,  4 Feb 2017 18:05:09 +0100
Message-Id: <1486227909-18319-5-git-send-email-nikolay@cumulusnetworks.com>
In-Reply-To: <1486227909-18319-1-git-send-email-nikolay@cumulusnetworks.com>
References: <1486227909-18319-1-git-send-email-nikolay@cumulusnetworks.com>
Subject: [Bridge] [PATCH net-next 4/4] bridge: fdb: write to used and
	updated at most once per jiffy
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

Writing once per jiffy is enough to limit the bridge's false sharing.
After this change the bridge doesn't show up in the local load HitM stats.

Suggested-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 net/bridge/br_fdb.c   | 3 ++-
 net/bridge/br_input.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index 5cbed5c0db88..5028691fa68a 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -597,7 +597,8 @@ void br_fdb_update(struct net_bridge *br, struct net_bridge_port *source,
 				fdb->dst = source;
 				fdb_modified = true;
 			}
-			fdb->updated = jiffies;
+			if (jiffies != fdb->updated)
+				fdb->updated = jiffies;
 			if (unlikely(added_by_user))
 				fdb->added_by_user = 1;
 			if (unlikely(fdb_modified))
diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index fba38d8a1a08..220943f920d2 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -198,7 +198,8 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
 		if (dst->is_local)
 			return br_pass_frame_up(skb);
 
-		dst->used = jiffies;
+		if (jiffies != dst->used)
+			dst->used = jiffies;
 		br_forward(dst->dst, skb, local_rcv, false);
 	} else {
 		if (!mcast_hit)
-- 
2.1.4

