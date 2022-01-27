Return-Path: <tim.yi@pica8.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=pica8com.onmicrosoft.com; s=selector2-pica8com-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8iMB/tKXYAzchAuHpJxAZjpz3NDUudrGkTXPiq2oa4=;
 b=ZeZ0gbiYQnKHbRWFW6rWC9oIK9zImLsFk89Gi40P7WEzBdzJtd+usYcDaLT+8v9+bs+PEfuOQ+PqD6NDnM9RdcrcQAP+v8hzBp0spgdfYhvPxms4l+2zp1IL/5byyzSMihpcvcsEiiGU/neFqA1HLlLuAdukGFYjbHSNrPaqEwg=
From: Tim Yi <tim.yi@pica8.com>
Date: Thu, 27 Jan 2022 15:49:53 +0800
Message-Id: <20220127074953.12632-1-tim.yi@pica8.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [PATCH] net: bridge: vlan: fix memory leak in
	__allowed_ingress
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: nikolay@nvidia.com
Cc: Tim Yi <tim.yi@pica8.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, roopa@nvidia.com, kuba@kernel.org, davem@davemloft.net

When using per-vlan state, if vlan snooping and stats are disabled,
untagged or priority-tagged ingress frame will go to check pvid state.
If the port state is forwarding and the pvid state is not
learning/forwarding, untagged or priority-tagged frame will be dropped
but skb memory is not freed.
Should free skb when __allowed_ingress returns false.

Signed-off-by: Tim Yi <tim.yi@pica8.com>
---
 net/bridge/br_vlan.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 84ba456a78cc..88c4297cddee 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -560,10 +560,10 @@ static bool __allowed_ingress(const struct net_bridge *br,
 		    !br_opt_get(br, BROPT_VLAN_STATS_ENABLED)) {
 			if (*state == BR_STATE_FORWARDING) {
 				*state = br_vlan_get_pvid_state(vg);
-				return br_vlan_state_allowed(*state, true);
-			} else {
-				return true;
+				if (!br_vlan_state_allowed(*state, true))
+					goto drop;
 			}
+			return true;
 		}
 	}
 	v = br_vlan_find(vg, *vid);
-- 
2.28.0.618.g9bc233ae1c

