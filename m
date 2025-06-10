Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9661E238C39
	for <bridge@lists.linux-foundation.org>; Tue, 10 Jun 2025 15:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749570857; cv=fail; b=ProF5eI0R8Pgt04nYfDVHs4NQSPIGMIvSzSSZDco61+zhY6Hn+5gqseKeGGXRaRSEbM8qIvBSKsRGzRgACfnNp8P9N26KQ3JxFobXY3XxmJNrze8EKPgfNUhc+7OpdfSN+2fRQpuKMFWFpmqSszZYmJXtQIb1NNSuJk295+7vDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749570857; c=relaxed/simple;
	bh=hCRb72vQLWnmesFcHHxGqfcxuS3L2Vce1i7hDeVgO+0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QP4NRJGB6HWvK6RQd2MP7+asBUgR1wKLcpdHNvxgn1c2bkPUOuVcCpXdiU0lG6lcrfSHEwzx+odIqzaqwYHcu8eY6aXpX5nfTHlIKGGW41aFYSPioPRC5R5bxLRtIUL2wL10eps72hMBQkc4kKMUWX6kE5Fixk30w+ZQKqdh7tk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rk46EO51; arc=fail smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rk46EO51"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1C86840116
	for <bridge@lists.linux-foundation.org>; Tue, 10 Jun 2025 15:54:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.103
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4l6kLZFi3ZKx for <bridge@lists.linux-foundation.org>;
 Tue, 10 Jun 2025 15:54:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:111:f403:2009::62c; helo=nam10-bn7-obe.outbound.protection.outlook.com; envelope-from=petrm@nvidia.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 51816400AD
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 51816400AD
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=rk46EO51
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2062c.outbound.protection.outlook.com [IPv6:2a01:111:f403:2009::62c])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 51816400AD
	for <bridge@lists.linux-foundation.org>; Tue, 10 Jun 2025 15:54:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UfNrbdaYZHqbYxW/En6YnKCtuqBVifOx4LqBs01jtEG/5XndSADB8B6Jzw6SpP4O1jV5d2jhDReuticfQq0IQ3B2R+/0gkRTS1yxk8vQJMpJTNl8lFLstrm0xr9dBnCd4hXsK0xtsGI+ITwkZcNCe8Qbu/rcXkO2J2A0VZm6IRb/KsMeAXpi+Tg3cfEejfvTsuWD51Mof9JBAOGWYNoF8zT9evjaeIa0XLVcnCvQ4naHPpwievG1Ya+ArXMZiCYjUWz9xRhjbqH3qJO26ghzKJekOiRg8AAK/BRD8qHfjKeTA4rWd4iTnDvYHxsSvgWOYm/NJXI9+Dn7Qp+E1pyCqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zY5lD0/RZHifxkwJRodMlFmU67rk+3f42WpyztzDAfA=;
 b=Az+F8QWztVvKTHRjN0gO6ucjZg6DmNsdpNCrq2fQ7JeVYOnCuKxTh3QhW6LxUEB5PvlvZEpVYCRaMrz8ZlzJNGiCfuhDCFjVYmbZmlTRMDEU6TQ1nUDjWD7q0lvAEDOGZZyf1f2JLjKcH7AkYbycHjPiJkrYdmkQxvCD4Rhl0UG2TdHIhY5zK0N71KwvY4S/ldXpBtwFABqe7uZLJssPDrswl0du+PoJakOtxNvdDEtt4Tl5o9Bapf4RAuOh3S44oWhXpwJHt4/TV0U2kzMV03y5n7uw07dnsrcufeKy/tz+o9H5grnfNWxpLIVMDYdPEfoPupNu+A9JIEOW/N8JZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zY5lD0/RZHifxkwJRodMlFmU67rk+3f42WpyztzDAfA=;
 b=rk46EO51QfsjmKjwKZbnIWo7JgvIT1qJTabpxfe1YKsYTrr6m38qYe3CA382prhc9YkiNZW6rphRrw20mxxMcB40GDkiJzxngtd9jk9ApzBtCttEnZlIgI6zcgpc1lM8dJYzlLPYuRUiOHtJHbgQUB8NsajcMN/2cDn9zyWszFxos55qFpQd5pjv6rKhKs+HECNkLQ0QkEeJdxZ9heV4VrPEsQPArCW+PGS3JQJzX0hXfUx5ubrwyeEDzg50Mxb/U5xzvZbwTuWnmqWsDlGlyE3DHeiznfFrhrJEDXP+8qQLObELMTqecLvTivQBNleXgdJsaNkorskXduOM29/GlA==
