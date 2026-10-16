Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013042.outbound.protection.outlook.com [40.93.201.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF3A4718DE
	for <bridge@lists.linux.dev>; Fri, 16 Oct 2026 10:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792145721; cv=fail; b=BQGHpK09DghzyaHWjDk5JC5wQKPvkTdfZu3AXH0sfdLRzEQf3zTsgw4XcFolrRwMNJdaTmxkJVIkBT2sOvcbtNzVTXvBO5I6FJdgsPA0SDLCo2l4EX92O2r0EAnYItHrkjH2aOg4K/4ytqDLpxh7Tu7iAwmLKE5nxMDsRt59F6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792145721; c=relaxed/simple;
	bh=OCvITvCSzGzzWer3TTNi7UvmXRD7i3u7j4l00Fy/Xe4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=oVMxhlm/T9kr3nAKKT8lVxTi4lYZdVeqoNpkCGqldZqHTWC1T2bIbjGTq5W6WuNTpV52WqvS+DcbVOp6izMJlONgVUBYknJn5AjJ4crslT2LJRS2gibxR6wQu8YmeFZqZtuDSMMzkSwWf6yZJc5UZRHCyVamfPz5hpsjbuCiph0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FXPeUGL7; arc=fail smtp.client-ip=40.93.201.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FXPeUGL7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vq8Nuhnxcpv21JIBYZXDBZGYqBE9WCJe3GZdmZF+tc1w55j9qtAU9+quggazIFnbt8qidz11nYqlQAkgyWkM0AJUh1l5AAkfCm0QCnHy1yxcx7QIWIXOVhKLeMqOR9CDPsmdIrGdIvyZlwnSPy94rbHra2eUgZxAhVC763YJv0J8OxO1DUpaf94977qgIlO3rqWs0V900tD7r1PY3FZ+om5RVhY+lOv/bRUoosE7lZW2Fw8z9syFYiFtJKIrTxNwiE4/b+SqTrD0Km/kd0qYUSzXQbbFGdzEKFC37v1xzBpuYJTFqznvItekV5igK1wklGD9CbZTEa7zeRjnBgecjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AY4cK2JYMY90KTi4IYnwjuJT86T+UuizBRMkFaJlmc4=;
 b=voFf46QPipdj8RodRa82o2Lt6ikZUV7LntPukfvxPiOgq72WCMQ2ZcPKPgraX9CJM/Vubl4XUISEc4UzWizHI7nwxKL3LMa6D8BK7OvW4n/EzQAA5Ep248+3kAvAMt1WOLwDNF3HdUhyXnBkVFtW8J/nmSF3fjjhYYRxB5cDgvf7lyo/63C/De00CqJ2ljMhSaRpSTAaCMyPMIe8tsQkmi2m1C6WZINqWZb3NEnhSOl/Qrixv8QYFeSYgwfhQkU0Npn3vGqbcB7c2FOVt9BsyWR65ZccBkszqhB67me2O2eNRczocdxlr21lOgBu6/B7AOEM4f6JQVT+JeSdfZb/gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AY4cK2JYMY90KTi4IYnwjuJT86T+UuizBRMkFaJlmc4=;
 b=FXPeUGL7McvlPDR9FlB5A1o8T2prA1fTqab427YMeKaK8Hldr54fiIfymBNWhwqbdoLbgB+xtpUSAWzzoiRBsk/lkL9IhhqpLs8BnMS2tH8ldJygMljXCG6K8QoznTaUJjHBqFSL8LNo73Rp7D4Z9tlimj9CqVgmlFuHs2H28lyyq36ATZZpZvLBs0WhdxayQZJzccZhFmVdPE7q02HIBvqg/ByFBr5vg0rZcXttonkA5G3nHPk8p8FQBIzh/lXLyem7GmtgZ90ufqgH+WH/5Wbqlq/yhwxsnYs6EOmsvF74Hl2saVPKdxwe+r68L/YlG+wVAx3KhWFnLCXT2G4UaA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by PH8PR12MB7278.namprd12.prod.outlook.com (2603:10b6:510:222::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Fri, 16 Oct
 2026 10:15:15 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0496.021; Fri, 16 Oct 2026
 10:15:15 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org,
	bridge@lists.linux.dev
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	razor@blackwall.org,
	horms@kernel.org,
	petrm@nvidia.com,
	yunlong_ma@buaa.edu.cn,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net 0/2] bridge: mcast: Fix MDB exhaustion by rejected entries
Date: Fri, 16 Oct 2026 13:14:05 +0300
Message-ID: <20261016101407.2030133-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.56.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MR1P264CA0169.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:55::17) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|PH8PR12MB7278:EE_
X-MS-Office365-Filtering-Correlation-Id: a3596fe3-fc2e-46fd-eb85-08df2b6e5f2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|11063799006|56012099006|18002099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	PNYRsMJGaDYmecQKCwVB934p4OL8Cv2mrXV0fDxVaVOHRfU6hBsMmtN63cV2PnJSK/Q0/EQzwnQAN8C9SifJlzVeU+8n+UwI+HMmkNmTclPTVREZpnaxBNo6VpdObh4fjw8rpop0gZuSRQVPUA2WYMLbYMxsBRy5ekDx1xMQPlz9KjZNSqzwSNZ3pioqPjejRQR6qEasItjf1qpJfFHABS1Z/ezhGGVsJMtM5OijLRetW0gf/JuV6endecm6UbtYuQm9reH20a+muXL1VSAsgnyKyVLkxQXw3flX0NV1MaWUv+t2G9TF8iOOp/6K4waS51sRRqZhSZPTpDweT+5AK35uU4g5vYvk6d/L6w2QACuz7Lrzzp5k5T/jI0fpKi3Aa3GC5/T3iL2HUll35UuUf+X6P1UJpVaLnW8mmxB3wlaRiJe9whME7ot08OE8ZpqDfrG4RzyjFb8N5iHOt95smVPmH75jUBlsdq2CxCIcZG94eLG2BbcFvGDWYkXXBu8R6pPiYZaI4YQkil5Jy0ojQVWV3KbRsrdToYENLN7VhmegLoDRuijUq7p5qBmPLJ5oNaPjn/9KlPh7SHi4DP4roCc8TfUlJ27WPfTcjWRG9qGNrfv2AA4Ef4dxlJw18CFSeBITqBa96MYZc5UY3Lyrnyu3D14anlNpPr4SgoeXnbk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(11063799006)(56012099006)(18002099003)(261009223027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9q5h04SSKTMfhrZqwqGe/ik9IRMRBG7M8ohKMI1/PlBFZUGHGAX2asP7owPf?=
 =?us-ascii?Q?kbh0EI3WEHxuYwsTFm7+CZ3ZsT/vlryC5i9wwpMFbrIaX4rhCfpM9/0KlmJf?=
 =?us-ascii?Q?3f+QrLn9bEqywFlhi9mXME3ijLOtxq7jHEJcQNLLxXEbwmh2lKK9AEvGF/bb?=
 =?us-ascii?Q?0mMpgL++hc0Gn65GBY9y7XBeN3PudFLUt3zjHggSs1srD/SRuKV6xINQ/0ft?=
 =?us-ascii?Q?zv2iQmMRMq48OQ+3YUXUAb0541aNADeAau0zMbzB+xjNgdhEIe1qV5RsJSCD?=
 =?us-ascii?Q?SPdbSxEQxzArX9BbE/AcNrdiCtIeV5h8kMqmT+G9Q/W8cDgiCopXxG6UAlS/?=
 =?us-ascii?Q?t2Z14NgYTdlWAqkjhRXbfG8R9y1kCWK9B/EfrZXUCymEUkT0wJKPMLVpkxBc?=
 =?us-ascii?Q?5nGrMjsRMEkalfBm+j0IYGzQZvQiHA+ScIwTprYALCpSf6d5+TnZ0794XmsK?=
 =?us-ascii?Q?DyE/qnKPkI1Y/2zcKpzjaTRnLrFGiuinajjVBJbRFHW0aSr9Vm0ZIzuPtFqK?=
 =?us-ascii?Q?oo/4q88rMU4dkSooZpiDVvftYY5x15r03VU7+XwN6iDrEdrcdTZP94rkLrXq?=
 =?us-ascii?Q?Q64/OUrpFKa5GKdGciWPOXiXWykkzanLHL6VflgdjvbskxC7I8XDZLi+SwNv?=
 =?us-ascii?Q?vKYyNOxvMeDe7OItD/MgFb0AMQotqKNiMRSwkpYRoitIfz9h0oEKWHjgSt1y?=
 =?us-ascii?Q?bV+9hYaudMpANKttiictpIuthwKY8jnwWL8U3S3zJrubzQoKhWjCybCqjLOW?=
 =?us-ascii?Q?cQ583cem3J5FoWjmJmhDMilkm7THU5NindVbz54bpGo6LhAMeLubKdlmnNE4?=
 =?us-ascii?Q?cOnRrLKGI8jqfptXNl4DOI8I1fMEAOd80RTHC3INHBZqUs+2RDsCSpf+YXqZ?=
 =?us-ascii?Q?CLNSXyAVJutT6RoCQrmt3FVZvURFwLzvIRb7HwryiN+Vd9x3PftF7HpS0f8b?=
 =?us-ascii?Q?q5+dRpJNcNA2PB/ujsmf3Z20FCCHGjJrADVWUA1Mk2BEOFq9A5gUl7/AATJH?=
 =?us-ascii?Q?htpyvcSGElHEld5aJlqKR0LfkDtA5XncFrA5oyKRFb7z1CsgYDt25hImothp?=
 =?us-ascii?Q?mD5vkEL1G0TgC5ozOWIUTGYG+ydDI6hPp6n7Jrnzw+pJYVgjlgSjJlCiCKn4?=
 =?us-ascii?Q?Gwi7qERA/6Q43I4XLk+GoYdaaQzUrly1r/JakhM4F+6AxnmIjNn5Ii5zf2IE?=
 =?us-ascii?Q?ZE/u/OTvEcpK4vAC87ETad+F+qjC0mnSXquTZJJR4HK3Xi2i5l65le9eWoUw?=
 =?us-ascii?Q?WnNdGZ2TvP5uoW8REsYuATW/+ytA7QSmE7qJ5NwNLQsqzUNKhE4LrrfCZ1U9?=
 =?us-ascii?Q?4JN1ikRXVFohTomURYj3dialGI15L/dBWgJhyLehTE+J96MezJl6Gfrq3hgk?=
 =?us-ascii?Q?8nrkj8TEr1fevFEEAWD9M+HsahR2li7PkIo0dOTCR7wIc2R3Td7zYqAVyzph?=
 =?us-ascii?Q?PHzcTgmQmFSrmhvNT8F8RpusZN6Sk3zqFTP3Syh44hXi1reayzRj6YDdQ6y5?=
 =?us-ascii?Q?Z/CIDo9g6Dv+mWbx1zocY+GPSpD2gjcN0ikd/GrdrTZYo14UKQ2kHR9+2uQe?=
 =?us-ascii?Q?ofeof2kLHml0equRsBtww5MczovZKIX5jAVT9r/Ds1c7QAZ1FR5d0OBp4s0b?=
 =?us-ascii?Q?BmdkSyjVptfyU1NxKarUobqCiLFx24fuLvd0IvuU6XzFEiq0PEQ3m1MN6lGl?=
 =?us-ascii?Q?bjMbdVx2iEaq2NJoh9czTkSMpM+O7eZQggBtRBUu5/HqIwjli/LhFR9y/c/3?=
 =?us-ascii?Q?6CcRKSS4kQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3596fe3-fc2e-46fd-eb85-08df2b6e5f2f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 10:15:15.4371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yXDTslL1QryFAgLERPrLmoqLMA4RzqvDtbAR/gyhfWQlTc7Oizriap1Gsf13Qeu/auzyjH2TJHgqNJKXE2DT8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7278

When the bridge fails to create a port group for a new MDB entry, the
entry is left behind with no ports and is never deleted, but it is still
counted towards mcast_hash_max. Since the introduction of
mcast_max_groups, a host behind a port that reached its maximum can use
this to exhaust the MDB and disable multicast snooping.

Patch #1 fixes the problem by deleting the entry upon failure.

Patch #2 adds a selftest.

Ido Schimmel (2):
  bridge: mcast: Delete empty MDB entry when port group creation fails
  selftests: forwarding: bridge_mdb_max: Add a test for rejected MDB
    entries

 net/bridge/br_mdb.c                           |  16 +-
 net/bridge/br_multicast.c                     |   9 ++
 net/bridge/br_private.h                       |   1 +
 .../net/forwarding/bridge_mdb_max.sh          | 138 ++++++++++++++++++
 4 files changed, 161 insertions(+), 3 deletions(-)

-- 
2.56.0

