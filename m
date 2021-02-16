Return-Path: <Horatiu.Vultur@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1613511794; x=1645047794;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=toNEZFJJYd5FgfnhWtjPWmHGIkQV7vwszU+NWqwwudI=;
 b=PhaZNro/o/9aH9RSjG7ikWDwZGZOGMXMV1PAl9tbRP9n2rXuGbMZLKm8
 laC7064I07K/9HK+WMDHh97ddVoL3o6RacuA+f0RlDTlA7M++jUtACqbj
 8dRRiX4QDDov4H4e/M+Q7BatnHUi23pRAjBZMjkpfbCNxWgI2UBF+MX14
 xI5G+nkeGVeLX5lVXZDPB2hAkp9QaxTI4kCY1gERgB9isW1RPcUaLCq07
 CHSiFedNgEpFCcR7g0nowiSPVeVb11Yq70o+INChIvulRMc2bvJxZYB3M
 g0qHFt2jZSEky0Zq0FmWY/1hJqVrf8zE2OJ8i2TKc8ue3arSMVlDjXrv7 A==;
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Tue, 16 Feb 2021 22:41:59 +0100
Message-ID: <20210216214205.32385-3-horatiu.vultur@microchip.com>
In-Reply-To: <20210216214205.32385-1-horatiu.vultur@microchip.com>
References: <20210216214205.32385-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next v4 2/8] switchdev: mrp: Extend
	ring_role_mrp and in_role_mrp
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: davem@davemloft.net, kuba@kernel.org
Cc: ivecera@redhat.com, andrew@lunn.ch, alexandre.belloni@bootlin.com, f.fainelli@gmail.com, jiri@resnulli.us, rasmus.villemoes@prevas.dk, vladimir.oltean@nxp.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, claudiu.manoil@nxp.com, netdev@vger.kernel.org, nikolay@nvidia.com, roopa@nvidia.com, Horatiu Vultur <horatiu.vultur@microchip.com>, vivien.didelot@gmail.com

Add the member sw_backup to the structures switchdev_obj_ring_role_mrp
and switchdev_obj_in_role_mrp. In this way the SW can call the driver in
2 ways, once when sw_backup is set to false, meaning that the driver
should implement this completely in HW. And if that is not supported the
SW will call again but with sw_backup set to true, meaning that the
HW should help or allow the SW to run the protocol.

For example when role is MRM, if the HW can't detect when it stops
receiving MRP Test frames but it can trap these frames to CPU, then it
needs to return -EOPNOTSUPP when sw_backup is false and return 0 when
sw_backup is true.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 include/net/switchdev.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index 465362d9d063..b7fc7d0f54e2 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -127,6 +127,7 @@ struct switchdev_obj_ring_role_mrp {
 	struct switchdev_obj obj;
 	u8 ring_role;
 	u32 ring_id;
+	u8 sw_backup;
 };
 
 #define SWITCHDEV_OBJ_RING_ROLE_MRP(OBJ) \
@@ -161,6 +162,7 @@ struct switchdev_obj_in_role_mrp {
 	u32 ring_id;
 	u16 in_id;
 	u8 in_role;
+	u8 sw_backup;
 };
 
 #define SWITCHDEV_OBJ_IN_ROLE_MRP(OBJ) \
-- 
2.27.0

