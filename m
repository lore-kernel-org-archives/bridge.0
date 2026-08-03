Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011028.outbound.protection.outlook.com [52.101.57.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB713B6C18
	for <bridge@lists.linux.dev>; Mon,  3 Aug 2026 11:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785756351; cv=fail; b=tumu4n8KK+PHFVKm5lXVgu8go5UMG39IcYySjL9SbZaDJ5MKPBJv4yOYi/WbnbQGemf87FVYfUGlQDOtlsu5XYvdJ7OPFITbZ6+wFg9XZZ4qxW3CHH3keSXs14UhoBjIsvd09FqQo2EQfYSgg+K9Qtfu60akivx38MOTUASZeAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785756351; c=relaxed/simple;
	bh=iQimtTKBBiDadgyAsOK574KmzBp60M9ubmSLXauc3LU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=niAZo9CKcWgWjZQK43UfqNp24oaZ7gKp4T6xxtPG10XaZX5kdl7PJ1rJt9D5HL/ilFWl0ij86kk2IawXdl0N0q6hBv6lin8RVUM0S20GJg9r54Hp4jgQNVUJs0ulQXe7+4VltdOjek/WqRUKJjeC58tOA76tMSYvg5ziKFbYHtg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Uf5UGF1k; arc=fail smtp.client-ip=52.101.57.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Uf5UGF1k"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hlSqlBdtLEJnxKmPGsRc5EAtz9m8kHtqqTATOUGDzoz4/2h+Seeo7/9mpBRueX5rRB2ajeDWHnqDGsunYDOyOgajDJ59p9y1sYQ8E+FY35/FqerasCg6wcxbrLiAA9JI65z5eybMNFfjdRXSvZz98YbJNmMpWYaRbssA3F5YQr20yG9UzXRTIVPRcJdlmtELfIYc36CM18GdGkuWmGdLA05c3/atjw7Jj8+06NGFEUgucM4iXNEdpE+FGD8jkjvyzr5fgETf6pYeZmR7Z8hsO1m+YUWEqRlgBqAqxv1+l47qWHZV1yXu7bhtIA4CIrJh6fbmhc53sZK2zEJADzqzGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sEXDfT/aoNBwAolaTzhwNtocco6k7s/6wmLL40mOPWo=;
 b=MahhA+4+vwsxELaxL/wY9JKXLga5MJjXCQHssCcYZjGGC9wlE8HgoE+B4fyOOsSxjGkqOlw5/U5k6AKFabxPi1qyMMl5S4iKrYCYVeyf3gIjYQUnTE4v4GUDO3bHuSXPPuQtC0LA3nWTmIBZmC3a6Da7uOxvEi6W+yWQ3blUaVN2i1lW77D/fptyfAXe/AeqHQ1gI2D8UyObhBbLOiiiqg14pGhATIL80CyUMIMDwaLu+0LlOHoXIlr5hB6NAlaM1CxUNBNFaCJtaxzekKsoMunqw+j/fZMbGage9c+VJ/gvfPcfLLLO0KxCJBn6k8eKicVX3YNxzeTQAMcBhXbhqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sEXDfT/aoNBwAolaTzhwNtocco6k7s/6wmLL40mOPWo=;
 b=Uf5UGF1kjoydBAma+CaTF3lB0SnX3Qk9j5ogVDy6obAfT6HX14hP9bNzu3btbN5e+JRweWBWYKAa+sjg+zZAuxhiNOm1zjte0cTeWp7URt/WWo6Q64ZH9Pi1IraHQo/kT5fuSUhhwf8IJQjDDjgGn70Yn5ghSSo/yueJh3Qzc4qujA5b2K5MiGrgA7jC0XVkkGa4Si9ED5FRThz8XqiItzAu2ZZmsgclVFGZmR1nXXhuXSrXtlRQDB89IUHeAq5NJWkihkFXOhweLFBDZhHit2rguh77VUzx4sLkBOTrEfIArgeHqJBc2+UgJtERBECESrp4dRMEZd0k/2JzRmGeJw==
Received: from MW4PR04CA0349.namprd04.prod.outlook.com (2603:10b6:303:8a::24)
 by SN7PR12MB7347.namprd12.prod.outlook.com (2603:10b6:806:29a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Mon, 3 Aug
 2026 11:25:39 +0000
Received: from SJ5PEPF000001D0.namprd05.prod.outlook.com
 (2603:10b6:303:8a:cafe::94) by MW4PR04CA0349.outlook.office365.com
 (2603:10b6:303:8a::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.18 via Frontend Transport; Mon, 3
 Aug 2026 11:25:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001D0.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Mon, 3 Aug 2026 11:25:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 3 Aug
 2026 04:25:24 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 3 Aug 2026 04:25:19 -0700
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <dsahern@kernel.org>, <idosch@nvidia.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <razor@blackwall.org>, <ja@ssi.bg>, <petrm@nvidia.com>,
	<fw@strlen.de>, <kuniyu@google.com>, <bridge@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Danielle Ratson <danieller@nvidia.com>
Subject: [PATCH net-next v2 0/5] bridge: Validate and clean up IPv6 neighbour suppression
Date: Mon, 3 Aug 2026 14:25:00 +0300
Message-ID: <20260803112505.613873-1-danieller@nvidia.com>
X-Mailer: git-send-email 2.54.0
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D0:EE_|SN7PR12MB7347:EE_
X-MS-Office365-Filtering-Correlation-Id: eb853d72-a657-4521-6312-08def151f1f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|23010399003|1800799024|82310400026|56012099006|10067099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	5rx+/XQkwUl4uG4hY3gndici8Wul2EJNgSnN7tb7xlPDT1IF5unY0Ft3KVVij4484WQ+MpzjAHpHYWcNjQfSL8Es940j5B+DrWW//UN5G1kmRC/t4SMEFo93MgiVXPAamXPswL6gRFPTfznlOLmCKzhM9+xaMKyBFUmuWQJYicu8e63GqFkE9+5U1MxsCwDjhrl9MtoBXi8JJhruJRb9hnMCmovZ7VK8rUFIPHZpN5SzeU73Wd++KmmDfuqW4EWCprqbni6ATOOTnFw3dCkxSlAZakQiQHSnvuib47d1tcwVV6Bg0nAKhzoSZp0COovbCkTvpBpP7X9Te4xqMWuJAMjeQnWKWsoRJHgEoZmbQw+ANF3UDQw3vb8RKUPbiaEZGQ3ZfScfkPI35N+H9e1g4ruX8ToY+4lbzPD9iApo5IjoCLuOKE/jtSYRyXqMFHhJdCJcLh2sa0CTHz5YWLnjNUExKc5Jap2xdAZkD3jtbiDatwatY4v1J+phWWX6rsiUskiA7NXkY4klAyPW9TcgEvqAleomA0Ec231itwcRHcw3tEyJeX/ECfSnQjzxQrOsFscbIQ4SJNs2/fhVK72zDlA5qGu2Syl0tMI3WQEMBD87QraD6KOij5kSVwdepzptm/z8QIFkoFPjDoPn7feCSwqyRowJB1UOm1m8oR1nt4n49hDvu1t2JME/CisxU259onE8MtLJDVJixTC2L+WvBA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(23010399003)(1800799024)(82310400026)(56012099006)(10067099003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RcpNQHYDjcCMn4TsTGQhzyW2HlLGHVON3Ujl0ecEsc8XAhC8Iv7NgA/VTRdScMV74y2hhMajSPu+D5+uux2fbSzPBryr26N2u7ATumEAtM/dnw+32FFcBlHUhEFB6hFKGKdaqVd2FcYVbuZZSBME0OMbdQ4s08NopaJyTNcPlgviVzCD6++nO4H1LkpE5ZSB5DHzNd0r2YXpihKIzLvBvYR6rmE6ExxP/NPRqr3Qn23Ei9/6/c6/O5jK4rcb5FqZf8bGVmiu0rIjjc2Htkf0HKufK9eeCfwIowfMAJyQKMvMD25S4/E1GMVse8h2BNvGf9DbjAx/zmH91f1RxdDrOxN8BM7Q3DYOSf9lQ2HR5yu8Izbs8cGzuau2IGn/FJhhIzijFGM451c0lQxpHXx8eVmTlW4ESplr/8G42mhqhefzYqqEVZi250EW7DsR57g+
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 11:25:38.5913
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb853d72-a657-4521-6312-08def151f1f4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7347

The bridge implements IPv6 neighbour suppression by snooping Neighbour
Solicitation and Neighbour Advertisement messages, but it previously only
checked the ICMPv6 type and code before acting on them. This leaves it
open to acting on malformed or spoofed packets that any RFC 4861 compliant
node should reject, and the option parsing in br_nd_send() open-codes a
loop that has historically been a source of bugs.

This series hardens and cleans up that path:

Add ndisc_check_ns_na(), a standalone NS/NA validator modeled after
ipv6_mc_check_mld(), implementing the RFC 4861 section 7.1.1 / 7.1.2
mandatory receive checks (hop limit, checksum, code, length, target and
option validation). Wire the bridge into it so NS/NA messages are
validated to the same standard MLD already enjoys.

Replace the manual ND option parsing loop in br_nd_send() with
ndisc_parse_options() and ndisc_opt_addr_data(), and linearize the skb
once it has been validated as an NS/NA message so that this and any future
ND message handling operate on a linear buffer. The first patch is a small
preparatory cleanup that drops the now-unnecessary skb_header_pointer()
fallback from br_is_nd_neigh_msg().

No functional change is intended for well-formed packets.

Patchset overview:
Patch #1: drop the skb_header_pointer() fallback.
Patches #2-#3: add ndisc_check_ns_na() and validate NS/NA with it.
Patch #4: linearize once the ND message type is validated.
Patch #5: parse options via ndisc_parse_options().

v2:
	* Patches #2,#5:
		* Use EXPORT_SYMBOL_GPL() instead of EXPORT_SYMBOL() to export
		  ndisc_check_ns_na().
	* Patch #4:
		* Add a comment noting that br_is_nd_neigh_msg() also linearizes
		  the skb.

Danielle Ratson (5):
  bridge: Use direct pointer in br_is_nd_neigh_msg()
  ipv6: ndisc: Add ndisc_check_ns_na() validation helper
  bridge: Validate NS/NA messages using ndisc_check_ns_na()
  bridge: Linearize skb once the ND message type is validated
  bridge: Use ndisc_parse_options() to parse ND options in br_nd_send()

 include/net/ndisc.h          |   2 +
 net/bridge/br_arp_nd_proxy.c |  57 ++++++-----
 net/bridge/br_device.c       |   4 +-
 net/bridge/br_input.c        |   4 +-
 net/bridge/br_private.h      |   2 +-
 net/ipv6/Makefile            |   2 +-
 net/ipv6/ndisc.c             |   1 +
 net/ipv6/ndisc_snoop.c       | 190 +++++++++++++++++++++++++++++++++++
 8 files changed, 227 insertions(+), 35 deletions(-)
 create mode 100644 net/ipv6/ndisc_snoop.c

-- 
2.54.0

