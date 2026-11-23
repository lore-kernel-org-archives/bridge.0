Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.14
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795456873;
	b=a5S0KURu2cw0zDAUvwMxkMzxj3X5wWsrXrLjeUtU2to59VmZR8EwHT4aNpDumABWy3R8
	 CjFhWZLqV0UnPixBqW4cO8hRb6kcmCV15pgcmwm27e5gH8EmfDfJWcHc7q4kVH65lXwFp
	 Ax4fHKS9EBRGwQcliRI1puNoDms/S6uQbH2D/mxO0ImZi8EMHBse0nfOfFoNZyOYihtPf
	 hssVyJQDud2OoUfgkqfmL7EzscnPOBlpog9MgDXJy3Bxub2EyiskbcsZ1UKaVTnfuDXML
	 mFS12lK9D5pwac1aaJVQnqm5XqnydjG9BlCG2Vf3GiyAq9OuklNNJ6SmB2pPq0z5fEA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795456873;
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
	bh=RDTkZ1eMIXFu/Bv2oSq6QS/QWxbySeCZ1ea/d0PHslE=;
	b=l765OIh1avBdmiwFz7PEtfHyn3Nb0SI9eWJgT+BvopLvBWfF5TlmLoozHns00jDIlx3d
	 zHSa6jYmS9hEbw9je1vES4OY4hksNd5tr/fmyZt8pjnPNBh2UEL/6eU0rK6Shu0WrxTA6
	 akjMOQIyyNcc1O6vHtjWAxqt3GxBxo1oMWf/fMUz28Xtr5nNXVXHUiSiazNa6yEd/dn98
	 93qnaLnMbVjWluANlRvad2LMj8Ye+7gZH54LboZ8DV1JGzvaOaxOTLLDWq7C6gmVWkqh+
	 aJZmIJRDjGtVIS2Jr8ZD+tDlE/jt43+coPdHyVySBjG+PFig8JzwhNvcNjPvYi0I2JA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=b++C8gnB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.14
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011014.outbound.protection.outlook.com [52.101.57.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC5E606A31F
	for <bridge@lists.linux.dev>; Mon, 23 Nov 2026 18:01:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FC5E606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=b++C8gnB
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mVsRQsB7gb96o01WTNgyTihL5l8UsCTfqJGPttF/UN+TtEAWDtcO14Sft2XY6jmN+HCcpha70gtDoh3KjdywPCOzjLe0ru+QEiEKLSt3X2iwH34mivmTDKIvl2suqfdzAhc5eRV9CWelGdkRzH/+peVVtEvJcglpUSSpHvDHA6j4UHxiO3UWRfdwBVo35BJGVyGDEO46auLcL0QKD0qKze1YpxbgUnzrX+nLe6BbnJ/rF91nLtcW7NeIIY0s9Av3VTIOozfHh2S5AlQq519u9Dg3kYH2mgciDNXJzTBLOwlR090pjo7oX4AtpNDOIW9wNVGmgveQtat4TiFmhqooZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RDTkZ1eMIXFu/Bv2oSq6QS/QWxbySeCZ1ea/d0PHslE=;
 b=nOdo5FYzyF8X8WMmgwJgOqzj3lsfVVAVhyxfQEcsYq10rxETVjSmWb9aJtt0Qy1eKOVcyChuKlX8wYuZy7XIou9EGV0+1ne//4vFUwGniDVevhTQQxjx9SzlHQNfUtssEXaZmxhj5ahf3F2nFNQs3F5Y3QZzZf0V6YCr7Rw/B0qX7Zo4uAQ4X2pwEpX8u3+/4BUgmmPWpLo9RN/we7HaXn4jiiSW59Ecl9yYds1WlQhaYPGlFsFXsvh5xmoAysIUXK3KbdsxLgJUvZhqb0wAzAEogFMSWyhhoqqCJZkWla2hUawj4yNO67q3ZYdx+H+6KmDHJATnIrHvSypmTXZsaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RDTkZ1eMIXFu/Bv2oSq6QS/QWxbySeCZ1ea/d0PHslE=;
 b=b++C8gnBfJz/XfvUywPcSBK1YktHTC3YREKqaX5q1dxuEQt6+IUp7wq+Xpvn2nj/7UZ0+Q782pVzAsrgPD3S8MmKEF6BMijH4Al6npZiKa7DNSiKrao2FjTF87gzcdKKAigB7OMMjhlooGPnEA/9ShAs9/r4KJPtHLUiGND6LvXfzY6kRK/hMtIB1yRbq9uG4EggpB81+uy0Fg7Hz3Iaz8U3RMZdc4pJ5EysmBAlfH7o/LVUhzEF22bgYr4N0A6Jso8HGCthad4fIt8FA548GJj6gLJoAxje/Eed8mTKJd5/fHfppILGM+c7rMv1lxyFvUmNmNzbgn+U4iTE8dZ/sg==
Received: from PH0PR07CA0111.namprd07.prod.outlook.com (2603:10b6:510:4::26)
 by IA1PR12MB7687.namprd12.prod.outlook.com (2603:10b6:208:421::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Mon, 23 Nov
 2026 18:01:04 +0000
Received: from PH3PEPF00059616.namprd05.prod.outlook.com
 (2603:10b6:510:4:cafe::a1) by PH0PR07CA0111.outlook.office365.com
 (2603:10b6:510:4::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Mon,
 23 Nov 2026 18:01:04 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 PH3PEPF00059616.mail.protection.outlook.com (10.167.243.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Mon, 23 Nov 2026 18:01:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 23 Nov
 2026 10:00:38 -0800
Received: from tuxedo.docsis.vodafone.cz (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Mon, 23 Nov 2026 10:00:33 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	<netdev@vger.kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, Nikolay Aleksandrov
	<razor@blackwall.org>, <bridge@lists.linux.dev>, Ido Schimmel
	<idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, Andy Roulin
	<aroulin@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 07/13] net: rtnetlink: Report port ID in bridge and VXLAN FDB notifications
Date: Mon, 23 Nov 2026 18:59:22 +0100
Message-ID: <34ecc6cb67b6a4003f74211a7c7f7a0e12a328ae.1795447450.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: PH3PEPF00059616:EE_|IA1PR12MB7687:EE_
X-MS-Office365-Filtering-Correlation-Id: ed282010-b46e-471c-66eb-08df498bbd95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|1800799024|376014|36860700016|6133799003|22082099003|18002099003|11063799006|261026121527099003|261022105027099003|56012099006|261026140227099003|261102123227099003|261021121427099003|261028144727099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	S/r4Un60/9hYI/f1dGJp5D8l4cgSUvWNSQyj0yeYzoD1mFspQdFmtfTymVWe5nGiLdfeycgIz/ss8fX/Zt7bZaX3EPXcitbpdI9XwB1mWL02I+DC//ZcZ0J1NYgVrmncV8eIxOfpkcvNRU092dNOubXerwXxzh9XQWpveexnkzFJByGsah0AXzosgxPKh9Df6nmj692dH5vzJ96/ZhiULxQ+/MCTm/h9xu8H5USPJhxEISQec+YnNIEtoDNjqbM+ZUrtEuytoO2oGeyhe/n64THZzgLGJX0zW35F4JDTixdVHCjgPdRlgOwEP3p/OrwXuGgpGSpQwHGxz0gkgqir4iAlM5/Wljx14fUCPNFMWimCRV8ULHawbcVTFHqdKL5BuXBSfznTmWbmm3+NrFufX22RRvkjEMkEcLriQUDKcq4W6uCP8rfqDE/o78jP/0RTuhFG+zoEnR5xdAlzx0/VMSGyTAeZaQXoLWh0AhG/FI6U09k+bruqvhNYiCjERrd+JZkzo1QUVlmafr+0e51mLxIRwfr5zX8RMf5iBGcJ2ozOhy6o1ECjgeGYEPKZK03Nzn/rx2NOiEGdLhtpPfZV+FPhn+8vxwZSJvPnGVHzVFjpbIKl1Mc8NNEdcpkQpsWqmgDgqYsGCj00sUV+3xoYEsjJQkI7F49Q3zaflIvLVPXg5Ojc4ozfb/AW++ETMbLOvCfca5E9IPrfFjJq4GUVGA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(1800799024)(376014)(36860700016)(6133799003)(22082099003)(18002099003)(11063799006)(261026121527099003)(261022105027099003)(56012099006)(261026140227099003)(261102123227099003)(261021121427099003)(261028144727099003)(261021123027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	u/vyD2EVZxxxcDVIg59o0WJcfBoJAzzAcwsPiZ3+U+SIdF+3ihgKrqGL5wPiYjRqf1XL7xOjVJXWNNPdD4Wt4VFjeh1XFXjFoZz8cTY1LHMjJhYxhVnj5uopvvRRYpgYcReAzV4LtSXJzTXVGVthcqcSHCGynlR8gyxf9w6qPihSScg9Bw3KbrdELBMnfNLLejJjSXB6pG6y9Uq0TWow7fOtdxbH/mDs7cBS5zFp9Dm+bBjpuMczF/xUrzZFQda+OnnLyWnYwiBBVlTQFjcxrdGByTS9W2xaYdVcZPSPHpEC7b8UeY+pyniVTGatzMAYmCcsnZwi1Wu3YKx25H7KPDNUc5i4U8uIiqSi3k9szwnheVFptDo9UtiIwKnBsUj57VrLM/4Fh/xsYjHhx0vFjjoz9stZYug1GQ65DVwrtTo5nteoDmBrX3qxpmFrzrDm
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 18:01:03.7073
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed282010-b46e-471c-66eb-08df498bbd95
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	PH3PEPF00059616.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7687

Commit 7b8f7a402d4c ("neighbour: fix nlmsg_pid in notifications") made
neighbour notifications carry the netlink port ID of the process that
triggered them in nlmsg_pid. Similarly route and nexthop update
notifications carry the port ID. This allows applications to tell
their own changes apart from those made by someone else. For
notifications related to FDB entries, port ID is currently always
zero, which makes this sort of notification filtering impossible.

After the preceding patches, port ID is available for bridge and VXLAN
to use by way of the struct ndo_fdb_parms' portid field, and the two
drivers pass the value through to the notifications. The field itself
however has so far been not initialized by rtnl_fdb_add() and
rtnl_fdb_del().

In this patch do that. With that, the RTM_NEWNEIGH and RTM_DELNEIGH
notifications that bridge and VXLAN FDB send carry the port ID.
Notifications that are not a result of a netlink request, such as
those for learning, aging, or switchdev events, still carry zero.

Bulk deletion (flush) goes through ndo_fdb_del_bulk instead, and is
converted in a separate patch.

Drivers other than bridge and VXLAN, which implement ndo_fdb_add and
ndo_fdb_del but fall back to the default implementations, still
report zero as well. That also is converted in a later patch.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 net/core/rtnetlink.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index f31549923848..e0d411c251aa 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -4857,6 +4857,7 @@ static int rtnl_fdb_add(struct sk_buff *skb, struct nlmsghdr *nlh,
 		.addr = addr,
 		.vid = vid,
 		.flags = nlh->nlmsg_flags,
+		.portid = NETLINK_CB(skb).portid,
 	};
 
 	err = -EOPNOTSUPP;
@@ -4927,6 +4928,7 @@ static int rtnl_fdb_del(struct sk_buff *skb, struct nlmsghdr *nlh,
 {
 	bool del_bulk = !!(nlh->nlmsg_flags & NLM_F_BULK);
 	struct net *net = sock_net(skb->sk);
+	u32 portid = NETLINK_CB(skb).portid;
 	const struct net_device_ops *ops;
 	struct ndmsg *ndm;
 	struct nlattr *tb[NDA_MAX+1];
@@ -4975,6 +4977,7 @@ static int rtnl_fdb_del(struct sk_buff *skb, struct nlmsghdr *nlh,
 			.dev = dev,
 			.addr = addr,
 			.vid = vid,
+			.portid = portid,
 		};
 	}
 
-- 
2.56.1

