Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 590F941E20
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4975641E0A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pCuNlmQ0Y+rlYqtiEwRxPujaPtzLQLWlpsV08N4GMOk=;
 b=EFGsWBVAwZqd9fFLXAP7dEdobuvRRtmmnYYk6fxqaQkMRRFaF58BXe6WsPOoiZq3t7X6zlpFszvLQFkBJvi0ZjMGq5d5oj7ZY2mdZvsKAbtoojxVCyI/l4MbYt3GJxCYBAy/XCgkmMTIHW8tLaI597YSikfT90y67tq/3jeyu95Qd7HQeVSY7IX0X/q5dAQioqdjdLYrtyXv9GvgBbZ+7CqjT/PISpVQmAzYJG/7iKwPNhWjNQJwMux8t7qbQHaJFiQSw7gQeqMM4gpSVsFTW5T4JL4B3Vjd3nJXImYCFHAOMtRBYgQJ2kPrlYHCBCFkGd5BnmnkzRTM8ZHF+rGb/A==
From: Ido Schimmel <idosch@nvidia.com>
Date: Mon, 29 May 2023 14:48:33 +0300
Message-ID: <20230529114835.372140-7-idosch@nvidia.com>
In-Reply-To: <20230529114835.372140-1-idosch@nvidia.com>
References: <20230529114835.372140-1-idosch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next v2 6/8] mlxsw: spectrum_flower: Do not
	force matching on iif
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
support for the 'l2_miss' field as well. It is valid to only match on
'l2_miss' without 'ingress_ifindex', so do not force matching on it.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---

Notes:
    v2:
    * New patch.

 drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c
index 2b0bae847eb9..9c62c12e410b 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c
@@ -290,6 +290,9 @@ mlxsw_sp_flower_parse_meta_iif(struct mlxsw_sp_acl_rule_info *rulei,
 	struct mlxsw_sp_port *mlxsw_sp_port;
 	struct net_device *ingress_dev;
 
+	if (!match->mask->ingress_ifindex)
+		return 0;
+
 	if (match->mask->ingress_ifindex != 0xFFFFFFFF) {
 		NL_SET_ERR_MSG_MOD(extack, "Unsupported ingress ifindex mask");
 		return -EINVAL;
-- 
2.40.1

