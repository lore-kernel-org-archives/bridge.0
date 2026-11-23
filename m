Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.24
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795456881;
	b=Au12IW/cpG+S/ZMPKx2t+/V+NZNPwYo4YhoAuTyBDTTNzUwe9s/IkDuw9ijPwe8POlmY
	 RyNKTMokbgJKznMDWMmABZS9pI40JPgiWd4B+KWU5+9azTNbslMp8pWcKP5M7e6qr6bbm
	 I/Lv+qz3IX1NYyhSxJVinKTr40n54nh7hIXnAIv7w6AUJB0lxRn3h8OkbqM3a2HCj1vzI
	 5KzS9zDGpoqHLIR0Ytmcjdv5DccTODURK3Qq0aFhsKc+B4+rgKehuEWa5hLA3uTqe233e
	 TIx7Rw0LIJbJawW4jhY2Y0bsUv1KJmi7KJz8yHCOkacM/372F8gF4YoTBgME5TSTScg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795456881;
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
	bh=tcVSgzsDPYtPo6ifBpa5mo5AAdp2jz2LHlPQ31geHCs=;
	b=hQLu3oPgz8A+IEwm7+8yDPbA08UjP5whhGdn2FMtCozPrdOu5RxmpcjPcX1jF96FA8LI
	 PsK4AkQcHz6vvEMSyQggye4qTVO7fazrmqQZ20bzZ68zIsp/gOlzcPpvR8kEEFi3KntK2
	 FOIToIquNn2P+VHhkOtVmkSlI1m/2qsuAT0JDa6k/7VhRIG9/aWCIR5TZW7W9YqLfsPrM
	 lQYrg6Nko8s2+MkuD+0aO5848KwmDqvStwMTY65Iz+MFXzn4HIP2fT4rnRXYiVWBct6YH
	 V952saB6teiEeKeOj/Ymb+I3Gyjilg7lzHyYMmDJnP5ptM1mg4oezd5K2PG4nxjhhFw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=YUJyeVPB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.24
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010024.outbound.protection.outlook.com [52.101.56.24])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FC3606A327
	for <bridge@lists.linux.dev>; Mon, 23 Nov 2026 18:01:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9FC3606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=YUJyeVPB
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M7J4dRLUbbWnxspNGT58Jq6J71KS0NnwXckkGYr4PRPbgjz/60UL4ikh/RVm2p6W+mB0rdKnFtBmbT3SpCQmQagt5FKUu9pQQT8D9GAcOSI9fv1i/SQ2pg+QWv4fWG16SqalLnt5/VTP8zEdT21hzbRAORzqAe6T501hJ2pO9VB+FtKOqqYNDzsyPGF9vumU7z87IWKjhkNR10oOGcmNwmLvLWJ0cjytrPpHwab8o8AcYK6aQAmHJGjHkE37iD545OCRN6MmlQe5L5o6ow8KHVI/17Jo3evoV9zOX1tXUkSeoFbtgyrdRn1P3T47H4DaeErFFj0msfxdz60o330dEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tcVSgzsDPYtPo6ifBpa5mo5AAdp2jz2LHlPQ31geHCs=;
 b=iyeJzS+NtG/gnYgRdUkRVzasQD1fA5jCEb7Gsfl/8hBb4t6mDQsjtDhUOUeVNwA6Jr/beEJieLBZyThDdvJr6gYzXkiuWWNWB/5ce3ED3wD1Gf62jpWnLhTywTdXRXbdiBnYGjmcMNBdNPXZYSy+0ifFzA6NcAShgQwN+9GpPL5HoeollcsDNd9wPjsX7/4vi/QyTfedEPo35cVoCK6dNNlovsQXroiP4/4WkmnII6CCU8pi4/rO6vpjlMupvM8Xpd8EF3Wee2ZYsTZkxnEpAOOR51fElck7PIacOic3229L6tCJdbvZ+1WnKU9dkee9yTjVA7aFd5AwqmJPcKXvww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tcVSgzsDPYtPo6ifBpa5mo5AAdp2jz2LHlPQ31geHCs=;
 b=YUJyeVPB1pjaT/Lt82LVyA47qg12iS+4MvfqvLh6BQunSFZZlFUi8MX94p/kdWPVj1+izPzAEFzMR7p4SpHwu1KX2sjWIyUlKyAVZ6BtV0tRsixqMbW3Zb7QrxdC7MmFch18Tmyjosp8D4V1PYb7gb5AQSsY90WugA3XzX8lrRC1tpMJoDHbWmEwZ72TeAfxo8hGgpyNJEQ3LkptC+WPd5lC8gsymnj9bOuBV/KttRLtbr1q/0bvamR3HyIgonCR+hykKipDzA1cJHeQXPxn7DHceXgFPOKk5fvGmTHWZ7MO6BXNgQzK1tVHZbKx71GRIBQwBOUq6zy2IWckxQGWYA==
