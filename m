Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.0
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795457028;
	b=apoiOEdDUvqHxqrA/jMyDXJUrUJef97ZI0pF3eqUCb4MDws8FSmW+VNerJFaw5j/bk00
	 3Xw0Jnsxl6TOoYANUG8I4QoB8IIwFSB6ka2Q27DCqgroXTEkjTWWgsuLJGfVBVw4eyM4n
	 FWeHoDAfgA8kvD2s1PWQOu2TIYeJV72UnKeaLF5v6nlNa/05sYkb+dy+WJVsR9JFIL0N+
	 m/pL/TCYJd0DJIDHnlf3gC6j9X9kKCHYqRO6APHCkesKI3h9/OYPngP9FwKZxTy5fTdmZ
	 Dl8+dXZCUCAL8gmXkZRi27W13MJGerzvFS2ACgKE/b1IOuFegwoSYZU8YLoZjjBOL2Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795457028;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=fEVTgxOf7+uRxVVOH5vRPm5FKco7xWdMGl/LJHOLP8o=;
	b=bFHNuCSGM2p/gnCyBcAD+HdwAFIG06SuG7P9Juzei9h0Hc2TdT5WMzSBSmHlQSzgBmgT
	 D3p8sgvh8FGFyqNlS8CMXuvJRqT5YhYP5ACcYKvomcuibp82aFxsb6LzEfDJbcG2roDrQ
	 cvk3Cnu1d1pv3QeVwO65QT9eaVjfwodMVla+LGIe9Mz3RC0I1E+mwv/ry6ZQpyk5aLe9t
	 YdrGo8xfkYfhESYXZKFbYJ5dikg9zT39To2Xi87lvic36POUNVKXSMIuo8JXo6BVos5cz
	 amYtgvtDiIcopEGmMvzVnVKppacn7BAgQfutqUmUT1l+nUR2EUL57YWTOichZ5I4mtQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=WCcnzSbx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.0
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013000.outbound.protection.outlook.com [40.93.201.0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27ED8606A31A
	for <bridge@lists.linux.dev>; Mon, 23 Nov 2026 18:03:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27ED8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=WCcnzSbx
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gvvRo6hvE1Utgx+33x3+jS5xmLdIaiCZTajZufGpOSXZBElwqVS2wuDvuEvymCsh8Bn7bVyjbOadeegrHi8VxXnsMJ2941+IIPlJIzoazPvWlC1gAHUthiNqHNSw5lDZR8PNomatXkMPoYwq93C8E1UxfbE9wY0MMUMYn37srpz9MTA6WGH6FEGbcM6M9pTm0OosLZQtFyCkruNwKGITHFKYwQDBOzZ+ZdLsyCqewHAc4bZV1b46Up+maggaE/O+2JugQGL8O+st9Yex492/U9EtPO0kw5H3s90zShXF3i4Sx4P6PVe7CN/ypGaRDY+Bey1pl2GQETbG2Dt3bWA2aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fEVTgxOf7+uRxVVOH5vRPm5FKco7xWdMGl/LJHOLP8o=;
 b=FHUcuVnYdaZOT3J5P7rGaFWGVcOKMdWn9xPsvF+X7IeFR56uRxm1200eA2IVMlQsmK9wNHyxqzlhEJTVwEpuHYSilUBjS8TIXFmtx1MsZfywE6o8OYm5gsr+nOQ5dxE+lUZZo/LfsUFWqqs618BmJjyRbASuFYzaEaVP+Khq2kocy61E3apZaLkCFkV01NGxyWU3zNqbMlWPE1gN5/Ud6CQRl6UdpqAK0lzkKG6NaE4pBKCVrJ50XTZERJbrwFx5G8FIyKJC1N3ThPyHT16Z1DjXD1OR0jEac2PZWEWPe/84qFh4/8wPdTLvDhX8Qg903H3kycNYpStxLctZwpaPQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fEVTgxOf7+uRxVVOH5vRPm5FKco7xWdMGl/LJHOLP8o=;
 b=WCcnzSbxXBBy8yvevfltlg/Hojii/l7KlAzL8F5+yAmmsqb3YF6+/9dwj35jn8LAJJjEJhZJUkRgz84c6YSLbGo7JiFZxlED4dc64EBVNzm8yCTqa7BqUkEtT5zX1pyEn21RdN1Pssp6bk+Ib4dGM8Mr6H7qFB4WSCQvz40/H73e4CZp92v74tbJ2I/38m7x6E3NJCTefELtnYO2XTtVlLXkJ02jg8YQ+cVJyfLz56XNF1rVLAKUIWE7lLz4+/1AoCI2QzTLVwdJFS9TkRTo3Jxb7ZFQtnqtLqazF8XtoWB4SuDBKjv1C+n7IArJlp6cp/dV6vWxAKShIoRu6lDT2w==
Received: from PH7P220CA0171.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:33b::32)
 by CH3PR12MB9453.namprd12.prod.outlook.com (2603:10b6:610:1c9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 18:01:30 +0000
Received: from MW2PEPF00014674.namprd04.prod.outlook.com
 (2603:10b6:510:33b:cafe::3f) by PH7P220CA0171.outlook.office365.com
 (2603:10b6:510:33b::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Mon,
 23 Nov 2026 18:01:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MW2PEPF00014674.mail.protection.outlook.com (10.167.249.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Mon, 23 Nov 2026 18:01:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 23 Nov
 2026 10:00:54 -0800
Received: from tuxedo.docsis.vodafone.cz (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Mon, 23 Nov 2026 10:00:49 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	<netdev@vger.kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, Nikolay Aleksandrov
	<razor@blackwall.org>, <bridge@lists.linux.dev>, Ido Schimmel
	<idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, Andy Roulin
	<aroulin@nvidia.com>, <mlxsw@nvidia.com>, David Ahern <dsahern@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next 10/13] netlink: specs: rt-neigh: Extend the delneigh request attributes
Date: Mon, 23 Nov 2026 18:59:25 +0100
Message-ID: <063022ea91850fcc159e0864eedb46bc36d826c5.1795447450.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <cover.1795447450.git.petrm@nvidia.com>
References: <cover.1795447450.git.petrm@nvidia.com>
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Post: <mailto:bridge@lists.linux.dev>
List-Help: <mailto:bridge+help@lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
List-Owner: <mailto:bridge+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PEPF00014674:EE_|CH3PR12MB9453:EE_
X-MS-Office365-Filtering-Correlation-Id: 783b1df0-5051-4263-b5f0-08df498bcd67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700016|23010399003|82310400026|10067099003|11063799006|56012099006|261021121427099003|261102123227099003|261021123027099003|261009223027099003|261028144727099003|261022105027099003|261026140227099003|261026121527099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	swKMQGkujERDchUcWnuXqcBsv5lTdgLvHfzt14GCveW2ClzrmJ7axvlKB8sNp1iEjEfesPI2CwI9WFWhfnnQSlARqej8AUtYtYse44r4bs8sktPfgADEiydfE0CVS2hOPIgEHJLtmDZTzgZxFJZbuYC7BI/Zos61whAt7VWPm2UeBAAcIZz082CsNX2FqogN6/Vw0SakbmNz7amxSdK9XUoiIFBN3HiA08F+seUZA7MvZ5dbv1mairZIR9bbIBBWRKhLaOEU6KkcGUFcIMO0sIphHAu2Amzx6vWSkbweY7sDA0nK3tv7Fn3rD6U2OuFgJOh7PvcCREaIprbxRYlbm1Vj7ndQ67cOW64ykTVDsUjvpuauv8jXqzfMWD3QAVIs4xbVR9xevaNlfDBabOWhkoUdW+I8sVzGpd3fp6Kkj+UHRDXDf81xHxXaIpC9MtdJF//6KZMDmq3Lv9F71ZDyyBPeiM9Ger977cwBj2MGy0CFyXZDLMxetwli8MRMSSIiK6LuYLDNRF5rKuszSWAi5feV8eVgYL/BF4N2WVlX4IdkVMIl8ziCQvrtXOuyKCM/Vk/b3Y48zHlweGYg4eFXfxrnRtEPqwSp6Qx2PjkO/7tkFJ4KXnh6LR1h+9Zp++rd+JuO42vtW/xxmD3WhEKfSKa5ym5WkG0O1sj+Rx92O3YycsoRBcKbEq2+qq8fUp9OYoNiV3j5WDkWyTWU1vLVdg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700016)(23010399003)(82310400026)(10067099003)(11063799006)(56012099006)(261021121427099003)(261102123227099003)(261021123027099003)(261009223027099003)(261028144727099003)(261022105027099003)(261026140227099003)(261026121527099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3PZs2I2+KgnS7wz46g9PN5SbPBCPardau65M0WNQWVKMc8METHukRRW/nXrDa+dO0uUbOFCnwQvICNNKEGc2QoPZMBplapSaGyIZ5seuJD1BEb+YeSJ2IAPX4bOGg0QT0Lbb0gKxnHRgEX+qXp0JQV7FMQT2Brutwo+3REcawUDA7tyNLDMSHclqD8RerSEgYW4I4nOuQ2+VCvAoRbMnZsiMz3P2Od4rP2DA+1ts2tHnM/IKAdbKXOQMxIO3NZFePeiSypAoeafuwAQDiLFF3f0XhoWfXexbDhGGRU6GQ94fkn4hB2D/ye4glwPtjO10BAstr/+kes3jBXr+4l2BBXDdkoPLx1KWkrSBjpXs7eg5sBrL+BBqdoAcIMqBS5qQRTGOEA+xIFttjMiGX7SscuU90YDcmLGy83vaz7Er7ibQL+lwL1mNVIroYHCWbmrp
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 18:01:30.4275
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 783b1df0-5051-4263-b5f0-08df498bcd67
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW2PEPF00014674.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9453

The kernel accepts more attributes in an RTM_DELNEIGH request than the
spec lists. FDB deletion identifies the entry by NDA_LLADDR and NDA_VLAN,
and bulk deletion (NLM_F_BULK) filters entries by NDA_NDM_STATE_MASK and
NDA_NDM_FLAGS_MASK.

Add lladdr, vlan, ndm-state-mask and ndm-flags-mask to the request
attributes of delneigh, so that these requests can be built through YNL.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---
CC: David Ahern <dsahern@kernel.org>
CC: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/netlink/specs/rt-neigh.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/netlink/specs/rt-neigh.yaml b/Documentation/netlink/specs/rt-neigh.yaml
index 7929e667cc7a..4dd4e3d997f0 100644
--- a/Documentation/netlink/specs/rt-neigh.yaml
+++ b/Documentation/netlink/specs/rt-neigh.yaml
@@ -380,7 +380,11 @@ operations:
           value: 29
           attributes:
             - dst
+            - lladdr
+            - vlan
             - ifindex
+            - ndm-state-mask
+            - ndm-flags-mask
     -
       name: delneigh-ntf
       doc: Notify a neighbour deletion
-- 
2.56.1

