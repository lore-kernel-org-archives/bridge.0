Return-Path: <Horatiu.Vultur@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1594027284; x=1625563284;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=BPXYksHE/6skyxwfmW3layVz9HGsj0QnR14maadzSj4=;
 b=17i4dR+pL3mN9MAnlCqgpOIoNQU+P1kyV2A1Tsq93PWI/VCMz34YoZ4O
 e64eb2ztMiP4hpR0AQwpa+a8rMdpKV7zcWnRonjeuYxvcJPdsLfy3xMrJ
 hTkBaKnQsZfx9yv8hEH5kFUtxj6O7GrfwW0G8HMfIUb9uSAcXmoHtTJ/A
 POedEumiUlnFp/cK9Zqnb6vkWT4TZWeUK5kU5GlLFIS7OxrgxWzutFzXL
 FD0hrXZH0ocXm9zWXbRM7p/Hli8Qioj0SGUpRRfcXc29/R4wlp/1vBgJu
 Ih4bh2HNyydYWhmQdYswE8uovF+40UF6J47gYT/+L2AMM0+8812ZItVxD Q==;
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Mon, 6 Jul 2020 11:18:42 +0200
Message-ID: <20200706091842.3324565-13-horatiu.vultur@microchip.com>
In-Reply-To: <20200706091842.3324565-1-horatiu.vultur@microchip.com>
References: <20200706091842.3324565-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next 12/12] net: bridge: Add port attribute
	IFLA_BRPORT_MRP_IN_OPEN
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: nikolay@cumulusnetworks.com, roopa@cumulusnetworks.com, davem@davemloft.net, kuba@kernel.org, jiri@resnulli.us, ivecera@redhat.com, andrew@lunn.ch, UNGLinuxDriver@microchip.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>

This patch adds a new port attribute, IFLA_BRPORT_MRP_IN_OPEN, which
allows to notify the userspace when the node lost the contiuity of
MRP_InTest frames.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 include/uapi/linux/if_link.h       | 1 +
 net/bridge/br_netlink.c            | 3 +++
 tools/include/uapi/linux/if_link.h | 1 +
 3 files changed, 5 insertions(+)

diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index cc185a007ade8..26842ffd0501d 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -344,6 +344,7 @@ enum {
 	IFLA_BRPORT_ISOLATED,
 	IFLA_BRPORT_BACKUP_PORT,
 	IFLA_BRPORT_MRP_RING_OPEN,
+	IFLA_BRPORT_MRP_IN_OPEN,
 	__IFLA_BRPORT_MAX
 };
 #define IFLA_BRPORT_MAX (__IFLA_BRPORT_MAX - 1)
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index c532fa65c9834..147d52596e174 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -152,6 +152,7 @@ static inline size_t br_port_info_size(void)
 #endif
 		+ nla_total_size(sizeof(u16))	/* IFLA_BRPORT_GROUP_FWD_MASK */
 		+ nla_total_size(sizeof(u8))	/* IFLA_BRPORT_MRP_RING_OPEN */
+		+ nla_total_size(sizeof(u8))	/* IFLA_BRPORT_MRP_IN_OPEN */
 		+ 0;
 }
 
@@ -216,6 +217,8 @@ static int br_port_fill_attrs(struct sk_buff *skb,
 		       !!(p->flags & BR_NEIGH_SUPPRESS)) ||
 	    nla_put_u8(skb, IFLA_BRPORT_MRP_RING_OPEN, !!(p->flags &
 							  BR_MRP_LOST_CONT)) ||
+	    nla_put_u8(skb, IFLA_BRPORT_MRP_IN_OPEN,
+		       !!(p->flags & BR_MRP_LOST_IN_CONT)) ||
 	    nla_put_u8(skb, IFLA_BRPORT_ISOLATED, !!(p->flags & BR_ISOLATED)))
 		return -EMSGSIZE;
 
diff --git a/tools/include/uapi/linux/if_link.h b/tools/include/uapi/linux/if_link.h
index cafedbbfefbe9..781e482dc499f 100644
--- a/tools/include/uapi/linux/if_link.h
+++ b/tools/include/uapi/linux/if_link.h
@@ -344,6 +344,7 @@ enum {
 	IFLA_BRPORT_ISOLATED,
 	IFLA_BRPORT_BACKUP_PORT,
 	IFLA_BRPORT_MRP_RING_OPEN,
+	IFLA_BRPORT_MRP_IN_OPEN,
 	__IFLA_BRPORT_MAX
 };
 #define IFLA_BRPORT_MAX (__IFLA_BRPORT_MAX - 1)
-- 
2.27.0

