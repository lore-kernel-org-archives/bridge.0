Return-Path: <Horatiu.Vultur@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1594288938; x=1625824938;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=bDsPDcBsqLSCU8wYG3pcNrGvWrN5XQXdrnUKLu6IKAM=;
 b=ajd0g1rM0jjkrRYBpAfH8d0U40Zljyzisa1bTxrXwBl+soRcRc1HdVjO
 h21TgUbYuIwO9Hgv07VrrUsLS9WDtUHjhyJNbv56Bm9KMza2a8+guljqy
 6M2lknK2DRpdXN5eUznBSN+bBeqE5kLchLzNwaOX1FV+BfSX10RpbAXha
 iL9tJQ6U7l1FcPljuc1kMIL80akjy4iVwP1x53DfvBNn6zon98X8qKHGv
 +bQxGWoMfucU3yre+mNz3mxxlIQWYP31CkSi6sCDc7NbwFH48R6b2k490
 xGBxsPitM0IU3fnXy7MT+d+0Vk7NT5F+cPp6zyVZFlhtJj7lGojMHxryr Q==;
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Thu, 9 Jul 2020 12:00:38 +0200
Message-ID: <20200709100040.554623-11-horatiu.vultur@microchip.com>
In-Reply-To: <20200709100040.554623-1-horatiu.vultur@microchip.com>
References: <20200709100040.554623-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next v2 10/12] bridge: uapi: mrp: Extend
	MRP_INFO attributes for interconnect status
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

Extend the existing MRP_INFO to return status of MRP interconnect. In
case there is no MRP interconnect on the node then the role will be
disabled so the other attributes can be ignored.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 include/uapi/linux/if_bridge.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
index d840a3e37a37c..c1227aecd38fd 100644
--- a/include/uapi/linux/if_bridge.h
+++ b/include/uapi/linux/if_bridge.h
@@ -243,6 +243,11 @@ enum {
 	IFLA_BRIDGE_MRP_INFO_TEST_INTERVAL,
 	IFLA_BRIDGE_MRP_INFO_TEST_MAX_MISS,
 	IFLA_BRIDGE_MRP_INFO_TEST_MONITOR,
+	IFLA_BRIDGE_MRP_INFO_I_IFINDEX,
+	IFLA_BRIDGE_MRP_INFO_IN_STATE,
+	IFLA_BRIDGE_MRP_INFO_IN_ROLE,
+	IFLA_BRIDGE_MRP_INFO_IN_TEST_INTERVAL,
+	IFLA_BRIDGE_MRP_INFO_IN_TEST_MAX_MISS,
 	__IFLA_BRIDGE_MRP_INFO_MAX,
 };
 
-- 
2.27.0

