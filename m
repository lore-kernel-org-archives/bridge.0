Return-Path: <Horatiu.Vultur@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1587395520; x=1618931520;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=f83042ZIqutNYkKufvnkcdocBQbp4ZWpcUIFE5BjUho=;
 b=1ZJBsVrm6RoOpk+4ZWR7UmjlbDRHLQjucjN8kbN0f8a15AruEizRUYsl
 SLuB2NpMYkc3wEJPOJvakV7na9+xipJnnvRC7JG6g2FGoDLvkCRaNjU13
 cKjT5YLp6oeujAyn2uQr/NLp9wpIe/XlqoshMh2L+9nPwN+lO/GiraLDB
 rmXKSmoc+CHfx/tvcqa0Kel2wpcHI11/FVPj1YYJQWdPcrt2GsqpGBP8V
 +S3OiEXW7foZLCWMgAkmEsB41x9Sarhe3IHzt6797OQ+2S3GN2df0WpsO
 Lr46ORexsfLxvOsD5Suifwi/6zRFDR1WJoJQuPGfKlPPzvP9PhhlMq1KB w==;
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Mon, 20 Apr 2020 17:09:40 +0200
Message-ID: <20200420150947.30974-7-horatiu.vultur@microchip.com>
In-Reply-To: <20200420150947.30974-1-horatiu.vultur@microchip.com>
References: <20200420150947.30974-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next 06/13] bridge: mrp: Extend bridge interface
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: nikolay@cumulusnetworks.com, davem@davemloft.net, jiri@resnulli.us, ivecera@redhat.com, kuba@kernel.org, roopa@cumulusnetworks.com, olteanv@gmail.com, andrew@lunn.ch, UNGLinuxDriver@microchip.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>

To integrate MRP into the bridge, first the bridge needs to be aware of ports
that are part of an MRP ring and which rings are on the bridge.
Therefore extend bridge interface with the following:
- add new flag(BR_MPP_AWARE) to the net bridge ports, this bit will be
  set when the port is added to an MRP instance. In this way it knows if
  the frame was received on MRP ring port
- add a list of MRP instances

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 include/linux/if_bridge.h | 1 +
 net/bridge/br_private.h   | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/include/linux/if_bridge.h b/include/linux/if_bridge.h
index 9e57c4411734..10baa9efdae8 100644
--- a/include/linux/if_bridge.h
+++ b/include/linux/if_bridge.h
@@ -47,6 +47,7 @@ struct br_ip_list {
 #define BR_BCAST_FLOOD		BIT(14)
 #define BR_NEIGH_SUPPRESS	BIT(15)
 #define BR_ISOLATED		BIT(16)
+#define BR_MRP_AWARE		BIT(17)
 
 #define BR_DEFAULT_AGEING_TIME	(300 * HZ)
 
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 735ec6ff86cc..b3c176a0a136 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -432,6 +432,10 @@ struct net_bridge {
 	int offload_fwd_mark;
 #endif
 	struct hlist_head		fdb_list;
+
+#if IS_ENABLED(CONFIG_BRIDGE_MRP)
+	struct list_head		__rcu mrp_list;
+#endif
 };
 
 struct br_input_skb_cb {
-- 
2.17.1

