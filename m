Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EEC1FDE22
	for <bridge@lists.linux-foundation.org>; Mon,  9 Jun 2025 16:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749485296; cv=fail; b=hL1DpdZc63zbTr4rhFP8pcXxIAKrjWfeqPBwG/v6mdT5PU7jw3Q7LUib+fAmRS5iygConQIuiqLH2SUp1AzJWIsYgBj9el1D6pPo7ELlrJBaTAH93yDaxhWPI/uoYIo4LIeU/oQ8rCS4aouIIfL/LZdYLVhCfucrdm2ZYaO2oK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749485296; c=relaxed/simple;
	bh=C/qkk/e3hbADOGeF0Y3+WOVK+2NL0JL5LOZ+kUjFW0w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pNhQoc7WfPhDJXLchDid7MXTaEgEwpFmgR9OO39AmoLBp+UqCLy2yN2xCnVJ7F0koGMWJ/l9M3dEIPcLwiZ9XjkC+Q6n/EiZ2uxbRllhpbP9tBfU2eoVRPnjQyCzZ9HJANv1zHXSvdrKfFrgZkEGifhLKlag+yQ2Lz8ZRyyFcaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DYKCilns; arc=fail smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DYKCilns"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 332A380F5A
	for <bridge@lists.linux-foundation.org>; Mon,  9 Jun 2025 16:08:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.103
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hDsWY2HFvDhL for <bridge@lists.linux-foundation.org>;
 Mon,  9 Jun 2025 16:08:14 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:111:f403:2413::605; helo=nam10-dm6-obe.outbound.protection.outlook.com; envelope-from=petrm@nvidia.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 765E580F24
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 765E580F24
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=DYKCilns
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on20605.outbound.protection.outlook.com [IPv6:2a01:111:f403:2413::605])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 765E580F24
	for <bridge@lists.linux-foundation.org>; Mon,  9 Jun 2025 16:08:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P69GR1MK9Gyr3KgwOnYkRyTxu+zFKhe5IXIh9sZHzx82UVPvAUmzCwNdF99GcD47LAZ0lp1trBOhp/fCZSRmJl/ixcTIHeK1ixvMtT77YSKva23SbUs9bjG+hvzwnIfjh/rcCGNn14Gme3KIh/ZLOeQ7k9GXbWkII0cDm0iHXoF0g30XPIKScoq7ZBGNUlP6IL4YkyHsQaZll+1sG0QVAhXmnPiwRNURjBFlLlWYrRDEvSoBWnyTPt3NNBbu+l1AWMtvVQQCOqbJsLpVfK4NYkMosUDLSIu6B1FCuAnpKqruvYh8rxBlSgHOvSb3CWi44Ep00UNXhHIK1ZUIU90lHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DSerN3SuFk8JvJ+eAdForPTYjQrhBND+zLIu7ksABPs=;
 b=vqcnIn7mBXkSQRGGPmG96AoRQtgbHkbijL/CeCpZD29+i8v48vtsGO6DAIejlXSxVAvL/n3u9vsOihsH1uAQnQL3Jmj077LZ8fnOpky61nLAd5/pnEOFO7/PIeI3SJzR+kguWKk7LjpHr9YkAGtmLo22zrzJYRcZu9x7u39hKdgHqO1kQI1o8q8DAwWfdVRSFk79s5FFhB3LTF3puz8wUNd/qbwQpP39RSqjRZKl48sT7G/GR66wDcCTkOQRjNwhn6E/a+1qCxQLyPD84ohRuqMT85T/osxzrZ2n75BBowdLO1hosAP2yTqPA/gnlmaXYVrZQq8BFlq9CwNr0yLvoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DSerN3SuFk8JvJ+eAdForPTYjQrhBND+zLIu7ksABPs=;
 b=DYKCilns7saCsog8gpey8/5R14Oq+pq6esNkfqaYVXXpBD/8Mwei770fpxBvbfJ7ExUMWZ90CnpyUqSNDsxB2lKR114nTknbUXkpi0G6o54KtgcKb+wbtXyNztRi/EzCQv/aEljhtF3c4AWaGqdIiVxiozUWh3G0G088XLjh8TQejy9tLhET2fSmcBwULOjN+AvICN/uXN3OkwOv8DBHjobp+Kr/pfRl01wul8gWRyedhGDZGDs63TTYS7r9NNHsQ5cd2tYWR/ji8KMOEK6a7uED5KJSGkSWE0BQhVbEM7EkDxWvqwh6boEQzTpKeMWFcW13cp0VD34aWHSxadKqPw==
