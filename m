Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8366389116
	for <bridge@lists.linux-foundation.org>; Wed,  3 Jun 2026 10:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780482969; cv=fail; b=Jzn8T5uSZWsxjX1L6J3Fk6GV+kvaD03QKwW9MfMfjLtcGC3OLwZoHJrJ1++KFjsEAFZZadQ4rfMtSpRdkDewCnB62IWQaZGTH4RSaXtVkTJSP6YLtwV+VEkfGt8dpASFzat7GAi+NQGxldRNSdIgNTdYHWDV1lYx/GIEPp9tu20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780482969; c=relaxed/simple;
	bh=eEeX/FE7qQ12ijMyy9kVDdlQUk3OIZzYvz4Vd88KP4s=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Xr5ORzdKY67gGJkWnRaYdVw2JKrhsXnZwcwSRg/SwQ4G3rTzDQOgfMUg4wm02Rsn2NDR3n55BFpvMnGc5jmsDSL2P0N/UFJhzDQVMkofnaZO1x4hAUOMLbefg1BYnsvS1hFpWKMj8bfrQHU+YbVYtz24Jy7Htf3bpL1pxud3mbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fdfTSi+s; arc=fail smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fdfTSi+s"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 646818248C
	for <bridge@lists.linux-foundation.org>; Wed,  3 Jun 2026 10:36:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.101
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 81EgGlTmY48O for <bridge@lists.linux-foundation.org>;
 Wed,  3 Jun 2026 10:36:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:111:f403:c007::2; helo=mw6pr02cu001.outbound.protection.outlook.com; envelope-from=idosch@nvidia.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 9D39A82356
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9D39A82356
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=fdfTSi+s
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azlp170120002.outbound.protection.outlook.com [IPv6:2a01:111:f403:c007::2])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9D39A82356
	for <bridge@lists.linux-foundation.org>; Wed,  3 Jun 2026 10:36:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hjb26ywpUyQGiQTCDkJYlSqsjbDcym4zgtz5GKnq0A4enS5wq5QcxlIWI1yfzNYDIFeb0cnfSq1T15QQ4bockNBofOm8bRYOoY7+PBodP7k1O3mxINjabrsXwmNqTUPVsoNXbAoB5Rm7uKbv+jjbc5FWRXccMn+AIFnLX0eNFa4CQ/W5852MDLzshXG6Ba9krQYhp1XxT3oU7GcwOnZspGX7RtX/JobBoj11lbZ3wSCxq/BF0DD+RNZFf4p9S+fdBN9625yYoZ4feD1tNynK++2m+VgzsBzLRROkK9/+DXCmOE50NoCP480S8q57z8TLRp4YmxUHNR9Y4M8MgJX0kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mm/wEP5oILdWL++Tjwnf1wSK5ACzKbAzu3pj9ieZOOg=;
 b=RkTPYMkUEX6d36HrU+PUUrWfLxjMP93sm/emvYI9Q1zHkmRe3kldg1UPK7Skjb2TLXchArPTLC14o01/nM2JHZoCW3Bo/r0lTFQTDqrlSiXU3t1fPE6ie2o4Jr++CjOF/vFmxRF7wgThHZdZWi1+2bGt9wR/kvV1zUKAiKZFQaeCEClm5wYhEELb9higgcYxajGOnn6PXGkFbEfi4Zwg8SesCLbkl1KZs7tygnIUASE53y4PwDfbuvXw9ktY61XMYIMLKz7RmNAM+DhnV2aBhh8GYOo9q0YEqUZ5/rqNTmIBg3XJgzHLErtHmQ+Vok5nyCYdKWBcx4MT0FnP+oqWaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mm/wEP5oILdWL++Tjwnf1wSK5ACzKbAzu3pj9ieZOOg=;
 b=fdfTSi+s/PF6SlXT2JM1sh5hSBAczAp0Y/N/5DZvHzlBFpYGhI8km9njqFMdy1lchPqVsmJ9mvX4Uv9wqjmnIr5rqc2fmRxOiLSM3AUSzUs7WrjO4g7GNhB0hhd/9C+nzfpQp4ATfIVPop9vGmuxSADeqROwuD7AUN4diQHAYsM3aESIhnRqJfm9qeslRWs6AnbnQqyLR1ZvlcTH3TYdBG7SVDj8C4LEg3z3ZIiijJXDgC0D6L8mWNKvoQJ1ElpmGFNYTlRoCV79ZkrKIbeWKAmtABaXyZYJkTgwAuypNlS0UjroKPKywEEMV9/usvWTsyELJPCM8HZmwpVd7HK0sQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CY5PR12MB6575.namprd12.prod.outlook.com (2603:10b6:930:41::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 10:36:03 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 10:36:03 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org,
	bridge@lists.linux-foundation.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	razor@blackwall.org,
	horms@kernel.org,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next] bridge: mcast: Synchronously shutdown port multicast timers