Received: from BY3PR05CA0015.namprd05.prod.outlook.com (2603:10b6:a03:254::20)
 by DS7PR12MB5838.namprd12.prod.outlook.com (2603:10b6:8:79::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Tue, 10 Jun
 2025 15:54:11 +0000
Received: from CO1PEPF000066E7.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::99) by BY3PR05CA0015.outlook.office365.com
 (2603:10b6:a03:254::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.17 via Frontend Transport; Tue,
 10 Jun 2025 15:54:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000066E7.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Tue, 10 Jun 2025 15:54:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 10 Jun
 2025 08:53:48 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 10 Jun
 2025 08:53:45 -0700
From: Petr Machata <petrm@nvidia.com>
To: David Ahern <dsahern@gmail.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Nikolay Aleksandrov
	<razor@blackwall.org>, <bridge@lists.linux-foundation.org>, Petr Machata
	<petrm@nvidia.com>
Subject: [PATCH iproute2-next v3 0/4] ip: Support bridge VLAN stats in `ip stats'
Date: Tue, 10 Jun 2025 17:51:23 +0200
Message-ID: <cover.1749567243.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.49.0
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E7:EE_|DS7PR12MB5838:EE_
X-MS-Office365-Filtering-Correlation-Id: a5ece88c-e6a8-4df0-9d27-08dda8370ae5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?38rzDtfZyAtuMZe6y1U0ngnFMEKXYMQk0QUMbEt4GvNvYAsQEq+OWWKGrXqO?=
 =?us-ascii?Q?ft/PyQ990OwT/yLVpRSkQw0HRr9qW6vSrWfenvx1/5/chNK3fqKY3ScLyY5R?=
 =?us-ascii?Q?4QUahbWPabBYB4XHmQpMipWfWQePFsZTAMy4BH6WgJXc5lTmqkH3nvUq7ote?=
 =?us-ascii?Q?p87e+cAJKXW2C2+AgBgmZkno1wFi089Jzmi9++I5fiAQjG2FZL0otOvhC/NE?=
 =?us-ascii?Q?/agujy0UcBDZfccF4eLQq8qZBUFGFDUyVQaBmySlqA3t6+RfOt1gvTKhJFvD?=
 =?us-ascii?Q?f9jdM7C0hDVO3N0MLoqk4yp3B1tVHW/enePgXHkctO6GrhcdoW4OeXi3A3bQ?=
 =?us-ascii?Q?yLd3P6zxPfJJxi0B7NMYw2b26q773Hod17LcAjq/qeWPrwPDnDw9v26ZMEF+?=
 =?us-ascii?Q?y41Tl4p/BzpeMTdFIa25WGMR7ItkI/KqSGFegePa92BhQLcUst9+a05GoPOG?=
 =?us-ascii?Q?i7618bfgelS3DRttYoodWtkeGLRRfxD+/OMB5xvicBjwcOXjLux9zD9RkCNw?=
 =?us-ascii?Q?ybE5glxwI0w2HQB2PG01rQVgRSmtlQkYoP4YIC9nlimHQzKcnepr3OhVTJDo?=
 =?us-ascii?Q?Rhb1VhqN3kqdjvepn1cyGTlPmJSvzvrAcWL27WmXZgWCmGmBjFnt/fnRRzZE?=
 =?us-ascii?Q?cCU00lPc3RFWXdHMu6Dto7B4HsSmTh+dUlg7RnC7ZSJcpBOCZx4coZx35sLs?=
 =?us-ascii?Q?hackHSobq1FrKia4vAeU8lbtyZDYfB4xmlUfRzQMzvlrIJwKJl2M6oiwXuNd?=
 =?us-ascii?Q?yUvOkE6sJPD+KAf25ezv2hAIxLssb5HEycao3UYkISQfL9JrGbzYnWL6CRBr?=
 =?us-ascii?Q?LkTkrJw42rh1471uuZMsV9ecigzK/R8EzeIPTfKu3vYVYmNf3aO0A5InAyGb?=
 =?us-ascii?Q?W1GkLE+kp6bAD7PZWs8eBGYF6S8r8Gor1bFUt2atJr1y81jSQQcxMCWt+MLm?=
 =?us-ascii?Q?tQhg1tH36LTsFd5Zzc8Dh2DcMoLksO96j8Rm9tnN4aYJC9WK+2VHXOJ6LkE9?=
 =?us-ascii?Q?23v10fklilRyx/2jiq7cR+Z6yINxejKemZ7tUxwtYcTCL+IyVPwgL9lBKBSV?=
 =?us-ascii?Q?CBpzGgc6isTzXldfZhm8/7+ketmbPQKFCeBJK9DknF0Wt1faMwoGACpKIhbk?=
 =?us-ascii?Q?Ezg7TzGgh4hA5bLsELTe734wF9QouzaJJtzdZJ6i+E15yVA5X7vCkY9DwZf5?=
 =?us-ascii?Q?ieqBMjOxxUKTFrCdU6vwZRa7YV0lAfQMXXGoN2QJMTvklSgOiJLyFy7xtVql?=
 =?us-ascii?Q?H5VKjJX8ExOWrUrJd6dSz9P6e8Edh7jwPOV6PrIOTkRqkw/rRGW5GRUEpPwj?=
 =?us-ascii?Q?EW1HQgZquPywaH1Tmz1rjQytTHaiHc4I62R7Y22jvVSUnSAV5ZqJMc0N4za9?=
 =?us-ascii?Q?pAomGr4zSZt1DF8TH3awROgQG/u7MLxNkLl1JNoQ54H/j1Yv3MboQd3sModv?=
 =?us-ascii?Q?9BcdYO3Po4YV7rOvOvn833P96Xk3a8nMdClla04fuGG2PLVQ4IiMOZA+GwZX?=
 =?us-ascii?Q?/iGsKfmlAfNNJ+WkEzXTVt92Mly+nCMpGr8R?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 15:54:11.4882
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5ece88c-e6a8-4df0-9d27-08dda8370ae5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5838

ip stats displays bridge-related multicast and STP stats, but not VLAN
stats. There is code for requesting, decoding and formatting these stats
accessible through `bridge -s vlan', but the `ip stats' suite lacks it. In
this patchset, extract the `bridge vlan' code to a generally accessible
place and extend `ip stats' to use it.

This reuses the existing display and JSON format, and plugs it into the
existing `ip stats' hierarchy:

 # ip stats show dev v2 group xstats_slave subgroup bridge suite vlan
 2: v2: group xstats_slave subgroup bridge suite vlan
                   10
                     RX: 3376 bytes 50 packets
                     TX: 2824 bytes 44 packets

                   20
                     RX: 684 bytes 7 packets
                     TX: 0 bytes 0 packets

 # ip -j -p stats show dev v2 group xstats_slave subgroup bridge suite vlan
 [ {
         "ifindex": 2,
         "ifname": "v2",
         "group": "xstats_slave",
         "subgroup": "bridge",
         "suite": "vlan",
         "vlans": [ {
                 "vid": 10,
                 "rx_bytes": 3376,
                 "rx_packets": 50,
                 "tx_bytes": 2824,
                 "tx_packets": 44
             },{
                 "vid": 20,
                 "rx_bytes": 684,
                 "rx_packets": 7,
                 "tx_bytes": 0,
                 "tx_packets": 0
             } ]
     } ]

Similarly for the master stats:

 # ip stats show dev br1 group xstats subgroup bridge suite vlan
 211: br1: group xstats subgroup bridge suite vlan
                   10
                     RX: 3376 bytes 50 packets
                     TX: 2824 bytes 44 packets

                   20
                     RX: 684 bytes 7 packets
                     TX: 0 bytes 0 packets

 # ip -j -p stats show dev br1 group xstats subgroup bridge suite vlan
 [ {
         "ifindex": 211,
         "ifname": "br1",
         "group": "xstats",
         "subgroup": "bridge",
         "suite": "vlan",
         "vlans": [ {
                 "vid": 10,
                 "flags": [ ],
                 "rx_bytes": 3376,
                 "rx_packets": 50,
                 "tx_bytes": 2824,
                 "tx_packets": 44
             },{
                 "vid": 20,
                 "flags": [ ],
                 "rx_bytes": 684,
                 "rx_packets": 7,
                 "tx_bytes": 0,
                 "tx_packets": 0
             } ]
     } ]

v3:
- Patch #4:
    - Add man page coverage.
    - Order the VLAN suite at the end in both master and slave subgroups.
    - Retain Nik's Acked-by for these.

v2:
- Patch #1:
    - Use rtattr_for_each_nested
    - Drop #include <alloca.h>, it's not used anymore
- Patch #3:
    - Add MAINTAINERS entry for the module
- Patch #4:
    - Add the master stats as well.

Petr Machata (4):
  ip: ipstats: Iterate all xstats attributes
  ip: ip_common: Drop ipstats_stat_desc_xstats::inner_max
  lib: bridge: Add a module for bridge-related helpers
  ip: iplink_bridge: Support bridge VLAN stats in `ip stats'

 MAINTAINERS         |  2 ++
 bridge/vlan.c       | 50 +++++--------------------------------------
 include/bridge.h    | 11 ++++++++++
 ip/ip_common.h      |  1 -
 ip/iplink_bond.c    |  2 --
 ip/iplink_bridge.c  | 52 +++++++++++++++++++++++++++++++++++++++++----
 ip/ipstats.c        | 17 ++++++---------
 lib/Makefile        |  3 ++-
 lib/bridge.c        | 47 ++++++++++++++++++++++++++++++++++++++++
 man/man8/ip-stats.8 | 12 ++++++++---
 10 files changed, 131 insertions(+), 66 deletions(-)
 create mode 100644 include/bridge.h
 create mode 100644 lib/bridge.c

-- 
2.49.0

