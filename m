Return-Path: <sevinj.aghayeva@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0218C843FB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DDBD6843F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
 bh=W7xcUTJ+Xi3/2c+HEMlnIJrwY7Px5v+GX+wSId5EDcY=;
 b=MWAjhl+xoCtoaOvlX5qq05l39uxVSoxvIlUaU55ko4WaCeYDNkn0oncD0EiX46yoQt
 ccbjdN3leY+2tL2T1iPG0AqZri5cOUHdEloinZbEdwtjquCkGvhnn6olCwK9n6KsuZc9
 PfzXa7Z7yvrCO3hT97TvsXKKFkl9MwxaWwpfFP3ODGWKl7nlHsnh2OpBrCQw7O6inAho
 8Bl/kbDWxvu9mez4VtcPkke48/0Chbnh/gzTRZtox9jwpEeuNfWbOc7DWXTxRSsLtBVz
 hgpo8sQOTKAOI+JTFU9jiRXpul6ILHO7TxsHOtmbdgSRAf0vEleLgFrP1p2S301/TlZV
 QoPA==
From: Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
Date: Sat, 17 Sep 2022 16:18:00 -0400
Message-Id: <8ef43d44ebdebe90783325cb68edb70a7c80c038.1663445339.git.sevinj.aghayeva@gmail.com>
In-Reply-To: <cover.1663445339.git.sevinj.aghayeva@gmail.com>
References: <cover.1663445339.git.sevinj.aghayeva@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH RFC net-next 4/5] net: bridge: handle
	link-type-specific changes in the bridge module
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: aroulin@nvidia.com, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, sbrivio@redhat.com, Eric Dumazet <edumazet@google.com>, Sevinj Aghayeva <sevinj.aghayeva@gmail.com>, roopa@nvidia.com, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>

Introduce a handler to bridge module for handling vlan-specific
events.

Signed-off-by: Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
---
 net/bridge/br.c         |  5 +++++
 net/bridge/br_private.h |  7 +++++++
 net/bridge/br_vlan.c    | 18 ++++++++++++++++++
 3 files changed, 30 insertions(+)

diff --git a/net/bridge/br.c b/net/bridge/br.c
index 96e91d69a9a8..62e939c6a3f0 100644
--- a/net/bridge/br.c
+++ b/net/bridge/br.c
@@ -51,6 +51,11 @@ static int br_device_event(struct notifier_block *unused, unsigned long event, v
 		}
 	}
 
+	if (is_vlan_dev(dev)) {
+		br_vlan_device_event(dev, event, ptr);
+		return NOTIFY_DONE;
+	}
+
 	/* not a port of a bridge */
 	p = br_port_get_rtnl(dev);
 	if (!p)
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 06e5f6faa431..a9a08e49c76c 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -1470,6 +1470,8 @@ void br_vlan_get_stats(const struct net_bridge_vlan *v,
 void br_vlan_port_event(struct net_bridge_port *p, unsigned long event);
 int br_vlan_bridge_event(struct net_device *dev, unsigned long event,
 			 void *ptr);
+void br_vlan_device_event(struct net_device *dev, unsigned long event,
+ 			  void *ptr);
 void br_vlan_rtnl_init(void);
 void br_vlan_rtnl_uninit(void);
 void br_vlan_notify(const struct net_bridge *br,
@@ -1701,6 +1703,11 @@ static inline int br_vlan_bridge_event(struct net_device *dev,
 	return 0;
 }
 
+static void br_vlan_device_event(struct net_device *dev,
+				 unsigned long event, void *ptr)
+{
+}
+
 static inline void br_vlan_rtnl_init(void)
 {
 }
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 6e53dc991409..ba4e3c7a5f03 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <linux/kernel.h>
 #include <linux/netdevice.h>
+#include <linux/notifier_info.h>
 #include <linux/rtnetlink.h>
 #include <linux/slab.h>
 #include <net/switchdev.h>
@@ -1768,6 +1769,23 @@ void br_vlan_port_event(struct net_bridge_port *p, unsigned long event)
 	}
 }
 
+void br_vlan_device_event(struct net_device *dev,
+			  unsigned long event, void *ptr)
+{
+	struct netdev_notifier_change_details_info *details;
+	struct net_device *br_dev;
+
+	switch (event) {
+	case NETDEV_CHANGE_DETAILS:
+		details = ptr;
+		if (!netif_is_bridge_master(vlan_dev_priv(dev)->real_dev))
+			break;
+		br_dev = vlan_dev_priv(dev)->real_dev;
+		br_vlan_upper_change(br_dev, dev, details->vlan.bridge_binding);
+		break;
+	}
+}
+
 static bool br_vlan_stats_fill(struct sk_buff *skb,
 			       const struct net_bridge_vlan *v)
 {
-- 
2.34.1

