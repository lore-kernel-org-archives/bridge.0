Return-Path: <Horatiu.Vultur@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1592903319; x=1624439319;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=kQsP/yVJQUNUJxvLd2o3N1wn7VHKUz9qL3WSHlmLZFk=;
 b=Q32xHsQzTgNH2EuW1l8323hHiq8nbGoY+7E0kvW23MxGdHyms5JnXIRX
 v0eJ463QXjI83mk6JpYrwOaILy/b71RrrmcP3yj5JU11Qo3zKZdFT41KF
 BgZvUoifY9B0hX+QjXt73+rxJ1rlgFYHBLu9m/d+P36rgJkdFvj0vi6Vr
 PK/409M8SD3KEy+k/W7W1XL9wssRoF51CbnXbzZDvsx0HiEw1ftzwqnkO
 0YriJccKhTvXZXpjCaytz/IitYQpapFxqpY2MsW3Zb3qUoyACkWBA8SgN
 BzBXZPLcqTst/azEKATiLayEhN5tet7WJnVhKV+dPe+Cw6o346Amzy0QI Q==;
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Tue, 23 Jun 2020 11:05:40 +0200
Message-ID: <20200623090541.2964760-2-horatiu.vultur@microchip.com>
In-Reply-To: <20200623090541.2964760-1-horatiu.vultur@microchip.com>
References: <20200623090541.2964760-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net v2 1/2] bridge: uapi: mrp: Fix MRP_PORT_ROLE
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: nikolay@cumulusnetworks.com, roopa@cumulusnetworks.com, davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org, netdev@vger.kernel.org, UNGLinuxDriver@microchip.com
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>

Currently the MRP_PORT_ROLE_NONE has the value 0x2 but this is in conflict
with the IEC 62439-2 standard. The standard defines the following port
roles: primary (0x0), secondary(0x1), interconnect(0x2).
Therefore remove the port role none.

Fixes: 4714d13791f831 ("bridge: uapi: mrp: Add mrp attributes.")
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 include/uapi/linux/mrp_bridge.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/uapi/linux/mrp_bridge.h b/include/uapi/linux/mrp_bridge.h
index 84f15f48a7cb1..bee3665402129 100644
--- a/include/uapi/linux/mrp_bridge.h
+++ b/include/uapi/linux/mrp_bridge.h
@@ -36,7 +36,6 @@ enum br_mrp_port_state_type {
 enum br_mrp_port_role_type {
 	BR_MRP_PORT_ROLE_PRIMARY,
 	BR_MRP_PORT_ROLE_SECONDARY,
-	BR_MRP_PORT_ROLE_NONE,
 };
 
 enum br_mrp_tlv_header_type {
-- 
2.26.2

