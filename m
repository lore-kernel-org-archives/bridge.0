Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9B01B4257
	for <bridge@lists.linux-foundation.org>; Mon, 22 Sep 2025 14:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758550598; cv=fail; b=Y+D00Mz6CqqEY+gG5bwB5kqInOtuyO0x0gitS3GYbu6BAMj5XWif/8906UFL1m5sPeY27n6+vhD8KJpGy+CATBq2vfPdtnUYUko7Cs1R5V13q9chr5zckA/YhXiusDCv2tLZ60lgcxftgedERXQj808TKxmhQH6V8xAdNvdweGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758550598; c=relaxed/simple;
	bh=BnzUkSgIUHsqkmCF1fNiz4QaIdZwBtVdt1+/wBhQokQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aBtyDB2hjvPC+lf52SsYMlhsFVaAIgm41DaZfIzK3CMJ1bt71CO2rOhF/Hgl54i5BZVZOXWIha5x9wYvXhMCIonqjSeLmEN0XaxwQ0RoxJq3viTUzRjcokY0OeDPCpv1WQUv2gtgqW95vy4fCHsB23HunL/uf5sANkpEZswl2U8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KPtue6rG; arc=fail smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KPtue6rG"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4814040488
	for <bridge@lists.linux-foundation.org>; Mon, 22 Sep 2025 14:16:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.103
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MoGh1Go997Nw for <bridge@lists.linux-foundation.org>;
 Mon, 22 Sep 2025 14:16:35 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:111:f403:c000::1; helo=byapr05cu005.outbound.protection.outlook.com; envelope-from=petrm@nvidia.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 47F6C41468
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 47F6C41468
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=KPtue6rG
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c000::1])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 47F6C41468
	for <bridge@lists.linux-foundation.org>; Mon, 22 Sep 2025 14:16:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EX5IJMwIdd1wHvvcTCX/psUFRqUpXkLOSRSBgYA3VnqB0zjoeSx230iF512nWbi67OoLMB1FWnJpNbMUov72Kn8WtS7do3nwvKMXUd+F3BjtSZvY1lWzRsIYG7jEPN49KTFk48T1dxg9CzlkhUW2urtnq5p5P8FDTcemy+RN1tDNSm7rPirjEd8SJKoyq2DNy6foHHF3/h95GGlzF+ZeH/BK2fqhtYtHAJOQwOo3229snO8DmZvuhp7WW+9h+ey/kQ8KdiFOvtbPkmBk//iCngII9AOE2xZSAt7vWfq39BNAs5tRo6OSZfqAR+ScT3NhP1PBIwbcpGcp82nvOlI5GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uTnw4EgjBCKHdGBXZFlPj8uFhIruG4EICb8+aO+hyeU=;
 b=g/2bJ/GyDGq/yPigEvtDIFdoeZFg40JGFywGRu+VqPSYroVeYYuTN97Z2XP/cBovahUZj3QAfCIzX5r4jTcAi+BIFXSfGsgPxI+9Hto1MYB5Rs+e2q51mGmyizeVz6ApkxDz2PDt3MetgJrCNRS8/RB/HYhD+MFXAl0c7dKKG5RMfDTwuBex0ysphpb2AawJ7MKAvx+lhkDHJNtIDiyNAL/fAiXCW5y9yboW71w1E2LBb7RxVZqc4WMYGKyd37L7YrmboGN3zsozTK9SXRtUqcw9pLkvCEHQk++LsjUq5uClI1c79Nl62ZlKALqYy61LJSOKVo+lqPI6/4NLtP1U0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uTnw4EgjBCKHdGBXZFlPj8uFhIruG4EICb8+aO+hyeU=;
 b=KPtue6rG4ep0FXQlC/q2U0bwI0mqyPQaHiyR6ICGhoQnB8mpLaqfTBrb3ip5zlmZpBEukPUPUAjLkAMykPTRe7cNIx+sPQlwYDV2+YvGOp8ysRc8CX8LIxCsQ6DBI/HDp5vnqMV7v0/qPOBp2iMi20SmkBSAJKURXBSatp95s6/D7NlroE+coXBoNFGqnsd+vYfQe77GlD+51936qJw/eOQGPa7GfJbmsAObDv3sJCtk0oGUYwLTyIiD9vwY0HVLp39T6pTT45wdRTnTOdlW7lnDSINFSi0LXkbhZIQmeSGk6Rt2qCGRaiVGhZWL/Dc//FV4orEeV5Rq6nn56tqf9g==
