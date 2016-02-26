Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=e3td3DAcFOY3lfm19OezNs1k7gsAWqOJeKBmfcFLA4g=;
	b=HTZviec+NNbS9KGtg9orQWVnytiVmYUr8ex0KIEMi+VIRB7qLvnkh5PfiH0pcWeY+T
	UboRd6C3+txuAZs+mKN/4ZK3v3GThGE2wXfpbDdo8ZFtJHaXKKHrge3C6BhWgxu5RPae
	HHOliGA4afFWjds1Q6gfw4dm+iRuZ7zN901jA=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Fri, 26 Feb 2016 21:20:04 +0100
Message-Id: <1456518004-25578-5-git-send-email-nikolay@cumulusnetworks.com>
In-Reply-To: <1456518004-25578-1-git-send-email-nikolay@cumulusnetworks.com>
References: <1456518004-25578-1-git-send-email-nikolay@cumulusnetworks.com>
Subject: [Bridge] [PATCH net-next v2 4/4] bridge: mcast: add support for
	more router port information dumping
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

Allow for more multicast router port information to be dumped such as
timer and type attributes. For that that purpose we need to extend the
MDBA_ROUTER_PORT attribute similar to how it was done for the mdb entries
recently. The new format is thus:
[MDBA_ROUTER_PORT] = { <- nested attribute
    u32 ifindex <- router port ifindex for user-space compatibility
    [MDBA_ROUTER_PATTR attributes]
}
This way it remains compatible with older users (they'll simply retrieve
the u32 in the beginning) and new users can parse the remaining
attributes. It would also allow to add future extensions to the router
port without breaking compatibility.

Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
v2: new patch, adds the extended router port netlink information

 include/uapi/linux/if_bridge.h | 14 +++++++++++++-
 net/bridge/br_mdb.c            | 16 ++++++++++++++--
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
index b281d02051cc..af98f6855b7e 100644
--- a/include/uapi/linux/if_bridge.h
+++ b/include/uapi/linux/if_bridge.h
@@ -161,7 +161,10 @@ enum {
  *     }
  * }
  * [MDBA_ROUTER] = {
- *    [MDBA_ROUTER_PORT]
+ *    [MDBA_ROUTER_PORT] = {
+ *        u32 ifindex
+ *        [MDBA_ROUTER_PATTR attributes]
+ *    }
  * }
  */
 enum {
@@ -209,6 +212,15 @@ enum {
 };
 #define MDBA_ROUTER_MAX (__MDBA_ROUTER_MAX - 1)
 
+/* router port attributes */
+enum {
+	MDBA_ROUTER_PATTR_UNSPEC,
+	MDBA_ROUTER_PATTR_TIMER,
+	MDBA_ROUTER_PATTR_TYPE,
+	__MDBA_ROUTER_PATTR_MAX
+};
+#define MDBA_ROUTER_PATTR_MAX (__MDBA_ROUTER_PATTR_MAX - 1)
+
 struct br_port_msg {
 	__u8  family;
 	__u32 ifindex;
diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index 73786e2fe065..253bc77eda3b 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -20,7 +20,7 @@ static int br_rports_fill_info(struct sk_buff *skb, struct netlink_callback *cb,
 {
 	struct net_bridge *br = netdev_priv(dev);
 	struct net_bridge_port *p;
-	struct nlattr *nest;
+	struct nlattr *nest, *port_nest;
 
 	if (!br->multicast_router || hlist_empty(&br->router_list))
 		return 0;
@@ -30,8 +30,20 @@ static int br_rports_fill_info(struct sk_buff *skb, struct netlink_callback *cb,
 		return -EMSGSIZE;
 
 	hlist_for_each_entry_rcu(p, &br->router_list, rlist) {
-		if (p && nla_put_u32(skb, MDBA_ROUTER_PORT, p->dev->ifindex))
+		if (!p)
+			continue;
+		port_nest = nla_nest_start(skb, MDBA_ROUTER_PORT);
+		if (!port_nest)
 			goto fail;
+		if (nla_put_nohdr(skb, sizeof(u32), &p->dev->ifindex) ||
+		    nla_put_u32(skb, MDBA_ROUTER_PATTR_TIMER,
+				br_timer_value(&p->multicast_router_timer)) ||
+		    nla_put_u8(skb, MDBA_ROUTER_PATTR_TYPE,
+			       p->multicast_router)) {
+			nla_nest_cancel(skb, port_nest);
+			goto fail;
+		}
+		nla_nest_end(skb, port_nest);
 	}
 
 	nla_nest_end(skb, nest);
-- 
2.4.3

