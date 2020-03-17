Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YBMtaydtMsUyjN0wuzRBrD9zMyV40susRIgvtFGzgDM=;
 b=HtCfsHD2ip/yn9NfToMIjSXno04bPTqe0tHzIMe1I+8ZseVbkmq7NMZ7MMKR+qICQE
 9MIR1cYE9FGSPWqpA2O2N5fgjtg2RXT8y3rkfnpK2mYh2xvQo6+OFjnXd4xAft3pw55/
 /TOdDRNeALlxrZ9hJfLJEh6pEpA9P+QTFBpG8=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Tue, 17 Mar 2020 14:08:34 +0200
Message-Id: <20200317120836.1765164-3-nikolay@cumulusnetworks.com>
In-Reply-To: <20200317120836.1765164-1-nikolay@cumulusnetworks.com>
References: <20200317120836.1765164-1-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 2/4] net: bridge: vlan tunnel: constify
	bridge and port arguments
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

The vlan tunnel code changes vlan options, it shouldn't touch port or
bridge options so we can constify the port argument. This would later help
us to re-use these functions from the vlan options code.

Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 net/bridge/br_netlink_tunnel.c |  6 +++---
 net/bridge/br_private_tunnel.h | 13 +++++++------
 net/bridge/br_vlan_tunnel.c    |  5 +++--
 3 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/net/bridge/br_netlink_tunnel.c b/net/bridge/br_netlink_tunnel.c
index afee292fb004..beea08b8c422 100644
--- a/net/bridge/br_netlink_tunnel.c
+++ b/net/bridge/br_netlink_tunnel.c
@@ -193,7 +193,7 @@ static const struct nla_policy vlan_tunnel_policy[IFLA_BRIDGE_VLAN_TUNNEL_MAX +
 	[IFLA_BRIDGE_VLAN_TUNNEL_FLAGS] = { .type = NLA_U16 },
 };
 
-static int br_vlan_tunnel_info(struct net_bridge_port *p, int cmd,
+static int br_vlan_tunnel_info(const struct net_bridge_port *p, int cmd,
 			       u16 vid, u32 tun_id, bool *changed)
 {
 	int err = 0;
@@ -250,8 +250,8 @@ int br_parse_vlan_tunnel_info(struct nlattr *attr,
 	return 0;
 }
 
-int br_process_vlan_tunnel_info(struct net_bridge *br,
-				struct net_bridge_port *p, int cmd,
+int br_process_vlan_tunnel_info(const struct net_bridge *br,
+				const struct net_bridge_port *p, int cmd,
 				struct vtunnel_info *tinfo_curr,
 				struct vtunnel_info *tinfo_last,
 				bool *changed)
diff --git a/net/bridge/br_private_tunnel.h b/net/bridge/br_private_tunnel.h
index 2bdef2ea3420..a9b818fc8b6c 100644
--- a/net/bridge/br_private_tunnel.h
+++ b/net/bridge/br_private_tunnel.h
@@ -18,8 +18,8 @@ struct vtunnel_info {
 /* br_netlink_tunnel.c */
 int br_parse_vlan_tunnel_info(struct nlattr *attr,
 			      struct vtunnel_info *tinfo);
-int br_process_vlan_tunnel_info(struct net_bridge *br,
-				struct net_bridge_port *p,
+int br_process_vlan_tunnel_info(const struct net_bridge *br,
+				const struct net_bridge_port *p,
 				int cmd,
 				struct vtunnel_info *tinfo_curr,
 				struct vtunnel_info *tinfo_last,
@@ -32,8 +32,9 @@ int br_fill_vlan_tunnel_info(struct sk_buff *skb,
 /* br_vlan_tunnel.c */
 int vlan_tunnel_init(struct net_bridge_vlan_group *vg);
 void vlan_tunnel_deinit(struct net_bridge_vlan_group *vg);
-int nbp_vlan_tunnel_info_delete(struct net_bridge_port *port, u16 vid);
-int nbp_vlan_tunnel_info_add(struct net_bridge_port *port, u16 vid, u32 tun_id);
+int nbp_vlan_tunnel_info_delete(const struct net_bridge_port *port, u16 vid);
+int nbp_vlan_tunnel_info_add(const struct net_bridge_port *port, u16 vid,
+			     u32 tun_id);
 void nbp_vlan_tunnel_info_flush(struct net_bridge_port *port);
 void vlan_tunnel_info_del(struct net_bridge_vlan_group *vg,
 			  struct net_bridge_vlan *vlan);
@@ -48,13 +49,13 @@ static inline int vlan_tunnel_init(struct net_bridge_vlan_group *vg)
 	return 0;
 }
 
-static inline int nbp_vlan_tunnel_info_delete(struct net_bridge_port *port,
+static inline int nbp_vlan_tunnel_info_delete(const struct net_bridge_port *port,
 					      u16 vid)
 {
 	return 0;
 }
 
-static inline int nbp_vlan_tunnel_info_add(struct net_bridge_port *port,
+static inline int nbp_vlan_tunnel_info_add(const struct net_bridge_port *port,
 					   u16 vid, u32 tun_id)
 {
 	return 0;
diff --git a/net/bridge/br_vlan_tunnel.c b/net/bridge/br_vlan_tunnel.c
index d13d2080f527..169e005fbda2 100644
--- a/net/bridge/br_vlan_tunnel.c
+++ b/net/bridge/br_vlan_tunnel.c
@@ -89,7 +89,8 @@ static int __vlan_tunnel_info_add(struct net_bridge_vlan_group *vg,
 /* Must be protected by RTNL.
  * Must be called with vid in range from 1 to 4094 inclusive.
  */
-int nbp_vlan_tunnel_info_add(struct net_bridge_port *port, u16 vid, u32 tun_id)
+int nbp_vlan_tunnel_info_add(const struct net_bridge_port *port, u16 vid,
+			     u32 tun_id)
 {
 	struct net_bridge_vlan_group *vg;
 	struct net_bridge_vlan *vlan;
@@ -107,7 +108,7 @@ int nbp_vlan_tunnel_info_add(struct net_bridge_port *port, u16 vid, u32 tun_id)
 /* Must be protected by RTNL.
  * Must be called with vid in range from 1 to 4094 inclusive.
  */
-int nbp_vlan_tunnel_info_delete(struct net_bridge_port *port, u16 vid)
+int nbp_vlan_tunnel_info_delete(const struct net_bridge_port *port, u16 vid)
 {
 	struct net_bridge_vlan_group *vg;
 	struct net_bridge_vlan *v;
-- 
2.24.1

