Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6F7C041E1D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8898441E0A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iYPpTZT3J06CTnlaPDCVlgNtqXiZsHdB+f4WN4iRJRc=;
 b=QdUyW7a9s1lmvB4PW/kYIl/3TGzq8HtWldO0Uyr+BQ4k95R13tDQlkY7efZuJQTLNEkh72w+vOYwOO6fS96GslNE/pKxhMH80xlxe08pkpWKvxyJpFnO735S8DVInjIW4XngPNwcCeyyjpa7A0kLbrm9A6kPdh3Vc+CBYxOpWAMdc3Al/8xj54FEAdGlixUHr+4oBTtbM7qDzaf5XW/HxEjJXIaSYI/xW0RBbazxK8yyDDS3Y/r9L+YumDiwydF4lUkVsLFyzXDchTp4yRbXYTJDQrlEmpHjeAeYVXNc8xCfVYGzAHRfxlWYIThTBJHCPNNsO+VwSY2Q/Mv2B0+7iA==
From: Ido Schimmel <idosch@nvidia.com>
Date: Mon, 29 May 2023 14:48:34 +0300
Message-ID: <20230529114835.372140-8-idosch@nvidia.com>
In-Reply-To: <20230529114835.372140-1-idosch@nvidia.com>
References: <20230529114835.372140-1-idosch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next v2 7/8] mlxsw: spectrum_flower: Add
	ability to match on layer 2 miss
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: taras.chornyi@plvision.eu, petrm@nvidia.com, alexandre.belloni@bootlin.com, jiri@resnulli.us, leon@kernel.org, vladimir.oltean@nxp.com, razor@blackwall.org, roopa@nvidia.com, claudiu.manoil@nxp.com, Ido Schimmel <idosch@nvidia.com>, UNGLinuxDriver@microchip.com, edumazet@google.com, jhs@mojatatu.com, xiyou.wangcong@gmail.com, simon.horman@corigine.com, kuba@kernel.org, pabeni@redhat.com, saeedm@nvidia.com, davem@davemloft.net

Add the 'fdb_miss' key element to supported key blocks and make use of
it to match on layer 2 miss.

The key is only supported on Spectrum-{2,3,4}. An error is returned for
Spectrum-1 since the key element is not present in any of its key
blocks.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---

Notes:
    v2:
    * Use 'fdb_miss' key element instead of 'dmac_type'.

 drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.c    | 1 +
 drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.h    | 3 ++-
 .../net/ethernet/mellanox/mlxsw/spectrum_acl_flex_keys.c    | 2 ++
 drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c       | 6 ++----
 4 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.c b/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.c
index bd1a51a0a540..f0b2963ebac3 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.c
@@ -42,6 +42,7 @@ static const struct mlxsw_afk_element_info mlxsw_afk_element_infos[] = {
 	MLXSW_AFK_ELEMENT_INFO_BUF(DST_IP_64_95, 0x34, 4),
 	MLXSW_AFK_ELEMENT_INFO_BUF(DST_IP_32_63, 0x38, 4),
 	MLXSW_AFK_ELEMENT_INFO_BUF(DST_IP_0_31, 0x3C, 4),
+	MLXSW_AFK_ELEMENT_INFO_U32(FDB_MISS, 0x40, 0, 1),
 };
 
 struct mlxsw_afk {
diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.h b/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.h
index 3a037fe47211..65a4abadc7db 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.h
@@ -35,6 +35,7 @@ enum mlxsw_afk_element {
 	MLXSW_AFK_ELEMENT_IP_DSCP,
 	MLXSW_AFK_ELEMENT_VIRT_ROUTER_MSB,
 	MLXSW_AFK_ELEMENT_VIRT_ROUTER_LSB,
+	MLXSW_AFK_ELEMENT_FDB_MISS,
 	MLXSW_AFK_ELEMENT_MAX,
 };
 
@@ -69,7 +70,7 @@ struct mlxsw_afk_element_info {
 	MLXSW_AFK_ELEMENT_INFO(MLXSW_AFK_ELEMENT_TYPE_BUF,			\
 			       _element, _offset, 0, _size)
 
-#define MLXSW_AFK_ELEMENT_STORAGE_SIZE 0x40
+#define MLXSW_AFK_ELEMENT_STORAGE_SIZE 0x44
 
 struct mlxsw_afk_element_inst { /* element instance in actual block */
 	enum mlxsw_afk_element element;
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_flex_keys.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_flex_keys.c
index 00c32320f891..4dea39f2b304 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_flex_keys.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_flex_keys.c
@@ -123,10 +123,12 @@ const struct mlxsw_afk_ops mlxsw_sp1_afk_ops = {
 };
 
 static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_mac_0[] = {
+	MLXSW_AFK_ELEMENT_INST_U32(FDB_MISS, 0x00, 3, 1),
 	MLXSW_AFK_ELEMENT_INST_BUF(DMAC_0_31, 0x04, 4),
 };
 
 static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_mac_1[] = {
+	MLXSW_AFK_ELEMENT_INST_U32(FDB_MISS, 0x00, 3, 1),
 	MLXSW_AFK_ELEMENT_INST_BUF(SMAC_0_31, 0x04, 4),
 };
 
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c
index 9c62c12e410b..72917f09e806 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c
@@ -336,10 +336,8 @@ static int mlxsw_sp_flower_parse_meta(struct mlxsw_sp_acl_rule_info *rulei,
 
 	flow_rule_match_meta(rule, &match);
 
-	if (match.mask->l2_miss) {
-		NL_SET_ERR_MSG_MOD(f->common.extack, "Can't match on \"l2_miss\"");
-		return -EOPNOTSUPP;
-	}
+	mlxsw_sp_acl_rulei_keymask_u32(rulei, MLXSW_AFK_ELEMENT_FDB_MISS,
+				       match.key->l2_miss, match.mask->l2_miss);
 
 	return mlxsw_sp_flower_parse_meta_iif(rulei, block, &match,
 					      f->common.extack);
-- 
2.40.1