Received: from PH0PR07CA0104.namprd07.prod.outlook.com (2603:10b6:510:4::19)
 by CH3PR12MB9341.namprd12.prod.outlook.com (2603:10b6:610:1cd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 18:00:58 +0000
Received: from PH3PEPF00059616.namprd05.prod.outlook.com
 (2603:10b6:510:4:cafe::68) by PH0PR07CA0104.outlook.office365.com
 (2603:10b6:510:4::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Mon,
 23 Nov 2026 18:00:58 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 PH3PEPF00059616.mail.protection.outlook.com (10.167.243.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Mon, 23 Nov 2026 18:00:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 23 Nov
 2026 10:00:33 -0800
Received: from tuxedo.docsis.vodafone.cz (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Mon, 23 Nov 2026 10:00:28 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	<netdev@vger.kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, Nikolay Aleksandrov
	<razor@blackwall.org>, <bridge@lists.linux.dev>, Ido Schimmel
	<idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, Andy Roulin
	<aroulin@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 06/13] net: vxlan: Pass portid through FDB notifications
Date: Mon, 23 Nov 2026 18:59:21 +0100
Message-ID: <5a6f82ef0a2bc105d18b5a4d825417bead282aa2.1795447450.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: PH3PEPF00059616:EE_|CH3PR12MB9341:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f5365fc-d312-4afd-b3b5-08df498bba36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|18002099003|22082099003|3023799007|11063799006|56012099006|261026121527099003|261026140227099003|261026135527099003|261028144727099003|261026130827099003|261102123227099003|261022115727099003|261009223027099003|261022105027099003|261021121427099003|261021130227099003|261021133027099003|261022075727099003|261022113327099003|261021123027099003|261021135927099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	r3a6/ugjyug8KTMdHc3vl3MhNoiOjinxgBiHpAP8mokz31h2H9NqvWF3WBStBSzC2JBjkjPFxD6bwf97cBFFibsGkyw4zBcRPpT2cxCEXL/pnr/O0de9Ny7JDWKJU+l8sgzA9GMliPyOVYeOh25927H209ZlJXvkkraVnxiZTeyJJHO1wL0PBOEMhIthmyuvxqpP8/pNviQv9FL80rMxFrc3XVRM7GqR/oFG9z6W2pMqg9zAe53GJUUgTgjPP8B5ZofpU3+1+ufVRIL3GkLQnRu6cRGLebDFI5ZR0vCJvW1RPiWhHSCP0UV5DnyZqjT2At4NaF56oIajSrCsflm4mGTI57+A5KvbL2dHPwXx6NjSBY1gd1AVPmny22lLvmOJ+aWtWMZobInkPrW0msLvoKck69SOIPfPyOXpATIFvBY/vCCSXLvKEUUCkA9OBLt898TBfwo7IXymT7e9STZLQxtxBLh001BAL285ZZJ4Sh/NsSxImqYCJ08jyELOqSCJWiU1qnIHgMKMwxhdoyeVwBXm6nCAJSQWHlumkVoOd2sb2Qua3zo9d9wCplesqYO5qjGusb10VI3X/E/k511QNppDOhvgF0XAzed2yjkHUb3SlGuw6Nm8eBbgfnxMaKLvmvvdSYDmHe0SQQH3oxN6YegObejXGV8E9lJPdl1xuuRZxclgAAsWFO9qPR/ljDOBMgBU1RHcYEionBWGLNDY1Q==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(18002099003)(22082099003)(3023799007)(11063799006)(56012099006)(261026121527099003)(261026140227099003)(261026135527099003)(261028144727099003)(261026130827099003)(261102123227099003)(261022115727099003)(261009223027099003)(261022105027099003)(261021121427099003)(261021130227099003)(261021133027099003)(261022075727099003)(261022113327099003)(261021123027099003)(261021135927099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dhRi/95ZFsk1Utl63/ogK3m8yPCIsTNn1wjnmTinUlQlBIM7XqGAVOI0yuaBzX+KHjQCnFa9qwHvsBXgiAvXA/e38NPAcs6msr2yIfqtUxyNjAEy8hWqai89SgkHw7Q6OqMRg4uI+3jRtKi9v1hOwjY7Ri+vBX/gxGwFWlm29hUOQzLcEiJb+ZBazC3+FqygcGz0ojC8pLk87TXsbawiBFLU278cDoIo8JvitTy3Mes2Hycx6n4/Dnk92T/xa5/vcplStYOFku1a7MIxixbrE67l7bOAyVrfx9XCJ0sOMu9Z42iZV8QuDEYoQDvan6JtRqxdTxefIwNKnJOZ13ZuehPfOC77babuqjzbZrsKY9nRemMwtjABoXSV0TL9jSAR4dER7NHxLxIHecVkMcEshIiZDBTMHni/qKavl3r4TlM8wZ8xMMrc9nNn170vZT3A
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 18:00:58.2409
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f5365fc-d312-4afd-b3b5-08df498bba36
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	PH3PEPF00059616.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9341

Add a portid argument to __vxlan_fdb_notify(), vxlan_fdb_notify(),
vxlan_fdb_destroy(), vxlan_fdb_dst_destroy(), vxlan_fdb_update() and its
_existing() and _create() helpers, __vxlan_fdb_delete(), vxlan_flush() and
vxlan_fdb_flush_match_remotes(), and use it as the netlink port ID of the
resulting RTM_NEWNEIGH / RTM_DELNEIGH notifications. Where both portid and
swdev_notify are passed, portid comes first: it is part of the message
metadata, similarly to the message type, whereas swdev_notify merely
toggles whether the switchdev notifiers are called.

vxlan_fdb_add() and vxlan_fdb_delete() pass on the port ID of the
requester. All other callers (snooping, device stop, changelink, VNI
filtering, switchdev events, as well as vxlan_fdb_delete_bulk()) pass zero,
as before.

As rtnl_fdb_add() and rtnl_fdb_del() do not yet fill in the port ID in
struct ndo_fdb_parms, all notifications are still sent with zero. No
functional change intended.

I considered passing struct ndo_fdb_parms down to vxlan_fdb_update()
instead of the individual address and flags, but eventually decided against
that. Only vxlan_fdb_add() has the structure at hand, whereas the other
callers would have to construct a throwaway one just to pass the address
and flags. This makes them longer, not shorter, and the callee would still
need most of the VXLAN-specific arguments separately.

Packing the VXLAN-specific parameters (remote IP, port, VNI, ifindex, ...)
into a dedicated VXLAN-specific structure might benefit the VXLAN driver in
a similar way to how it cleaned up the NDO interface. However this was left
out for potential future patchset.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/vxlan/vxlan_core.c      | 89 +++++++++++++++--------------
 drivers/net/vxlan/vxlan_private.h   |  5 +-
 drivers/net/vxlan/vxlan_vnifilter.c |  6 +-
 3 files changed, 52 insertions(+), 48 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 725c6216d56c..a010eb8f7f28 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -265,7 +265,7 @@ static inline size_t vxlan_nlmsg_size(void)
 }
 
 static void __vxlan_fdb_notify(struct vxlan_dev *vxlan, struct vxlan_fdb *fdb,
-			       struct vxlan_rdst *rd, int type)
+			       struct vxlan_rdst *rd, int type, u32 portid)
 {
 	struct net *net = dev_net(vxlan->dev);
 	struct sk_buff *skb;
@@ -275,7 +275,7 @@ static void __vxlan_fdb_notify(struct vxlan_dev *vxlan, struct vxlan_fdb *fdb,
 	if (skb == NULL)
 		goto errout;
 
-	err = vxlan_fdb_info(skb, vxlan, fdb, 0, 0, type, 0, rd);
+	err = vxlan_fdb_info(skb, vxlan, fdb, portid, 0, type, 0, rd);
 	if (err < 0) {
 		/* -EMSGSIZE implies BUG in vxlan_nlmsg_size() */
 		WARN_ON(err == -EMSGSIZE);
@@ -329,8 +329,8 @@ static int vxlan_fdb_switchdev_call_notifiers(struct vxlan_dev *vxlan,
 }
 
 static int vxlan_fdb_notify(struct vxlan_dev *vxlan, struct vxlan_fdb *fdb,
-			    struct vxlan_rdst *rd, int type, bool swdev_notify,
-			    struct netlink_ext_ack *extack)
+			    struct vxlan_rdst *rd, int type, u32 portid,
+			    bool swdev_notify, struct netlink_ext_ack *extack)
 {
 	int err;
 
@@ -349,7 +349,7 @@ static int vxlan_fdb_notify(struct vxlan_dev *vxlan, struct vxlan_fdb *fdb,
 		}
 	}
 
-	__vxlan_fdb_notify(vxlan, fdb, rd, type);
+	__vxlan_fdb_notify(vxlan, fdb, rd, type, portid);
 	return 0;
 }
 
@@ -364,7 +364,7 @@ static void vxlan_ip_miss(struct net_device *dev, union vxlan_addr *ipa)
 		.remote_vni = cpu_to_be32(VXLAN_N_VID),
 	};
 
-	vxlan_fdb_notify(vxlan, &f, &remote, RTM_GETNEIGH, true, NULL);
+	vxlan_fdb_notify(vxlan, &f, &remote, RTM_GETNEIGH, 0, true, NULL);
 }
 
 static void vxlan_fdb_miss(struct vxlan_dev *vxlan, const u8 eth_addr[ETH_ALEN])
@@ -376,7 +376,7 @@ static void vxlan_fdb_miss(struct vxlan_dev *vxlan, const u8 eth_addr[ETH_ALEN])
 
 	memcpy(f.key.eth_addr, eth_addr, ETH_ALEN);
 
-	vxlan_fdb_notify(vxlan, &f, &remote, RTM_GETNEIGH, true, NULL);
+	vxlan_fdb_notify(vxlan, &f, &remote, RTM_GETNEIGH, 0, true, NULL);
 }
 
 /* Look up Ethernet address in forwarding table */
