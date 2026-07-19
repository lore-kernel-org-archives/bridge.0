Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010041.outbound.protection.outlook.com [52.101.85.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E154427BF93
	for <bridge@lists.linux.dev>; Sun, 19 Jul 2026 13:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784468140; cv=fail; b=XF+zlJhWV5DTnoiAwGwqSBVo4Z7eVoMBQGuHfFmAZSmMbcQ2w53bt6pZ7Q7CrJ06h35GsZskMKBWlHTQtn8lcJgsxToOfzH5YL3SeqgJiRkDACNfwZq8vrde5UJo46jWkdY7E/LPpNd4sf9vsHFptolOC5JhsQlLaARpWsZrOJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784468140; c=relaxed/simple;
	bh=wAj7kqhnVnZX5uQqfa5BjR+usphdXfc3D87KO0HJ/xM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aU8EL/Y+GB1bugY4lseRFun/vrZl9u0AyhtQlsj3GlAcOqF3D3z/0uXlJlTz53TmSp4R5RXUm5CqxeuItZTMnbHXeNQjd4dm087F+AABObqNMJNVi0MHogCYRjux9/pK50GYfKWIdx1mT1ut51vhiydqFJONJNid2aPCZo6Jjb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aj0KDEaI; arc=fail smtp.client-ip=52.101.85.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aj0KDEaI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t7WfGxgO2su5RL9xCcOy6doZyQyMh/kOTM0KBVK4tcZYfEBd8q+cV6CG2kjzC4QuCRmzuLMgeTssPeNEV72Fw5AccTnJ/2u42Q6dBtco7wlCoFN78C8NCsGU84oAbXSdkM1T4wcaVYpVmKZUmoB+nUiUbvARIRj/vN1aRj7T0KjXjMnZ8JVcFLuTIv7kbLYSARbmKYHxBV/pxTUiGutAepU9B1b/+LCgsR5Tlh4IPijtJpPyFe+WcLh+/IOvGtFrq8YpGom4CdGd9SEogip8Mv9/geN7JKZoLl1zPu7KTtOglbiTn74Qpb8kaABrB51FNrWCjN1AHvYAVpT3iBBByg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vco+rl/Q7CE9zaX0iCacf3e1PYO3Z++FbWcalzMAQec=;
 b=vg50hNCiQVUANQu5FEFjKqUAjZH1AWXOWji6JsCMMF5qU/sNICYk0PLfebNjOGCuDpo8UZUzLr+UZ2qo6f3HbCJ4xz+fUCjcdsD6OVea5aXcTJy9w5+FZIsr8XIttqMxXmwHH2AsfD/pwBpIMv9on4mGqIpuXcMa/kopkRx3orDIb8e6nXMF1kJqFchINQYyCjYFBo0Pbfh/kNypCuY5enQWSVd3Tq7Xv4c64OR2CCA8pqhfoW2andcn5kdnTZKOqQF93Vm3AkfDNfrRmpZZH+LzMP8xmKDuA9RRYTYEVs7teWXY4c9ZMZ469KyyWYvk591wbGute0FsXG2JYS8KQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vco+rl/Q7CE9zaX0iCacf3e1PYO3Z++FbWcalzMAQec=;
 b=aj0KDEaIj3Og5+Qix/ZPduRU3A/zR1IV1hQ1VNgamj4Io677vCi7L9jv/5lyhd9F/2M9+0+vJSEiC4UMpHbjCw2mqLd0JwVwpNLzjxurD/V/NkQY0PwDEpOgTZ1jC5L8zWCHD9ezXaADTS5mr4G6CweZZgQgd8mDAdhB/hcW3cZYyMPs4NKx2pSCfudMasnG/SMLPeg/9bOGxgAB3oBrDClZDdf2Xw5NDbIsi0d81HYdzf/Fke/DmH4AkNRzHYT8a9i20/Ist17CN1Flg8U/RkVp6kACaP+w0DL8mcrvKhUTsmmr8tiLdwjyK8mS5kwhfO8yemZAmRJmQOxXv5z8tg==
Received: from CH0PR04CA0095.namprd04.prod.outlook.com (2603:10b6:610:75::10)
 by DS5PPF016FC81DF.namprd12.prod.outlook.com (2603:10b6:f:fc00::644) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.16; Sun, 19 Jul
 2026 13:35:33 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:610:75:cafe::1b) by CH0PR04CA0095.outlook.office365.com
 (2603:10b6:610:75::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.16 via Frontend Transport; Sun,
 19 Jul 2026 13:35:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Sun, 19 Jul 2026 13:35:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 19 Jul
 2026 06:35:18 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 19 Jul 2026 06:35:14 -0700
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <dsahern@kernel.org>, <idosch@nvidia.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <razor@blackwall.org>, <ja@ssi.bg>, <petrm@nvidia.com>,
	<fw@strlen.de>, <kuniyu@google.com>, <bridge@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Danielle Ratson <danieller@nvidia.com>
Subject: [PATCH net-next 1/5] bridge: Use direct pointer in br_is_nd_neigh_msg()
Date: Sun, 19 Jul 2026 16:34:51 +0300
Message-ID: <c710e4a236e69868a59c969bab31e5f29cfc0e86.1784463131.git.danieller@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1784463131.git.danieller@nvidia.com>
References: <cover.1784463131.git.danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|DS5PPF016FC81DF:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fc07b9b-ec56-4e32-cdf9-08dee59a9b65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|23010399003|7416014|376014|18002099003|22082099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	K3x8FB5OvOSOcwGeX8PmoH9lY+DelCtod8oHljKeiYajStNWUxOkzgInmZ/z0sE5L238jtsOsC+wxwq8teeC0EBV8yNTBxnH/Q/Gfhta3SHisbQtNWzKqiHxThXYKcN5QLO5b3yTUsJF9sFbm6HWlxnEV4J4kutg1Zq8xEuTl5umqh14ICPwWpKUva2B0dL/xMbURR4KauiLUMD6A7UUGdhKTCLmYmhpKCGCHplOCWDZU7HAgQBQrKguzGXjwybixWYihwM3q2pc31UgtIvAYeJL26Y/+RO4RJcI419XweTEdGR9Yk/j4GY06QMd91iuAPJVSPfvGfo8vJrvWa+lZNUco3tl/fFOyBNRCdKUay0hQrhvXEzIQHSNZrjmjJziNiaMxrH8RJlNIawG7VIBliTfrsXF1+0/V0WjAZwZXVJ9d8Svx6RQ3C0jCoiQYDv6vHTdkp/Kr7kRTntT5eeN7Y1CjB++sWflWZieGGp5XeZ1HfHvPz2laZmekWa5wIit3pudTIMhNG89YoXPtvkBBXAbYwrX1/g+t3eWxV/pNLvHVHggqQ0cCRYssu/uNLnjBu7ASAlLmaWs4YaJpFTiP36Q3aEMBLC5/sGzMzcG2WFBK9pM8wkjesRVCH2zNqtEquoqEOkSnqIEq+q+49+EeLslpim15XzIy3g++ZTJEL5Qd3q1byyR7NgPiGBsBBb+B2Q10btD2ULHSYqE6IELUw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(7416014)(376014)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	SWCIGy0zT/jlMksGKyi66lXQ566DXmWjJOPlsKVghoB6NfQnvuQJEe/9EROXBRskJB9s/H9oCNxH5vQUiLLs3FWMH9quwjiv3dB0dOoecdcBOkYthu6uNJnxYE65oQu8WYQz+IwghoPjxCc4iRsHvxkLIWosJTLe99lFCLH3yAhsuk0Vq69Hyw3XI+Oh1GubuxUdnhLEbpLwFIbM2b5Qlt019yJ3VNmYXTXXP6m7LDx/qzPmlMWlW5qeZFizqp85wYM3EBIQZ3705Zc+2uVyeoheMGcNWDaXR3HjY5NYVk638l4QjdXdwAsm7bdfTB86TWbbIvNjprFgqRFda+gCn3I3S+tQvpVla0lr+wU9LvLDxcpAUlY6WaPaUdV7SOnQXiP3GDSVeyd46Ggdju/F7HAepQaCsObmxTUbCICO8F/4uQppPBMpv1su7XDmgmR6
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2026 13:35:32.6354
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fc07b9b-ec56-4e32-cdf9-08dee59a9b65
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF016FC81DF

Both callers of br_is_nd_neigh_msg() already call pskb_may_pull() to
ensure sizeof(struct ipv6hdr) + sizeof(struct nd_msg) bytes are in the
linear area before invoking this function. The skb_header_pointer()
call and its fallback buffer are therefore unnecessary.

Replace skb_header_pointer() with a direct cast to ipv6_hdr(skb) + 1
and drop the now-unused 'msg' parameter and its corresponding stack
buffer from all callers.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Danielle Ratson <danieller@nvidia.com>
---
 net/bridge/br_arp_nd_proxy.c | 9 ++-------
 net/bridge/br_device.c       | 4 ++--
 net/bridge/br_input.c        | 4 ++--
 net/bridge/br_private.h      | 2 +-
 4 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/net/bridge/br_arp_nd_proxy.c b/net/bridge/br_arp_nd_proxy.c
index 23eb6931a2b4..db08c3272001 100644
--- a/net/bridge/br_arp_nd_proxy.c
+++ b/net/bridge/br_arp_nd_proxy.c
@@ -234,14 +234,9 @@ void br_do_proxy_suppress_arp(struct sk_buff *skb, struct net_bridge *br,
 #endif
 
 #if IS_ENABLED(CONFIG_IPV6)
-struct nd_msg *br_is_nd_neigh_msg(const struct sk_buff *skb, struct nd_msg *msg)
+struct nd_msg *br_is_nd_neigh_msg(const struct sk_buff *skb)
 {
-	struct nd_msg *m;
-
-	m = skb_header_pointer(skb, skb_network_offset(skb) +
-			       sizeof(struct ipv6hdr), sizeof(*msg), msg);
-	if (!m)
-		return NULL;
+	struct nd_msg *m = (struct nd_msg *)(ipv6_hdr(skb) + 1);
 
 	if (m->icmph.icmp6_code != 0 ||
 	    (m->icmph.icmp6_type != NDISC_NEIGHBOUR_SOLICITATION &&
diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index e7f343ab22d3..ff55dab73632 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -80,9 +80,9 @@ netdev_tx_t br_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 		   pskb_may_pull(skb, sizeof(struct ipv6hdr) +
 				 sizeof(struct nd_msg)) &&
 		   ipv6_hdr(skb)->nexthdr == IPPROTO_ICMPV6) {
-			struct nd_msg *msg, _msg;
+			struct nd_msg *msg;
 
-			msg = br_is_nd_neigh_msg(skb, &_msg);
+			msg = br_is_nd_neigh_msg(skb);
 			if (msg)
 				br_do_suppress_nd(skb, br, vid, NULL, msg);
 	}
diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index ddb8f002a40e..d87a5f9fa92b 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -176,9 +176,9 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
 		   pskb_may_pull(skb, sizeof(struct ipv6hdr) +
 				 sizeof(struct nd_msg)) &&
 		   ipv6_hdr(skb)->nexthdr == IPPROTO_ICMPV6) {
-			struct nd_msg *msg, _msg;
+			struct nd_msg *msg;
 
-			msg = br_is_nd_neigh_msg(skb, &_msg);
+			msg = br_is_nd_neigh_msg(skb);
 			if (msg)
 				br_do_suppress_nd(skb, br, vid, p, msg);
 	}
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index f8f77a2d4891..a51246747537 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -2365,7 +2365,7 @@ void br_do_proxy_suppress_arp(struct sk_buff *skb, struct net_bridge *br,
 			      u16 vid, struct net_bridge_port *p);
 void br_do_suppress_nd(struct sk_buff *skb, struct net_bridge *br,
 		       u16 vid, struct net_bridge_port *p, struct nd_msg *msg);
-struct nd_msg *br_is_nd_neigh_msg(const struct sk_buff *skb, struct nd_msg *m);
+struct nd_msg *br_is_nd_neigh_msg(const struct sk_buff *skb);
 bool br_is_neigh_suppress_enabled(const struct net_bridge_port *p, u16 vid);
 bool br_is_neigh_forward_grat_enabled(const struct net_bridge_port *p, u16 vid);
 #endif
-- 
2.54.0

