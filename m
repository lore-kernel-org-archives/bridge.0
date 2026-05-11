Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011024.outbound.protection.outlook.com [52.101.52.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA39A30DED0
	for <bridge@lists.linux.dev>; Mon, 11 May 2026 07:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778482847; cv=fail; b=e1v8CJLjUCYkhaix2IOVMLDmizO6VpMnkD+0mXbWNbd830kYfzOaVWVotWWWERqZkeYSXKogRS/oz0OAGlkIJx/5eSSkNaTyBz0KzvEnZL4hzEV9ph59hayBIe/4And+xQtiz4geApw8PpQDp9aKeK8h+iiFN/NydiJKk0mE6Sk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778482847; c=relaxed/simple;
	bh=xGbAHGgu3/nxDQ0St0liCyj84BgRkcFJVogUycp2cQ8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UXK4HkC6/xdsTLs0bBUT0dY+0kexB77jqOgKrtgUMtc3bQxwBQ1kt1IylXAxBCzXHE91+FhItKhTyiQzWOluYZ7nBlGaehwFJM3YfVO9xlpKlJ9Mwat/PysyOPAVACb064yIjt5ZJRQ0y/g2u7wjbUPZkJt42EJsJvBeggugqHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JNIRmjLG; arc=fail smtp.client-ip=52.101.52.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JNIRmjLG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U1o0I/8vohyq1aDxSnAAb9JzZVcZvw8v9MRXK37IIegbtqMZZGsm0DMJ8HzqylG2Oo5TvT61PDMnL4yDscq0jwMXOJalnmG7QXhtnVpTuwtorkqy+Dni3azZ3dlIx+V8+mW4o67WquiBFkShe9ZTo3Sl2pdJEkSb1zptYiA24abBAaNQaOeuIGQ85c0ZCSGDeGaEws33DgnmPLlvv/BQrvExsS8ZLJLmIWUQe7ACLZgUGgueQT2gHKt4cz8pdeLIrgoeggvx7cFchQBKpxKaTJxdewgpM8F/ZwvqA1FomQK7NdphX5ma6Axh6Uw6Egvcbzx6G+RcAQbb1RA2dqbdMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uNLMRkca+4nEMoX4048b1TDdApKJ8r9hyF2EHyPvIyE=;
 b=Sf40/BzQprXmvMEi0tt1du0ulQHEIX9jOm/dZpnafK3FAj1ICCmu8B3D69LztdaQD+JQaStvYlxhEVJMV8g7JepQyOg+xSzCSTKGn7AszUe8GoX0rNz6xfmeDJ/6fMcDsAi4nlZwPqQWJoUxPqIvKeC3ltdnkNwAb39h9c6kX3/iiZ9enNE7vBGC0hXgpTWYG8kdJ/2yuh/eiTZcwpICBpgUgUQgWENYfXymQ/RC2hSvT9HFUYkoqvxmWST4FFxmyDCmXUt/h/DeNJ81qqlbCjZAJokqpy5rTK2Pv0iFiURyXxT0k0wKmKWsKs3Dvz8PWzDyqROWjxVAP0/rUpPKgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uNLMRkca+4nEMoX4048b1TDdApKJ8r9hyF2EHyPvIyE=;
 b=JNIRmjLGogkn+9protV++MRSmGW0gehz1Y83YQfifbdWqy2j8GdprWzTQd+a0ybM2uom16b7rLFwFWeESkioAOIH53FtHYKKdmC0/Qe3Ial7URwxCpJGMmKUKN9jmzX1+olNBalMhRXSbWC5urql5qCv7zE+IrM/aLQv43Up4Qq7zZaBy88FTj6WlCng1y/81pqi1kT222SnsaTdCxykYgMoaeWoMe18onSywi1m5MoZedeHcwQwsqsZEJ3CBJUlJdBMe9pMMmnPOSwRLc0hi8t+adaCk2ndwm6nccdVfoqlA0kffqUTT127wNVJad1onpwVltJCkoqdC0IvJoLizQ==
Received: from CH0PR03CA0195.namprd03.prod.outlook.com (2603:10b6:610:e4::20)
 by BN7PPFABD533732.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6df) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Mon, 11 May
 2026 07:00:40 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:610:e4:cafe::35) by CH0PR03CA0195.outlook.office365.com
 (2603:10b6:610:e4::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Mon,
 11 May 2026 07:00:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Mon, 11 May 2026 07:00:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 11 May
 2026 00:00:18 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 11 May 2026 00:00:09 -0700
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <donald.hunter@gmail.com>, <kuba@kernel.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <pabeni@redhat.com>, <horms@kernel.org>,
	<razor@blackwall.org>, <idosch@nvidia.com>, <andrew+netdev@lunn.ch>,
	<shuah@kernel.org>, <ast@fiberby.net>, <liuhangbin@gmail.com>,
	<daniel@iogearbox.net>, <aroulin@nvidia.com>, <fmaurer@redhat.com>,
	<sdf.kernel@gmail.com>, <sd@queasysnail.net>, <kees@kernel.org>,
	<nickgarlis@gmail.com>, <amorenoz@redhat.com>, <alasdair@mcwilliam.dev>,
	<johannes.wiesboeck@aisec.fraunhofer.de>, <petrm@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <bridge@lists.linux.dev>,
	<linux-kselftest@vger.kernel.org>, Danielle Ratson <danieller@nvidia.com>
Subject: [PATCH net-next v2 2/6] bridge: Add internal flags for neigh_forward_grat
Date: Mon, 11 May 2026 09:59:32 +0300
Message-ID: <20260511065936.4173106-3-danieller@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260511065936.4173106-1-danieller@nvidia.com>
References: <20260511065936.4173106-1-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|BN7PPFABD533732:EE_
X-MS-Office365-Filtering-Correlation-Id: d7af486d-fa37-4007-81e8-08deaf2b02cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700016|1800799024|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	l7zpW5B2jxrnS4mkOgbnA2vT7vD0Mq67+xkBH2PGOpI49GeJUDwox6p/LsBlNEAnMm9Sc9kqMwFC3JsY2Bsg3AY8rFCPjMm8HgkOwklEAx36M/+F2J1t2hkhKzIBMeToSavHpztRLni5YActqCrR/EZVIwr87RkI/KgCoy39NnnsQGqE8v+p71Lp9OY8rzxg6CyXNwsyiy3EDhGySTkdScoEk+WYMuMqhxPG3aN6wGYR4WpjrSbdNOrSKU3ZzuoRlwwvJvWLVu1BUAF0OcH+k2JUf1QImsfbtrYtwI9wrcNTMt3u5sa5VOcUpxs548Pxjr3VnMPfR4sZxiweLLAvnkdU4sZ4OscGD32ze2FCawORGlm+eu8YFP4iJAiBbf5hi5Dvio0YF4WMoJIQqC/32K2SgZuc5zwZgrRvA5xJ175rRRjTsX6JLN/zIWmgSGEG6+wboOhQOd4rIJPOWYqNdfPnvcWhITt12zjzwrNgv8m2HA5SHlpz1y/tznuQPjYnsomGdz+tYmGlHFOzZbRV5X1SvA+UGTrVEvBsCW+xVe+Ixxm3U7kr18yTieyueGBzbRtKB5YMaC9m2QL7W6KQtaAM5Wksf+angeGAdi8eYnW4Jl5yMGo1gORKvdk1+FT5bJa+R1KKoHSrRv/OaJ1MTDR9vkyebvGK/GGMvAtFUiN8hNZ/mEcfjr9RUQW0SD++qaobip1p5R7l6BnIV1HI9zYJYSx6w++aIXy1BjlVDu0=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700016)(1800799024)(82310400026)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ycNEQE838cAJzfpWzXq8Mrnczb833mIc0im/IZKPP+0w5cJNCnzH2RzwiaOSAarm5HgwT+1QuBYbY/5IAZAcPssHQrVI6ONHFMaatrBZUpFpI3B4pyMlAwREuiOXnMLNQTFKSs736oJOCp4gHCNWqi0LNpd9iKbOjWUbTEKoESEmzFxJFqJ6PyN2sVRBGR85Ork/YmPmAwHoqQp5gfPbLeBh0L8dpZ1Eh3FnqY0SQqzMfegsoWizLTtESGNUZqNHq2K5G3BQaDPU/00JNXJbaMImPVHOA/e+pjZUfcKLxlVFTvbSSU5kjvbgG5UbFQUc5VLWGNzzUv9mqrng6aWPwzCzLgVk+FC5LJY0OXm4q4LOlyJwiHl2m2CaDxbMwe2P0x0zLzehukf/BjClDSkJOr2X8ti1BkUYI7Gvrz10DW2OBD9hkLDRwEuOQGu/yE0C
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 07:00:39.7150
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7af486d-fa37-4007-81e8-08deaf2b02cf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFABD533732

