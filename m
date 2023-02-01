Return-Path: <petrm@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 05F4540AA6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 47C5E40A37
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e3Afw2Xez+FIQKEQo3lqKv+Eo0xyTlcJx0ejHMFjpoQ=;
 b=AcQC/eMTuP//hArD+a0PmtgQdAWYb1cZQbHj+ngD3OkoIOauRPv7QKHcxmmhfx6Svkn3WXPOKlTSGMpFbE4yMU1h2QL3xBioag8PNO0fzVt1u4NWVyhlSa1HQ9wc39ZDW7qUyCvllD2qDwRYoiVuZ9oqgZoWPUKT82bhTOYMAt8NXC8w5rNELqiAwtLjiSr81orG5fgi6rwmouTYl+PwQhi05x0bPPGZiTPpRYi0xPb9+xNd1fbZAcuOhSP2R9Mzv6/QFnnVpK4AcWbj1d08Rb9Ey+lwkOE8yf4wiwWPggDPricwNPrTlQoKqI0dW0MbWB3iuUVBGwl9d+OSIiid4A==
From: Petr Machata <petrm@nvidia.com>
Date: Wed, 1 Feb 2023 18:28:38 +0100
Message-ID: <519175434f6f015f62b29e5fc54b098fe6d5a989.1675271084.git.petrm@nvidia.com>
In-Reply-To: <cover.1675271084.git.petrm@nvidia.com>
References: <cover.1675271084.git.petrm@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next mlxsw v2 05/16] net: bridge: Change a
	cleanup in br_multicast_new_port_group() to goto
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org
Cc: Petr Machata <petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux-foundation.org

This function is getting more to clean up in the following patches.
Structuring the cleanups in one labeled block will allow reusing the same
cleanup from several places.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_multicast.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 08da724ebfdd..51b622afdb67 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1309,8 +1309,7 @@ struct net_bridge_port_group *br_multicast_new_port_group(
 	    rhashtable_lookup_insert_fast(&port->br->sg_port_tbl, &p->rhnode,
 					  br_sg_port_rht_params)) {
 		NL_SET_ERR_MSG_MOD(extack, "Couldn't insert new port group");
-		kfree(p);
-		return NULL;
+		goto free_out;
 	}
 
 	rcu_assign_pointer(p->next, next);
@@ -1324,6 +1323,10 @@ struct net_bridge_port_group *br_multicast_new_port_group(
 		eth_broadcast_addr(p->eth_addr);
 
 	return p;
+
+free_out:
+	kfree(p);
+	return NULL;
 }
 
 void br_multicast_del_port_group(struct net_bridge_port_group *p)
-- 
2.39.0

