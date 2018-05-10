Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
	bh=Un7vH4RdZoZ4JMfZimiWEQPXgUTKhSm9g8Q+9+ZCIZw=;
	b=S47LoT6QzklM33qwlEl4/kx5+OYyLDCdeepuWIKc790QGuLoULQQcU9apVmmyVUo/HWygd4W0XXcD+hgnm2tzToOmX8FGP/WYwEzmISRLfT1muTN3F5JreKayuvfuCMbS6hnvg7aBwHJQgyM853UAhH6R8ERfeIwGL+k91sb4QE=
From: Ido Schimmel <idosch@mellanox.com>
Date: Thu, 10 May 2018 13:13:04 +0300
Message-Id: <20180510101306.4891-3-idosch@mellanox.com>
In-Reply-To: <20180510101306.4891-1-idosch@mellanox.com>
References: <20180510101306.4891-1-idosch@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next 2/4] mlxsw: reg: Add
	MLXSW_REG_MPAT_SPAN_TYPE_REMOTE_ETH
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: Ido Schimmel <idosch@mellanox.com>, mlxsw@mellanox.com, nikolay@cumulusnetworks.com, jiri@mellanox.com, petrm@mellanox.com, davem@davemloft.net

From: Petr Machata <petrm@mellanox.com>

Add MLXSW_REG_MPAT_SPAN_TYPE_REMOTE_ETH to support VLAN-encapsulated
port mirroring.

Signed-off-by: Petr Machata <petrm@mellanox.com>
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
---
 drivers/net/ethernet/mellanox/mlxsw/reg.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/reg.h b/drivers/net/ethernet/mellanox/mlxsw/reg.h
index 6218231e379e..3f4d7e22cece 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/reg.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/reg.h
@@ -6833,6 +6833,12 @@ enum mlxsw_reg_mpat_span_type {
 	 */
 	MLXSW_REG_MPAT_SPAN_TYPE_LOCAL_ETH = 0x0,
 
+	/* Remote SPAN Ethernet VLAN.
+	 * The packet is forwarded to the monitoring port on the monitoring
+	 * VLAN.
+	 */
+	MLXSW_REG_MPAT_SPAN_TYPE_REMOTE_ETH = 0x1,
+
 	/* Encapsulated Remote SPAN Ethernet L3 GRE.
 	 * The packet is encapsulated with GRE header.
 	 */
-- 
2.14.3