@@ -945,7 +945,7 @@ static void vxlan_fdb_free(struct rcu_head *head)
 }
 
 static void vxlan_fdb_destroy(struct vxlan_dev *vxlan, struct vxlan_fdb *f,
-			      bool do_notify, bool swdev_notify)
+			      bool do_notify, u32 portid, bool swdev_notify)
 {
 	struct vxlan_rdst *rd;
 
@@ -955,11 +955,11 @@ static void vxlan_fdb_destroy(struct vxlan_dev *vxlan, struct vxlan_fdb *f,
 	if (do_notify) {
 		if (rcu_access_pointer(f->nh))
 			vxlan_fdb_notify(vxlan, f, NULL, RTM_DELNEIGH,
-					 swdev_notify, NULL);
+					 portid, swdev_notify, NULL);
 		else
 			list_for_each_entry(rd, &f->remotes, list)
 				vxlan_fdb_notify(vxlan, f, rd, RTM_DELNEIGH,
-						 swdev_notify, NULL);
+						 portid, swdev_notify, NULL);
 	}
 
 	hlist_del_init_rcu(&f->fdb_node);
@@ -983,7 +983,7 @@ static int vxlan_fdb_update_existing(struct vxlan_dev *vxlan,
 				     __be16 port, __be32 vni,
 				     __u32 ifindex, __u16 ndm_flags,
 				     struct vxlan_fdb *f, u32 nhid,
-				     bool swdev_notify,
+				     u32 portid, bool swdev_notify,
 				     struct netlink_ext_ack *extack)
 {
 	__u16 fdb_flags = (ndm_flags & ~NTF_USE);
@@ -1057,7 +1057,7 @@ static int vxlan_fdb_update_existing(struct vxlan_dev *vxlan,
 
 		WRITE_ONCE(f->updated, jiffies);
 		err = vxlan_fdb_notify(vxlan, f, rd, RTM_NEWNEIGH,
-				       swdev_notify, extack);
+				       portid, swdev_notify, extack);
 		if (err)
 			goto err_notify;
 	}
