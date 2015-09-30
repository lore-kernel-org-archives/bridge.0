Return-Path: <razor@blackwall.org>
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Wed, 30 Sep 2015 20:16:55 +0200
Message-Id: <1443637015-4153-6-git-send-email-razor@blackwall.org>
In-Reply-To: <1443637015-4153-1-git-send-email-razor@blackwall.org>
References: <1443637015-4153-1-git-send-email-razor@blackwall.org>
Subject: [Bridge] [PATCH net-next 5/5] bridge: vlan: don't pass flags when
	creating context only
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net, vyasevich@gmail.com

From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

We should not pass the original flags when creating a context vlan only
because they may contain some flags that change behaviour in the bridge.
The new global context should be with minimal set of flags, so pass 0
and let br_vlan_add() set the master flag only.

Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 net/bridge/br_vlan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 7e9d60a402e2..75214a51cf0e 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -197,7 +197,7 @@ static int __vlan_add(struct net_bridge_vlan *v, u16 flags)
 		masterv = br_vlan_find(br->vlgrp, v->vid);
 		if (!masterv) {
 			/* missing global ctx, create it now */
-			err = br_vlan_add(br, v->vid, master_flags);
+			err = br_vlan_add(br, v->vid, 0);
 			if (err)
 				goto out_filt;
 			masterv = br_vlan_find(br->vlgrp, v->vid);
-- 
2.4.3

