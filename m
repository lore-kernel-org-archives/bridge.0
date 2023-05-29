Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 20BD1827D9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5D26882369
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VSdU3zwmLDiO+kyAaRsEdMZsXlHWLaaAmuYA+aih/7U=;
 b=Mc1tYqsUuU/w9CfsCldpTCd4hdA8ncJrauRQ34SqY3HFhcHQwZLHfZ6hNIjJQgmaKdxbMh20aknuigB5SOZzv4WOZtBPdtugsh6CXT9RU8HSMNadMCv9GB4ADUzYmFCokX29t8cSItMzVUI0eWAsL9RKV7EJdIDiGms9We+55/wayWppYN0VlzHIp2QjbGXyj0aHh2TzulQHVBsYNMz+pdxtbZ+yCu1o97ENxml5GvX29IMkds7bEIg9qdANLQzEQth2O94SqW3pAMj1N+sh6K8BLIFE186HMAIj4g6800FlAxy2l/RExZ5i55dWU6GmSijikEuUNZMDIyM/y+aadw==
From: Ido Schimmel <idosch@nvidia.com>
Date: Mon, 29 May 2023 14:48:32 +0300
Message-ID: <20230529114835.372140-6-idosch@nvidia.com>
In-Reply-To: <20230529114835.372140-1-idosch@nvidia.com>
References: <20230529114835.372140-1-idosch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next v2 5/8] mlxsw: spectrum_flower: Split iif
	parsing to a separate function
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

Currently, mlxsw only supports the 'ingress_ifindex' field in the
'FLOW_DISSECTOR_KEY_META' key, but subsequent patches are going to add
support for the 'l2_miss' field as well. Split the parsing of the
'ingress_ifindex' field to a separate function to avoid nesting. No
functional changes intended.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---

Notes:
    v2:
    * New patch.

 .../ethernet/mellanox/mlxsw/spectrum_flower.c | 54 +++++++++++--------
 1 file changed, 33 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c
index 6fec9223250b..2b0bae847eb9 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c
@@ -281,45 +281,35 @@ static int mlxsw_sp_flower_parse_actions(struct mlxsw_sp *mlxsw_sp,
 	return 0;
 }
 
-static int mlxsw_sp_flower_parse_meta(struct mlxsw_sp_acl_rule_info *rulei,
-				      struct flow_cls_offload *f,
-				      struct mlxsw_sp_flow_block *block)
+static int
+mlxsw_sp_flower_parse_meta_iif(struct mlxsw_sp_acl_rule_info *rulei,
+			       const struct mlxsw_sp_flow_block *block,
+			       const struct flow_match_meta *match,
+			       struct netlink_ext_ack *extack)
 {
-	struct flow_rule *rule = flow_cls_offload_flow_rule(f);
 	struct mlxsw_sp_port *mlxsw_sp_port;
 	struct net_device *ingress_dev;
-	struct flow_match_meta match;
-
-	if (!flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_META))
-		return 0;
-
-	flow_rule_match_meta(rule, &match);
 
-	if (match.mask->l2_miss) {
-		NL_SET_ERR_MSG_MOD(f->common.extack, "Can't match on \"l2_miss\"");
-		return -EOPNOTSUPP;
-	}
-
-	if (match.mask->ingress_ifindex != 0xFFFFFFFF) {
-		NL_SET_ERR_MSG_MOD(f->common.extack, "Unsupported ingress ifindex mask");
+	if (match->mask->ingress_ifindex != 0xFFFFFFFF) {
+		NL_SET_ERR_MSG_MOD(extack, "Unsupported ingress ifindex mask");
 		return -EINVAL;
 	}
 
 	ingress_dev = __dev_get_by_index(block->net,
-					 match.key->ingress_ifindex);
+					 match->key->ingress_ifindex);
 	if (!ingress_dev) {
-		NL_SET_ERR_MSG_MOD(f->common.extack, "Can't find specified ingress port to match on");
+		NL_SET_ERR_MSG_MOD(extack, "Can't find specified ingress port to match on");
 		return -EINVAL;
 	}
 
 	if (!mlxsw_sp_port_dev_check(ingress_dev)) {
-		NL_SET_ERR_MSG_MOD(f->common.extack, "Can't match on non-mlxsw ingress port");
+		NL_SET_ERR_MSG_MOD(extack, "Can't match on non-mlxsw ingress port");
 		return -EINVAL;
 	}
 
 	mlxsw_sp_port = netdev_priv(ingress_dev);
 	if (mlxsw_sp_port->mlxsw_sp != block->mlxsw_sp) {
-		NL_SET_ERR_MSG_MOD(f->common.extack, "Can't match on a port from different device");
+		NL_SET_ERR_MSG_MOD(extack, "Can't match on a port from different device");
 		return -EINVAL;
 	}
 
@@ -327,9 +317,31 @@ static int mlxsw_sp_flower_parse_meta(struct mlxsw_sp_acl_rule_info *rulei,
 				       MLXSW_AFK_ELEMENT_SRC_SYS_PORT,
 				       mlxsw_sp_port->local_port,
 				       0xFFFFFFFF);
+
 	return 0;
 }
 
+static int mlxsw_sp_flower_parse_meta(struct mlxsw_sp_acl_rule_info *rulei,
+				      struct flow_cls_offload *f,
+				      struct mlxsw_sp_flow_block *block)
+{
+	struct flow_rule *rule = flow_cls_offload_flow_rule(f);
+	struct flow_match_meta match;
+
+	if (!flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_META))
+		return 0;
+
+	flow_rule_match_meta(rule, &match);
+
+	if (match.mask->l2_miss) {
+		NL_SET_ERR_MSG_MOD(f->common.extack, "Can't match on \"l2_miss\"");
+		return -EOPNOTSUPP;
+	}
+
+	return mlxsw_sp_flower_parse_meta_iif(rulei, block, &match,
+					      f->common.extack);
+}
+
 static void mlxsw_sp_flower_parse_ipv4(struct mlxsw_sp_acl_rule_info *rulei,
 				       struct flow_cls_offload *f)
 {
-- 
2.40.1

