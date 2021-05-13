Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Thu, 13 May 2021 15:20:52 +0200
Message-Id: <20210513132053.23445-11-linus.luessing@c0d3.blue>
In-Reply-To: <20210513132053.23445-1-linus.luessing@c0d3.blue>
References: <20210513132053.23445-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [net-next v4 10/11] net: bridge: mcast: add ip4+ip6 mcast
	router timers to mdb netlink
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>

Now that we have split the multicast router state into two, one for IPv4
and one for IPv6, also add individual timers to the mdb netlink router
port dump. Leaving the old timer attribute for backwards compatibility.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 include/uapi/linux/if_bridge.h | 2 ++
 net/bridge/br_mdb.c            | 8 +++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
index 13d59c5..6b56a75 100644
--- a/include/uapi/linux/if_bridge.h
+++ b/include/uapi/linux/if_bridge.h
@@ -627,6 +627,8 @@ enum {
 	MDBA_ROUTER_PATTR_UNSPEC,
 	MDBA_ROUTER_PATTR_TIMER,
 	MDBA_ROUTER_PATTR_TYPE,
+	MDBA_ROUTER_PATTR_INET_TIMER,
+	MDBA_ROUTER_PATTR_INET6_TIMER,
 	__MDBA_ROUTER_PATTR_MAX
 };
 #define MDBA_ROUTER_PATTR_MAX (__MDBA_ROUTER_PATTR_MAX - 1)
diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index 10c416c..3f839a8 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -79,7 +79,13 @@ static int br_rports_fill_info(struct sk_buff *skb, struct netlink_callback *cb,
 		    nla_put_u32(skb, MDBA_ROUTER_PATTR_TIMER,
 				max(ip4_timer, ip6_timer)) ||
 		    nla_put_u8(skb, MDBA_ROUTER_PATTR_TYPE,
-			       p->multicast_router)) {
+			       p->multicast_router) ||
+		    (have_ip4_mc_rtr &&
+		     nla_put_u32(skb, MDBA_ROUTER_PATTR_INET_TIMER,
+				 ip4_timer)) ||
+		    (have_ip6_mc_rtr &&
+		     nla_put_u32(skb, MDBA_ROUTER_PATTR_INET6_TIMER,
+				 ip6_timer))) {
 			nla_nest_cancel(skb, port_nest);
 			goto fail;
 		}
-- 
2.31.0

