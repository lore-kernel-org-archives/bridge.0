Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=aiR23CdvX/YW7ASJTZF8b+8Ds0NXrhmWhy57VeViwyo=;
 b=QLeBRmfebetUgt50tunwIMdWH6Xh1XJU9NxhzbFJAB/SEky4PZPW1vehsAR9QpJ1jd
 xnwHiEdsUpkVp20AXnOhuhqv4wrkuEjJUMej4dHJCqo87Bx5RtJ50Pnt35QfLSCW110V
 O6BT5W/I6LvhXGAadQUXekqC7NFdbPWz9lVQPpHVuoA0aJpWuoBz6Jd7GOm+epqC4AxX
 BzNWPn8aBkBPVwINR4Sk3omo8C/M1BzSgwWTODeAs0P52L0HMrc3Yz4637W0bbelGtZL
 LVCDk8IijuC90eH7mP8I5Yp5mCNT7b3nb8tFBQ/9QP6h/CqUf1mxAdjMfYpjFlRMLi4B
 oHCA==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Fri,  3 Sep 2021 12:34:15 +0300
Message-Id: <20210903093415.1544837-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net] net: bridge: mcast: fix vlan port router
	deadlock
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: bridge@lists.linux-foundation.org, Nikolay Aleksandrov <nikolay@nvidia.com>, roopa@nvidia.com

From: Nikolay Aleksandrov <nikolay@nvidia.com>

Before vlan/port mcast router support was added
br_multicast_set_port_router was used only with bh already disabled due
to the bridge port lock, but that is no longer the case and when it is
called to configure a vlan/port mcast router we can deadlock with the
timer, so always disable bh to make sure it can be called from contexts
with both enabled and disabled bh.

Fixes: 2796d846d74a ("net: bridge: vlan: convert mcast router global option to per-vlan entry")
Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
 net/bridge/br_multicast.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 9231617a16e4..3523c8c7068f 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -4255,7 +4255,7 @@ int br_multicast_set_port_router(struct net_bridge_mcast_port *pmctx,
 	bool del = false;
 
 	brmctx = br_multicast_port_ctx_get_global(pmctx);
-	spin_lock(&brmctx->br->multicast_lock);
+	spin_lock_bh(&brmctx->br->multicast_lock);
 	if (pmctx->multicast_router == val) {
 		/* Refresh the temp router port timer */
 		if (pmctx->multicast_router == MDB_RTR_TYPE_TEMP) {
@@ -4305,7 +4305,7 @@ int br_multicast_set_port_router(struct net_bridge_mcast_port *pmctx,
 	}
 	err = 0;
 unlock:
-	spin_unlock(&brmctx->br->multicast_lock);
+	spin_unlock_bh(&brmctx->br->multicast_lock);
 
 	return err;
 }
-- 
2.31.1