Date: Wed,  3 Jun 2026 13:35:22 +0300
Message-ID: <20260603103522.622411-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0103.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::13) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CY5PR12MB6575:EE_
X-MS-Office365-Filtering-Correlation-Id: e1421075-fc29-4c7c-83a3-08dec15be934
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|6133799003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	PQla1QbhvbqY+1c4ibpV+sljotlwCi5ZI5AIykKw5RbYLoQDIn0SvBzXPOnfPYgJThYSiVwEfeHjEirzxWCFS7d6zmH055hdYi+W7Jrrf4Ynhcia6jEukbQrUe4mQKY0ozEKBAx2k1bwDSuf41yO77m3vnOvZ0yNm8yJOoFFFksgZzhFaivHRm8HQQArPeKHv6T7C55O9lTYSNGpCe8ryjlnK10lAFj0Wd6NSc0jq41l9bTmLSPf/IU9/ugDxn8tSAMBk5n/5n71ZQJE4llultjyiVbvIgpeAptnEGcNE+3ni5Zn7sBYN1JyJ5+2c2Q1PgjcxrIBUerGSVXzek3ayGVy7cXO5dTKbboLySpSv6TVYUnBPfsZY7Dmkq5WSEbnIpuXo+T4RN8a3p1JI8kqFwMLq7fmadjI/zxhhYL1gs8A0GkVpQxoYtopuZRUSYeDlrmFFYuXWbSHfE0EQggdYnxDWp0NmOip9ZJfG1hjridsJu+S6hBX3v71AAfbxTVbWxgIxxO6paSwEVDWjHS2Am5LgREzQElD4TlYSz2eULF90hC70xXy71UdG1BNU08c/4TT4qJefmqox+2KsPaoEoWslSXxuYZmF2Y1GlU+L88q8tPEZt2RzJNiPb9tMQynh12tO+rLHyiDRVD0SN7Fc14hz+BkQXRbMc3UevAgrQfH/teem3vzhzf4/8N+2xPH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(6133799003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pOzwI1c53+medtDi7bGfEBA2GuNt7GUH5Q/jXUYARhrU/F1SJSk/u8jXLvee?=
 =?us-ascii?Q?0nM0CeaisPCPCJVopoD2IkCQrFqxNrXKAOXD1vP5ujGmkFQjYohU0O11r3WU?=
 =?us-ascii?Q?blSNTcrS1goTi9b1YdarT1BUZMT/+UXZSzQx/KjneSp4DjLC03vMLGFlUSHh?=
 =?us-ascii?Q?C6LCyicGQ8KIa91F4IqUdJiK/M1LrcYJmzrMaA0fGBu0VR+2oKyUJwIegzFN?=
 =?us-ascii?Q?xVmw9m22VnBRnYBccMNomTy8ODUoZdgReCb8vSH+9/Pbe8v043PuynDCgobv?=
 =?us-ascii?Q?gVzwWGHow9nT0dicynkBEpwTi4EL7if4av8TTu4Cf70EikP3Z05+g13MB7SU?=
 =?us-ascii?Q?CmqMQpxMvXNxPu6XBX9o5vcnwlvxSmcHW+3eawrETLu0CCXXOumFoZZFSIdO?=
 =?us-ascii?Q?Fjh2WbOkJD/A5ejvxF6rEZef6bf2ApRLva7esasDrmmCHHRLOOAfeODvSqTP?=
 =?us-ascii?Q?MIlsffKp5sPoE6NCIO2FBexdtsqcsIECRD5YenCtjVNxnlay/tdY7MBNzCK3?=
 =?us-ascii?Q?0QrVSACXc+hgoXjIUxxGGLZOeDLsmcrfvSVk2zZAo2n8F6sH2tf04c02HfYJ?=
 =?us-ascii?Q?YTHHod+MMnvZ835Hdqr1UvjgOycdm9vlRcZmqEwB/GYbmOhuVsy2XzXpHRVb?=
 =?us-ascii?Q?SuBGshgq9HdDDQpo1NziZWETIB1NsjBUA4KfJ4LF+W+jnx3XMq5K696u6sWj?=
 =?us-ascii?Q?U3rWG2NkoLMrBruDRrTl8Y7NHZxP0dJnQKLIg4Gei/DMV12qyZwkUenWAVPO?=
 =?us-ascii?Q?ienXj44/iHNJ+YNBCguJR9bHXQ/IZtS44/8QfVWM8ich5dstRj7X4Rw5JJO/?=
 =?us-ascii?Q?K5Zzl8CTcoyImi1il6siUrueMlZUsjjL7O3J2LiPeOsP9hIXsGrE8Krq3glm?=
 =?us-ascii?Q?xEvQfzImtBFXc4V58qnjZSw0qfIoHvWIZ25p8zp+78Ymgi+M/kEzIP5b1FYs?=
 =?us-ascii?Q?EWMFj70S68Y6xdtQAjlTq95+2e5kalz5DQnsvJ5zize44j5Y4zQPwzVt3y36?=
 =?us-ascii?Q?KkEZ/oPCWA+n/HNf6bxagyxb+mAyOLeET7nCz5X8d4k1cMBySUhKxmu11JC8?=
 =?us-ascii?Q?lyzfxtyuZsBrXwb0znsexoG58JdzJ/EvRwtzFyRg9L6YLsPGCtXxe5qRL5qV?=
 =?us-ascii?Q?LJdGydE76i+1YcB2YlyQYefvEqxLuR3j2B6WUekUKMbBZc311Os57hvSPJLb?=
 =?us-ascii?Q?963YJVspK0PlFdUpcN/cuuwiNTfE/aM5D9r9zJAbAyzkgx4ZqrWuAspO5aZ+?=
 =?us-ascii?Q?sshjL50CcZIHZIM/XXMRrbs2SyJdqDdUOhDBTxbc7BQ5d3jq7RS6VpF+Kv/d?=
 =?us-ascii?Q?/t9r2krkV4pfggcBKxyLV8QtBuT5bIB9AWLuNWJh+pWTvtzGFNDZWEq9cfpW?=
 =?us-ascii?Q?r1OE2HVPVdtvHH58qvD7KgVk6NcqrGYRwSPLPv2PW9Tdw+Nh+/HC4ehXnBl6?=
 =?us-ascii?Q?Mb937qjsxCVR+HjE+UM1o8OcWnAUgsFJQ0eeK+iZ/+w1ZENa78Du2LEHupFz?=
 =?us-ascii?Q?TF2WrEisB1YHmA6g60e+8uAV5Ka2KKAE5N3dCq0/vOV9pWyBrr+4Qtx3Ur3s?=
 =?us-ascii?Q?/igylKAlkfH+zzM1pdXeB+qXfbMMh/AIVNolW1Wrr5Z1/PGOneoDGZ7OPyq1?=
 =?us-ascii?Q?gJDTBCCTTVqBvmWOMVK8ueA/kRpaor7FWfuUB7j91wZDyuQJDvZsciOqdPD1?=
 =?us-ascii?Q?PzCW0vX8qHkfGROgL7oClXyhmF56Yv9jdldhCdmpWTFUHdZa?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1421075-fc29-4c7c-83a3-08dec15be934
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 10:36:03.4106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yFaLNZ+47nrlfWWIG+sAH6znZYuuloaa/rZ7kmUChRDFcKL96Fhz+8SCJ0qGSD4aDizBn9tU+6ODdk5JyMcJPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6575

Currently, while four timers are set up during port multicast context
initialization, only two are synchronously deleted when the context is
de-initialized, just before being deleted.

This is fine because the structure containing the multicast context
(either a bridge port or a VLAN) is only deleted after an RCU grace
period and it will not pass as long as the timers are executing. These
timers are also not supposed to do any work at this stage. They acquire
the bridge multicast lock, see that the multicast context was disabled
and exit.

Make the code more explicit and symmetric and synchronously shutdown all
four timers when the multicast context is de-initialized. Use
timer_shutdown_sync() to guarantee that the timers will not be re-armed
given that the containing structure is being deleted.

Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/bridge/br_multicast.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 5d6fdfb43c04..c2c93c740415 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -2027,9 +2027,11 @@ void br_multicast_port_ctx_deinit(struct net_bridge_mcast_port *pmctx)
 	bool del = false;
 
 #if IS_ENABLED(CONFIG_IPV6)
-	timer_delete_sync(&pmctx->ip6_mc_router_timer);
+	timer_shutdown_sync(&pmctx->ip6_own_query.timer);
+	timer_shutdown_sync(&pmctx->ip6_mc_router_timer);
 #endif
-	timer_delete_sync(&pmctx->ip4_mc_router_timer);
+	timer_shutdown_sync(&pmctx->ip4_own_query.timer);
+	timer_shutdown_sync(&pmctx->ip4_mc_router_timer);
 
 	spin_lock_bh(&br->multicast_lock);
 	del |= br_ip6_multicast_rport_del(pmctx);
-- 
2.54.0