@@ -1081,7 +1081,7 @@ static int vxlan_fdb_update_create(struct vxlan_dev *vxlan,
 				   __u16 state, __u16 flags,
 				   __be16 port, __be32 src_vni, __be32 vni,
 				   __u32 ifindex, __u16 ndm_flags, u32 nhid,
-				   bool swdev_notify,
+				   u32 portid, bool swdev_notify,
 				   struct netlink_ext_ack *extack)
 {
 	__u16 fdb_flags = (ndm_flags & ~NTF_USE);
@@ -1100,14 +1100,14 @@ static int vxlan_fdb_update_create(struct vxlan_dev *vxlan,
 		return rc;
 
 	rc = vxlan_fdb_notify(vxlan, f, first_remote_rtnl(f), RTM_NEWNEIGH,
-			      swdev_notify, extack);
+			      portid, swdev_notify, extack);
 	if (rc)
 		goto err_notify;
 
 	return 0;
 
 err_notify:
-	vxlan_fdb_destroy(vxlan, f, false, false);
+	vxlan_fdb_destroy(vxlan, f, false, 0, false);
 	return rc;
 }
 
@@ -1117,7 +1117,7 @@ int vxlan_fdb_update(struct vxlan_dev *vxlan,
 		     __u16 state, __u16 flags,
 		     __be16 port, __be32 src_vni, __be32 vni,
 		     __u32 ifindex, __u16 ndm_flags, u32 nhid,
-		     bool swdev_notify,
+		     u32 portid, bool swdev_notify,
 		     struct netlink_ext_ack *extack)
 {
 	struct vxlan_fdb *f;
@@ -1132,23 +1132,26 @@ int vxlan_fdb_update(struct vxlan_dev *vxlan,
 
 		return vxlan_fdb_update_existing(vxlan, ip, state, flags, port,
 						 vni, ifindex, ndm_flags, f,
-						 nhid, swdev_notify, extack);
+						 nhid, portid, swdev_notify,
+						 extack);
 	} else {
 		if (!(flags & NLM_F_CREATE))
 			return -ENOENT;
 
 		return vxlan_fdb_update_create(vxlan, mac, ip, state, flags,
 					       port, src_vni, vni, ifindex,
-					       ndm_flags, nhid, swdev_notify,
-					       extack);
+					       ndm_flags, nhid, portid,
+					       swdev_notify, extack);
 	}
 }
 
 static void vxlan_fdb_dst_destroy(struct vxlan_dev *vxlan, struct vxlan_fdb *f,
-				  struct vxlan_rdst *rd, bool swdev_notify)
+				  struct vxlan_rdst *rd, u32 portid,
+				  bool swdev_notify)
 {
 	list_del_rcu(&rd->list);
-	vxlan_fdb_notify(vxlan, f, rd, RTM_DELNEIGH, swdev_notify, NULL);
+	vxlan_fdb_notify(vxlan, f, rd, RTM_DELNEIGH, portid, swdev_notify,
+			 NULL);
 	call_rcu(&rd->rcu, vxlan_dst_free);
 }
 
