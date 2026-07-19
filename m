Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012016.outbound.protection.outlook.com [52.101.48.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE4F27E07E
	for <bridge@lists.linux.dev>; Sun, 19 Jul 2026 13:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784468148; cv=fail; b=epZC8B7hYpwdm4mwKIP7I3XlQykUGNcXKKivVzExc+YxI1UPMv5eW/8qoghUR7fZAlkSvPt+WSGp6SBn5rcqEn1mcwJMrkH6mtB8nY9wscJcLvFExRK8HBKWQqI2/sAWd67lrWH25rvzc2Vi0lg8PA0oVxH7jKVZP+Zg3MbSins=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784468148; c=relaxed/simple;
	bh=uK0fotdcb2uHAsTZJTUIWQLeke1J0CAY8c2P9B9c8i0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dNn6wJyr+f7pywP/e2ZSBonYuyyautxBABU/yS5SE8SGRSEvHkNj4QiI0KHd4b1+DQhoDE3KfXwfc1kJ3SfZITm8cAYzpk/IT5+6KgP69M5W+xRwAuxpQFkySXdBt7K+m1vAUfjN0yGahc615qZMrT5FB/KgH5Kl53qPgj8r51Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fuyMxjYL; arc=fail smtp.client-ip=52.101.48.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fuyMxjYL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tR54hu/sQUiNHPTVwTo4I+8xv2JnwAvXRYU5NXEMndHP+792iY3P+BED3eiTXkKes36yJIQ7H4wAiApX6+pKEFc+GiSJsg/xUgNQaBGEU+gyxPWWM0OXfMbbkmIThbIV5hrCIUPlh0cUS56FlromHrWCo/VPrBAn93ucZjNJyMQGu3tPkYIS6NGtWwqeo7uX0htMrxTNL3kbFZVt5uvsuYRINy49P7xgECnD9kEsL2+sINyr7M2rsSPVLu3YyFLjEn7buwotiayaDMriAeoQHKyMh4axCnPPmb+KuqceUrpYo3/eGTF7JEUDOFZf4z2bTWxBu+Ozjby5B9+RzfzpaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zZa8Xz6TwN3nCzvrg5E/leVt7WVX239o5S0f0OKHta8=;
 b=GdiS/dfA2DowJNc+KVHyC9FeiyWjREn9bykfEXTtnfitVm1GHc1WWqDSPNkjBeacWClRfiCVqzGSRNIvK07z0Ak7HpLpxd4Zgf/leaF8llTrUCSAWUmu5UGK7qRAQS5+55lWkVboSW8Ypu7F/cDjt/LHeSDnSA0WEMfnSPhI4EVG5RuH5uX4oy6BZlZSBuRH6ZzmT0s3MsIAkaZE/xKClPLZx7ikTdoSsOrr77mu4PihO7o5Ft6nyR0b0OjAXf2RcmstOCBdPgAJXyiSEwoI4f04x58hVHOPJb5qmGgrJtcmLOnt3Qjt9QD9z+L+DxBYhnhQQAAM6ICVjW5j3Wysiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZa8Xz6TwN3nCzvrg5E/leVt7WVX239o5S0f0OKHta8=;
 b=fuyMxjYLVNErQDr8E/Obv2sBsorkcsgQsz9s0COOad09qktm7mftq6ovAvxP2mq9xdk1VO2tqK44p3h+U+2mhqyGBkbgy2T7G2F2MnZXig5AWRNs/rVKGcqgvxFibisQeTUzIZuyE3Pmm1cAT7jKzE4sHNiFNP03yafn7i2nlzJCkpzIeKWYBO0ZD14PzWa+jvxqgBn9l9B+ka+TZnZ4LqGVieCNWjGsQva1bSvMiDrB2caQXzdJ7M/8ukryutkSAD+mVrYGQ40bOTnVNP8CQGRsy4q+Luv9zJxxEH2eSdadL2ItO29UtyX2i1o5eQKanR7VmG2Ow3aiscBxN8JW5A==
Received: from PH2PEPF0000385A.namprd17.prod.outlook.com (2603:10b6:518:1::7c)
 by DS3PR12MB999240.namprd12.prod.outlook.com (2603:10b6:8:38f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.14; Sun, 19 Jul
 2026 13:35:40 +0000
Received: from SA2PEPF00003F63.namprd04.prod.outlook.com
 (2a01:111:f403:f90f::6) by PH2PEPF0000385A.outlook.office365.com
 (2603:1036:903:48::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.16 via Frontend Transport; Sun,
 19 Jul 2026 13:35:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003F63.mail.protection.outlook.com (10.167.248.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Sun, 19 Jul 2026 13:35:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 19 Jul
 2026 06:35:27 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 19 Jul 2026 06:35:22 -0700
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <dsahern@kernel.org>, <idosch@nvidia.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <razor@blackwall.org>, <ja@ssi.bg>, <petrm@nvidia.com>,
	<fw@strlen.de>, <kuniyu@google.com>, <bridge@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Danielle Ratson <danieller@nvidia.com>
Subject: [PATCH net-next 3/5] bridge: Validate NS/NA messages using ndisc_check_ns_na()
Date: Sun, 19 Jul 2026 16:34:53 +0300
Message-ID: <63efa708b4b0bd9edb3a6f6a521cb5022c43aaa5.1784463131.git.danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F63:EE_|DS3PR12MB999240:EE_
X-MS-Office365-Filtering-Correlation-Id: d13faf4a-8b1e-4de1-53c0-08dee59a9fe2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|36860700016|82310400026|1800799024|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	SUbrF7TaUwEOV3Ktob64VK6IQSZkFYQWTzzeuy3NqnIvJSEeHA2bAmCEongyGuQgqzH77WNpXQk0caapjSEbKf89TV/ndAk4LyQYzT/weJDgRATBeubJLTIH0AdjkiMScxrFr0lHL9PEt483v3cZpqBnqNYA/WxU66awf+nE6S6E2a0Z5ay8V+kmRndnS6ZfstFwkO3TJ9mjws7qLoy1vwvDccE+pzAv3NlMwKXopVPOB2n0B5VIeJYayjjPW1f9QPUP+9Wynsf399gOzGlI0ze9n0cHdShaSwTDfhqgiU0jXituB37unFu2K5SfM4XUrvC5/6ps3GDwH4z+c8lJY29k+FxMUNni9YOqdFjST6DIDTgt6EiBul5W3C7JuIvBdAmEmb1ybPz+2Cn/5Bp0j0no0HpF2n6nfg7kVKaZBuyVD7o8tXxSyp/d8K2Pj1EtpLePAEXV6ow9wSHRhSipM+fDeMyRvYG6cJbA/LCpYqQrG2aMEH+5Oka9NNe1jBAxGdMrEgA6LsecpmyG7ZbqD80mS9dMrqw7zeGLWZ/WO6QLkNyl8xHYlGmDdvWOpHSn0x2OLxPZvOTPi90FAYcc3SxDpGQmVbdw+nt8RbMeTBlr/3oIKUntQ5PlD60jqc9c8cxGGw7E3O+eJ7kjK5LWIqj8k33dOwQMQqi/7GYa8tW3tC/QrTPd3eSg6ifIsHW+Mrw1vDUHIG2EZYH4Yt6RmQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(36860700016)(82310400026)(1800799024)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	miK+75VQ7BrUjFOw1ElvJGHNs8slrFpgWVT/BCGhVZFumIN4/HdJwEHcR8DGFpCOaAJq2tIDo/cBueuLqhnR6MaXx+xTVviYKRBxWkoU81g7lwaUeqk/l/HJNY9rJNSlN6lWKeoOo3yKx1E+qLISO3zBF7w3FxVYUMttU9tOGI/nyNlYUV7JDIClr05Xkp7og/oghXdWimDxN8cX2aQxLj5UuPDJj8TnSJBs0cYQ1otfMTkAbOaMLGPesHz3PYBXc9yoR82gjfuS9zdd1JUDrK0ItDcMqE7IcnREvr6ZdPjUg1dij1idC6676/ZML+MaQTfwAfdibeH0n+A8Lpch5Ie/MIsuJgVhXBfHPAipVmobX1P4xEOGUJY1WV3+qgTAqc8YqguOWylSKGyojkYSwu+pnAzCKeeBZIRWqZ+diPSKA+Qm9KFYQyYrq95JQqPZ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2026 13:35:40.1856
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d13faf4a-8b1e-4de1-53c0-08dee59a9fe2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR12MB999240

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
index a51246747537..81b807487dcc 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -2365,7 +2365,7 @@ void br_do_proxy_suppress_arp(struct sk_buff *skb, struct net_bridge *br,
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

