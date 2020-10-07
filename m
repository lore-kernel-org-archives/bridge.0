Return-Path: <Henrik.Bjoernlund@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1602072540; x=1633608540;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=A71AhQGOkyGRAStPfAC/MBymcrQUUaFkVYzBRt+XfEQ=;
 b=kTU7lhXA3LOq3XVwjI40xKX70G+yx4xIEdewrNMe8MftvT+i5JPu3Uq1
 Hi0v7cw4MqQYSVQgUorfSXh6gCDKjFPXP11hwny7XaSDFh73c9B2NTLnA
 uFZHhjKltHQs4RmgM4HQtJedLEnEyZCBUmev+34iZQ/WAYYn7RTihhdDf
 wgUZsrG9m0Hu32N+4i87YSjPBCTqewobzuKI4zIYCi8qmHUyusfX6GK1f
 p48sz500t8dMy0Kmd14kdRxaDKrX0WGwduIzJAlA+wR7zdN5hooJ+U5tW
 9u426z5VF13VBv/eC4C1XClxzS8EyK+l4iRfjPws1sokKX2rsuHeAGkwR w==;
From: Henrik Bjoernlund <henrik.bjoernlund@microchip.com>
Date: Wed, 7 Oct 2020 12:07:00 +0000
Message-ID: <20201007120700.2152699-1-henrik.bjoernlund@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net] bridge: Netlink interface fix.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: davem@davemloft.net, roopa@nvidia.com, nikolay@nvidia.com, kuba@kernel.org, bridge@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com
Cc: Henrik Bjoernlund <henrik.bjoernlund@microchip.com>, Horatiu Vultur <horatiu.vultur@microchip.com>

This commit is correcting NETLINK br_fill_ifinfo() to be able to
handle 'filter_mask' with multiple flags asserted.

Fixes: 36a8e8e265420 ("bridge: Extend br_fill_ifinfo to return MPR status")

Signed-off-by: Henrik Bjoernlund <henrik.bjoernlund@microchip.com>
Reviewed-by: Horatiu Vultur <horatiu.vultur@microchip.com>
Suggested-by: Nikolay Aleksandrov <nikolay@nvidia.com>
Tested-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 net/bridge/br_netlink.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 8a71c60fa357..92d64abffa87 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -380,6 +380,7 @@ static int br_fill_ifinfo(struct sk_buff *skb,
 			  u32 filter_mask, const struct net_device *dev)
 {
 	u8 operstate = netif_running(dev) ? dev->operstate : IF_OPER_DOWN;
+	struct nlattr *af = NULL;
 	struct net_bridge *br;
 	struct ifinfomsg *hdr;
 	struct nlmsghdr *nlh;
@@ -423,11 +424,18 @@ static int br_fill_ifinfo(struct sk_buff *skb,
 		nla_nest_end(skb, nest);
 	}
 
+	if (filter_mask & (RTEXT_FILTER_BRVLAN |
+			   RTEXT_FILTER_BRVLAN_COMPRESSED |
+			   RTEXT_FILTER_MRP)) {
+		af = nla_nest_start_noflag(skb, IFLA_AF_SPEC);
+		if (!af)
+			goto nla_put_failure;
+	}
+
 	/* Check if  the VID information is requested */
 	if ((filter_mask & RTEXT_FILTER_BRVLAN) ||
 	    (filter_mask & RTEXT_FILTER_BRVLAN_COMPRESSED)) {
 		struct net_bridge_vlan_group *vg;
-		struct nlattr *af;
 		int err;
 
 		/* RCU needed because of the VLAN locking rules (rcu || rtnl) */
@@ -441,11 +449,6 @@ static int br_fill_ifinfo(struct sk_buff *skb,
 			rcu_read_unlock();
 			goto done;
 		}
-		af = nla_nest_start_noflag(skb, IFLA_AF_SPEC);
-		if (!af) {
-			rcu_read_unlock();
-			goto nla_put_failure;
-		}
 		if (filter_mask & RTEXT_FILTER_BRVLAN_COMPRESSED)
 			err = br_fill_ifvlaninfo_compressed(skb, vg);
 		else
@@ -456,32 +459,25 @@ static int br_fill_ifinfo(struct sk_buff *skb,
 		rcu_read_unlock();
 		if (err)
 			goto nla_put_failure;
-
-		nla_nest_end(skb, af);
 	}
 
 	if (filter_mask & RTEXT_FILTER_MRP) {
-		struct nlattr *af;
 		int err;
 
 		if (!br_mrp_enabled(br) || port)
 			goto done;
 
-		af = nla_nest_start_noflag(skb, IFLA_AF_SPEC);
-		if (!af)
-			goto nla_put_failure;
-
 		rcu_read_lock();
 		err = br_mrp_fill_info(skb, br);
 		rcu_read_unlock();
 
 		if (err)
 			goto nla_put_failure;
-
-		nla_nest_end(skb, af);
 	}
 
 done:
+	if (af)
+		nla_nest_end(skb, af);
 	nlmsg_end(skb, nlh);
 	return 0;
 
-- 
2.28.0

