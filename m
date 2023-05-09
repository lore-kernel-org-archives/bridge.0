Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8344F41F20
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2ADCD41EE8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HzVsWpsxg8gzs1LvHZ7mKUQ5piBodmCsbCSwsQDlS6Y=;
 b=SlvMRxn4FRgjGX8toPOxHJb3LgJRnuUnvGOheKX+3hB0c3PS+ktOzIg9b31h/kUJP2EfwpEeUb+Der88hUH7vfA0DTkg2juxxoZAKZw8uVpboI44Fi+OI4G+Q8f8HBjpY280/gr305FLouAlJM8GMHzg1gvWL7qUYiWm6GiDOftA34B9arn1yY35oL+kIS0WPY/uHRwcyt8oXwXa7s1ZkSS6J9fTmk7D0VOBKqrW4IFIEB922Ky36Qtxr4d/IumNDrhmRtc7zN1Gf8jLhVi3PfXHPHbZzl/4qsZ8BhMgJMTw8K55id+9cNnpaemNN36j2Ik8vignub9wZ0CiXA5WGg==
From: Ido Schimmel <idosch@nvidia.com>
Date: Tue, 9 May 2023 10:04:45 +0300
Message-ID: <20230509070446.246088-5-idosch@nvidia.com>
In-Reply-To: <20230509070446.246088-1-idosch@nvidia.com>
References: <20230509070446.246088-1-idosch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [RFC PATCH net-next 4/5] mlxsw: spectrum_flower: Add
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
Cc: petrm@nvidia.com, jiri@resnulli.us, taspelund@nvidia.com, xiyou.wangcong@gmail.com, Ido Schimmel <idosch@nvidia.com>, razor@blackwall.org, jhs@mojatatu.com, edumazet@google.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

Add the 'dmac_type' key element to supported key blocks and make use of
it to match on layer 2 miss.

This is a two bits key in hardware with the following values:
00b - Known multicast.
01b - Broadcast.
10b - Known unicast.
11b - Unknown unicast or unregistered multicast.

When 'l2_miss' is set we need to match on 01b or 11b. Therefore, only
match on the LSB in order to differentiate between both cases of
'l2_miss'.

Tested on Spectrum-{1,2,3,4}.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 .../mellanox/mlxsw/core_acl_flex_keys.c       |  1 +
 .../mellanox/mlxsw/core_acl_flex_keys.h       |  3 ++-
 .../mellanox/mlxsw/spectrum_acl_flex_keys.c   |  5 +++++
 .../ethernet/mellanox/mlxsw/spectrum_flower.c | 20 ++++++++++++++-----
 4 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.c b/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.c