Received: from SJ0PR13CA0076.namprd13.prod.outlook.com (2603:10b6:a03:2c4::21)
 by DM3PR12MB9390.namprd12.prod.outlook.com (2603:10b6:0:42::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 14:16:30 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::a8) by SJ0PR13CA0076.outlook.office365.com
 (2603:10b6:a03:2c4::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Mon,
 22 Sep 2025 14:16:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 22 Sep 2025 14:16:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Mon, 22 Sep
 2025 07:16:10 -0700
Received: from fedora.docsis.vodafone.cz (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.34; Mon, 22 Sep 2025 07:16:05 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Ido Schimmel <idosch@nvidia.com>, Nikolay Aleksandrov
	<razor@blackwall.org>, <netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Petr Machata <petrm@nvidia.com>,
	<bridge@lists.linux-foundation.org>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 1/2] net: bridge: Install FDB for bridge MAC on VLAN 0
Date: Mon, 22 Sep 2025 16:14:48 +0200
Message-ID: <415202b2d1b9b0899479a502bbe2ba188678f192.1758550408.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|DM3PR12MB9390:EE_
X-MS-Office365-Filtering-Correlation-Id: 96581c60-eb6c-4c46-6dee-08ddf9e29fe2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7oSLf9OE1oKJRw3ufGJ6fo9eJBagCFrD4FsizH+M+ntYnKeFgqVOjsHKGzrg?=
 =?us-ascii?Q?CsbnlgjhUtR5OhYaCMdTb5B+MCC1jdEc2nM+v78+wDM6ALDD8Kf+w3YpG3ki?=
 =?us-ascii?Q?Mm+pWeG9OyTjTrD5QO1n/gPWvooRbxtkKk0ZWvVGDnqF//9T66pT72/TCpSp?=
 =?us-ascii?Q?X5+8fVr+ubrlu7KNW8jFNb4PGk8qtpOQxSZYbZchWfS7qS3jTWwsLA/UG2JB?=
 =?us-ascii?Q?PrwZic0yhb2XJSM7t7X0AxBkzK6FFFLBswE0qBD1h+XD3MD607/V6AJXMnps?=
 =?us-ascii?Q?RzhCNQCFjBN/vxTl+o9Kb7uiePxF7ZOIcGmHAFKrpshElkgsz7nJUDRCFXFW?=
 =?us-ascii?Q?eQ52NB6xSgsiGa9vgy9fOasuug9x4JKYn89mWLpXLPWN2r2ozhQf5+qsha3j?=
 =?us-ascii?Q?hmR8NXU8VmW5L63wDk48h8WSCQCsN67BcI9Ao0ExxN40IrktIg73PDL1QmO0?=
 =?us-ascii?Q?jFVxjTPxSvUS5GNG5bnUntjNLqg9OI5lbauwDvE1mt/qPuEy7genJtT5YTdB?=
 =?us-ascii?Q?7iBKgYekml+9gxdvwqwye3Ol2NTgYacxK2u/qHqNOGAsocAxh7L2HAEOCCLU?=
 =?us-ascii?Q?gZM+Rh+TsLS6oCrMJ7XZLKIHn/grN8f3aCvzXsrw4MCTgt0lJrN/RaxZGDUe?=
 =?us-ascii?Q?Shc5dkAB8QZ5rc74nBbBnTH+CYE2fI5OEoMJaLYAgBhQheBc1mWR4cAcAWAh?=
 =?us-ascii?Q?T5UmROioMX7ou0XSKTOLXeJMoCy/SGoQuG1trMaNpJXpzbXeggjo5BO583bf?=
 =?us-ascii?Q?BoBpxj7iuqD4zR9O5uBQDQ/7uluHGToBk2Uz6rpBFSowfFk/Xu/snBzgroA5?=
 =?us-ascii?Q?AdcuI6dRctA6XXHnrTs/iOyEQ00nQS7aSYR1rXCbueeGoacv3O/Zr7yaDdvq?=
 =?us-ascii?Q?lYqj29d1ZuaVxbJWcvHMcdufStwGQlC2OU4w2Zi+zItZCgqXpf3LF1Q/KOoh?=
 =?us-ascii?Q?e464W4kS1yfyumVdSyWQ9Amf7FEprb6ZpnmftEAbCoqVxLbaOI2NbR24kDrz?=
 =?us-ascii?Q?G/TMJINFZUKRMLD9I5Og+Tw2/wRsKZKSNp0jvnGGnSfL7dFu7OPKMJDobPL2?=
 =?us-ascii?Q?KBf1JNXQMU/FSRC3ODPnVY2UEYekkT4VRE1nisaeRFyaNLQYE8QUcxcBpUqg?=
 =?us-ascii?Q?rTPTCGR6Mp2WeZLeCmOSQkMSVrIPIVdp6Rew4CXiGXHEKF2k9CJqnuJF4+ng?=
 =?us-ascii?Q?U+BiM34opoxhuJvrHHRlsAxucIwvOzMcUBrjAU/nEOjMBr+mqNqyxwjJcxvK?=
 =?us-ascii?Q?18B46gDZosp2fjrJzemBizj3TdCM55JFLAmiioA5EANHdBnFWsRiIEwQ91mZ?=
 =?us-ascii?Q?CIg8+RSdrUsahDrynS/qX3OT/+umGbbSyZSj9l4EX7+2SNfFHsq55XlR8UKk?=
 =?us-ascii?Q?kfUtfx9TS9ep9NW55reQ2Hu9utNo4B1QFlKea0zgLP/TtjtCVrtmukk0blOF?=
 =?us-ascii?Q?bREM2YMcz95wgPKHBWkBRLMjxkxgzf0TuttqTcxETaMbxC1qKgqne0+1gFmo?=
 =?us-ascii?Q?cBdAURzWRMe55J5TmuWQmUxmZQAw5hRh271i?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 14:16:29.5641
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96581c60-eb6c-4c46-6dee-08ddf9e29fe2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9390

Currently, after the bridge is created, the FDB does not hold an FDB entry
for the bridge MAC on VLAN 0:

 # ip link add name br up type bridge
 # ip -br link show dev br
 br               UNKNOWN        92:19:8c:4e:01:ed <BROADCAST,MULTICAST,UP,LOWER_UP>
 # bridge fdb show | grep 92:19:8c:4e:01:ed
 92:19:8c:4e:01:ed dev br vlan 1 master br permanent

Later when the bridge MAC is changed, or in fact when the address is given
during netdevice creation, the entry appears:

 # ip link add name br up address 00:11:22:33:44:55 type bridge
 # bridge fdb show | grep 00:11:22:33:44:55
 00:11:22:33:44:55 dev br vlan 1 master br permanent
 00:11:22:33:44:55 dev br master br permanent

However when the bridge address is set by the user to the current bridge
address before the first port is enslaved, none of the address handlers
gets invoked, because the address is not actually changed. The address is
however marked as NET_ADDR_SET. Then when a port is enslaved, the address
is not changed, because it is NET_ADDR_SET. Thus the VLAN 0 entry is not
added, and it has not been added previously either:

 # ip link add name br up type bridge
 # ip -br link show dev br
 br               UNKNOWN        7e:f0:a8:1a:be:c2 <BROADCAST,MULTICAST,UP,LOWER_UP>
 # ip link set dev br addr 7e:f0:a8:1a:be:c2
 # ip link add name v up type veth
 # ip link set dev v master br
 # ip -br link show dev br
 br               UNKNOWN        7e:f0:a8:1a:be:c2 <BROADCAST,MULTICAST,UP,LOWER_UP>
 # bridge fdb | grep 7e:f0:a8:1a:be:c2
 7e:f0:a8:1a:be:c2 dev br vlan 1 master br permanent

Then when the bridge MAC is used as DMAC, and br_handle_frame_finish()
looks up an FDB entry with VLAN=0, it doesn't find any, and floods the
traffic instead of passing it up.

Fix this by simply adding the VLAN 0 FDB entry for the bridge itself always
on netdevice creation. This also makes the behavior consistent with how
ports are treated: ports always have an FDB entry for each member VLAN as
well as VLAN 0.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 net/bridge/br.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/bridge/br.c b/net/bridge/br.c
index 512872a2ef81..c37e52e2f29a 100644
--- a/net/bridge/br.c
+++ b/net/bridge/br.c
@@ -37,6 +37,11 @@ static int br_device_event(struct notifier_block *unused, unsigned long event, v
 	int err;
 
 	if (netif_is_bridge_master(dev)) {
+		struct net_bridge *br = netdev_priv(dev);
+
+		if (event == NETDEV_REGISTER)
+			br_fdb_change_mac_address(br, dev->dev_addr);
+
 		err = br_vlan_bridge_event(dev, event, ptr);
 		if (err)
 			return notifier_from_errno(err);
-- 
2.49.0

