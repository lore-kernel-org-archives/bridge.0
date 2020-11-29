Return-Path: <idosch@idosch.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=2W1zOzV8vwqD5mcj0ElSCJx7G8UJmzHzIMBQBmZcUfw=; b=qpg92gUd
 j5geiy9Hcg2E+t+82w/aap+8H8H8vtZIBlAany6QcjQ29uyL4eoKCifiC1Hr0D5T
 tQpCr+bgc77Jg5kGzBwC7kZHurKU0KwM19IvTrQm88bpoXwQdT578v9rpWv99uD+
 n/tlhegJ4XCx90t58J/5fBSL/wtMjon78uDsHH18nn/FKxiD5HyDcZ1sIQvUd7/B
 gQEn3KDErkIqhgNafYG+9fopagF5gSQw/45Eb+E4SW8EZ7rEI3uPVpHtfQ36w2X7
 /+gEppPdYyAMMiU4D6dQMYNVha0YfRDyIyMQ+ZhLII9hOABC4IA8x6fVPFwZXCIS
 Mdy7EorM3AtetQ==
From: Ido Schimmel <idosch@idosch.org>
Date: Sun, 29 Nov 2020 14:54:00 +0200
Message-Id: <20201129125407.1391557-3-idosch@idosch.org>
In-Reply-To: <20201129125407.1391557-1-idosch@idosch.org>
References: <20201129125407.1391557-1-idosch@idosch.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 2/9] mlxsw: reg: Add et_vlan field to
	SPVID register
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: ivecera@redhat.com, petrm@nvidia.com, amcohen@nvidia.com, danieller@nvidia.com, mlxsw@nvidia.com, Ido Schimmel <idosch@nvidia.com>, jiri@nvidia.com, nikolay@nvidia.com, roopa@nvidia.com, kuba@kernel.org, davem@davemloft.net

From: Amit Cohen <amcohen@nvidia.com>

et_vlan field is used to configure which EtherType is used when VLAN is
pushed at ingress (for untagged packets or for QinQ push mode).

It will be used to configure tagging with ether_type1 (i.e., 0x88A8) for
QinQ mode.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/reg.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/reg.h b/drivers/net/ethernet/mellanox/mlxsw/reg.h
index 5248532c3999..bea919b92f76 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/reg.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/reg.h
@@ -834,6 +834,17 @@ MLXSW_ITEM32(reg, spvid, local_port, 0x00, 16, 8);
  */
 MLXSW_ITEM32(reg, spvid, sub_port, 0x00, 8, 8);
 
+/* reg_spvid_et_vlan
+ * EtherType used for when VLAN is pushed at ingress (for untagged
+ * packets or for QinQ push mode).
+ * 0: ether_type0 - (default)
+ * 1: ether_type1
+ * 2: ether_type2 - Reserved when Spectrum-1, supported by Spectrum-2
+ * Ethertype IDs are configured by SVER.
+ * Access: RW
+ */
+MLXSW_ITEM32(reg, spvid, et_vlan, 0x04, 16, 2);
+
 /* reg_spvid_pvid
  * Port default VID
  * Access: RW
-- 
2.28.0

