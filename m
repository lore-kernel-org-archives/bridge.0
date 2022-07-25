Return-Path: <bpoirier@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E5AFB40BB9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5A481400CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gfG18CqkicX3Zh98wFWzVuBJRVRZ5OoNRxgtmXBUkIQ=;
 b=kni+pcebiRNZ6nLZJcgHmg5eyOPr0hQR/91Nla1Me/CEiwZxtLrx0MR0khO3D5ZOHWe3jmvS3+3Cc6/Fg41CIKi26bDJa+2BVkJAo7Pydi3B6O33t3ldZuLE55ylhOR9O+GiF7YfFonhqjcTjTV05vNGcgIJg4ocxtd4KPyOjBv//F6k/W4/cbO9OqpYSta6ea/ymO2SjjK5mcHY5X0Q8Cpsq+63TgekSTEKMbA1dmMKjl0vzHvx9wMQJ2WHTX1odRs6GsGvBz27yl7s4gzNoHXa+U4TndJTjdi6DObHbuUCbbUWXkO/QwUyWf27tTFW55OLe15vCA1qfiTM0yBBuw==
From: Benjamin Poirier <bpoirier@nvidia.com>
Date: Mon, 25 Jul 2022 09:12:36 +0900
Message-Id: <20220725001236.95062-1-bpoirier@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [PATCH net] bridge: Do not send empty IFLA_AF_SPEC
	attribute
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Henrik Bjoernlund <henrik.bjoernlund@microchip.com>, Roopa Prabhu <roopa@nvidia.com>, Horatiu Vultur <horatiu.vultur@microchip.com>

After commit b6c02ef54913 ("bridge: Netlink interface fix."),
br_fill_ifinfo() started to send an empty IFLA_AF_SPEC attribute when a
bridge vlan dump is requested but an interface does not have any vlans
configured.

iproute2 ignores such an empty attribute since commit b262a9becbcb
("bridge: Fix output with empty vlan lists") but older iproute2 versions as
well as other utilities have their output changed by the cited kernel
commit, resulting in failed test cases. Regardless, emitting an empty
attribute is pointless and inefficient.

Avoid this change by canceling the attribute if no AF_SPEC data was added.

Fixes: b6c02ef54913 ("bridge: Netlink interface fix.")
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
---
 net/bridge/br_netlink.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index bb01776d2d88..c96509c442a5 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -589,9 +589,13 @@ static int br_fill_ifinfo(struct sk_buff *skb,
 	}
 
 done:
+	if (af) {
+		if (nlmsg_get_pos(skb) - (void *)af > nla_attr_size(0))
+			nla_nest_end(skb, af);
+		else
+			nla_nest_cancel(skb, af);
+	}
 
-	if (af)
-		nla_nest_end(skb, af);
 	nlmsg_end(skb, nlh);
 	return 0;
 
-- 
2.36.1

