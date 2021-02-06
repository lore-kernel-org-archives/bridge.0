Return-Path: <Horatiu.Vultur@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1612648189; x=1644184189;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Y0LF0QiYzcdX2y6gwZ07FxsFEt3swqe56rzuZlawFZY=;
 b=iNsxw4lRLNj7Bk+TVUCxJOHEx8Jkdu1BDA8SXMNFYIcU9SrBDPhwIql7
 34nfnkQcRnjLAY0inT2dG/MKz/xv8t6o/9EFa90GMu94Ki56/I6IWIPre
 sd40xslRz/wCinpWJ+6d+K1S089icMoQ4XFbKnf1zvbVtXYJsdHx6B+pb
 tzdNeuMXp5OrylmJdKm8zO6mAfo+QkqkiSbm5RKOK7x5ucwiZcxywSqGf
 anQqa7hNxVIgaTPYB4IwfXwlTQe8CGkWAz660rSPy0G1P5xyNUu+ruERN
 DiKT1RGRGuw8YVVGkUvTfAsWnlbc6SdY2hnpC8PwfFi04Ghm68z3JmiYW w==;
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Sat, 6 Feb 2021 22:47:34 +0100
Message-ID: <20210206214734.1577849-3-horatiu.vultur@microchip.com>
In-Reply-To: <20210206214734.1577849-1-horatiu.vultur@microchip.com>
References: <20210206214734.1577849-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net 2/2] switchdev: mrp: Remove
	SWITCHDEV_ATTR_ID_MRP_PORT_STAT
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: jiri@resnulli.us, ivecera@redhat.com, davem@davemloft.net, kuba@kernel.org, roopa@nvidia.com, nikolay@nvidia.com, rasmus.villemoes@prevas.dk, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>

Now that MRP started to use also SWITCHDEV_ATTR_ID_PORT_STP_STATE to
notify HW, then SWITCHDEV_ATTR_ID_MRP_PORT_STAT is not used anywhere
else, therefore we can remove it.

Fixes: c284b545900830 ("switchdev: mrp: Extend switchdev API to offload MRP")
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 include/net/switchdev.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index 99cd538d6519..afdf8bd1b4fe 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -42,7 +42,6 @@ enum switchdev_attr_id {
 	SWITCHDEV_ATTR_ID_BRIDGE_MC_DISABLED,
 	SWITCHDEV_ATTR_ID_BRIDGE_MROUTER,
 #if IS_ENABLED(CONFIG_BRIDGE_MRP)
-	SWITCHDEV_ATTR_ID_MRP_PORT_STATE,
 	SWITCHDEV_ATTR_ID_MRP_PORT_ROLE,
 #endif
 };
@@ -62,7 +61,6 @@ struct switchdev_attr {
 		u16 vlan_protocol;			/* BRIDGE_VLAN_PROTOCOL */
 		bool mc_disabled;			/* MC_DISABLED */
 #if IS_ENABLED(CONFIG_BRIDGE_MRP)
-		u8 mrp_port_state;			/* MRP_PORT_STATE */
 		u8 mrp_port_role;			/* MRP_PORT_ROLE */
 #endif
 	} u;
-- 
2.27.0

