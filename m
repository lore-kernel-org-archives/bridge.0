Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.55
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795456893;
	b=f9c4Cu//pDlfyUu5gMxqWuSrW1WUW9txDbJJU2f/6tqq7MRkSLHi5MmWN+5NSJ/8JVvx
	 bUhzo6SX3PrVEQegu2VgNUD9qGFVCu7SdTAmgmeRfgMe5d+5AaA6Rm6/Kn+pI/1W3g2ys
	 IYijq2Ye+jhrkz46AfPTNCyIdMnT7EHavHvW5xbFMFDl6wZYJrcqP2YDwMszFUUwUrXk6
	 Rougv0u2neeigarEWvwC1R8/kDWKf9UygbDGrjaot/wAh7Oe12nf6agevvBYRY5pn2TWf
	 SY4w+MVmidZWXjSNzapIHRmZlVcdTTDHdxSj9cBrdHmkqbum6KSZEBXFht4BQeHxjhQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795456893;
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
	bh=z4+fTJ1ALCioLtToCDCPQRkj38i6aG8oqJw8tpFNsUQ=;
	b=y01GtLkaUhGucXfJ8EvWZNWsHdCOSuU7gYghU+IlZvDfe4pMigGzi12wkkUoN2fQ7KWP
	 Sy8SDwXPA35YCESr8ENcOulueCUOohNSxkrENRdt5SmtG7eu7O92l27ggFe40JJY53ysC
	 Nnoy/uhuJGgLpVVaEQb3PLvOBKbjaRo/9EUBNTG+SBzZMBlslKe0U7dPqRsKH3RRgAPpr
	 UeE7aCAEk9jbnvVb5iKPKTb6TJWZMkdEnHhjAE5/owK4kUcH8ADLkKOwnAGYjz9I3bP7P
	 JQy2JnhD9zJAI5bd7jLLWJlKwhxdDnxcbs/wWH+LpGx4tMjcnVh03IHq+QbZR2Egeqg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ERdSzdMz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.55
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010055.outbound.protection.outlook.com [52.101.56.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3924606A32E
	for <bridge@lists.linux.dev>; Mon, 23 Nov 2026 18:01:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3924606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ERdSzdMz
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=suONFLWYcz/7ynm1l9+kgferkNWUTlQrDjE1qwJ+C//54ljsFRoyMCmJuP6OJY+Yx3FU1L04Z+sByge0zYIneLGw105djGg0tqczAtcIXrAlGOnXtTMXsEVlZZKUE8Sx3nxOUlIf/dsoWZySD1vejTMnWInVFZR1EF8vQELI+FGGD1yOHoQBnpx0zF6JQi48GFzrvapi0CpCmaiaxfO5N+V+4cQHfx6stsBnnIfjHKG2rb5KtRad7hFYFuGo1w7DKScNCRqAx+4hHk/M1QVwzIdZ2I1jib/RmKquqgcqu6ynhAJgAqFuzNcb2qFr4U112QG0HHDth6bA+xTCSqjmZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z4+fTJ1ALCioLtToCDCPQRkj38i6aG8oqJw8tpFNsUQ=;
 b=tPXIMhDkXbflj9qTFhgxsh6iRXDVhy2IzkJTQlwq6mfrQbEslYs0/QunUs9Rgf4fUGB/BaLv5/rQcW9DMSCwrgvL4qal14y/s0lsSPpUExlhBTrRtVe8D440IQ5pHQk9/eIXInPm1B8+a0FdlvWRk6Rc5q5GboCjBXErCDMBSEz9PGx1Ys17I7uZF5s9mqx2dEQduhDBdgRM/gNiUctdT07tI6GNQ4HS/iGYOYcqgR9ckb/UQhnetazLC1DdV5jxQOs0VnMt245eMVuQxpf8Vyw2YrTEMlbeiuufH6fVmYMDXqeqbO65MQ4WhXzw/vD0lrxGjt0tYxgsd5hM/i3Yow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z4+fTJ1ALCioLtToCDCPQRkj38i6aG8oqJw8tpFNsUQ=;
 b=ERdSzdMz2juY9Vp+K8eiEhsORyCZ0q3j45hEl1JRNPpvTcSHQ9OQeKVFbpHeNeVLYmhJRPdtCXFersIo/9QhBhvgKnAWT88HManFX0dD6NrX2YRUl9wXO7UlVUfHa3opSGNHIN5VtzaAmrkxArwEegTVQhL/dZ8IAfanywiszDd5YyONF+ek6aw2TA3kssVYl8FBSqYvSZnrpgqDE/kbPwi2dx+J4Q3zRJOyS+WGpM3CzIvl+pgCC6+BMCJTKvjSB9lDprEtGQOyBw2cgKmmeEALbY64y+i2nNR5uLHIFSM/ZIdldO9UZf1VDVUrIhuNzMoQcbDTXeo5u2JKWr8weA==
Received: from MW4PR04CA0115.namprd04.prod.outlook.com (2603:10b6:303:83::30)
 by PH0PR12MB5629.namprd12.prod.outlook.com (2603:10b6:510:141::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 18:01:26 +0000
Received: from MW2PEPF00014678.namprd04.prod.outlook.com
 (2603:10b6:303:83:cafe::15) by MW4PR04CA0115.outlook.office365.com
 (2603:10b6:303:83::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Mon,
 23 Nov 2026 18:01:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MW2PEPF00014678.mail.protection.outlook.com (10.167.249.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Mon, 23 Nov 2026 18:01:24 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 23 Nov
 2026 10:00:49 -0800
Received: from tuxedo.docsis.vodafone.cz (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Mon, 23 Nov 2026 10:00:44 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	<netdev@vger.kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, Nikolay Aleksandrov
	<razor@blackwall.org>, <bridge@lists.linux.dev>, Ido Schimmel
	<idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, Andy Roulin
	<aroulin@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 09/13] net: rtnetlink: Report port ID in fallback FDB notifications
Date: Mon, 23 Nov 2026 18:59:24 +0100
Message-ID: <ce28bc74da6b7af6f3c719749479072b00003611.1795447450.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MW2PEPF00014678:EE_|PH0PR12MB5629:EE_
X-MS-Office365-Filtering-Correlation-Id: 66a4bc8f-c305-406c-0858-08df498bc9fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|261102123227099003|261021121427099003|261021123027099003|261026121527099003|11063799006|56012099006|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	/pjdl0RphU/fdgraF3sTecbLg1KUnQujUp3V8ZFysSlJM3x0VIk2R4Fraai7hGK6ouggnSPznKNiFGRFZIDrxbJK+gSeaVCdjprsoyhDVK8ICEzn1OgWtdZiyAieajVuX8Qrbv5gzzoZx7cAW6j5VKD/fjAKa9/cYjnWiRi1CfNE8kB76CbCqv38woBskgpSOe6xaIhVqcC8VN4mxfrtZd5UF3EoxuXq/Gc+Gn4ZeyRKXXXyv8qP8fn1GjsNASRsJsSXXt5GOy41DcWwP/ljQbcv4gIQDstrnuQzqhdigWy1O6uhOjethhtBLslAw+3N8WWo8xVt2PEP2zWdUHDb4E6S+sC3Btm/TlzacQMvDDpoPkJrLGFf+4LkQl0l7vi6Pg+fWm9Rw5tZR7U4o+oI4mxIwIoqTlMPA5HjznPXKUtzJqq1GCtFNoIDKNVDi2T43En85PAU1CALfD63tnUubtTkGa9WlqEP4CzTjTh4cwhR+4RcyHtTbZCDC87YNiU+g7B6BcOx6JCCXv9bgoun34UDfWn2kziEjGAlr2NlGyzG9oiqhpKxVR09YAsyMq1JRXrilD8z8JY7VHzPyNdvw0qIs0rSkLJnmxHZewwlpHuaEo1n2XMwaiRuOrTpi19X/vRBp5aSLz+ki5bqiqzDVuDowH2M85zjsoTx8Y9681iE6SQrqS3HFCRI1mbvnSU7cklnTsZFKrRPq0AlTAgrDg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(261102123227099003)(261021121427099003)(261021123027099003)(261026121527099003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5BzAuBFx3CZW1u1ViATf2dGAsb6Dkj6V5d4LGSS67urA2WTYeDvBsKU7f7ei86tt+3H45iKOPR02Q49G/2wI1INxPdvBYheZL1Fbouahdc140SNh7+Bugu70DOOw0trND7sEAtikKv4JmtEw/45EK4/IVTEs+YQoS5xtoIIiIMO08sxaGBH0bwd97aArvxGx+jLxWTh6mf4odylG8flgXwDiwzPb2s7Le7c61Zp0PCJNT0LTO5kt98mV5w7gfedxGJTY6gGqDXhdLBUOPK3bfiHCtRowbxs1DXuI9CISZ/Wb8TSIjZujYmITyq/5xBf/ugxY+BjIlsS8IdAu1xXGSr7EKTAio1eN4oToASmaUXODRhTvtIdqWn1xdSwFz2RBDRHFvhQdNXJGeBv2/egAlyu1AMHpLJsGzt82JUrOvN0sLNR6LCKXlMtx7tF3rXhJ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 18:01:24.6787
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66a4bc8f-c305-406c-0858-08df498bc9fa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW2PEPF00014678.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5629

The previous patch made the bridge and VXLAN drivers report the port ID of
the requester in the FDB notifications that they emit. Other drivers that
implement ndo_fdb_add and ndo_fdb_del, as well as the default
implementations ndo_dflt_fdb_add() and ndo_dflt_fdb_del(), do not send
notifications themselves. Instead rtnl_fdb_add() and rtnl_fdb_del() send
one on their behalf through rtnl_fdb_notify(), and that always uses port ID
of zero.

Pass the port ID of the requester to rtnl_fdb_notify() as well, so that
the notifications sent for these devices carry it in nlmsg_pid just like
the ones from bridge and VXLAN.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 net/core/rtnetlink.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index e1607a3232c7..51713666f0e3 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -4721,7 +4721,7 @@ static inline size_t rtnl_fdb_nlmsg_size(const struct net_device *dev)
 }
 
 static void rtnl_fdb_notify(struct net_device *dev, u8 *addr, u16 vid, int type,
-			    u16 ndm_state)
+			    u16 ndm_state, u32 portid)
 {
 	struct net *net = dev_net(dev);
 	struct sk_buff *skb;
@@ -4732,7 +4732,7 @@ static void rtnl_fdb_notify(struct net_device *dev, u8 *addr, u16 vid, int type,
 		goto errout;
 
 	err = nlmsg_populate_fdb_fill(skb, dev, addr, vid,
-				      0, 0, type, NTF_SELF, 0, ndm_state);
+				      portid, 0, type, NTF_SELF, 0, ndm_state);
 	if (err < 0) {
 		kfree_skb(skb);
 		goto errout;
@@ -4888,7 +4888,7 @@ static int rtnl_fdb_add(struct sk_buff *skb, struct nlmsghdr *nlh,
 
 		if (!err && !notified) {
 			rtnl_fdb_notify(dev, addr, vid, RTM_NEWNEIGH,
-					ndm->ndm_state);
+					ndm->ndm_state, parms.portid);
 			ndm->ndm_flags &= ~NTF_SELF;
 		}
 	}
@@ -5033,7 +5033,7 @@ static int rtnl_fdb_del(struct sk_buff *skb, struct nlmsghdr *nlh,
 		if (!err) {
 			if (!del_bulk && !notified)
 				rtnl_fdb_notify(dev, addr, vid, RTM_DELNEIGH,
-						ndm->ndm_state);
+						ndm->ndm_state, portid);
 			ndm->ndm_flags &= ~NTF_SELF;
 		}
 	}
-- 
2.56.1

