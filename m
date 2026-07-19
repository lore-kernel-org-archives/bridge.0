Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012050.outbound.protection.outlook.com [52.101.43.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C20E2AEF5
	for <bridge@lists.linux.dev>; Sun, 19 Jul 2026 13:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784468135; cv=fail; b=gLEZpxqNYcvpUXPw1fOYE8jwwwmI10VvaSdAVkNq5D1K4R+lTNIIVQ7O6KoilLsDiomF+Cz2kzlhsTXRl2rWM4+XY8nZ1plz6n9hJYcOMmR00dBmLoocsGHTVhmrzi8tRQwFptlry7GavORXlFRSeuenJRYh2YY2lOhMgicDOec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784468135; c=relaxed/simple;
	bh=Tb5oLmsoKuUrHxIdf0+XtMFjAwq0g4rYfn0pOe+nPic=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RSFwyciT0sxBqdJiCf1kyDoKx8n9Pz/EnZNVf6HmK80CoijXgWz7kHrZFNHrm49JOJV4jeGyvcKwuqS0Bszz18aMM9LJK0SSKzjD9bjMQ8t8nP80EmJrqmfl81NZnLbGQpGhw6BJvgZbRK3B9gzwhmfyBqVdXbVBVVj/4j/f96w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JinWo+eI; arc=fail smtp.client-ip=52.101.43.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JinWo+eI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kMJE81ie0KvzxTKX9FMUWq7jsJfXcfS8maqz0W93eZjphyj3Dd6ghx16PM83lks3F3au4YgLFvT9zqOusRn/dM+UBs5dXeeeSV63E3oZdjsjYHpDY+PI8TQ9NpPyp/buJkoWSXtgiJKstriw5IT0WCqFsEf68fdj6tRPIl30W+rsCjRI9KjLPU2LWqkBGiS2NaqUD/zVgzatseRoL9Z3wBOszAfMyA9UIMpSJZKcxzl8Ge/JXh7yRCr7UmZBHk77rBmFWPxclfsmgYrN1lYZYdXf9l3l+0jph35l3bYMOBABVkruzkOrVi6IiA14k4YYsPw59PatK9sLrz9hrfuRcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nRqdBxzQJ1Q9ltWEms+RfRLWJBIWXOQEx37uXd61Cg4=;
 b=uz3m0OHf17QSKCHD/bkI1KwJAFtAf4te5ZsQCwT5ky7Qq8sBWnKDhU/mS8ta8L0tjEcPX0novV21GCmdm0BxbGhvXBuXrbVTWFCfWu6NF7CzvncIuEsr0Pi/xTL8H9/mCD8NgyCOSfHR2V/5R5FnMpp6Pt4FzgcTe+Spth+s0gDF9PQ6ZzOUsuwVkk2JymJm4llndkEPfRhMhmHxHPeY84YiK2LK2Xscy9VwvJdBpO4Xse+55nJ93D3WX1ULZS6sxs8BBWYWflYm1NKDiTTGiRX+BYuSHP7QJHBhbCQMoQqy6BMd9TLWVe7KMJMqGGZRPL3RiAGnAPYDpL/n4l1XSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nRqdBxzQJ1Q9ltWEms+RfRLWJBIWXOQEx37uXd61Cg4=;
 b=JinWo+eIspyvUPUHehOUd3ZbxQhqsdFr28uaNvWCLJW65+bckC7fuComChx5+fSg/iQtZVeo7UFnRzs+g0TlmjRX8GCmRFisufkxEWludXeMBgXDQp6NYh7a4yulpu5YNEx6FWn6gfk3IvgwFZTPCkVd0mk8eukQ49dSb8tmaQ4wkSs9QhwZDOgqM2PRw+sIzgp/57aGq0sj+88PQZ77SPgqCaKsEcrfJZGRhC8r523sTjOHnn20cYOkCRyx/CCt5c+ODEvxQhBLyQ2xWxxi6OHzLmpP3RUBIrF97Xoxr71vf06uXukxxXH9yYYvfVeISGu2W+d9/8gWy2l+I14+rA==
Received: from CH0PR03CA0408.namprd03.prod.outlook.com (2603:10b6:610:11b::9)
 by SJ0PR12MB7081.namprd12.prod.outlook.com (2603:10b6:a03:4ae::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.16; Sun, 19 Jul
 2026 13:35:28 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:610:11b:cafe::4b) by CH0PR03CA0408.outlook.office365.com
 (2603:10b6:610:11b::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.16 via Frontend Transport; Sun,
 19 Jul 2026 13:35:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Sun, 19 Jul 2026 13:35:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 19 Jul
 2026 06:35:14 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 19 Jul 2026 06:35:09 -0700
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <dsahern@kernel.org>, <idosch@nvidia.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <razor@blackwall.org>, <ja@ssi.bg>, <petrm@nvidia.com>,
	<fw@strlen.de>, <kuniyu@google.com>, <bridge@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Danielle Ratson <danieller@nvidia.com>
Subject: [PATCH net-next 0/5] bridge: Validate and clean up IPv6 neighbour suppression
Date: Sun, 19 Jul 2026 16:34:50 +0300
Message-ID: <cover.1784463131.git.danieller@nvidia.com>
X-Mailer: git-send-email 2.54.0
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|SJ0PR12MB7081:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dab3119-1218-484d-f5d8-08dee59a98ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|82310400026|36860700016|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	hhHV7WoF1Dz0irZ6Kp8UlVbk6i2n1SrME++QzjuIGHfZIenNHyb6l/d0u957mOOOM+jC3RlOHyswGXnMEHa5KSyWA2OdHJ6iLv0hHyu3NocBSM9Nh3XXkZsaznrCcJgzECus01BeeUvsuzfseGDSa9y+kSwqF5RpVKsMO+3f674gF08vyEnrPjzCjS8gIl1ICcfs9Cp4P3iSF5znk5nGDe7nSSZpyC0m/IOJ0RWdAsClm9GnxtUSh5cpo08anv3InFaWmW0Ybz4FY5eAQRxCvPa6o/6dWBUbQlapAqGkcmrl1KooLaQR87xw1PoPBlm6ur8M1z9FEHR8PNF2Xzcj8i2YQB+naWIJWptsJkyER8HdQmB1hT0ZutnbYm7BAU6XBfaw6FQx4xLjlXw3cMadGOrEeG6wwDeQy9WjL/XZ2wr044CHZw8z7N9WQt9cDGN9CFn/rk7T9UdOKUTDsQO99GMDXrrykisVZ8PebqWX7Z4tJwu6CPuNbx7RYJnlD7S4lCBWHqF+t4luXRiR4aDfZYI+/laDgzvxAuQgOsurL15fJifvPIyzFk7BPY8BWlK/jMJIk4/GiJpIgIjJ6x6EWixHYypibTmRQ4c9wahykatzb0xaZx2rBjnSkjXKjmjT9A/A7LPr2Q9dkYkobFj83MKmYg+sA8ZvT452g1BMPb4Z08TH6mKQu6unLqMBmSF+tbUI2gYyyHIkWXA2OTsaGA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(82310400026)(36860700016)(18002099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3M2NYLCGH3NIo8igb68o1UTBF42jqcaNVwsS8GNGGNUJOAtE4TaSZfO1StbusKKtfL7mHQxR8Qpzq6K6cPsgZuE/o0zm58FGR88s3rfx2lPsGwgwX30nmrqzmLPUFbbFjWLVDoq2rdSTwOZW1W88Qn45IshC6wZ5SV6PSewLKfHeTe/N2Ku6rLR1iJCnVzX8t8vYZm0xrUVS0ETHoJn4BtvhRtgLCeQLs6zzM8BF2EBvpMkJl3WdKdhlJQ8B6bN4xvT/T2AFcJKRV0YDrNUOQN/yZhuT22TE5b6B5bgOc8S2rnnVLJcUwVfnV20k4S8/V7b/tLPGgnJKKxsMSpdZ//FuWdIxNzIH0Q9y4NQ0xDgUR76/sIHMpBgdJPq1WumFGPufLmVW/jw08oiwFyNPAKkSLwFvR67AK+JhvkXwVsKT5IUOeTD0pHRbGyuIFKPY
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2026 13:35:28.0783
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dab3119-1218-484d-f5d8-08dee59a98ab
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7081

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

Danielle Ratson (5):
  bridge: Use direct pointer in br_is_nd_neigh_msg()
  ipv6: ndisc: Add ndisc_check_ns_na() validation helper
  bridge: Validate NS/NA messages using ndisc_check_ns_na()
  bridge: Linearize skb once the ND message type is validated
  bridge: Use ndisc_parse_options() to parse ND options in br_nd_send()

 include/net/ndisc.h          |   2 +
 net/bridge/br_arp_nd_proxy.c |  54 +++++-----
 net/bridge/br_device.c       |   4 +-
 net/bridge/br_input.c        |   4 +-
 net/bridge/br_private.h      |   2 +-
 net/ipv6/Makefile            |   2 +-
 net/ipv6/ndisc.c             |   1 +
 net/ipv6/ndisc_snoop.c       | 190 +++++++++++++++++++++++++++++++++++
 8 files changed, 224 insertions(+), 35 deletions(-)
 create mode 100644 net/ipv6/ndisc_snoop.c

-- 
2.54.0

