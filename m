Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012032.outbound.protection.outlook.com [52.101.53.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B8C397B0B
	for <bridge@lists.linux.dev>; Wed, 19 Aug 2026 08:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787128345; cv=fail; b=ito1aspaT77LiF5L9EruLaOK2+lN/8fM4egz1idhUTRgyegFrF4U56DPfN4AkrE+D0Xw08wJJ9qGRUkSeVry4PdBStW4hlcsq3v46NbIhSPwxZNDcv9eKyk/skfEPMfd6iUCai93mtu4ZE4j9/+1PqVuu8czTfxpGl0atzJWYn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787128345; c=relaxed/simple;
	bh=IENUpRVdrSjl1dGa/lBSKLJNTnfujThVe99CGJyuniI=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VrQcF+1i0mH9sl9mUhfNWjcI48fxDV825TgFkXOztPB1Si9k4s6UNhgdE0OkAQcKuH56s8yYU007xE9p4Hx29HXGL2Q21rh3T06t2eAXNEzMWVBYo6Qjv/RaOkmc9a/+aMdBBG6NstTq2pLMXuqc5T1CT9Dgg9m0qvPOch8LAto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fYFohJe1; arc=fail smtp.client-ip=52.101.53.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fYFohJe1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b++uNchp+0tgERo30wuoNYPthIalJGOATkBHO3AGGKvcD61CcdHI5WNjn4DCnAyh0yxggrWmgezFkJtphsij4/WWg5NIRUnRyVuOzURCuYLV3Wpu5KtJkCweQ1dIfGYnhcxnIcgoZ4QBnf7ZAntkkP8Brbuc0KczGRUbCxaZxp7DVJYUTtwCwVHMEo2GllY/+h5G0y0Bzx57hMrEgzxaXrnuANl8R0zkK1Qv/0slbm3a8sYJ8+jwBdLPJl6DnTJyI+d5srWXT9ZinK2E7NkSYT7ZH+Zb4sArCnkOEk3FuAKSZAhLOEeLjvrVkvyfCkPVEzU3kLKVcedpydXCqFH+tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kWuTAXEFMyi7BeZANJpCBHBwX4ughq1DNdndo0zZWFY=;
 b=Aarc76mREr01sIwC+X9nl79b5pL4yUsDllSPuet2yyNGUgEEYA0bo/G1n7PAlb8q5XAbzmrgEZzu12Xw1snKTtnLmLUSlIi3+0qfidrO7FecXxfydDUaHNxuaksU/9/NFqeCVvzWevFB34zpBdnWNcdHcQWwQT5jGTHfhOjlDo6moy15iYBoDhHTSUEAoIvkXBQqQYil1xCnwlYWVxoKoEptPLrnVif/bSmLeIHSbkbRFOQFAf8LXavBXhydJHvl2ygnh5HFpNNyNSa7b/6OqkiEpsaRdVyAyx6PO7r8L5jImaLKMtoZfuk78igx7whqu0DAzovND/IwHwH3oYcRGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kWuTAXEFMyi7BeZANJpCBHBwX4ughq1DNdndo0zZWFY=;
 b=fYFohJe16kM2Tm5KZ3lsCiUnbrdJ0E/Ti0OC8GCkt/xAuaLMLe1Gsu11cJAWz40X0yI3VDxR8TIBlk4rie0/GvqT55DbjvXtbJW9Nm0Saw0EJIK94/fn03yokz5gyDgJkq3Lt2L9WNTE/h9hg3TwPH6VFSh104byBi5hd8AlEPP8ynE5nJ3V9/EhKOX8gHY3k5VcirATLsiGZ69TLtAgH4AF8J/7J9RJ1T4e7dR27LTD1YtejoXrDCT8/ldVD0Mlz9479KwV4TacsD0vBcdbUSeaoQnSIvg0v6PVGe2SvhvE0IjHhe45iqHaWuEqSiJyNW72x5ttdrKQbxiPRvz1Mw==
Received: from CH2PR16CA0011.namprd16.prod.outlook.com (2603:10b6:610:50::21)
 by DS0PR12MB7948.namprd12.prod.outlook.com (2603:10b6:8:152::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 08:32:18 +0000
Received: from CH2PEPF00000148.namprd02.prod.outlook.com
 (2603:10b6:610:50:cafe::2b) by CH2PR16CA0011.outlook.office365.com
 (2603:10b6:610:50::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Wed,
 19 Aug 2026 08:32:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000148.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Wed, 19 Aug 2026 08:32:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 19 Aug
 2026 01:32:02 -0700
Received: from tuxedo (10.126.231.37) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 19 Aug
 2026 01:31:57 -0700
From: Petr Machata <petrm@nvidia.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
CC: <netdev@vger.kernel.org>, <idosch@nvidia.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <roopa@nvidia.com>, <bridge@lists.linux.dev>,
	<andrew+netdev@lunn.ch>, <dlstevens@us.ibm.com>, <amwang@redhat.com>
Subject: Re: [PATCH net v2 1/2] net: bridge: arp/nd proxy: fix reading neigh ha
In-Reply-To: <20260818150756.890025-2-razor@blackwall.org> (Nikolay
	Aleksandrov's message of "Tue, 18 Aug 2026 18:07:55 +0300")
References: <20260818150756.890025-1-razor@blackwall.org>
	<20260818150756.890025-2-razor@blackwall.org>
User-Agent: mu4e 1.12.15; emacs 30.2
Date: Wed, 19 Aug 2026 10:31:52 +0200
Message-ID: <87tsoq7bpj.fsf@pmachata.org>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000148:EE_|DS0PR12MB7948:EE_
X-MS-Office365-Filtering-Correlation-Id: 074b3d12-2962-4374-0e2c-08defdcc61ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|7416014|82310400026|23010399003|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	rS7RG/4PV0CyHgBsXDkqqex1wLIClAFD5DOWExt+OGfa6u2tToh4j4Tds9512glZvB1OM1vdZ/3vMCPBJc2+VFFWvrDGwX9i2jKJDTI4QKz7E1+EVdLICFgj7VevHpcXzDnGFgcPLXzVDKFAUsl0q65wYEln6ErJJbLuy/ZKz2hE2gBrbqUEezBXMw0dLVd0//avROq2k3QyqJsQaVHIxe6VT5AXtZhsKEIDQrOgB9SFfkaqp0v0ZoXCCsmzZh1NA5aZ0Qv8PQSKDSKJHGb0xPvAlE+aEkOyMF+r6rFKs1UP9GUGOJz4vaq7JIHNd0VzrHL3Iru6Nt0cUiDEkAXs6fHt+ivBME7Fx7i0Z6z9AD24svRX9bkiamfNZf8rjMBCYX/yoxHy4j84ElUtHfqe26a1cbdTbO0RJus6QWpiE+o+CqfRpwhUF/+QkCz08Z1FuaM1UMhc0iRtRhmGRL1wE9bQr85e/QEEc2Vpd+Dxxh+ZgAmevFctORTfQQukUFJUNhLBfWB0vJbD1VhxvsacFchZQaPuRl9Z714vHHeO9TVFbAnzHrBvNc2co9v7e0qhQPkj8RI2LtsK045etY+XDO8XfvwJ3E9i+deaK+ld65kbusqlP0l6qhuineUo3U+yAPjggpm5c/lt/VodU6PhcUou/+NFvCPcsHSWnEYPNJ/57MaDMqc0XbanrglQeNVX54JaoDvxNZb7q2DlVWN43Q==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(7416014)(82310400026)(23010399003)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	DuPgqM0SCYRGme+0JoNRt0PFEDoEBRBnKmFff1yv6bANULOKOgtuWUp/BdyXHz6LfDJv7OdXN0s05Xa32Nx4Z5XoRGu+r5LcGJt1YmEIETgvhyA6zUcPrRGD0IX1Gn1JJF3ElJ7810Syn5gtDxAEvvbJaS/XA8hrCV+gbMGZP5XpaN9zKlwDSiMPq+l8B8AIR7cOClzN/24d0Rliq7wWDVeu5bVZl+pjjsMJiTd3yOYRabrU54QMNVO8lPFV5+UY95LOeLWevHQNs3deebKvmZaT8DB+wTOX44F3GhapTMJRQFDO8gDYR4AlgYDpCkzJrw9aGpH8jBNj7wg5S5B8/XbE/UYhrPfwcrbMsaPsioDsgvfWnFD3Ta/1v18Bjiv+U2y0aS4YwbdHMIKLwoOZcxr34drpb4RxDffW86VWi3cF0Uyb3ePSUN4/GR6I0NZy
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 08:32:18.5318
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 074b3d12-2962-4374-0e2c-08defdcc61ab
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7948

Nikolay Aleksandrov <razor@blackwall.org> writes:

> Currently neigh ha address is read directly, but that can result in
> torn/partial reads if the neigh is being updated. Use neigh_ha_snapshot
> to take a stable snapshot of the address.
>
> Fixes: 057658cb33fb ("bridge: suppress arp pkts on BR_NEIGH_SUPPRESS ports")
> Fixes: ed842faeb2bd ("bridge: suppress nd pkts on BR_NEIGH_SUPPRESS ports")
> Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>

Reviewed-by: Petr Machata <petrm@nvidia.com>

> @@ -252,7 +254,7 @@ struct nd_msg *br_is_nd_neigh_msg(const struct sk_buff *skb, struct nd_msg *msg)
>  }
>  
>  static void br_nd_send(struct net_bridge *br, struct net_bridge_port *p,
> -		       struct sk_buff *request, struct neighbour *n,
> +		       struct sk_buff *request, struct neighbour *n, u8 *ha,

(This looks like it could be const u8 *ha though.)

>  		       __be16 vlan_proto, u16 vlan_tci)
>  {
>  	struct net_device *dev = request->dev;
