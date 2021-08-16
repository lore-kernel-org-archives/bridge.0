Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cEF4JoMHZEME1+G2CZln0Yotihc+zLCjsCuSYLc+j3Q=;
 b=ZjYbNocK7nQUZmK7tS1SYFaF524im4zpkYuIBe6PLoxPdvEg0nn2rcea6i9NgA8bX4
 5WxNZdktA5V1y3KOperLhnJRMWBEby8lRcK9l7YLqU355DpaS10sNON3jKYdlBXK8ytZ
 jcDmlbG/jOEGCna1DpdOLm16+JkjTsG1COKe/bBUmDBZ5Puj4LqLXK45s9LdVVItgSaS
 M8AU97MS3myCmrlBPZ+iXOeShvRSHzWI7WtrziFO2XoQv24HwBVQD9wl0A5CCtnsoMb2
 u2DlHGrvkSDUt3nAQmJ4Oz37oB5aH27bTak8L5rH0jBRcM/dBPzjZ2AcfcmnC3KJ48Is
 3kRg==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Mon, 16 Aug 2021 17:57:07 +0300
Message-Id: <20210816145707.671901-5-razor@blackwall.org>
In-Reply-To: <20210816145707.671901-1-razor@blackwall.org>
References: <20210816145707.671901-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 4/4] net: bridge: mcast: toggle also host
	vlan state in br_multicast_toggle_vlan
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: bridge@lists.linux-foundation.org, Nikolay Aleksandrov <nikolay@nvidia.com>, roopa@nvidia.com

From: Nikolay Aleksandrov <nikolay@nvidia.com>

When changing vlan mcast state by br_multicast_toggle_vlan it iterates
over all ports and enables/disables the port mcast ctx based on the new
state, but I forgot to update the host vlan (bridge master vlan entry)
with the new state so it will be left out. Also that function is not
used outside of br_multicast.c, so make it static.

Fixes: f4b7002a7076 ("net: bridge: add vlan mcast snooping knob")
Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
 net/bridge/br_multicast.c | 5 ++++-
 net/bridge/br_private.h   | 6 ------
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index c9f7f56eaf9b..16e686f5b9e9 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -4074,7 +4074,7 @@ void br_multicast_toggle_one_vlan(struct net_bridge_vlan *vlan, bool on)
 	}
 }
 
-void br_multicast_toggle_vlan(struct net_bridge_vlan *vlan, bool on)
+static void br_multicast_toggle_vlan(struct net_bridge_vlan *vlan, bool on)
 {
 	struct net_bridge_port *p;
 
@@ -4089,6 +4089,9 @@ void br_multicast_toggle_vlan(struct net_bridge_vlan *vlan, bool on)
 			continue;
 		br_multicast_toggle_one_vlan(vport, on);
 	}
+
+	if (br_vlan_is_brentry(vlan))
+		br_multicast_toggle_one_vlan(vlan, on);
 }
 
 int br_multicast_toggle_vlan_snooping(struct net_bridge *br, bool on,
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index df0fa246c80c..21b292eb2b3e 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -938,7 +938,6 @@ void br_multicast_port_ctx_init(struct net_bridge_port *port,
 				struct net_bridge_mcast_port *pmctx);
 void br_multicast_port_ctx_deinit(struct net_bridge_mcast_port *pmctx);
 void br_multicast_toggle_one_vlan(struct net_bridge_vlan *vlan, bool on);
-void br_multicast_toggle_vlan(struct net_bridge_vlan *vlan, bool on);
 int br_multicast_toggle_vlan_snooping(struct net_bridge *br, bool on,
 				      struct netlink_ext_ack *extack);
 bool br_multicast_toggle_global_vlan(struct net_bridge_vlan *vlan, bool on);
@@ -1370,11 +1369,6 @@ static inline void br_multicast_toggle_one_vlan(struct net_bridge_vlan *vlan,
 {
 }
 
-static inline void br_multicast_toggle_vlan(struct net_bridge_vlan *vlan,
-					    bool on)
-{
-}
-
 static inline int br_multicast_toggle_vlan_snooping(struct net_bridge *br,
 						    bool on,
 						    struct netlink_ext_ack *extack)
-- 
2.31.1

