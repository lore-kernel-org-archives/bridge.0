Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012038.outbound.protection.outlook.com [40.107.209.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498633EFFB2
	for <bridge@lists.linux.dev>; Mon,  3 Aug 2026 11:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785756372; cv=fail; b=OiSMefTpi+/PpUIoy2EzGeRPX6Akl0iQ6Vlco84+s4K4k3+ANOkfaIQJCYFIXBdLu+0WjRduYk4Sqw1fc23qXFJA07AEO9GWKwrGh2ss0O9VVmizzzFHqfluFk/mQkVspMwtIa+ZylJhuDfiapmTQn7oCZK8pEGl6CSAI82bDbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785756372; c=relaxed/simple;
	bh=qFjy9ineWjWQ9DVb7cRMJXeddCP1R5wk2Jd8BzId84g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tXXsmFhNEMqHuulFpHzJj1/BSLlUGhYEvo+HDSZXF3egrU7kvbISpoiU4qi3givkR9Radss/FWnCovDmQeRZ6b68x4YazauyeyPhgVpc9WSHgIXE4lz/9blP/bI7NH84Q2L3iJ8/RFIuXb9WBN9mKPfq+aoFruPG4C/NjxkS++g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=n9/wAY2m; arc=fail smtp.client-ip=40.107.209.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="n9/wAY2m"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P0r3wUjyXnO1Ahwl5KGcHq5aFQ2aTOvU6fJzTXiNimUoVLpaV9DY7e7PzJBAdwPi2sh8kVbfh17ndKGtxb1yvYr/bauWlbgnEQIR2h4/ue79AuZ5YvLPzb5KDpiUz0P/VUFq58CNlBYgsAmK8KfnEP5Ze9zB3WjtWIzu9yZLTy7UM7n9QgVqYLMuJyCdnVOQDc/Cis4sV//+XxoLXz8LKzJeZjyyXwGoLTh7eAEMfzaVYxzjIUfKbX26qJOpEDjZ7fCeWlei41B5W+wBvoG4mJdYWMKttcNjDI4fGJ5RZUbwNnIvP6a8BnQdOL3Ng6xu0aO/FaxzGzk3iLdIX23wxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BFKvHAQ+bIS+e+avEi8+UBCJf2WSCLF1319NYYwLpvE=;
 b=egSlloEERO3WF6aYrnHYO3KAvs6ThO84BVQVSC9k97S5HDFqSc9wf8fLRMG7BAuaixMQzG4AGYMsqSsL0dtAXsj/9VXE2PraLWimZph1WNzvGtIwhsyX0VPPY2nzY77KDyzEeqpnGYi+P0PoUnqm5dDUoTg01MKOclK0tGFZK8rUILT2/qgTmoTsY5DByA5Q9cyRd0WHJ7Ilu+AefM9ZiIG91tr3O3JQ1OGdvKAWKknyl0HdDQ8hNo6CY9u0pJBHeM4cqQr8i/TfROt9u+pjRdcc3F0ZSJ6EZrh1ZlucbLwWON+SkGXjer5SqfjcX8tFHinPy/qy4F2b44HcQ/rctg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BFKvHAQ+bIS+e+avEi8+UBCJf2WSCLF1319NYYwLpvE=;
 b=n9/wAY2mCj4hsi3wMASWeYQpFjj4v0hxpcv0b0iwWe5Vx3VOZ52/ygcgmtJ9Pwn1Ny/zC0viO+FXfJX5lSE6HQJCTToHCT047kI0NFalJzC4Asy62k38vWqSg4u4xnZGlH8+VdRHGozZC9JXP6K2rUu5NUZNS73U+gb32/lvL872Yqs2z6WaZwZWvfBFNyqrJUAqXvHJrsAMo/hk5TBI4T636SigtrVWZiVzbm0a88xaxSZXpYQP2OGCzqpApODQCc9ZIsCcy0WMAeAl4iymy2qUboYadrMhLsEoLKzfUqTw+fkBghz4C22/972/4XoQS4yr75DbX6PU4Puxfms2rA==
Received: from BN9P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::14)
 by CH3PR12MB9313.namprd12.prod.outlook.com (2603:10b6:610:1ca::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 11:26:01 +0000
Received: from BN1PEPF00004686.namprd03.prod.outlook.com
 (2603:10b6:408:13e:cafe::6a) by BN9P220CA0009.outlook.office365.com
 (2603:10b6:408:13e::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.17 via Frontend Transport; Mon, 3
 Aug 2026 11:26:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00004686.mail.protection.outlook.com (10.167.243.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Mon, 3 Aug 2026 11:26:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 3 Aug
 2026 04:25:47 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 3 Aug 2026 04:25:42 -0700
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <dsahern@kernel.org>, <idosch@nvidia.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <razor@blackwall.org>, <ja@ssi.bg>, <petrm@nvidia.com>,
	<fw@strlen.de>, <kuniyu@google.com>, <bridge@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Danielle Ratson <danieller@nvidia.com>
Subject: [PATCH net-next v2 5/5] bridge: Use ndisc_parse_options() to parse ND options in br_nd_send()
Date: Mon, 3 Aug 2026 14:25:05 +0300
Message-ID: <20260803112505.613873-6-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004686:EE_|CH3PR12MB9313:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a90e220-00a5-4570-cd0e-08def151ff10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|1800799024|7416014|376014|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	MXyySNOP46dJVXUOla6wzsIV6NjPXRlxX7aYffxB53kJUPK3AzQjSWPBMetCSQ51dewl/ROMnbo53QxoKS9Mhkd6EOOOry0v7LYfeIxbJkQZak8ISrytka0oW8Pg/gMPIiP2SKQnndddzIz0VE7bYJOVNSTfZdyKxS+DF+c9fh9m09pX+tMlqVCVhSs4KXltvfgX9xYcu3+qi/+KBaa6JtX2RSY+To4nWwl6FwfZGVWQ72ZBquzYR+9590CvROqhkvVLg0wZteH+sll84QGR8ceTMpdd+apYR0hvGbECbglLIUql8MfTpUpYnjzul+rYRxXaSGEz0b0//pw102c/PwkgXSbZpC88Do0J8n+UOV9lNyLRo4H/gfZnwMRHbS4bZd63SkF1tlGR2+pE+HxyCk+EJ8R6CDlh1mqdCQLhqJYrc0+h5yP1nzY4hVJQibtwiwj94GmttREPPz4NC+lESq8bQQjeEMpHL05Fb3W5z7EgLB2qAcY4qBy8IpUrZFis0yEOmPK6PnGumaG6iA3vlIG/o3KTA2SipbN63T4pqOQHopEXeDVu5sii/uHYXZsft1PXrwt5isp3MGHyjXccAciwV7GSgb4u0MDPowCVEvKa+EZqOAlowFu4pG4O+2zmqMxckoggEwR/ITqcF5CiGprvSqbOV2G9INSO93s2tm/6+ncj4IXrNo9FlbbAMaPyDe9AJQXMxICYoBmuhwCGqA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(7416014)(376014)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5N2hKtrvpgwvPVjT+cMn9VTkSj5NpSBr02OWIS8JNonCsnNpcLuElNBO7dwiEFQmyaEwSUGEaW800cyGczxxRuYBmpQLHzgcyFmo824ry51L0WtC2/FU/IW2i0CvSE0oh3VX7JKiWPCmLEIXEhLCY2CixQe0l7LNPfu/+bPgh5uCGtua4iykbxR7wC9fN8ohIQrLXLn4AwI0e2ms227XEWTg544wN/w/6kbf74uV70ckLsLVxW3HYr6Iu8SqcRRyVS6s8YVnkd9M1s9q37lW4XvY3TKgRdZ1IneG6YaH/rTwI0XH954plUdQKG/ajRFTV1RDllP6pIq3fuDFuoQlyhrNumxDTWkLDA7LjQk2vU/cDgq7angdnE75KmxZQ2n7pdrxFa1+ve67WdXUK9z6jpK4XSLSLXsai3s5+6dbkY/we++p7HAfeeiGTE99pwNm
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 11:26:00.5215
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a90e220-00a5-4570-cd0e-08def151ff10
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004686.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9313

Replace the manual ND option parsing loop in br_nd_send() with
ndisc_parse_options(), which provides proper validation and avoids the
class of bugs that were fixed by commit 53fc685243bd ("bridge: Avoid
infinite loop when suppressing NS messages with invalid options") and
commit 850837965af1 ("bridge: br_nd_send: validate ND option lengths").

Use ndisc_opt_addr_data() to extract the source link-layer address
from the parsed options, which correctly validates the option length
for the underlying device type.

Export ndisc_parse_options() so that it can be resolved from the bridge
when it is built as a module (CONFIG_BRIDGE=m); otherwise modpost fails
with an undefined symbol.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
Signed-off-by: Danielle Ratson <danieller@nvidia.com>
---

Notes:
    v2:
    	* Use EXPORT_SYMBOL_GPL() instead of EXPORT_SYMBOL() to export
    	  ndisc_parse_options().

 net/bridge/br_arp_nd_proxy.c | 32 +++++++++++++++++---------------
 net/ipv6/ndisc.c             |  1 +
 2 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/net/bridge/br_arp_nd_proxy.c b/net/bridge/br_arp_nd_proxy.c
index 6b6de0eff38c..b6e5a86b6a92 100644
--- a/net/bridge/br_arp_nd_proxy.c
+++ b/net/bridge/br_arp_nd_proxy.c
@@ -255,15 +255,16 @@ static void br_nd_send(struct net_bridge *br, struct net_bridge_port *p,
 {
 	struct net_device *dev = request->dev;
 	struct net_bridge_vlan_group *vg;
+	struct ndisc_options ndopts;
 	struct nd_msg *na, *ns;
 	struct sk_buff *reply;
 	struct ipv6hdr *pip6;
 	int na_olen = 8; /* opt hdr + ETH_ALEN for target */
 	int ns_olen;
-	int i, len;
 	u8 *daddr;
 	bool dad;
 	u16 pvid;
+	int len;
 
 	if (!dev)
 		return;
@@ -284,20 +285,21 @@ static void br_nd_send(struct net_bridge *br, struct net_bridge_port *p,
 	daddr = eth_hdr(request)->h_source;
 	ns = (struct nd_msg *)skb_transport_header(request);
 
-	/* Do we need option processing ? */
-	ns_olen = request->len - (skb_network_offset(request) +
-				  sizeof(struct ipv6hdr)) - sizeof(*ns);
-	for (i = 0; i < ns_olen - 1; i += (ns->opt[i + 1] << 3)) {
-		if (!ns->opt[i + 1] || i + (ns->opt[i + 1] << 3) > ns_olen) {
-			kfree_skb(reply);
-			return;
-		}
-		if (ns->opt[i] == ND_OPT_SOURCE_LL_ADDR) {
-			if ((ns->opt[i + 1] << 3) >=
-			    sizeof(struct nd_opt_hdr) + ETH_ALEN)
-				daddr = ns->opt + i + sizeof(struct nd_opt_hdr);
-			break;
-		}
+	/* Derive the option length from the IPv6 payload length so that any
+	 * trailing L2 padding in the skb is not parsed as ND options.
+	 */
+	ns_olen = ntohs(ipv6_hdr(request)->payload_len) - sizeof(*ns);
+	if (!ndisc_parse_options(dev, ns->opt, ns_olen, &ndopts)) {
+		kfree_skb(reply);
+		return;
+	}
+
+	if (ndopts.nd_opts_src_lladdr) {
+		u8 *lladdr;
+
+		lladdr = ndisc_opt_addr_data(ndopts.nd_opts_src_lladdr, dev);
+		if (lladdr)
+			daddr = lladdr;
 	}
 
 	dad = ipv6_addr_any(&ipv6_hdr(request)->saddr);
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index fe36b3f51285..2ceb655c4229 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -283,6 +283,7 @@ struct ndisc_options *ndisc_parse_options(const struct net_device *dev,
 	}
 	return ndopts;
 }
+EXPORT_SYMBOL_GPL(ndisc_parse_options);
 
 int ndisc_mc_map(const struct in6_addr *addr, char *buf, struct net_device *dev, int dir)
 {
-- 
2.54.0