Add internal flags for the neigh_forward_grat feature:

- BR_NEIGH_FORWARD_GRAT: Port-level flag
- BR_VLFLAG_NEIGH_FORWARD_GRAT_ENABLED: Per-VLAN flag

These will be used to control whether gratuitous ARP and unsolicited NA
packets are forwarded when neighbor suppression is enabled.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Danielle Ratson <danieller@nvidia.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 include/linux/if_bridge.h | 1 +
 net/bridge/br_private.h   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/linux/if_bridge.h b/include/linux/if_bridge.h
index c5fe3b2a53e8..ec9ffea1e46e 100644
--- a/include/linux/if_bridge.h
+++ b/include/linux/if_bridge.h
@@ -61,6 +61,7 @@ struct br_ip_list {
 #define BR_PORT_LOCKED		BIT(21)
 #define BR_PORT_MAB		BIT(22)
 #define BR_NEIGH_VLAN_SUPPRESS	BIT(23)
+#define BR_NEIGH_FORWARD_GRAT	BIT(24)
 
 #define BR_DEFAULT_AGEING_TIME	(300 * HZ)
 
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index bed1b1d9b282..3bc15978a8df 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -183,6 +183,7 @@ enum {
 	BR_VLFLAG_GLOBAL_MCAST_ENABLED = BIT(3),
 	BR_VLFLAG_NEIGH_SUPPRESS_ENABLED = BIT(4),
 	BR_VLFLAG_TAGGING_BY_SWITCHDEV = BIT(5),
+	BR_VLFLAG_NEIGH_FORWARD_GRAT_ENABLED = BIT(6),
 };
 
 /**
-- 
2.51.0

