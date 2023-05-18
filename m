Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EBC24607D0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7A6DF60807
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nruIgm4v7mpElLZK3vX2XDPG6wn+168Lo+vJlkqbJmg=;
 b=WsFPXonT23gA9HSwHacsCmopa5QKKTeVP5pV65CwdmEY5phsDO5Z+gv5TzjqjM/b+KoeD5+4y3COMoslyvEsfaz8CCpdSUcVEKlzn2Z6z0YkNv44wA8O786hoeCv93LA2F58lvZjOnqTIv6NTa2HbjE4JTi01Lhv1RWyfd4jq6XZ33BpLPn7WZgkkEzkW9w8KwQaTRsXGs1+G2tVUvvoxCVDm/Enz4LbjZHyq0Dme5bvB7x3/dbKISshthgpELLNpCHy0JJ1cl7hxuYqJ/LX9NDOTHB4WFWaVVfYjVF4qT1Ylsb/tQj7QVb//uOEIT1m0eimXEDD0y8xTvHU2vPtrA==
From: Ido Schimmel <idosch@nvidia.com>
Date: Thu, 18 May 2023 14:33:26 +0300
Message-ID: <20230518113328.1952135-4-idosch@nvidia.com>
In-Reply-To: <20230518113328.1952135-1-idosch@nvidia.com>
References: <20230518113328.1952135-1-idosch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next 3/5] flow_offload: Reject matching on
	layer 2 miss
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: taras.chornyi@plvision.eu, petrm@nvidia.com, alexandre.belloni@bootlin.com, jiri@resnulli.us, taspelund@nvidia.com, leon@kernel.org, vladimir.oltean@nxp.com, razor@blackwall.org, claudiu.manoil@nxp.com, Ido Schimmel <idosch@nvidia.com>, UNGLinuxDriver@microchip.com, xiyou.wangcong@gmail.com, edumazet@google.com, jhs@mojatatu.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, saeedm@nvidia.com, davem@davemloft.net

Adjust drivers that support the 'FLOW_DISSECTOR_KEY_META' key to reject
filters that try to match on the newly added layer 2 miss option. Add an
extack message to clearly communicate the failure reason to user space.

Example:

 # tc filter add dev swp1 egress pref 1 proto all flower skip_sw l2_miss true action drop
 Error: mlxsw_spectrum: Can't match on "l2_miss".
 We have an error talking to the kernel

Acked-by: Elad Nachman <enachman@marvell.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 .../net/ethernet/marvell/prestera/prestera_flower.c    |  6 ++++++
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c        |  6 ++++++
 drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c  |  6 ++++++
 drivers/net/ethernet/mscc/ocelot_flower.c              | 10 ++++++++++
 4 files changed, 28 insertions(+)

diff --git a/drivers/net/ethernet/marvell/prestera/prestera_flower.c b/drivers/net/ethernet/marvell/prestera/prestera_flower.c
index 91a478b75cbf..3e20e71b0f81 100644
--- a/drivers/net/ethernet/marvell/prestera/prestera_flower.c
+++ b/drivers/net/ethernet/marvell/prestera/prestera_flower.c
@@ -148,6 +148,12 @@ static int prestera_flower_parse_meta(struct prestera_acl_rule *rule,
 	__be16 key, mask;
 
 	flow_rule_match_meta(f_rule, &match);
+
+	if (match.mask->l2_miss) {
+		NL_SET_ERR_MSG_MOD(f->common.extack, "Can't match on \"l2_miss\"");
+		return -EOPNOTSUPP;
+	}
+
 	if (match.mask->ingress_ifindex != 0xFFFFFFFF) {
 		NL_SET_ERR_MSG_MOD(f->common.extack,
 				   "Unsupported ingress ifindex mask");
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
index 728b82ce4031..516653568330 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -2586,6 +2586,12 @@ static int mlx5e_flower_parse_meta(struct net_device *filter_dev,
 		return 0;
 
 	flow_rule_match_meta(rule, &match);
+
+	if (match.mask->l2_miss) {
+		NL_SET_ERR_MSG_MOD(f->common.extack, "Can't match on \"l2_miss\"");
+		return -EOPNOTSUPP;
+	}
+
 	if (!match.mask->ingress_ifindex)
 		return 0;
 
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c
index 594cdcb90b3d..6fec9223250b 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c
@@ -294,6 +294,12 @@ static int mlxsw_sp_flower_parse_meta(struct mlxsw_sp_acl_rule_info *rulei,
 		return 0;
 
 	flow_rule_match_meta(rule, &match);
+
+	if (match.mask->l2_miss) {
+		NL_SET_ERR_MSG_MOD(f->common.extack, "Can't match on \"l2_miss\"");
+		return -EOPNOTSUPP;
+	}
+
 	if (match.mask->ingress_ifindex != 0xFFFFFFFF) {
 		NL_SET_ERR_MSG_MOD(f->common.extack, "Unsupported ingress ifindex mask");
 		return -EINVAL;
diff --git a/drivers/net/ethernet/mscc/ocelot_flower.c b/drivers/net/ethernet/mscc/ocelot_flower.c
index ee052404eb55..e0916afcddfb 100644
--- a/drivers/net/ethernet/mscc/ocelot_flower.c
+++ b/drivers/net/ethernet/mscc/ocelot_flower.c
@@ -592,6 +592,16 @@ ocelot_flower_parse_key(struct ocelot *ocelot, int port, bool ingress,
 		return -EOPNOTSUPP;
 	}
 
+	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_META)) {
+		struct flow_match_meta match;
+
+		flow_rule_match_meta(rule, &match);
+		if (match.mask->l2_miss) {
+			NL_SET_ERR_MSG_MOD(extack, "Can't match on \"l2_miss\"");
+			return -EOPNOTSUPP;
+		}
+	}
+
 	/* For VCAP ES0 (egress rewriter) we can match on the ingress port */
 	if (!ingress) {
 		ret = ocelot_flower_parse_indev(ocelot, port, f, filter);
-- 
2.40.1

