Return-Path: <sevinj.aghayeva@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B32C560BDF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D59F560B33
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=44S36YW/XCMky1KM2xLak/T6CHlN1QC9bWrP+1FyJlw=;
 b=g0Q21UbliVaSVVRMLR3KfiO1ctfkqbex+ADs1SZPfocxQiayXVsduesPlZ4XJEiDIX
 MbPdTPlfkRj/GfrNerNSTILsktSvye1srw6OW48ozmemcia6FSJlgkXOKVrgKLANXPmu
 +FF/9kp/oYfvE7hwMdi6PzVw2QgMACsouWINDbI3zFGjUzpPw/b098zruYu7M0QyxJVR
 wkqAQxQKbgxWILj3gAe+4QNYGSNupa3H3lBxy4TR2c4d7ZMnUOr9D3b+A3G93pV0yHxu
 SjwEyUuZRP1dzX4nkN6wf9HzXqxi3wo2x6YbfP2j6OxJYslXCvJOkk6/wJiWe97PEDUP
 ii0g==
From: Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
Date: Sat, 30 Jul 2022 12:03:30 -0400
Message-Id: <75d00c06deadc0386811874f9e4edbf5381df949.1659195179.git.sevinj.aghayeva@gmail.com>
In-Reply-To: <cover.1659195179.git.sevinj.aghayeva@gmail.com>
References: <cover.1659195179.git.sevinj.aghayeva@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 1/3] net: bridge: export
	br_vlan_upper_change
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: aroulin@nvidia.com
Cc: netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, sbrivio@redhat.com, Eric Dumazet <edumazet@google.com>, Sevinj Aghayeva <sevinj.aghayeva@gmail.com>, roopa@nvidia.com, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>

This function contains the logic for correctly setting the bridge
binding behavior of a vlan interface. Therefore, it should be executed
whenever the bridge binding flag of a vlan interface changes via the
vlan_dev_change_flags function in the 8021q module. Currently this
function is private, and it is only executed when a vlan interface is
first created. Export the function so that it can be called from
vlan_dev_change_flags.

Signed-off-by: Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
Reviewed-by: Andy Roulin <aroulin@nvidia.com>
Reviewed-by: Roopa Prabhu <roopa@nvidia.com>
---
 include/linux/if_bridge.h | 9 +++++++++
 net/bridge/br_vlan.c      | 7 ++++---
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/include/linux/if_bridge.h b/include/linux/if_bridge.h
index d62ef428e3aa..0d92b0ed0961 100644
--- a/include/linux/if_bridge.h
+++ b/include/linux/if_bridge.h
@@ -180,6 +180,9 @@ void br_fdb_clear_offload(const struct net_device *dev, u16 vid);
 bool br_port_flag_is_set(const struct net_device *dev, unsigned long flag);
 u8 br_port_get_stp_state(const struct net_device *dev);
 clock_t br_get_ageing_time(const struct net_device *br_dev);
+void br_vlan_upper_change(struct net_device *dev,
+			  struct net_device *upper_dev,
+			  bool linking);
 #else
 static inline struct net_device *
 br_fdb_find_port(const struct net_device *br_dev,
@@ -208,6 +211,12 @@ static inline clock_t br_get_ageing_time(const struct net_device *br_dev)
 {
 	return 0;
 }
+
+static inline void br_vlan_upper_change(struct net_device *dev,
+					struct net_device *upper_dev,
+					bool linking)
+{
+}
 #endif
 
 #endif
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 6e53dc991409..6bfc36da5a88 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -1653,9 +1653,9 @@ static void br_vlan_set_all_vlan_dev_state(struct net_bridge_port *p)
 	}
 }
 
-static void br_vlan_upper_change(struct net_device *dev,
-				 struct net_device *upper_dev,
-				 bool linking)
+void br_vlan_upper_change(struct net_device *dev,
+			  struct net_device *upper_dev,
+			  bool linking)
 {
 	struct net_bridge *br = netdev_priv(dev);
 
@@ -1670,6 +1670,7 @@ static void br_vlan_upper_change(struct net_device *dev,
 			      br_vlan_has_upper_bind_vlan_dev(dev));
 	}
 }
+EXPORT_SYMBOL_GPL(br_vlan_upper_change);
 
 struct br_vlan_link_state_walk_data {
 	struct net_bridge *br;
-- 
2.25.1