@@ -1276,7 +1279,7 @@ static int vxlan_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
 			       parms->flags,
 			       port, src_vni, vni, ifindex,
 			       ndm->ndm_flags | NTF_VXLAN_ADDED_BY_USER,
-			       nhid, true, extack);
+			       nhid, parms->portid, true, extack);
 	spin_unlock_bh(&vxlan->hash_lock);
 
 	if (!err)
@@ -1288,7 +1291,7 @@ static int vxlan_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
 int __vxlan_fdb_delete(struct vxlan_dev *vxlan,
 		       const unsigned char *addr, union vxlan_addr ip,
 		       __be16 port, __be32 src_vni, __be32 vni,
-		       u32 ifindex, bool swdev_notify)
+		       u32 ifindex, u32 portid, bool swdev_notify)
 {
 	struct vxlan_rdst *rd = NULL;
 	struct vxlan_fdb *f;
@@ -1308,11 +1311,11 @@ int __vxlan_fdb_delete(struct vxlan_dev *vxlan,
 	 * otherwise destroy the fdb entry
 	 */
 	if (rd && !list_is_singular(&f->remotes)) {
-		vxlan_fdb_dst_destroy(vxlan, f, rd, swdev_notify);
+		vxlan_fdb_dst_destroy(vxlan, f, rd, portid, swdev_notify);
 		goto out;
 	}
 
-	vxlan_fdb_destroy(vxlan, f, true, swdev_notify);
+	vxlan_fdb_destroy(vxlan, f, true, portid, swdev_notify);
 
 out:
 	return 0;
@@ -1337,7 +1340,7 @@ static int vxlan_fdb_delete(struct ndmsg *ndm, struct nlattr *tb[],
 
 	spin_lock_bh(&vxlan->hash_lock);
 	err = __vxlan_fdb_delete(vxlan, parms->addr, ip, port, src_vni, vni,
-				 ifindex, true);
+				 ifindex, parms->portid, true);
 	spin_unlock_bh(&vxlan->hash_lock);
 
 	if (!err)
@@ -1480,7 +1483,7 @@ static enum skb_drop_reason vxlan_snoop(struct net_device *dev,
 				    src_mac, &rdst->remote_ip.sa, &src_ip->sa);
 
 		rdst->remote_ip = *src_ip;
-		vxlan_fdb_notify(vxlan, f, rdst, RTM_NEWNEIGH, true, NULL);
+		vxlan_fdb_notify(vxlan, f, rdst, RTM_NEWNEIGH, 0, true, NULL);
 	} else {
 		/* learned new entry */
 		spin_lock(&vxlan->hash_lock);
@@ -1493,7 +1496,7 @@ static enum skb_drop_reason vxlan_snoop(struct net_device *dev,
 					 cfg->dst_port,
 					 vni,
 					 cfg->vni,
-					 ifindex, NTF_SELF, 0, true, NULL);
+					 ifindex, NTF_SELF, 0, 0, true, NULL);
 		spin_unlock(&vxlan->hash_lock);
 	}
 
