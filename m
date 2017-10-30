Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id;
	bh=1eMkG/vKpLM1tn9R/p50s9EWdUNqlVtW/XmQNjeAZFE=;
	b=eaK5giCZWLhgXELncsGFYm2f1vFPi+4wWN8Z92TZ4+HvmJ/mU1f9LRkBVGBMh5d6Je
	rL6T3pwDwR/Zmf02gJYjITNANABVBtlh2GP7XSciC3QM7a3v2JAco9B3iZsK2QjRrG7J
	welaJa6AzhJNbuhEJmuvxVgABYLzVvg6Ricvo=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Mon, 30 Oct 2017 12:56:33 +0200
Message-Id: <1509360993-25227-1-git-send-email-nikolay@cumulusnetworks.com>
Subject: [Bridge] [PATCH net-next] net: bridge: add neigh_suppress to bridge
	port policies
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

Add an entry for IFLA_BRPORT_NEIGH_SUPPRESS to bridge port policies.

Fixes: 821f1b21cabb ("bridge: add new BR_NEIGH_SUPPRESS port flag to suppress arp and nd flood")
Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 net/bridge/br_netlink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index e732403669c6..26aeb0b5cf30 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -651,6 +651,7 @@ static const struct nla_policy br_port_policy[IFLA_BRPORT_MAX + 1] = {
 	[IFLA_BRPORT_MCAST_FLOOD] = { .type = NLA_U8 },
 	[IFLA_BRPORT_BCAST_FLOOD] = { .type = NLA_U8 },
 	[IFLA_BRPORT_GROUP_FWD_MASK] = { .type = NLA_U16 },
+	[IFLA_BRPORT_NEIGH_SUPPRESS] = { .type = NLA_U8 },
 };
 
 /* Change the state of the port and notify spanning tree */
-- 
2.1.4

