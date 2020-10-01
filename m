Return-Path: <Henrik.Bjoernlund@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1601548361; x=1633084361;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Hy/X4MWlgIswHAuMy/xndHrV6UV0/kJxBVphfflqOAM=;
 b=BObZBoBRNhbGl3EAHU2Ik4CBxn+e+jWAe7sEkjQDjnENMyzTBrYnRzTb
 /daCPESEyRdbqM4up12D7dSjlEClKEeH/lkW8SXDrv7gBTxRBX/ikmQxw
 ilkc/YxQbXeCFfsiU1SJP3LeJCPUMe2aDR1pMo0MtS8yvU6SiYqhWuiG8
 9ZJKLi3lTl3uXkzBUULypTedY0gl2NQyVdill+bCWWZcFQx57nKP6LH5g
 rt12ytm1wx1QKtG/8UVqP48hbuZ7JT7xhIAgFy2gtChWs5iBVOzABe0yb
 NyWmHF42LKb8iMfFJKzp94gyRYXl+jKOE5cOS9iA4A17V2LUzs2jc3nAi w==;
From: Henrik Bjoernlund <henrik.bjoernlund@microchip.com>
Date: Thu, 1 Oct 2020 10:30:10 +0000
Message-ID: <20201001103019.1342470-3-henrik.bjoernlund@microchip.com>
In-Reply-To: <20201001103019.1342470-1-henrik.bjoernlund@microchip.com>
References: <20201001103019.1342470-1-henrik.bjoernlund@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [net-next v2 02/11] bridge: cfm: Add BRIDGE_CFM to Kconfig.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: davem@davemloft.net, kuba@kernel.org, roopa@nvidia.com, nikolay@nvidia.com, jiri@mellanox.com, idosch@mellanox.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, UNGLinuxDriver@microchip.com
Cc: Henrik Bjoernlund <henrik.bjoernlund@microchip.com>, Horatiu Vultur <horatiu.vultur@microchip.com>

This makes it possible to include or exclude the CFM
protocol according to 802.1Q section 12.14.

Reviewed-by: Horatiu Vultur  <horatiu.vultur@microchip.com>
Signed-off-by: Henrik Bjoernlund  <henrik.bjoernlund@microchip.com>
---
 net/bridge/Kconfig      | 11 +++++++++++
 net/bridge/br_device.c  |  3 +++
 net/bridge/br_private.h |  3 +++
 3 files changed, 17 insertions(+)

diff --git a/net/bridge/Kconfig b/net/bridge/Kconfig
index 80879196560c..3c8ded7d3e84 100644
--- a/net/bridge/Kconfig
+++ b/net/bridge/Kconfig
@@ -73,3 +73,14 @@ config BRIDGE_MRP
 	  Say N to exclude this support and reduce the binary size.
 
 	  If unsure, say N.
+
+config BRIDGE_CFM
+	bool "CFM protocol"
+	depends on BRIDGE
+	help
+	  If you say Y here, then the Ethernet bridge will be able to run CFM
+	  protocol according to 802.1Q section 12.14
+
+	  Say N to exclude this support and reduce the binary size.
+
+	  If unsure, say N.
diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index 206c4ba51cd2..2a3b316f32eb 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -476,6 +476,9 @@ void br_dev_setup(struct net_device *dev)
 	INIT_HLIST_HEAD(&br->frame_type_list);
 #if IS_ENABLED(CONFIG_BRIDGE_MRP)
 	INIT_LIST_HEAD(&br->mrp_list);
+#endif
+#if IS_ENABLED(CONFIG_BRIDGE_CFM)
+	INIT_HLIST_HEAD(&br->mep_list);
 #endif
 	spin_lock_init(&br->hash_lock);
 
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 747f6f08f439..c7b0e91547f6 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -492,6 +492,9 @@ struct net_bridge {
 #if IS_ENABLED(CONFIG_BRIDGE_MRP)
 	struct list_head		mrp_list;
 #endif
+#if IS_ENABLED(CONFIG_BRIDGE_CFM)
+	struct hlist_head		mep_list;
+#endif
 };
 
 struct br_input_skb_cb {
-- 
2.28.0

