Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012038.outbound.protection.outlook.com [40.107.200.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0833F483D
	for <bridge@lists.linux.dev>; Mon,  3 Aug 2026 11:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785756363; cv=fail; b=TxM3K2NsB9KwKoV9iT1nROx/BkQAtWo3DtWY05ybTcvEkCTKASmCxi8fAKvCG+boSl4T10KKT3QwnGVRHyT/uxtJEdMbJgb8BcHucQZZV/L7u3px+cOWZiTDa811AOUsuzLDGqcDfgXwlvDClK2TrqN83vC+4Rq+tR/VRgbCXUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785756363; c=relaxed/simple;
	bh=PsQWzvP+nZV9Ftvna2MqXGK2ppxZhIkD6HtY9y4bBJ4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G5nWkszw39ZSVH/ML3G5tQsiMNP3u4Li+f5BIIhXcvp1MSRsp/YoWppkEXotVJEr/sKWG3oc5U6OJAC902UGsGfFckkmC6ZX/VxCeb8vpptE1u4gzFV2sQFMLH5Zgw45ZQvLhcblGmT/RwLRcfojiMcBVxHVJHd2cMvw3YN9xiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GCPoYuzp; arc=fail smtp.client-ip=40.107.200.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GCPoYuzp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=htd3JvRr+RA3xvnrwEeLW/dhpue6imIcIBqjvaU4l7qbHGr6ZUdneCP0rpbS1NdEbYepFhNqkyGuWOJi3GNeCQdtjPR3DUKmHjV2B8uqrsW2IYCbPOUSZbRcDNF3CXU8L3JKstMpaNPoNoFgkJrt9+km8ewSBU2l882FjwjQzVFlp+DlxOuX3wOzQ3WWjlr2UVyrKRbWHukJsGiecAm09OKlrQZxlNZDtXkJKhAPJEhUONo210WEiUQP6KerwtspZeq0/VTAvFebixlZg0kfrQU5MoPtsM9Horr1r9iQ+Os+3n5oWzk4uWo/Z9xKITh9UBUwGmbDV4n/Eq02OtX32A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dh+D433ZcjdVYKfdRvAaAViP/sqKx+uqVJhIlVyYgL4=;
 b=getNBUd50jQ7NUz+8xsOmCpiVvzaRm2rJyLaQlgrTRIcpKUty9ftwJaMrvJpsdRuGeWNBwMrBKfhQRV/3jjA7cO0cyuPdebnVTPVdb7nIEJhyZ+TRyXlFiPTm2x4BF5niVX9oXuoCYkd0J6wP8Jj0vuZTRMsO35Cd/yCroh0jqfaVBivbKlRlizA+4RDuuhGxmCwdSYCSirL9e4HusQZE/VO/h6L3QAslQX/qfz0nGPh5TlluLu3V0VccblukLVkvQj27yspyEk9MVU/nrjiFZ4LBRSqQJy2ySZ8QAkVuzpTAbQ1jUs0ixKay8RsIxZFTc1Z6jaM1YtfmnUYr4OwAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dh+D433ZcjdVYKfdRvAaAViP/sqKx+uqVJhIlVyYgL4=;
 b=GCPoYuzpi667lDsZb+3sQ5NoCMrN6uFKfrw0ytk4ZVzQEb5BE5TTLSwbb4JROPCc0IPEqELLVqsJw/JBOhqdB5fbGC9qbhPme+jDOSVKMjl+ExU01kvJGsPygI6scLbJnQZYgFnd3OqwDanilVT5fGHyVjIldH0UoFFKILTqSisaF2QVsR7yTaqjrZIxvGHmKr4WsaBXXVJE9u3W6sPRTMKvp0yUTO/m3p4B7xHSyVzwMIa1dheFOB47LxbPNMeALDdN7w4IaE7Id7FB5MqOfzDhWZf7DcJwLGTiIuMbuJAxB2JT7KOtH7f4YgY2gCX3gSv4ma89o063lWyFqUox5Q==
Received: from SJ0PR03CA0180.namprd03.prod.outlook.com (2603:10b6:a03:338::35)
 by CYYPR12MB8939.namprd12.prod.outlook.com (2603:10b6:930:b8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Mon, 3 Aug
 2026 11:25:51 +0000
Received: from SJ5PEPF000001D4.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::52) by SJ0PR03CA0180.outlook.office365.com
 (2603:10b6:a03:338::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.18 via Frontend Transport; Mon, 3
 Aug 2026 11:25:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001D4.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Mon, 3 Aug 2026 11:25:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 3 Aug
 2026 04:25:38 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 3 Aug 2026 04:25:33 -0700
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <dsahern@kernel.org>, <idosch@nvidia.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <razor@blackwall.org>, <ja@ssi.bg>, <petrm@nvidia.com>,
	<fw@strlen.de>, <kuniyu@google.com>, <bridge@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Danielle Ratson <danieller@nvidia.com>
Subject: [PATCH net-next v2 3/5] bridge: Validate NS/NA messages using ndisc_check_ns_na()
Date: Mon, 3 Aug 2026 14:25:03 +0300
Message-ID: <20260803112505.613873-4-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D4:EE_|CYYPR12MB8939:EE_
X-MS-Office365-Filtering-Correlation-Id: 709fa420-ee78-458d-5387-08def151f9aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700016|23010399003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	rHJ9UJjK1MOPwnAjzZZtL+6O3hF7AX0hBXQ9+KHFrL0smcCyzofXUiB3VnSEcd57zhW1WINKeYwx9maunLfA68Nux70ToKbiG6VoEKW7u7pcQMAXo69ab2jmC2J68ixZZU820MxWyJISfpbfGPlX3px+Q7ZK6RYiIrfKLJNImdIAugO9SPDz4FaF11Ctqh4kIFttEyOq4YQhV6DUG0wxqBGppks/Ywe3NaLwqUzXSwxninwOSuauta4BCFHAHPKQMphQN7b5nbmHyOcZ1X/hKLXrYar1jmDzX+4atlWgqAgA2gVKF8gFUgPXel5gcVDRqpkij8BXVe0G4rjDXBH2EacaAMD50eQ8UfHz0R0dpLwXUIi8IOQWa1VBBz6cw64w5TQdOhs60yxvZXXeatMDF8XE6MiJy75QSv5dj2w0ELJ+LLOTbAKeWBzTcwtXBmLmvB1FFZlbx8VY59HKNummJ94UEPqeaOnxLhTBIFQ6jN4bheQuZfc0OwUerAh2BDsJPqlyYyhoURybEbkBS1S6vJkDIVO/VCMIj51tIVHdldG3GwpdvarDv2UNnwAsNxOTNAqx/eYSWPgUvYr0NWQg/TuUl21igkXKOwDsSUMwZRF9AEUJIU5JQpx64ig7Jc8ojD8lKP9QYtOq2SH8GP2nIO5WE95PXY4EughkADAtWdZHefNMRLut8eqtDXHY6uBSuP0dqU30tIIBJDE5Llk1/Q==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700016)(23010399003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	HGH/dRhynqaKS1Hf+RvP7UUWdLoREtPXTAPJsXuseR8j6wI2mLfP4v9rW0XV2OL15J84HGFC2MvRMTbtH/nR93rOH8F/C1qwEa3ja2lNihZp1YK9bLxP7TFarBr15hMmfqJaLQ9ncG056+7U9/19NAvv7FBEOfNr82VXIIZrd9xilrEqpC9m+aOkQO8neNPM+QDUH4L1DokDJzzP04acZc60DLC68u+CR5dS0x8H2CesYX7sBhzviyPmz9PMQtK9FXd1P0Jr3rQ970YGY6vUl4R3CmGfrwgtncdyRUUmGY9zBagkr3Fn9tR1LmsklgBRAHmedVF7ovIge/NUZgBn73e88Sk94xNX2GpJRWVObic1vGTRVZdhJGAWUM5T4evp3fxhWL9jcwnihGhkgZU7Pq/Qt51oUk/y2CYIyN1OE2o25pNp6O045oB2wZNwJLSD
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 11:25:51.5266
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 709fa420-ee78-458d-5387-08def151f9aa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8939

The bridge performs neighbor suppression by snooping NS/NA messages, but
previously only checked the ICMPv6 type and code. This leaves it open to
acting on malformed or spoofed packets that any RFC-compliant node should
reject.

Wire br_is_nd_neigh_msg() into the new ndisc_check_ns_na() helper, which
enforces the full RFC 4861 section 7.1.1/7.1.2 receive validation:
hop limit of 255, valid checksum, correct code, and type-specific rules
(NS target not multicast; NA solicited flag clear for multicast
destinations).

MLD messages are already validated by ipv6_mc_check_mld() before the
bridge acts on them; this brings NS/NA to the same standard.

As a side effect, the skb parameter of br_is_nd_neigh_msg() changes from
const to non-const, since ndisc_check_ns_na() may reallocate the skb head
via pskb_may_pull() and sets the transport header. The returned pointer is
now derived from skb_transport_header() rather than a direct cast.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
Signed-off-by: Danielle Ratson <danieller@nvidia.com>
---
 net/bridge/br_arp_nd_proxy.c | 11 ++++-------
 net/bridge/br_private.h      |  2 +-
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/net/bridge/br_arp_nd_proxy.c b/net/bridge/br_arp_nd_proxy.c
index db08c3272001..445c930ed59b 100644
--- a/net/bridge/br_arp_nd_proxy.c
+++ b/net/bridge/br_arp_nd_proxy.c
@@ -19,6 +19,7 @@
 #include <net/addrconf.h>
 #if IS_ENABLED(CONFIG_IPV6)
 #include <net/ip6_checksum.h>
+#include <net/ndisc.h>
 #endif
 
 #include "br_private.h"
@@ -234,16 +235,12 @@ void br_do_proxy_suppress_arp(struct sk_buff *skb, struct net_bridge *br,
 #endif
 
 #if IS_ENABLED(CONFIG_IPV6)
-struct nd_msg *br_is_nd_neigh_msg(const struct sk_buff *skb)
+struct nd_msg *br_is_nd_neigh_msg(struct sk_buff *skb)
 {
-	struct nd_msg *m = (struct nd_msg *)(ipv6_hdr(skb) + 1);
-
-	if (m->icmph.icmp6_code != 0 ||
-	    (m->icmph.icmp6_type != NDISC_NEIGHBOUR_SOLICITATION &&
-	     m->icmph.icmp6_type != NDISC_NEIGHBOUR_ADVERTISEMENT))
+	if (ndisc_check_ns_na(skb))
 		return NULL;
 
-	return m;
+	return (struct nd_msg *)skb_transport_header(skb);
 }
 
 static void br_nd_send(struct net_bridge *br, struct net_bridge_port *p,
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index e31439cb4420..d337b1cfb980 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -2367,7 +2367,7 @@ void br_do_proxy_suppress_arp(struct sk_buff *skb, struct net_bridge *br,
 			      u16 vid, struct net_bridge_port *p);
 void br_do_suppress_nd(struct sk_buff *skb, struct net_bridge *br,
 		       u16 vid, struct net_bridge_port *p, struct nd_msg *msg);
-struct nd_msg *br_is_nd_neigh_msg(const struct sk_buff *skb);
+struct nd_msg *br_is_nd_neigh_msg(struct sk_buff *skb);
 bool br_is_neigh_suppress_enabled(const struct net_bridge_port *p, u16 vid);
 bool br_is_neigh_forward_grat_enabled(const struct net_bridge_port *p, u16 vid);
 #endif
-- 
2.54.0

