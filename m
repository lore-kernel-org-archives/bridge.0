Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=AdSWbL1WHUhzYSOvkpZXCzCxGORDu84QZyVAcmvjbwk=;
	b=WsxCpOkUsHQu4Cnh0AfwOOuy/UZv7oZSR5310VmBUqAnvzfwnbI9IHtkVS4z2VR9r9
	TCr9N1zk4wVe78+wnFOTqdASZdfy3rof9CnqAkjdbw71I/VMEULdfo3VvzLWrgFXDUL7
	okmg8HE061PdyQB3J/YSx8dnZ+8iwsMGg78yA=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Tue, 16 Apr 2019 16:15:56 +0300
Message-Id: <20190416131556.27109-1-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net] net: bridge: fix netlink export of
	vlan_stats_per_port option
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org

Since the introduction of the vlan_stats_per_port option the netlink
export of it has been broken since I made a typo and used the ifla
attribute instead of the bridge option to retrieve its state.
Sysfs export is fine, only netlink export has been affected.

Fixes: 9163a0fc1f0c0 ("net: bridge: add support for per-port vlan stats")
Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 net/bridge/br_netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 9c07591b0232..7104cf13da84 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -1441,7 +1441,7 @@ static int br_fill_info(struct sk_buff *skb, const struct net_device *brdev)
 	    nla_put_u8(skb, IFLA_BR_VLAN_STATS_ENABLED,
 		       br_opt_get(br, BROPT_VLAN_STATS_ENABLED)) ||
 	    nla_put_u8(skb, IFLA_BR_VLAN_STATS_PER_PORT,
-		       br_opt_get(br, IFLA_BR_VLAN_STATS_PER_PORT)))
+		       br_opt_get(br, BROPT_VLAN_STATS_PER_PORT)))
 		return -EMSGSIZE;
 #endif
 #ifdef CONFIG_BRIDGE_IGMP_SNOOPING
-- 
2.20.1

