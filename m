Return-Path: <nikolay@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p6ZRcqzDnwrqWxQW1yfr4I3M5EOGrCjW647q0rmwcMY=;
 b=svtwmBhMSgnfxNYsIerfcIdJCXNmAPSiF1VYQ5Ob8o9Wivrp6hiX2swL5eY2RyIC9cg96O8uPGTmSkb5PnCdCg/Pbhy0O/pXvLdsqNy/3utqtqpJtTzx6hM5U5HjxmgLO9/p2X5tYLizfXhRcd0E0UtAy4MRHbC0QHQUkNLhGiQBjIg0qw+AkAcPbwu6znSXXZqB78YDqNSDzgGnioMyH8q6x20qUmhfh9E/Vn2uzBsrseI8Izf/LjLwJgQWCUq3bk5vfTXSqJC81l9Xj/93W3ZDuQLOmuYHOPmuwb6l2qrBXnqk3PadOZGEQeODaqHkuOw7PAFLtxhKqa1cU+uduQ==
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Date: Tue, 28 Dec 2021 17:31:42 +0200
Message-ID: <20211228153142.536969-1-nikolay@nvidia.com>
In-Reply-To: <20211228152811.534521-1-nikolay@nvidia.com>
References: <20211228152811.534521-1-nikolay@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net v2] net: bridge: mcast: fix
	br_multicast_ctx_vlan_global_disabled helper
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@nvidia.com>, kuba@kernel.org, bridge@lists.linux-foundation.org, davem@davemloft.net, roopa@nvidia.com

We need to first check if the context is a vlan one, then we need to
check the global bridge multicast vlan snooping flag, and finally the
vlan's multicast flag, otherwise we will unnecessarily enable vlan mcast
processing (e.g. querier timers).

Fixes: 7b54aaaf53cb ("net: bridge: multicast: add vlan state initialization and control")
Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
v2: fix indentation warning by checkpatch

 net/bridge/br_private.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 2187a0c3fd22..e8c6ee322c71 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -1153,9 +1153,9 @@ br_multicast_port_ctx_get_global(const struct net_bridge_mcast_port *pmctx)
 static inline bool
 br_multicast_ctx_vlan_global_disabled(const struct net_bridge_mcast *brmctx)
 {
-	return br_opt_get(brmctx->br, BROPT_MCAST_VLAN_SNOOPING_ENABLED) &&
-	       br_multicast_ctx_is_vlan(brmctx) &&
-	       !(brmctx->vlan->priv_flags & BR_VLFLAG_GLOBAL_MCAST_ENABLED);
+	return br_multicast_ctx_is_vlan(brmctx) &&
+	       (!br_opt_get(brmctx->br, BROPT_MCAST_VLAN_SNOOPING_ENABLED) ||
+		!(brmctx->vlan->priv_flags & BR_VLFLAG_GLOBAL_MCAST_ENABLED));
 }
 
 static inline bool
-- 
2.33.1

