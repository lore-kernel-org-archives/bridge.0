Return-Path: <ast@asbjorn.biz>
From: Asbjoern Sloth Toennesen <ast@fiberby.net>
Date: Mon, 12 Aug 2013 16:30:09 +0000
Message-Id: <1376325009-8399-1-git-send-email-ast@fiberby.net>
In-Reply-To: <52090C26.4090001@fiberby.net>
References: <52090C26.4090001@fiberby.net>
Subject: [Bridge] [PATCH] rtnetlink: rtnl_bridge_getlink: Call
	nlmsg_find_attr() with ifinfomsg header
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "David S. Miller" <davem@davemloft.net>, Vlad Yasevich <vyasevic@redhat.com>, Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org

Fix the iproute2 command `bridge vlan show`, after switching from
rtgenmsg to ifinfomsg.

Signed-off-by: Asbjoern Sloth Toennesen <ast@fiberby.net>
---
 net/core/rtnetlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 3de7408..a043171 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -2384,7 +2384,7 @@ static int rtnl_bridge_getlink(struct sk_buff *skb, struct netlink_callback *cb)
 	struct nlattr *extfilt;
 	u32 filter_mask = 0;
 
-	extfilt = nlmsg_find_attr(cb->nlh, sizeof(struct rtgenmsg),
+	extfilt = nlmsg_find_attr(cb->nlh, sizeof(struct ifinfomsg),
 				  IFLA_EXT_MASK);
 	if (extfilt)
 		filter_mask = nla_get_u32(extfilt);
-- 
1.8.4.rc1