@@ -2943,7 +2946,7 @@ static void vxlan_cleanup(struct timer_list *t)
 				netdev_dbg(vxlan->dev, "garbage collect %pM\n",
 					   f->key.eth_addr);
 				f->state = NUD_STALE;
-				vxlan_fdb_destroy(vxlan, f, true, true);
+				vxlan_fdb_destroy(vxlan, f, true, 0, true);
 			}
 			spin_unlock(&vxlan->hash_lock);
 		} else if (time_before(timeout, next_timer)) {
@@ -3138,7 +3141,7 @@ vxlan_fdb_flush_remote_matches(const struct vxlan_fdb_flush_desc *desc,
 static void
 vxlan_fdb_flush_match_remotes(struct vxlan_fdb *f, struct vxlan_dev *vxlan,
 			      const struct vxlan_fdb_flush_desc *desc,
-			      bool *p_destroy_fdb)
+			      u32 portid, bool *p_destroy_fdb)
 {
 	struct vxlan_rdst *rd, *tmp;
 
@@ -3151,13 +3154,13 @@ vxlan_fdb_flush_match_remotes(struct vxlan_fdb *f, struct vxlan_dev *vxlan,
 			return;
 		}
 
-		vxlan_fdb_dst_destroy(vxlan, f, rd, true);
+		vxlan_fdb_dst_destroy(vxlan, f, rd, portid, true);
 	}
 }
 
 /* Purge the forwarding table */
 static void vxlan_flush(struct vxlan_dev *vxlan,
-			const struct vxlan_fdb_flush_desc *desc)
+			const struct vxlan_fdb_flush_desc *desc, u32 portid)
 {
 	bool match_remotes = vxlan_fdb_flush_should_match_remotes(desc);
 	struct vxlan_fdb *f;
@@ -3174,14 +3177,14 @@ static void vxlan_flush(struct vxlan_dev *vxlan,
 		if (match_remotes) {
 			bool destroy_fdb = false;
 
-			vxlan_fdb_flush_match_remotes(f, vxlan, desc,
+			vxlan_fdb_flush_match_remotes(f, vxlan, desc, portid,
 						      &destroy_fdb);
 
 			if (!destroy_fdb)
 				goto unlock;
 		}
 
-		vxlan_fdb_destroy(vxlan, f, true, true);
+		vxlan_fdb_destroy(vxlan, f, true, portid, true);
 unlock:
 		spin_unlock_bh(&vxlan->hash_lock);
 	}
@@ -3263,7 +3266,7 @@ static int vxlan_fdb_delete_bulk(struct nlmsghdr *nlh, struct net_device *dev,
 		desc.dst_ip = ip;
 	}
 
-	vxlan_flush(vxlan, &desc);
+	vxlan_flush(vxlan, &desc, 0);
 
 	return 0;
 }
@@ -3283,7 +3286,7 @@ static int vxlan_stop(struct net_device *dev)
 
 	timer_delete_sync(&vxlan->age_timer);
 
-	vxlan_flush(vxlan, &desc);
+	vxlan_flush(vxlan, &desc, 0);
 	vxlan_sock_release(vxlan);
 
 	return 0;
@@ -4143,7 +4146,7 @@ static int vxlan_dev_create(struct net *net, struct net_device *dev,
 				       cfg->vni,
 				       cfg->vni,
 				       cfg->remote_ifindex,
-				       NTF_SELF, 0, true, extack);
+				       NTF_SELF, 0, 0, true, extack);
 		spin_unlock_bh(&vxlan->hash_lock);
 		if (err)
 			goto unlink;
