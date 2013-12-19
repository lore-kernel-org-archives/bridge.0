Return-Path: <tanxiaojun@huawei.com>
From: Tan Xiaojun <tanxiaojun@huawei.com>
Date: Thu, 19 Dec 2013 13:28:10 +0800
Message-ID: <1387430894-11220-2-git-send-email-tanxiaojun@huawei.com>
In-Reply-To: <1387430894-11220-1-git-send-email-tanxiaojun@huawei.com>
References: <1387430894-11220-1-git-send-email-tanxiaojun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Bridge] [PATCH 1/5] bridge: remove unnecessary condition judgment
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: stephen@networkplumber.org, davem@davemloft.net, bart.de.schuymer@pandora.be
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org

Because err is always negative, remove unnecessary condition
judgment.

Signed-off-by: Tan Xiaojun <tanxiaojun@huawei.com>
---
 net/bridge/br_fdb.c     | 3 +--
 net/bridge/br_netlink.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index 33e8f23..c5f5a4a 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -570,8 +570,7 @@ static void fdb_notify(struct net_bridge *br,
 	rtnl_notify(skb, net, 0, RTNLGRP_NEIGH, NULL, GFP_ATOMIC);
 	return;
 errout:
-	if (err < 0)
-		rtnl_set_sk_err(net, RTNLGRP_NEIGH, err);
+	rtnl_set_sk_err(net, RTNLGRP_NEIGH, err);
 }
 
 /* Dump information about entries, in response to GETNEIGH */
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index c2fd6bc..6526ac8 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -195,8 +195,7 @@ void br_ifinfo_notify(int event, struct net_bridge_port *port)
 	rtnl_notify(skb, net, 0, RTNLGRP_LINK, NULL, GFP_ATOMIC);
 	return;
 errout:
-	if (err < 0)
-		rtnl_set_sk_err(net, RTNLGRP_LINK, err);
+	rtnl_set_sk_err(net, RTNLGRP_LINK, err);
 }
 
 
-- 
1.8.0


