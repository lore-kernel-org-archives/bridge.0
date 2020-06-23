Return-Path: <Horatiu.Vultur@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1592903323; x=1624439323;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Vab59iB18cUXfZdY2UKkw5U/rizieclL7eIH6pZwzYE=;
 b=hAg3TKcxMgMtv6DFI+R0/Cpr52TsR2tJcnKylFGme43BmX16OMNRNoYa
 bDuYT/NQyg8BslBtfPipgjyIeqh0tZlnadXM3nMVYThNPf/ihcA8QQVbX
 7/QAPA7RsDXZHHblujxAGysdeiWERtc74E3qdozhkHrG+lbxCsDN0cZi9
 BdTVvWnNHYzmi3EMHsZIFaGsLYh0iS0PL2yjAR4XnExagnKKx2hNG6osC
 3mp5igljac3FvjoQow5rA/SrcuBbJDae/41DwrSYuVf//Zjhf2nRUttuS
 tikSc7TsosxF5/Mg46kajiWzppWBckBEjx8teDabzeg9E4D9VvlPVqp1e w==;
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Tue, 23 Jun 2020 11:05:41 +0200
Message-ID: <20200623090541.2964760-3-horatiu.vultur@microchip.com>
In-Reply-To: <20200623090541.2964760-1-horatiu.vultur@microchip.com>
References: <20200623090541.2964760-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net v2 2/2] bridge: mrp: Validate when setting the
	port role
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

This patch adds specific checks for primary(0x0) and secondary(0x1) when
setting the port role. For any other value the function
'br_mrp_set_port_role' will return -EINVAL.

Fixes: 20f6a05ef63594 ("bridge: mrp: Rework the MRP netlink interface")
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 net/bridge/br_mrp.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_mrp.c b/net/bridge/br_mrp.c
index 24986ec7d38cc..779e1eb754430 100644
--- a/net/bridge/br_mrp.c
+++ b/net/bridge/br_mrp.c
@@ -411,10 +411,16 @@ int br_mrp_set_port_role(struct net_bridge_port *p,
 	if (!mrp)
 		return -EINVAL;
 
-	if (role == BR_MRP_PORT_ROLE_PRIMARY)
+	switch (role) {
+	case BR_MRP_PORT_ROLE_PRIMARY:
 		rcu_assign_pointer(mrp->p_port, p);
-	else
+		break;
+	case BR_MRP_PORT_ROLE_SECONDARY:
 		rcu_assign_pointer(mrp->s_port, p);
+		break;
+	default:
+		return -EINVAL;
+	}
 
 	br_mrp_port_switchdev_set_role(p, role);
 
-- 
2.26.2

