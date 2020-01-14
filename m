Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mr/2MNCOIx0U4K+Pv+vAm/4J6d5/EukzrdHaRzf8ia0=;
 b=Vu8D4RL6/Waqf9k5QySzdYA8kN/YYdxNE6u5TyyBc96Hjee7hyf456xV2xTRY9m22Y
 wfz0bVNsBE1FQ8o3LN8L+cpKDvGjCsA5xQBT9qt3s0ZxZq6N0Z8rW0KnR9s7/5Jvqn+T
 au4rW07YhX9WcRcX9CXKtj7KbrNrcHs2Wh6Zk=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Tue, 14 Jan 2020 19:56:11 +0200
Message-Id: <20200114175614.17543-6-nikolay@cumulusnetworks.com>
In-Reply-To: <20200114175614.17543-1-nikolay@cumulusnetworks.com>
References: <20200114175614.17543-1-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next v2 5/8] net: bridge: vlan: add del rtm
	message support
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, dsahern@gmail.com, kuba@kernel.org, davem@davemloft.net

Adding RTM_DELVLAN support similar to RTM_NEWVLAN is simple, just need to
map DELVLAN to DELLINK and register the handler.

Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 net/bridge/br_vlan.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 6da0210b01eb..89d5fa75c575 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -1697,6 +1697,9 @@ static int br_vlan_rtm_process_one(struct net_device *dev,
 	case RTM_NEWVLAN:
 		cmdmap = RTM_SETLINK;
 		break;
+	case RTM_DELVLAN:
+		cmdmap = RTM_DELLINK;
+		break;
 	}
 
 	err = br_process_vlan_info(br, p, cmdmap, vinfo, &vinfo_last, &changed,
@@ -1757,10 +1760,13 @@ void br_vlan_rtnl_init(void)
 			     br_vlan_rtm_dump, 0);
 	rtnl_register_module(THIS_MODULE, PF_BRIDGE, RTM_NEWVLAN,
 			     br_vlan_rtm_process, NULL, 0);
+	rtnl_register_module(THIS_MODULE, PF_BRIDGE, RTM_DELVLAN,
+			     br_vlan_rtm_process, NULL, 0);
 }
 
 void br_vlan_rtnl_uninit(void)
 {
 	rtnl_unregister(PF_BRIDGE, RTM_GETVLAN);
 	rtnl_unregister(PF_BRIDGE, RTM_NEWVLAN);
+	rtnl_unregister(PF_BRIDGE, RTM_DELVLAN);
 }
-- 
2.21.0