Received: from SA1P222CA0074.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2c1::20)
 by CH3PR12MB9170.namprd12.prod.outlook.com (2603:10b6:610:199::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Mon, 9 Jun
 2025 16:08:08 +0000
Received: from SA2PEPF00003AE7.namprd02.prod.outlook.com
 (2603:10b6:806:2c1:cafe::42) by SA1P222CA0074.outlook.office365.com
 (2603:10b6:806:2c1::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Mon,
 9 Jun 2025 16:08:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003AE7.mail.protection.outlook.com (10.167.248.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 9 Jun 2025 16:08:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Jun 2025
 09:07:52 -0700
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 9 Jun
 2025 09:07:49 -0700
From: Petr Machata <petrm@nvidia.com>
To: David Ahern <dsahern@gmail.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Nikolay Aleksandrov
	<razor@blackwall.org>, <bridge@lists.linux-foundation.org>, Petr Machata
	<petrm@nvidia.com>
Subject: [PATCH iproute2-next v2 4/4] ip: iplink_bridge: Support bridge VLAN stats in `ip stats'
Date: Mon, 9 Jun 2025 18:05:12 +0200
Message-ID: <c0d97a28464afeb3c123f73b656e5e5532893726.1749484902.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1749484902.git.petrm@nvidia.com>
References: <cover.1749484902.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE7:EE_|CH3PR12MB9170:EE_
X-MS-Office365-Filtering-Correlation-Id: 597edbd9-abc6-4428-edff-08dda76fd330
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9p7PLDsj2tV4p47/H4SzgJe6xEqYmriomTLo1nf/yxIhD+YouiXtAbjpW/qE?=
 =?us-ascii?Q?jYiHPyHtm2b6INpn9dNhx4x5Gp7sd0iy2OTCahuDHZfFXYTwOCqxsrbX01HW?=
 =?us-ascii?Q?05u2aDGUOQjIUn7X7b1DzlXyTSsIZVD2zdxn3h2L2K8d2XEFI0Njk9sdRPUA?=
 =?us-ascii?Q?NjK/fXCw9R1d0fBJGS/zK+YPm3qVAzvPDNKAf1KtNY0QFUtbFMjVm7OZ8MCS?=
 =?us-ascii?Q?xt+bXISb1KOJD8CVBaQ1ZfC2CFQwU5gJvyNFU/lgGDz44c1tpf3d14tOxo/h?=
 =?us-ascii?Q?+Dm9J8KDO2yRVDAaAPtTFHhS8xHGUq+3bnOCHcZuoAIjepf9Me0ktIVkUZAb?=
 =?us-ascii?Q?DNd2q+Eql7Nq43EMkCgHSezjbh7v6krH7JQJRIvniSYzs9LHtFIgDGici06l?=
 =?us-ascii?Q?Ph4w45hVts6r1ljE50EgNgHkOdBPH1x9IeWTZuXJC7Kfjv3xXZmrHiIAAyMF?=
 =?us-ascii?Q?pbWnTJqX9C6b7FmUxhWVcm0IZuaUijEWadqFzLJ+kgl86rGj+znNQQztW9Yn?=
 =?us-ascii?Q?FocesNkGfDLw+kCdaE6Baopk2voO5OGlS++S/ehgtdmPiQlb5xnQXObaOkEz?=
 =?us-ascii?Q?qC1bVovtawUV2uEEMrht5Ft8DBi4P4rt4qdkPvK6Hg34od2Wc5Pvkmm/Ewi3?=
 =?us-ascii?Q?e96++bBtN3szQ5EMW3YoKjYjEWFwcKDh0W5IGurtUlUmvbExNVDBjb7GtCZv?=
 =?us-ascii?Q?9A1a5ohTkkZ8APBw997OTKOFWoUGJ1xXp+6qXmfkJlJv2IrV9ZX1czmnZhfC?=
 =?us-ascii?Q?OdlytiWo1MFvjWgyKJyIJliaiOrICTOC99eKDIX4vrq5Xtz4g8frH0+iUpP4?=
 =?us-ascii?Q?kRoNAGnsev+K8fWXUSbfDv50sWofwtT/N5WLBcgcGz+CVWM5ywqFLR5DMrmO?=
 =?us-ascii?Q?w52XRd252M89D+G/GnAHTPLursDYKLeDcw8kFzhKdyDADWOX/ulxuyUAlkFU?=
 =?us-ascii?Q?cZERlpSgeRkQJWXL5WTxLEDxMuvCqysAUx3MOG4NjQ8pA3ZDEaiuJKMzJuJc?=
 =?us-ascii?Q?UN45I8MnJIExqhJ1Fwc3mDVtl7GUvarbkobqOP2lPVwwdjpaxO+Nko0qjarO?=
 =?us-ascii?Q?h0PrI200I6O+V+po4WyTMndbK/BIeAwjC6B2/TGwLx7MRj8xsoVavKkyGVFm?=
 =?us-ascii?Q?/Est5kM0LWL7wD61KXBge+F+GGSJBFjmU5vTiqgVANRIRB8HfMnXYe5S+XSd?=
 =?us-ascii?Q?emdqx/mzlxpkPaVZmRFWTpxeyT7giWX+ETZ1xoW3/c8rGusZAk1PJyYzV8K+?=
 =?us-ascii?Q?Pt7fIfvEGBy8L5X2nbvNDa+F65I5fr0DCKiYPfqh031JmZ+JDTLjIZQyF98W?=
 =?us-ascii?Q?4R0V/1u/4YqUpc90Cv8QNh7a3rW94Ta02xkr2gDsy1NNhMO/TP72c4VWutY+?=
 =?us-ascii?Q?bgEmhXH7Q3b90/vdG2BKgQF7tzmdq8oXdLgP7Ka6D2TgYpoaZXop9rKHrX6+?=
 =?us-ascii?Q?uO9ZaOKyjzgcFEw9tc0IPZN8lN94UtPwHCdhiogbQt2QciqQLpVRQkyBldAA?=
 =?us-ascii?Q?M7l3QWon1HSOE2woKlxp8yvtCLaXfRLIRnV7?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 16:08:08.1514
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 597edbd9-abc6-4428-edff-08dda76fd330
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9170

Add support for displaying bridge VLAN statistics in `ip stats'.
Reuse the existing `bridge vlan' display and JSON format:

 # ip stats show dev v2 group xstats_slave subgroup bridge suite vlan
 2: v2: group xstats_slave subgroup bridge suite vlan
                   10
                     RX: 3376 bytes 50 packets
                     TX: 2824 bytes 44 packets

                   20
                     RX: 684 bytes 7 packets
                     TX: 0 bytes 0 packets

 # ip -j -p stats show dev v2 group xstats_slave subgroup bridge suite vlan
 [ {
         "ifindex": 2,
         "ifname": "v2",
         "group": "xstats_slave",
         "subgroup": "bridge",
         "suite": "vlan",
         "vlans": [ {
                 "vid": 10,
                 "rx_bytes": 3376,
                 "rx_packets": 50,
                 "tx_bytes": 2824,
                 "tx_packets": 44
             },{
                 "vid": 20,
                 "rx_bytes": 684,
                 "rx_packets": 7,
                 "tx_bytes": 0,
                 "tx_packets": 0
             } ]
     } ]

Similarly for the master stats:

 # ip stats show dev br1 group xstats subgroup bridge suite vlan
 211: br1: group xstats subgroup bridge suite vlan
                   10
                     RX: 3376 bytes 50 packets
                     TX: 2824 bytes 44 packets

                   20
                     RX: 684 bytes 7 packets
                     TX: 0 bytes 0 packets

 # ip -j -p stats show dev br1 group xstats subgroup bridge suite vlan
 [ {
         "ifindex": 211,
         "ifname": "br1",
         "group": "xstats",
         "subgroup": "bridge",
         "suite": "vlan",
         "vlans": [ {
                 "vid": 10,
                 "flags": [ ],
                 "rx_bytes": 3376,
                 "rx_packets": 50,
                 "tx_bytes": 2824,
                 "tx_packets": 44
             },{
                 "vid": 20,
                 "flags": [ ],
                 "rx_bytes": 684,
                 "rx_packets": 7,
                 "tx_bytes": 0,
                 "tx_packets": 0
             } ]
     } ]

Signed-off-by: Petr Machata <petrm@nvidia.com>
---

Notes:
    v2:
    - Add the master stats as well.

 ip/iplink_bridge.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/ip/iplink_bridge.c b/ip/iplink_bridge.c
index 3d54e203..4a74ef3f 100644
--- a/ip/iplink_bridge.c
+++ b/ip/iplink_bridge.c
@@ -14,6 +14,7 @@
 #include <linux/if_bridge.h>
 #include <net/if.h>
 
+#include "bridge.h"
 #include "rt_names.h"
 #include "utils.h"
 #include "ip_common.h"
@@ -978,6 +979,26 @@ static void bridge_print_stats_stp(const struct rtattr *attr)
 	close_json_object();
 }
 
+static void bridge_print_stats_vlan(const struct rtattr *attr)
+{
+	const struct bridge_vlan_xstats *vstats = RTA_DATA(attr);
+
+	print_string(PRINT_FP, NULL, "%-" textify(IFNAMSIZ) "s  ", "");
+	bridge_print_vlan_stats(vstats);
+}
+
+static int bridge_stat_desc_show_xstats(struct ipstats_stat_show_attrs *attrs,
+					const struct ipstats_stat_desc *desc)
+{
+	int ret;
+
+	open_json_array(PRINT_JSON, "vlans");
+	ret = ipstats_stat_desc_show_xstats(attrs, desc);
+	close_json_array(PRINT_JSON, "vlans");
+
+	return ret;
+}
+
 static void bridge_print_stats_attr(struct rtattr *attr, int ifindex)
 {
 	struct rtattr *brtb[LINK_XSTATS_TYPE_MAX+1];
@@ -1088,8 +1109,25 @@ ipstats_stat_desc_xstats_bridge_mcast = {
 	.show_cb = &bridge_print_stats_mcast,
 };
 
+#define IPSTATS_STAT_DESC_BRIDGE_VLAN {			\
+		.name = "vlan",				\
+		.kind = IPSTATS_STAT_DESC_KIND_LEAF,	\
+		.show = &bridge_stat_desc_show_xstats,	\
+		.pack = &ipstats_stat_desc_pack_xstats,	\
+	}
+
+static const struct ipstats_stat_desc_xstats
+ipstats_stat_desc_xstats_bridge_vlan = {
+	.desc = IPSTATS_STAT_DESC_BRIDGE_VLAN,
+	.xstats_at = IFLA_STATS_LINK_XSTATS,
+	.link_type_at = LINK_XSTATS_TYPE_BRIDGE,
+	.inner_at = BRIDGE_XSTATS_VLAN,
+	.show_cb = &bridge_print_stats_vlan,
+};
+
 static const struct ipstats_stat_desc *
 ipstats_stat_desc_xstats_bridge_subs[] = {
+	&ipstats_stat_desc_xstats_bridge_vlan.desc,
 	&ipstats_stat_desc_xstats_bridge_stp.desc,
 	&ipstats_stat_desc_xstats_bridge_mcast.desc,
 };
@@ -1119,10 +1157,20 @@ ipstats_stat_desc_xstats_slave_bridge_mcast = {
 	.show_cb = &bridge_print_stats_mcast,
 };
 
+static const struct ipstats_stat_desc_xstats
+ipstats_stat_desc_xstats_slave_bridge_vlan = {
+	.desc = IPSTATS_STAT_DESC_BRIDGE_VLAN,
+	.xstats_at = IFLA_STATS_LINK_XSTATS_SLAVE,
+	.link_type_at = LINK_XSTATS_TYPE_BRIDGE,
+	.inner_at = BRIDGE_XSTATS_VLAN,
+	.show_cb = &bridge_print_stats_vlan,
+};
+
 static const struct ipstats_stat_desc *
 ipstats_stat_desc_xstats_slave_bridge_subs[] = {
 	&ipstats_stat_desc_xstats_slave_bridge_stp.desc,
 	&ipstats_stat_desc_xstats_slave_bridge_mcast.desc,
+	&ipstats_stat_desc_xstats_slave_bridge_vlan.desc,
 };
 
 const struct ipstats_stat_desc ipstats_stat_desc_xstats_slave_bridge_group = {
-- 
2.49.0

