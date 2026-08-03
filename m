Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010000.outbound.protection.outlook.com [52.101.46.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D813B6C18
	for <bridge@lists.linux.dev>; Mon,  3 Aug 2026 11:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785756346; cv=fail; b=PQkXN/fKo+UoHFCO0o3dF3Vqzedf/a+JNBm4CrwJcrvP4m6imn0GYAbt3/rfyx9JxVok/fTdhmmDXoxa9wAdYVrvXDOrgocSZCNLffnwXFTtdD8+DIByErC1Xj/oijDBzvVRIrFg4Uwvb4Y5k9i1vEkWiLG8xys3MSVsrzvz59w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785756346; c=relaxed/simple;
	bh=S/C0jxqid/DI6K8aM3dzz7cRcHNweovqUdx0IFhDFeQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TQCHXmPZVnnktjgJNBF+zzY6u6Qs8KthfbKZ6bqU9SOWEVltlECpFNi0fj/j+NJO6087q180x4O7YMRv+UKaCDR64hguRfg1MLJ5vmR3PCwbRJqfEO0k166zFMBA0CMFCLib7SWw0dD3I6+ahU4ZmOxaQjNy8VdUOyC7avbI4V0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WDUZjqQy; arc=fail smtp.client-ip=52.101.46.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WDUZjqQy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PyodJAIjn+EN/ZE50m9URR138fktib/u53vXyM1VWUy1h0YX34LdyAJwLMxsfvky9OGFmFRf04TXxDuu1c5kmZ56ovmbMZ8qVss4E5cbGaSrtWS8i1c8De5j+HgB4I/Ny+7pUehdZlb15hEl5el/8fWrqR/NWqchsyX7Lu3d4+w6XcwEI+23EbcFXuzUP4aiQFtYgfFtwWVcGcVnI3HpzXnOEaxw818t5JFJyeL90hDEBkIbD29qw1HVXZdS8UiAxTyJ8xkdzDzpluavgyA8ldHq4lxf74dd1WnhJiRQn+ry3U+T7+d7Uk03nCFWE36h3wIymmOGdc+CkANBImSqFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n1FQSqiCe4Chh7xPc+dCuUrByWlhJLcOONkFNzskHs4=;
 b=Er2fYISwu9PQi35MbBE8utdu+/ymAEsAN6/1Wsu2mfc0ei8chEkHH49gVsPaNeoJK2FPfvxvjeXRVQcD9HxL8AXKI7dvwigLu6BbmbDKVAj/CiQXvDjnKofEuuV2uGxUwBwGdc/GCIDXImtz6HAkWZ+HHs7gPFFIRxg+u+55IqMTEQ9jG7uDOkekYX/CrAvbAR25fS32EWJ73Ly6q0a2ITeeFaPuP4i4EaxHJvbqUnE2a7zxlUEdkHH9bnYF8wMUF9CIljecUmnsyKMTXz6iDpxkLM/f8uI22azQOUMBvijsB89aoPmANJATMUq8oCcHI3MYrFeEnRYhIIDfEt8cog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n1FQSqiCe4Chh7xPc+dCuUrByWlhJLcOONkFNzskHs4=;
 b=WDUZjqQyX+lG6b0FR2BIb/Gw45P2nSj6/ONnNvRTDeSvRHPnIVo5o0d5YpWZUmFcFTBxdsHLfeYGRdXmC0QUR9TgKmf10nN1OUKVLWe5vapxA9IzGrDflX28z4M+Jak8zj1mUIeYvevQX4ItL9odiYxYkudYyYpOXUXcri9THZ9EsQCV3kJfGrZoKW+0Xfkk5Qk78w6TLVdGxg7VOcCDaVPoTxCKKhj4YUiGWhBNtsRR6YX5BvxKinWM8qO3KeHAX/VymN/oQgAtvdBEbQhzzN9A+hZn+SAmbNPpUjvWEFIMZPXMnTE8UW6+/kZHY6hBFpPlonaW9rXRjW3IORSPnw==
Received: from BN9PR03CA0749.namprd03.prod.outlook.com (2603:10b6:408:110::34)
 by LV0PR12MB999093.namprd12.prod.outlook.com (2603:10b6:408:32e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 11:25:41 +0000
Received: from BN1PEPF00004685.namprd03.prod.outlook.com
 (2603:10b6:408:110:cafe::13) by BN9PR03CA0749.outlook.office365.com
 (2603:10b6:408:110::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.17 via Frontend Transport; Mon, 3
 Aug 2026 11:25:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00004685.mail.protection.outlook.com (10.167.243.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Mon, 3 Aug 2026 11:25:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 3 Aug
 2026 04:25:28 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 3 Aug 2026 04:25:24 -0700
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <dsahern@kernel.org>, <idosch@nvidia.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <razor@blackwall.org>, <ja@ssi.bg>, <petrm@nvidia.com>,
	<fw@strlen.de>, <kuniyu@google.com>, <bridge@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Danielle Ratson <danieller@nvidia.com>
Subject: [PATCH net-next v2 1/5] bridge: Use direct pointer in br_is_nd_neigh_msg()
Date: Mon, 3 Aug 2026 14:25:01 +0300
Message-ID: <20260803112505.613873-2-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004685:EE_|LV0PR12MB999093:EE_
X-MS-Office365-Filtering-Correlation-Id: 49f04d08-66ba-4dcf-ea05-08def151f381
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700016|23010399003|11063799006|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	JpGF031hLcr5D927rKs6naqano5qUKXAlveyrdlaXISOPJEPZ4nX89JRy6zhMufoEHaMHzHDz18k+DKiNYwgrbFf/xNutgupAEog61xGAZHFZ9VsmeRNop5qLYEByX+woYqjqukdxKN2PEgg7EXXXbcsLb+QeslFpkURp9GGyzNihPsHsraL8TWDlFNcZceBkyiRoIgiAgAjPAHkxAfx/qcCSew1asmMJHrXaWvgJLKSVWI22E9JO4GifgMyN/J26rFsceEanHpUtrDIPUICgbYK0+NNjF2TPIXNPQFeD3ocdw+S+mW0z96YjfMFfcCcSQK3dA+k78CPpgn5UByxZR8iVERb8yjFf87cPsYqe+6cLgMeVgv6rPQcnB86iHC2duhloBc8WmU8ab4sziMuxllSphte7MhGRmlobn7jtnu2nMgGDVxMUrLGcmZa/kWOl5YCjt/MEz6sEsGegAHygXaNlNJEQz0ocG4aXCMUBmmUe/l2+KqypFHQmdR8Mf6lVQDqa2M7PQ3FE8Eze9qVigCkk5VpVQoPq6TI6E+eipRCLMIBXZQjHTXl/2/um7tea23pRRgbrKWkokyYdOazHMLnvfwLZdtTtUZiH8/vWPxcZqio9830YoA9N7Y5Xt2a6gMJ3ZaB3CUAIAUN2udTmj0tnrTFf/XMIRmbhDl6mIVvHRiXkiiQsZ3TP4nylyC5oT6Eiu27VrEGz+/Eo+V1CA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700016)(23010399003)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	obApSBVvR5LLSLDhG1TgRBBdSVVeUiwB0rR+7i89ZW4LWUH9XQgIXy1shvTvfqbiLpUbx3dURfBCAMoUMKREGrElRlvrRQ7GUViikZg+tooCkCMOtSRRMQuF4UGITlMwHdguhN5nmqIGalPw+67akAJ0NqOhJNlb1mogGLLiCPSZuAQtAna0MwfEh42p3D1NuOw6e7TIa1YJMMvJY8hkzW08SLpUNXfy8CL5ndzLjw/a2xBTLAvo4cEWliVAO0c5BVfwPZISxRvrmQsLLITIr+uvpIVWoZKG2raPjoXRt8eoS6bDlsiivR6Oep1+BUPaxi8+lioV9eUgAugy+IOBXsNXtQ4fTVBxCJzIS63r5siOfzS77uqN3+HcS6LonR5V/5rJswC9vX2LRjAHAu4zzsjc8kx0c0e9nWJ+1D21vtZIdsZS9GpVHIc+IO+mIlnn
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 11:25:41.1214
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49f04d08-66ba-4dcf-ea05-08def151f381
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004685.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB999093

Both callers of br_is_nd_neigh_msg() already call pskb_may_pull() to
ensure sizeof(struct ipv6hdr) + sizeof(struct nd_msg) bytes are in the
linear area before invoking this function. The skb_header_pointer()
call and its fallback buffer are therefore unnecessary.

Replace skb_header_pointer() with a direct cast to ipv6_hdr(skb) + 1
and drop the now-unused 'msg' parameter and its corresponding stack
buffer from all callers.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
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
index 4cf8b1ab9047..e31439cb4420 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -2367,7 +2367,7 @@ void br_do_proxy_suppress_arp(struct sk_buff *skb, struct net_bridge *br,
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