@@ -4606,7 +4609,7 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
 					       cfg->dst_port,
 					       conf.vni, conf.vni,
 					       conf.remote_ifindex,
-					       NTF_SELF, 0, true, extack);
+					       NTF_SELF, 0, 0, true, extack);
 			if (err) {
 				spin_unlock_bh(&vxlan->hash_lock);
 				if (lowerdev_changed)
@@ -4623,7 +4626,7 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
 					   cfg->vni,
 					   cfg->vni,
 					   cfg->remote_ifindex,
-					   true);
+					   0, true);
 		spin_unlock_bh(&vxlan->hash_lock);
 
 		/* If vni filtering device, also update default fdb entries of
@@ -4687,7 +4690,7 @@ static void vxlan_dellink(struct net_device *dev, struct list_head *head)
 	struct vxlan_dev *vxlan = netdev_priv(dev);
 	struct vxlan_fdb_flush_desc desc = {};
 
-	vxlan_flush(vxlan, &desc);
+	vxlan_flush(vxlan, &desc, 0);
 
 	list_del(&vxlan->next);
 	unregister_netdevice_queue(dev, head);
@@ -4961,7 +4964,7 @@ vxlan_fdb_external_learn_add(struct net_device *dev,
 			       fdb_info->remote_vni,
 			       fdb_info->remote_ifindex,
 			       NTF_USE | NTF_SELF | NTF_EXT_LEARNED,
-			       0, false, extack);
+			       0, 0, false, extack);
 	spin_unlock_bh(&vxlan->hash_lock);
 
 	return err;
@@ -4987,7 +4990,7 @@ vxlan_fdb_external_learn_del(struct net_device *dev,
 					 fdb_info->vni,
 					 fdb_info->remote_vni,
 					 fdb_info->remote_ifindex,
-					 false);
+					 0, false);
 
 	spin_unlock_bh(&vxlan->hash_lock);
 
@@ -5045,7 +5048,7 @@ static void vxlan_fdb_nh_flush(struct nexthop *nh)
 		WARN_ON(!vxlan);
 		spin_lock_bh(&vxlan->hash_lock);
 		if (!hlist_unhashed(&fdb->fdb_node))
-			vxlan_fdb_destroy(vxlan, fdb, false, false);
+			vxlan_fdb_destroy(vxlan, fdb, false, 0, false);
 		spin_unlock_bh(&vxlan->hash_lock);
 	}
 	rcu_read_unlock();
diff --git a/drivers/net/vxlan/vxlan_private.h b/drivers/net/vxlan/vxlan_private.h
index f0ee85f83732..632e1880c0b9 100644
--- a/drivers/net/vxlan/vxlan_private.h
+++ b/drivers/net/vxlan/vxlan_private.h
@@ -196,13 +196,14 @@ int vxlan_fdb_create(struct vxlan_dev *vxlan,
 int __vxlan_fdb_delete(struct vxlan_dev *vxlan,
 		       const unsigned char *addr, union vxlan_addr ip,
 		       __be16 port, __be32 src_vni, __be32 vni,
-		       u32 ifindex, bool swdev_notify);
+		       u32 ifindex, u32 portid, bool swdev_notify);
 int vxlan_fdb_update(struct vxlan_dev *vxlan,
 		     const u8 *mac, union vxlan_addr *ip,
 		     __u16 state, __u16 flags,
 		     __be16 port, __be32 src_vni, __be32 vni,
 		     __u32 ifindex, __u16 ndm_flags, u32 nhid,
-		     bool swdev_notify, struct netlink_ext_ack *extack);
+		     u32 portid, bool swdev_notify,
+		     struct netlink_ext_ack *extack);
 void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 		    const struct vxlan_config *cfg,
 		    __be32 default_vni, struct vxlan_rdst *rdst, bool did_rsc);
diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
index c5cc6cd08545..927b63db3b5b 100644
--- a/drivers/net/vxlan/vxlan_vnifilter.c
+++ b/drivers/net/vxlan/vxlan_vnifilter.c
@@ -550,7 +550,7 @@ int vxlan_update_default_fdb_entry(struct vxlan_dev *vxlan, __be32 vni,
 				       vni,
 				       vni,
 				       new_ifindex,
-				       NTF_SELF, 0, true, extack);
+				       NTF_SELF, 0, 0, true, extack);
 		if (err && extack) {
 			spin_unlock_bh(&vxlan->hash_lock);
 			return err;
@@ -563,7 +563,7 @@ int vxlan_update_default_fdb_entry(struct vxlan_dev *vxlan, __be32 vni,
 				   cfg->dst_port,
 				   vni, vni,
 				   old_ifindex,
-				   true);
+				   0, true);
 	}
 	spin_unlock_bh(&vxlan->hash_lock);
 
@@ -727,7 +727,7 @@ static void vxlan_vni_delete_group(struct vxlan_dev *vxlan,
 				   cfg->dst_port,
 				   vninode->vni, vninode->vni,
 				   cfg->remote_ifindex,
-				   true);
+				   0, true);
 		spin_unlock_bh(&vxlan->hash_lock);
 	}
 
-- 
2.56.1

