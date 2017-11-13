Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id;
	bh=Vjh1wqTkJF1S/cjtQGD71AIWr/yhPReOFQmqlihEFFI=;
	b=fA8OBKhWXKOtL+G74HHj3I/RpS00lMzU+xADmaZ9rPlOySO4vhpBc9NRd2v+b5RAVJ
	pFQVVa+Wc90WdB/N8BSW8BhEWdFfOjDLTrWf5UPWtEa6C/yG5ZGa9bXWW/ZNcierJYVa
	haahber9IdwHwYK0EPfM2ttE9qe5YXUtx46pQ=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Mon, 13 Nov 2017 18:30:55 +0200
Message-Id: <1510590655-20935-1-git-send-email-nikolay@cumulusnetworks.com>
Subject: [Bridge] [PATCH net] net: bridge: add vlan_tunnel to bridge port
	policies
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org

Found another missing port flag policy entry for IFLA_BRPORT_VLAN_TUNNEL
so add it now.

CC: Roopa Prabhu <roopa@cumulusnetworks.com>
Fixes: efa5356b0d97 ("bridge: per vlan dst_metadata netlink support")
Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 net/bridge/br_netlink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index de2152730809..adc095c5703f 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -637,6 +637,7 @@ static const struct nla_policy br_port_policy[IFLA_BRPORT_MAX + 1] = {
 	[IFLA_BRPORT_MCAST_TO_UCAST] = { .type = NLA_U8 },
 	[IFLA_BRPORT_MCAST_FLOOD] = { .type = NLA_U8 },
 	[IFLA_BRPORT_BCAST_FLOOD] = { .type = NLA_U8 },
+	[IFLA_BRPORT_VLAN_TUNNEL] = { .type = NLA_U8 },
 };
 
 /* Change the state of the port and notify spanning tree */
-- 
2.1.4

