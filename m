Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4E66C40A89
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8761B40A88
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m3B836tSduSX6HvM6NOhRWJnuh1AZBBBz6KtJIP4MbU=;
 b=ZkfL77sQuzPAW/dN+FPPx+r9aayEBajSteAtg+/XiEZDBviak7CH25p0uFObi7xUSC05iVB2UIzyu+qRn3Xq8/884OifNURVE5H6om0YIx+tx08hSBgg0DraEySRvjPi8DEcWQ9qbp8IdSf5UN31jNpXq7PBzavu3nsJM3qAHVivCbjj38seoKdeTArrL6Z5nUeYNAtaxNJHHMU1f2Y0pFMz5lL+4WlWRdyqf11kveNY/jMxX7WuWgrL3HCtBE30HbXly1NrnKejrtMLvelhZr4AN4RzcJhgk+09wABTNJ8e8TI6fH0EZTKid+F7n2WIwioX+NebZnfeP09ELj/NsQ==
From: Ido Schimmel <idosch@nvidia.com>
Date: Tue, 18 Oct 2022 09:40:00 +0300
Message-Id: <20221018064001.518841-4-idosch@nvidia.com>
In-Reply-To: <20221018064001.518841-1-idosch@nvidia.com>
References: <20221018064001.518841-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next 3/4] bridge: mcast: Use spin_lock()
	instead of spin_lock_bh()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: mlxsw@nvidia.com, razor@blackwall.org, Ido Schimmel <idosch@nvidia.com>, edumazet@google.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

IGMPv3 / MLDv2 Membership Reports are only processed from the data path
with softIRQ disabled, so there is no need to call spin_lock_bh(). Use
spin_lock() instead.

This is consistent with how other IGMP / MLD packets are processed.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/bridge/br_multicast.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index db4f2641d1cd..09140bc8c15e 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -2669,7 +2669,7 @@ static int br_ip4_multicast_igmp3_report(struct net_bridge_mcast *brmctx,
 		if (!pmctx || igmpv2)
 			continue;
 
-		spin_lock_bh(&brmctx->br->multicast_lock);
+		spin_lock(&brmctx->br->multicast_lock);
 		if (!br_multicast_ctx_should_use(brmctx, pmctx))
 			goto unlock_continue;
 
@@ -2717,7 +2717,7 @@ static int br_ip4_multicast_igmp3_report(struct net_bridge_mcast *brmctx,
 		if (changed)
 			br_mdb_notify(brmctx->br->dev, mdst, pg, RTM_NEWMDB);
 unlock_continue:
-		spin_unlock_bh(&brmctx->br->multicast_lock);
+		spin_unlock(&brmctx->br->multicast_lock);
 	}
 
 	return err;
@@ -2807,7 +2807,7 @@ static int br_ip6_multicast_mld2_report(struct net_bridge_mcast *brmctx,
 		if (!pmctx || mldv1)
 			continue;
 
-		spin_lock_bh(&brmctx->br->multicast_lock);
+		spin_lock(&brmctx->br->multicast_lock);
 		if (!br_multicast_ctx_should_use(brmctx, pmctx))
 			goto unlock_continue;
 
@@ -2859,7 +2859,7 @@ static int br_ip6_multicast_mld2_report(struct net_bridge_mcast *brmctx,
 		if (changed)
 			br_mdb_notify(brmctx->br->dev, mdst, pg, RTM_NEWMDB);
 unlock_continue:
-		spin_unlock_bh(&brmctx->br->multicast_lock);
+		spin_unlock(&brmctx->br->multicast_lock);
 	}
 
 	return err;
-- 
2.37.3

