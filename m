Return-Path: <Horatiu.Vultur@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1593588177; x=1625124177;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=CBHDKe17OWh23IN1qsZyil4P/7Q7BPKQEEmOkyRy9rQ=;
 b=EHU3aOGwy0iW7wTOtGalCReQ5DDrwkJhXEBaAFz8kcTX0ty7CuqtSjZl
 ZVuNHCAdn78hj4l1WHkILZTWxtJSjDfK//40PVEJsl/PyRmCh6PEFzAu7
 7T8UJSZgLP06YNs/EOVIoNSGUSdJXaCskrJ47HEzw+EcI6mONtuGPnwfV
 qEK783/Oyzyk68qYP/uBmvIyqmYdREhyj6tADZdMuMnN3XEiLKd9rJZgN
 5xdsmDw1UGHQpldQ5ophIf1UOsKqiCacIaC6KYwHCYK0yPsHNSMm/Cgy5
 jEDVITsSuNcyxOB2XwFp8dBsy7unfkkCwt+/3HFTo9J+K8Wmljz+zpTWO w==;
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Wed, 1 Jul 2020 09:22:37 +0200
Message-ID: <20200701072239.520807-2-horatiu.vultur@microchip.com>
In-Reply-To: <20200701072239.520807-1-horatiu.vultur@microchip.com>
References: <20200701072239.520807-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next v2 1/3] bridge: uapi: mrp: Extend MRP
	attributes to get the status
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: nikolay@cumulusnetworks.com, roopa@cumulusnetworks.com, davem@davemloft.net, kuba@kernel.org, jiri@mellanox.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org, UNGLinuxDriver@microchip.com
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>

Add MRP attribute IFLA_BRIDGE_MRP_INFO to allow the userspace to get the
current state of the MRP instances. This is a nested attribute that
contains other attributes like, ring id, index of primary and secondary
port, priority, ring state, ring role.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 include/uapi/linux/if_bridge.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
index caa6914a3e53a..c114c1c2bd533 100644
--- a/include/uapi/linux/if_bridge.h
+++ b/include/uapi/linux/if_bridge.h
@@ -166,6 +166,7 @@ enum {
 	IFLA_BRIDGE_MRP_RING_STATE,
 	IFLA_BRIDGE_MRP_RING_ROLE,
 	IFLA_BRIDGE_MRP_START_TEST,
+	IFLA_BRIDGE_MRP_INFO,
 	__IFLA_BRIDGE_MRP_MAX,
 };
 
@@ -228,6 +229,22 @@ enum {
 
 #define IFLA_BRIDGE_MRP_START_TEST_MAX (__IFLA_BRIDGE_MRP_START_TEST_MAX - 1)
 
+enum {
+	IFLA_BRIDGE_MRP_INFO_UNSPEC,
+	IFLA_BRIDGE_MRP_INFO_RING_ID,
+	IFLA_BRIDGE_MRP_INFO_P_IFINDEX,
+	IFLA_BRIDGE_MRP_INFO_S_IFINDEX,
+	IFLA_BRIDGE_MRP_INFO_PRIO,
+	IFLA_BRIDGE_MRP_INFO_RING_STATE,
+	IFLA_BRIDGE_MRP_INFO_RING_ROLE,
+	IFLA_BRIDGE_MRP_INFO_TEST_INTERVAL,
+	IFLA_BRIDGE_MRP_INFO_TEST_MAX_MISS,
+	IFLA_BRIDGE_MRP_INFO_TEST_MONITOR,
+	__IFLA_BRIDGE_MRP_INFO_MAX,
+};
+
+#define IFLA_BRIDGE_MRP_INFO_MAX (__IFLA_BRIDGE_MRP_INFO_MAX - 1)
+
 struct br_mrp_instance {
 	__u32 ring_id;
 	__u32 p_ifindex;
-- 
2.27.0