index bd1a51a0a540..81af0b9a4329 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.c
@@ -42,6 +42,7 @@ static const struct mlxsw_afk_element_info mlxsw_afk_element_infos[] = {
 	MLXSW_AFK_ELEMENT_INFO_BUF(DST_IP_64_95, 0x34, 4),
 	MLXSW_AFK_ELEMENT_INFO_BUF(DST_IP_32_63, 0x38, 4),
 	MLXSW_AFK_ELEMENT_INFO_BUF(DST_IP_0_31, 0x3C, 4),
+	MLXSW_AFK_ELEMENT_INFO_U32(DMAC_TYPE, 0x40, 0, 2),
 };
 
 struct mlxsw_afk {
diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.h b/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.h
index 3a037fe47211..6f1649cfa4cb 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.h
@@ -35,6 +35,7 @@ enum mlxsw_afk_element {
 	MLXSW_AFK_ELEMENT_IP_DSCP,
 	MLXSW_AFK_ELEMENT_VIRT_ROUTER_MSB,
 	MLXSW_AFK_ELEMENT_VIRT_ROUTER_LSB,
+	MLXSW_AFK_ELEMENT_DMAC_TYPE,
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
index 00c32320f891..18a968cded36 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_flex_keys.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_flex_keys.c
@@ -26,6 +26,7 @@ static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_l2_smac[] = {
 static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_l2_smac_ex[] = {
 	MLXSW_AFK_ELEMENT_INST_BUF(SMAC_32_47, 0x02, 2),
 	MLXSW_AFK_ELEMENT_INST_BUF(SMAC_0_31, 0x04, 4),
+	MLXSW_AFK_ELEMENT_INST_U32(DMAC_TYPE, 0x08, 0, 2),
 	MLXSW_AFK_ELEMENT_INST_U32(ETHERTYPE, 0x0C, 0, 16),
 };
 
@@ -50,6 +51,7 @@ static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_ipv4[] = {
 };
 
 static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_ipv4_ex[] = {
+	MLXSW_AFK_ELEMENT_INST_U32(DMAC_TYPE, 0x00, 24, 2),
 	MLXSW_AFK_ELEMENT_INST_U32(VID, 0x00, 0, 12),
 	MLXSW_AFK_ELEMENT_INST_U32(PCP, 0x08, 29, 3),
 	MLXSW_AFK_ELEMENT_INST_U32(SRC_L4_PORT, 0x08, 0, 16),
@@ -78,6 +80,7 @@ static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_ipv6_sip_ex[] = {
 };
 
 static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_packet_type[] = {
+	MLXSW_AFK_ELEMENT_INST_U32(DMAC_TYPE, 0x00, 30, 2),
 	MLXSW_AFK_ELEMENT_INST_U32(ETHERTYPE, 0x00, 0, 16),
 };
 
@@ -123,6 +126,7 @@ const struct mlxsw_afk_ops mlxsw_sp1_afk_ops = {
 };
 
 static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_mac_0[] = {
+	MLXSW_AFK_ELEMENT_INST_U32(DMAC_TYPE, 0x00, 0, 2),
 	MLXSW_AFK_ELEMENT_INST_BUF(DMAC_0_31, 0x04, 4),
 };
 
@@ -313,6 +317,7 @@ const struct mlxsw_afk_ops mlxsw_sp2_afk_ops = {
 };
 
 static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_mac_5b[] = {
+	MLXSW_AFK_ELEMENT_INST_U32(DMAC_TYPE, 0x00, 2, 2),
 	MLXSW_AFK_ELEMENT_INST_U32(VID, 0x04, 18, 12),
 	MLXSW_AFK_ELEMENT_INST_EXT_U32(SRC_SYS_PORT, 0x04, 0, 9, -1, true), /* RX_ACL_SYSTEM_PORT */
 };
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c
index 6fec9223250b..170a07f35897 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c
@@ -295,11 +295,6 @@ static int mlxsw_sp_flower_parse_meta(struct mlxsw_sp_acl_rule_info *rulei,
 
 	flow_rule_match_meta(rule, &match);
 
-	if (match.mask->l2_miss) {
-		NL_SET_ERR_MSG_MOD(f->common.extack, "Can't match on \"l2_miss\"");
-		return -EOPNOTSUPP;
-	}
-
 	if (match.mask->ingress_ifindex != 0xFFFFFFFF) {
 		NL_SET_ERR_MSG_MOD(f->common.extack, "Unsupported ingress ifindex mask");
 		return -EINVAL;
@@ -327,6 +322,21 @@ static int mlxsw_sp_flower_parse_meta(struct mlxsw_sp_acl_rule_info *rulei,
 				       MLXSW_AFK_ELEMENT_SRC_SYS_PORT,
 				       mlxsw_sp_port->local_port,
 				       0xFFFFFFFF);
+
+	/* This is a two bits key in hardware with the following values:
+	 * 00b - Known multicast.
+	 * 01b - Broadcast.
+	 * 10b - Known unicast.
+	 * 11b - Unknown unicast or unregistered multicast.
+	 *
+	 * When 'l2_miss' is set we need to match on 01b or 11b. Therefore,
+	 * only match on the LSB in order to differentiate between both cases
+	 * of 'l2_miss'.
+	 */
+	mlxsw_sp_acl_rulei_keymask_u32(rulei, MLXSW_AFK_ELEMENT_DMAC_TYPE,
+				       match.key->l2_miss,
+				       match.mask->l2_miss & BIT(0));
+
 	return 0;
 }
 
-- 
2.40.1

