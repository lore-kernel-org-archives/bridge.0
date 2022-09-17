Return-Path: <sevinj.aghayeva@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A1054843FB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D10AC843F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
 bh=KD38OQmgSaziFwz483qpbZ1Z/wABtZJQ/6K4DXA6e78=;
 b=gs9ODi1SU9Kl9RMZdfPPVTL92g9U582A3QyiLLRHk0DP7aMRekW1vpxaCY0DuFyIy4
 Gmc4JC2MEREo4YrkmPICVj1cRladnhz9FRB9fiEK9D3+BIlyLccZYLnCIxuHqHwdrsGD
 dW8uzY5Nr3tOyjePNVIUQBANY0ZAZjFX1So6C4mK1nQlfAAJBFmtz6jCoNsXy7zttZND
 jKfX1evavoNcmyB5HmuMkKAb5ycpNjp8o+OKvklksejBqwuCTi0YqGk2/+C1AXLVvmLd
 o8ma7WJJpQUuFiae7662YPBheSg92Qu7bruwrCCM5boqvzkYdsq1aBWq0QBXeiPfQ6Js
 14Xw==
From: Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
Date: Sat, 17 Sep 2022 16:17:59 -0400
Message-Id: <d6500b2caf726437fad97d37c728708755791c0e.1663445339.git.sevinj.aghayeva@gmail.com>
In-Reply-To: <cover.1663445339.git.sevinj.aghayeva@gmail.com>
References: <cover.1663445339.git.sevinj.aghayeva@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH RFC net-next 3/5] net: 8021q: notify bridge module
	of bridge-binding flag change
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

Notify the bridge module when a user changes the bridge-binding flag
of a VLAN interface using "ip link set ... vlan bridge_binding on"
command, so that the bridge module can take the appropriate action for
this change.

Signed-off-by: Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
---
 net/8021q/vlan.h     |  2 +-
 net/8021q/vlan_dev.c | 20 +++++++++++++++++---
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/net/8021q/vlan.h b/net/8021q/vlan.h
index 5eaf38875554..71947cdcfaaa 100644
--- a/net/8021q/vlan.h
+++ b/net/8021q/vlan.h
@@ -130,7 +130,7 @@ void vlan_dev_set_ingress_priority(const struct net_device *dev,
 int vlan_dev_set_egress_priority(const struct net_device *dev,
 				 u32 skb_prio, u16 vlan_prio);
 void vlan_dev_free_egress_priority(const struct net_device *dev);
-int vlan_dev_change_flags(const struct net_device *dev, u32 flag, u32 mask);
+int vlan_dev_change_flags(struct net_device *dev, u32 flag, u32 mask);
 void vlan_dev_get_realdev_name(const struct net_device *dev, char *result,
 			       size_t size);
 
diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index e1bb41a443c4..7c61b813e654 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -22,6 +22,7 @@
 #include <linux/skbuff.h>
 #include <linux/netdevice.h>
 #include <linux/net_tstamp.h>
+#include <linux/notifier_info.h>
 #include <linux/etherdevice.h>
 #include <linux/ethtool.h>
 #include <linux/phy.h>
@@ -211,8 +212,9 @@ int vlan_dev_set_egress_priority(const struct net_device *dev,
 /* Flags are defined in the vlan_flags enum in
  * include/uapi/linux/if_vlan.h file.
  */
-int vlan_dev_change_flags(const struct net_device *dev, u32 flags, u32 mask)
+int vlan_dev_change_flags(struct net_device *dev, u32 flags, u32 mask)
 {
+	struct netdev_notifier_change_details_info details;
 	struct vlan_dev_priv *vlan = vlan_dev_priv(dev);
 	u32 old_flags = vlan->flags;
 
@@ -223,19 +225,31 @@ int vlan_dev_change_flags(const struct net_device *dev, u32 flags, u32 mask)
 
 	vlan->flags = (old_flags & ~mask) | (flags & mask);
 
-	if (netif_running(dev) && (vlan->flags ^ old_flags) & VLAN_FLAG_GVRP) {
+	if (!netif_running(dev))
+		return 0;
+
+	if ((vlan->flags ^ old_flags) & VLAN_FLAG_GVRP) {
 		if (vlan->flags & VLAN_FLAG_GVRP)
 			vlan_gvrp_request_join(dev);
 		else
 			vlan_gvrp_request_leave(dev);
 	}
 
-	if (netif_running(dev) && (vlan->flags ^ old_flags) & VLAN_FLAG_MVRP) {
+	if ((vlan->flags ^ old_flags) & VLAN_FLAG_MVRP) {
 		if (vlan->flags & VLAN_FLAG_MVRP)
 			vlan_mvrp_request_join(dev);
 		else
 			vlan_mvrp_request_leave(dev);
 	}
+
+	if ((vlan->flags ^ old_flags) & VLAN_FLAG_BRIDGE_BINDING &&
+	    netif_is_bridge_master(vlan->real_dev)) {
+		details.info.dev = dev;
+		details.vlan.bridge_binding =
+		    !!(vlan->flags & VLAN_FLAG_BRIDGE_BINDING);
+		call_netdevice_notifiers_info(NETDEV_CHANGE_DETAILS, &details.info);
+	}
+
 	return 0;
 }
 
-- 
2.34.1

