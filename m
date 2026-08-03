Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012065.outbound.protection.outlook.com [52.101.53.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C6A3FD96E
	for <bridge@lists.linux.dev>; Mon,  3 Aug 2026 11:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785756363; cv=fail; b=R7M5tNNw9NXwK5wwsiXL1B46/GQlm9hxtMXr+Smt6P5P4afGCe+4WGbOTlwiff3pAgy4ZOcq16ofvzhNNYn4mzCsdbZuQutFF3cryAuWmkSH1iUaySDaKCmEVvIjdCHeJk9aikGf5EDGt6pG+cjmA7lHniseXZazIgneO0kcgLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785756363; c=relaxed/simple;
	bh=Iw/Fi0w5c/TxlhhiZvVB4q6i+ENGMrQIhhAfid3vvvU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uoScusxhBz1c27SxwjJHmyKpxxh1hIpFGypa810xcXubJ/5sAZTzRQYG2YVdngPBu6tvz51P5+kou0CAodoZ01ytov3FhKYPKYmJqJHWegh5VuOBh9ovHgSoKgOFbA8w+wYCTCExwvpE7dWueuqdllch2rdndeWHZrlxUsmE/8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cCbPLcEr; arc=fail smtp.client-ip=52.101.53.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cCbPLcEr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eOsl8RWqrz7JcPIaK9ddk8lQ87UnJjQ4cYM/kuWzLcxO+KZQVhqWRKv0EJNrR52XD+h6nQZiVGVrAgVRrSPU9i4c64Pq/aMpgPokPQAluwJVCvbv6PAbc9Twq/uTUtwUGZrOI1pDpfQ5jc8+6bSZmiDCEP6lJlXJIetnpuk3k5ivkg3kM8QKxusF+DsxM0Cf8XCF6O5dFFn4thROfkNIQYaEY6rzoKII5xCynn2iE6dUeycSKuCHSO8ZRPNy1L5cLgW/k6zR0hH5PcpoX/3zvgypJeVIU9vHFQLXClwkqlPkBlQMiPmD4jXwTg5rxkQR12LwUkLnY5J6//heepHOfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VZkcTj2z70JFJusAax4ZVxRyiTWr9z4UftmhnDzxAzM=;
 b=R1PuLCImg2DiKv2XcXoMbBn/siXMny+UHbpysi+d4FdAIaBlyet2rAT7+caVvePfwhs3a5Llm++uB+Pl904x4+dCasvYklGaXs5eadS2kk6YO8fAoRapb91+Rng15oKsfo6FnXDUTkcJjxfhpEZzGRHQt+aNZ22xhobcHCuBntxpGVr2lbGVs99vJkI9gsxkXd/45E3/oLR/75Sbn/iAeKmpH9Mpsu8ZeXxvxsR/a6zK9vFzJxNzcUNzZSPIOyXBqlnSmW3zWv1s0aRI/xq6TJCQU6H8818oJS4kU0hsrVdtnXV6iqa/YVb0ESUyJhMgCzCMpTVGtWfKw57Zi76XJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VZkcTj2z70JFJusAax4ZVxRyiTWr9z4UftmhnDzxAzM=;
 b=cCbPLcErJDV9xolzEEPuRHEIHxL1gQiyf9BHFtyu5AHtSfqx2IbQtF1EmITVPjy9AdyiUv04W9aE0vkwmFQ06zmPE7POOp53g4lWB8v/GxNX8Wzhom+hh8NU04mABOseDcijKYXt38zM/rtnHCxK/eRUlP0ry3XtJRPvwUpAIRDeBMv992prQZYr7daieePBK6VxBiH/oo7zDEuah5RJ1yP7cgytRF8L5G3Np/FQpRMRChwj7drvduwrTBPPMUoPIrMGaMR42A8LC25s2xRvZEjNXirzA8GhotnDbrUkJ/80XPf6KicQok1O67vULOQ+OxvdxBcp+fx9kz/pQVncUQ==
Received: from MW4PR04CA0360.namprd04.prod.outlook.com (2603:10b6:303:8a::35)
 by CY5PR12MB6059.namprd12.prod.outlook.com (2603:10b6:930:2c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Mon, 3 Aug
 2026 11:25:54 +0000
Received: from SJ5PEPF000001D0.namprd05.prod.outlook.com
 (2603:10b6:303:8a:cafe::9a) by MW4PR04CA0360.outlook.office365.com
 (2603:10b6:303:8a::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.18 via Frontend Transport; Mon, 3
 Aug 2026 11:25:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001D0.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Mon, 3 Aug 2026 11:25:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 3 Aug
 2026 04:25:42 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 3 Aug 2026 04:25:38 -0700
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <dsahern@kernel.org>, <idosch@nvidia.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <razor@blackwall.org>, <ja@ssi.bg>, <petrm@nvidia.com>,
	<fw@strlen.de>, <kuniyu@google.com>, <bridge@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Danielle Ratson <danieller@nvidia.com>
Subject: [PATCH net-next v2 4/5] bridge: Linearize skb once the ND message type is validated
Date: Mon, 3 Aug 2026 14:25:04 +0300
Message-ID: <20260803112505.613873-5-danieller@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260803112505.613873-1-danieller@nvidia.com>
References: <20260803112505.613873-1-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D0:EE_|CY5PR12MB6059:EE_
X-MS-Office365-Filtering-Correlation-Id: b7a23602-4894-429b-ae83-08def151fb38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|376014|7416014|1800799024|82310400026|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	UvTcz6UOEB88pi1t5GEwmyxGN5d9FUexszkpqU6g80MWLZ3ipmiG72h7yjDNXo7fRs4I97OJ27QM4RanhYtAbf0yNy9WCPsVcQOWCoscDmGSAnvHafUZz1zFPJCvrVt96fexcumvpK8R6ocmd4bKTwW4FhVeoZYrwy92rtbg1fl8JLa+PfnC3lTtBoVqpjTyzbwozjlN38JKhYUmdRwkMvnv5Rgx72kooMxCyZwXpSd5Q+acIXYzP2SvHi5s/mf1qNvznPht+Ezuwp7+3WHPMh7cpKTwykAypLig3oHZC5YQoLGiF5ejP44fNChgX2bt02YeFPpOBbrQQockjpR6+/yz9jekXIQxC6MYUMvZfPJcdxIWfwxLoWaLWcr+MCEOsKwQB/ZJ34ak6gZl6CLZ5nSVZUonT7/DhocArHRi0Hm+24PpVKb9/ox/+grdJasSx+DYw66fC5nfJE0i7oVV1vUhJ+SZv/tkVL/z6dKw3Qeaawle1IDR4YdtCDIK+MA99Z568z8mH33QLX/soMFSbLiMhrsowvpNOMICBSA2HEz6/oAurn0mtdQJ0MLlkS15EWH/2mKlbnYh+M6Fk+INPgsEgaBMqBdTTFnIJXnYTz6MynuFcIfEQ02ay1nm8rWlnZfxBcxg3uYtLugs9TlfEsSh5mpVwIApl8KlrbYGybANEEm2JmTLkj6TUVefKhRjsZuOt0MnToUsB/G/8AVW1A==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(376014)(7416014)(1800799024)(82310400026)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	30ebRXW6CWMo4/L20es/VAhWeUPdvmrWMmxzFomxgaPy5SN15H4v0KWlLi7gCfNXsHZK/RxHQTtcUf9PZKO6PHAWUFBO+eMyr8xo1onl+ZGFTV6rtLtcdsIKDUCQ9mrHkQPEAiohXu+hCtvNDS1Yn5yzVvp2rxjbobgODr3+ffi3kW3jA/eSy860QWusctdORUcRrJ8Vq5se+GuhLwJ4ejPOpGaoUkZmn1kVi8zLn2hcAyaWnOmVD4repnYxGSr/7nyj7V0rzpW4X+lHAnhe1T8AX9HLXflPcSSwkCoj06T/R4T9ByP84FMFjmHXkkj8GkAVZznlDc5WEX53OH9DN7YCS5jX8DzSE8muBSRZyS4gk/F9eUaBQYzRrgKCHHIrFDx1dQ/uMg+SfdwubAgXI/ikZnrzaH4PFuKKgkQ98rPomcIhTKVsj3gBUsRnG52C
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 11:25:54.1379
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7a23602-4894-429b-ae83-08def151fb38
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6059

br_nd_send() parses ND options from ns->opt[] and therefore needs the skb
to be linear. Commit a01aee7cafc5 ("bridge: br_nd_send: linearize skb
before parsing ND options") ensured that by linearizing inside
br_nd_send() itself.

Move the linearization up into br_is_nd_neigh_msg(), right after
ndisc_check_ns_na() has validated the message as an NS/NA. This makes a
linear buffer a property of every recognized ND message, so that this and
any future ND message handling operate on a linear skb and cannot
reintroduce that class of bug by forgetting to linearize.

Since the skb is now linear by the time br_nd_send() runs, drop the
linearization there and derive ns from the transport header set by
ndisc_check_ns_na(), instead of recomputing it from the network header.

If linearization fails under memory pressure, br_is_nd_neigh_msg() returns
NULL and the packet falls back to normal forwarding rather than being
suppressed.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Danielle Ratson <danieller@nvidia.com>
---

Notes:
    v2:
    	* Add a comment noting that br_is_nd_neigh_msg() also linearizes the
    	  skb.

 net/bridge/br_arp_nd_proxy.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/bridge/br_arp_nd_proxy.c b/net/bridge/br_arp_nd_proxy.c
index 445c930ed59b..6b6de0eff38c 100644
--- a/net/bridge/br_arp_nd_proxy.c
+++ b/net/bridge/br_arp_nd_proxy.c
@@ -235,11 +235,17 @@ void br_do_proxy_suppress_arp(struct sk_buff *skb, struct net_bridge *br,
 #endif
 
 #if IS_ENABLED(CONFIG_IPV6)
+/* Validate skb as an NS/NA and linearize it for br_nd_send()'s ND
+ * option parsing; returns the nd_msg, or NULL on failure.
+ */
 struct nd_msg *br_is_nd_neigh_msg(struct sk_buff *skb)
 {
 	if (ndisc_check_ns_na(skb))
 		return NULL;
 
+	if (skb_linearize(skb))
+		return NULL;
+
 	return (struct nd_msg *)skb_transport_header(skb);
 }
 
@@ -259,7 +265,7 @@ static void br_nd_send(struct net_bridge *br, struct net_bridge_port *p,
 	bool dad;
 	u16 pvid;
 
-	if (!dev || skb_linearize(request))
+	if (!dev)
 		return;
 
 	len = LL_RESERVED_SPACE(dev) + sizeof(struct ipv6hdr) +
@@ -276,8 +282,7 @@ static void br_nd_send(struct net_bridge *br, struct net_bridge_port *p,
 	skb_set_mac_header(reply, 0);
 
 	daddr = eth_hdr(request)->h_source;
-	ns = (struct nd_msg *)(skb_network_header(request) +
-			       sizeof(struct ipv6hdr));
+	ns = (struct nd_msg *)skb_transport_header(request);
 
 	/* Do we need option processing ? */
 	ns_olen = request->len - (skb_network_offset(request) +
-- 
2.54.0

