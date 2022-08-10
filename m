Return-Path: <sevinj.aghayeva@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B179260FE2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D4A9D60FA8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc;
 bh=Hp8X0Fyr4/2vEhnQv+XptPZYetbjO6fR4naGTVRNFEM=;
 b=cNpzzB1r3CIyeIFPMsN7JSnnntMkiuMtFWRzYVBFPnHuy082TYrzFn/KTQZipNcjgk
 uZ1Mk/VwdQoMec9VWUtDqfcMKy47WBL32T7HHnz6i14X7ZAdZq37p1iaUBXsAXndQbxA
 1F3Jp4KoCltzWgv6n1TUfL0ry8MKU9RLs5XgcgAzheVqVsIeUUNfvcFBilIPFjgChHBs
 Rv4KXtpSNmRbp9f5stWjX5Avc6XJbG06A55YMS8BxDViv1EllxR6ysbpA0BduKb6nM8V
 XmskwtufmwpAtFuPT8xW3v1i5YH4wv9qErn+znOLnbISrtP9bDLhTRna3ghVntrBewwV
 f43Q==
From: Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
Date: Tue,  9 Aug 2022 23:11:20 -0400
Message-Id: <3a01eea27e92133a3130e3d8d5f487d6900298db.1660100506.git.sevinj.aghayeva@gmail.com>
In-Reply-To: <cover.1660100506.git.sevinj.aghayeva@gmail.com>
References: <cover.1660100506.git.sevinj.aghayeva@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH RFC net-next 2/3] net: 8021q: fix bridge binding
	behavior for vlan interfaces
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

Currently, when one creates a vlan interface with the bridge binding flag
disabled (using ip link add... command) and then enables the bridge binding flag
afterwards (using ip link set... command), the second command has no effect. In
other words, the vlan interface does not follow the status of the ports in its
vlan.

The root cause of this problem is as follows. The correct bridge binding
behavior depends on two flags being set: a per vlan interface flag
(VLAN_FLAG_BRIDGE_BINDING) and global per bridge flag
(BROPT_VLAN_BRIDGE_BINDING); the ip link set command calls vlan_dev_change_flags
function, which sets only the per vlan interface flag.

The correct behavior is to set/unset per bridge flag as well, depending on
whether there are other vlan interfaces with bridge binding flags set. The logic
for this behavior is already captured in br_vlan_upper_change function, which is
called whenever NETDEV_CHANGEUPPER event occurs. This patch fixes the bridge
binding behavior by triggering the NETDEV_CHANGEUPPER event from the
vlan_dev_change_flags function whenever the per interface flag is changed.

Signed-off-by: Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
---
 net/8021q/vlan.h     |  2 +-
 net/8021q/vlan_dev.c | 25 ++++++++++++++++++++++---
 2 files changed, 23 insertions(+), 4 deletions(-)

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
index 839f2020b015..49cf4cceebef 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -208,12 +208,19 @@ int vlan_dev_set_egress_priority(const struct net_device *dev,
 	return 0;
 }
 
+static inline bool netif_is_bridge(const struct net_device *dev)
+{
+	return dev->rtnl_link_ops &&
+	    !strcmp(dev->rtnl_link_ops->kind, "bridge");
+}
+
 /* Flags are defined in the vlan_flags enum in
  * include/uapi/linux/if_vlan.h file.
  */
-int vlan_dev_change_flags(const struct net_device *dev, u32 flags, u32 mask)
+int vlan_dev_change_flags(struct net_device *dev, u32 flags, u32 mask)
 {
 	struct vlan_dev_priv *vlan = vlan_dev_priv(dev);
+	struct netdev_notifier_changeupper_info info;
 	u32 old_flags = vlan->flags;
 
 	if (mask & ~(VLAN_FLAG_REORDER_HDR | VLAN_FLAG_GVRP |
@@ -223,19 +230,31 @@ int vlan_dev_change_flags(const struct net_device *dev, u32 flags, u32 mask)
 
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
+	    netif_is_bridge(vlan->real_dev)) {
+		info.info.dev = vlan->real_dev;
+		info.upper_dev = dev;
+		info.linking = !!(vlan->flags & VLAN_FLAG_BRIDGE_BINDING);
+		call_netdevice_notifiers_info(NETDEV_CHANGEUPPER, &info.info);
+	}
+
 	return 0;
 }
 
-- 
2.25.1

