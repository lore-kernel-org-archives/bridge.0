Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012064.outbound.protection.outlook.com [40.93.195.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AABA20C029
	for <bridge@lists.linux.dev>; Sun, 19 Jul 2026 13:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784468159; cv=fail; b=FKFPXRnrP0T/O2ArnvMZvxXWOyDGGfxVjeL2tgL55LJDorLpujDZ4ZMCONmmLOAd2YcuYKDRAMVAPwkiCfNNtyYESwi1qfC3MW1OkPtEoTQp7iyugqa05695typjcET1/yiX/LUz2jl2D0pPZsz5RcdiBn+6caF9L4gWH3MyJYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784468159; c=relaxed/simple;
	bh=8uah2dFuzqV6xQdEkjvy5Rt28sbRWiXvwnw/Aj3hhc8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dngJq1JN7UDExtLv6YUoPNjmFBt2m5fig6iuI3Ve6DCXU/oVPuY812HobTs64gZiz6UNNq5qWxBFE75C6/yxQ26g0cAk5YR53wSIrmTFdpjBKO3N680JBunK4tJ1Q2QrwoMLwukw7kvUT6OGL366Oid+/LATf+C1HSit9g7HHNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YnLJ5nZP; arc=fail smtp.client-ip=40.93.195.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YnLJ5nZP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OpoTPRLcn8IyUduct/AfIB4ebDWYkAHYOfc3x/u0+gU1QZT2IvES7N2LDcNzMmKolSfcJ3meHA0NiwPdYqgidstjH9ouGNpgQvOBDPLxT0hb9xxwA4AUO2rF4fXLbbMlpTOx8IooyKoMxmOSgj74c/6NtDbGBmSMdZ1ZgF47pyJkxbUGA5d9yDYvCpAg3dIaxu0g2dgA0bo1HQrFDqqpJer0Jhmg499twbzmsw0m8Dlnzt19UF7XdHhzwMJc9mq2n+1sg2KhuwJQZVWv/jX+F0c1Vdnj+VbwxsrS3JxIWsH+aFV8y1DQZ9jTOc4Y2ESqoJudBKsMfvn5+QKKBKAYgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7x0Q0DCtwC4wvHCraJ0/L4iVlxbQLIgs42mqzfGufCw=;
 b=Q3cXKeWISlhkgpY2e+HtZ2POinuUjp5UsKPwl8utZrkba+XhY+41ebRN04JehbCahr/xnPIuV1ouBxWIQri43hqehJ6gndNGq34EKO5VSIuXDPSF6KGwRUXF/SNeBgW0rAcGmecjGmSin05Kelq17F41DCPK1NHQ/ShWAT47cD+2C0yJhZ8NLXqM/pLCrXLOGfjfvPGlTSJ5umnxhRXozGOvaw195J+Axo0R3hgXAyfr0antchN4YG3NUt/orc5GS1f5+6AxvoyfF+ZWON7Lci+kj+tr/SGEJH8K0zuxDyV07whYqtCDCOzBHw8Ij18/C6HLr6uKcxtLuJkL1EU1qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7x0Q0DCtwC4wvHCraJ0/L4iVlxbQLIgs42mqzfGufCw=;
 b=YnLJ5nZP2epP4OY6dOmY1HXAaxKg0IVcEBiB4IpolDoBRVzP0lkXF0ua1V+pr3axpr2VRCJDBTXn7BRbKktE3d/aRV391H4rq5UgX8IcDIFByNevBFA3DmZBzwGxkfQ2vFE2FQpQVXrHPsTQHTqdBQ2nJOgkUz1NpqoGNo9y4ahiyKmK7ol1/AEm4jg/N7temWoOr0yhb2IJxJlmFLO2vVwX4lnz2bEIsbfV61UALxYASZTHIj+tNL48v0S9HRzW4aCXhaLzLopGqlFxBGb0259JPT5MKvQQ2TzjW8GsU/u5PHgnjSGX1JxL6NcswyRUuvpsHqxtNx066PHKQTQdQg==
Received: from PH2PEPF0000385F.namprd17.prod.outlook.com (2603:10b6:518:1::6d)
 by DM6PR12MB4137.namprd12.prod.outlook.com (2603:10b6:5:218::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.16; Sun, 19 Jul
 2026 13:35:51 +0000
Received: from SA2PEPF00003F63.namprd04.prod.outlook.com
 (2a01:111:f403:f90f::6) by PH2PEPF0000385F.outlook.office365.com
 (2603:1036:903:48::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.16 via Frontend Transport; Sun,
 19 Jul 2026 13:35:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003F63.mail.protection.outlook.com (10.167.248.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Sun, 19 Jul 2026 13:35:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 19 Jul
 2026 06:35:35 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 19 Jul 2026 06:35:31 -0700
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <dsahern@kernel.org>, <idosch@nvidia.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <razor@blackwall.org>, <ja@ssi.bg>, <petrm@nvidia.com>,
	<fw@strlen.de>, <kuniyu@google.com>, <bridge@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Danielle Ratson <danieller@nvidia.com>
Subject: [PATCH net-next 5/5] bridge: Use ndisc_parse_options() to parse ND options in br_nd_send()
Date: Sun, 19 Jul 2026 16:34:55 +0300
Message-ID: <d75c565729850a2b95c5b19fd5997e94cf55029c.1784463131.git.danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F63:EE_|DM6PR12MB4137:EE_
X-MS-Office365-Filtering-Correlation-Id: 20446b01-1ab7-4eeb-36af-08dee59aa65f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|23010399003|7416014|376014|22082099003|18002099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	fbPQ6iCNHjAwl3MIXUNm2Q20jiOVW0CZRGY1fFRKQrygPiRRJI+VngHdN7JuH3vJbV4x5PPw1arjryqBFK/M49IiS84yIg/BJNuQZ6RNQlI6l42WmdgFs4ud9FKwhzncT4aovCso+qWF7hknUrHFV/Y4TIfG2fElS8FHZSHolQWhQu5iC0P9VKow0e5wOp8wcaMVJDHILviePAKlCtt0kaeIV55zY8UL42X9ifqGf6qYlJmuDuF5OuvtoFgVZ2DzfNj6Iq1SzmEeBbyaclN4/jGHS63PaumOdyIHknLcvnO0uNgpneQfZpyIKJWhqkjywbyzE3kt3HlzQsprwjVLEaTAu+6GO3pwHmZjAhlh0J0psykn2ZImCynGtpCnEm30xDOsWLTLtnB456LYkFFWH9toUSG3NF1f2aEBrXcUCs0oWqXLsrzui8UqJuj0jd5XJvseiK7QO1gmokTZCLTpNYSIZIPRFGtOiZ4tkfjtZDyeXIIJ7vKAHDQ2BpHNBjs8Pi/GHj+SYcKJYwVbDSWAgv3iDhG9itYB0DDA+Tl+Lnhpppam7FA5hStX9jDwENeaamSZMC1scx50w2JOJJu9TywMyFnWREgjYDXVqm+wUjMscJpNWigyeviGdtMzR6POtjop/ZxRqMnNWrufR/29vMuoXl1mtCLYHbEHpFaE95nF+rXrhfdDlRnr/DOs3iD5BSrGnfvVjh9DvS2auWiMEA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(23010399003)(7416014)(376014)(22082099003)(18002099003)(56012099006)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8b4fdE1+DEIWK56fs+41JzA3+Eu+H2Fr9ozbtwMwEdDbuwvI0Rsi1nyWobzm44megSkgnS03ykqAATH1xvOYbD4xTKykwi0aEHMPPMYTy6xjmKtARfoggTReXoa8UuV5O3PnczonWSfiu/E9qZ8G3yB8l4lNX2dioaru63OYyyPSAGaxs7LJ3Eda0CbWWGa2l7XmT58wxzMSClW6bd943CwPA4n8tpEuDx3s0NvuFsKSKLSlJQU6niq/r5i+9DKqCCho9fZT3SF4TfDJlrSvW9FolxI1mF9wuoaNQD8lQAqyReCxoB5bGE9+RBLEdNIDZdAC4KTmQBa7euOrq4MUrj3v3k9Q1A7J7t8gBDa/knaFizVkxSHqkkJXk9uwdT1Oy2A8sGCIC9lYeIJW8Es5C0J8ZJ2za95jkpO6/QjyN6jjEmJOwwRsyQBVPf9bHkA4
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2026 13:35:51.0693
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20446b01-1ab7-4eeb-36af-08dee59aa65f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4137

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
Signed-off-by: Danielle Ratson <danieller@nvidia.com>
---
 net/bridge/br_arp_nd_proxy.c | 32 +++++++++++++++++---------------
 net/ipv6/ndisc.c             |  1 +
 2 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/net/bridge/br_arp_nd_proxy.c b/net/bridge/br_arp_nd_proxy.c
index 46779d9fad61..7863beae0c55 100644
--- a/net/bridge/br_arp_nd_proxy.c
+++ b/net/bridge/br_arp_nd_proxy.c
@@ -252,15 +252,16 @@ static void br_nd_send(struct net_bridge *br, struct net_bridge_port *p,
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
@@ -281,20 +282,21 @@ static void br_nd_send(struct net_bridge *br, struct net_bridge_port *p,
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
index f867ec8d3d90..d8b4588f6bff 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -283,6 +283,7 @@ struct ndisc_options *ndisc_parse_options(const struct net_device *dev,
 	}
 	return ndopts;
 }
+EXPORT_SYMBOL(ndisc_parse_options);
 
 int ndisc_mc_map(const struct in6_addr *addr, char *buf, struct net_device *dev, int dir)
 {
-- 
2.54.0

