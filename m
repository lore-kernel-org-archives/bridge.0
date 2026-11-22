Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.33
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795332464;
	b=s/fHgceR2eAH3Yh1XHdFLaMm74GuZSY/djcUxtnFtKUBw1iItM56X8/i+aD95DAsz7EO
	 tl54tp/aJN0FwymZ++hrROdkg0hRmUyfatTkIHEb2sAwDPgnlIABqCYquCbkFDnN5Zt7X
	 BoZ4bY3MestCqY95d3DotknbmPc07Aht7A9GoRQgWPqZKJB3upyBk2NmSCJmeaiHBDvfe
	 YC1OCoXmePsFLQUsnzANAjwpzlOEqft7X6qYBck05IxcS58sAvCnAIB4MjUOucCDWpZ4f
	 w8maMIVzUdJXHqnIwKZKou0mJMKZ59WJlATZbbGvK8rzYsdkllouPGoAYQeJCY2OG9Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795332464;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=WCZate8X2fWlqf2Jlj+3L5Aa6pNXKCWjylCRCfTpxQ8=;
	b=4mEr/v9PgNPnXJlrPl9u+aGaKNpEoCoEIXg4BXzRgeP/6UsSbbRvp+pGXX/HS6UyH0Tq
	 zRAd/yAE3lAn4J7bFa6u7221FG1aGV8hSVOLotvhWjm84kFwW210GH4zXhnxxPKja0dnL
	 gFrG4XWHYY9cyCKL6/wHXZLwrO0inV9lmE2PG6vxkmQFdHVeTo/sW6j68M8nukd9V+7D0
	 AC2ENzxBef/4MdxRdVgLnThvMlRIFRgoAkTLSDgg+RhObzUVJDEwGyNauevO9AlPtacyt
	 zoyZ2rGygu1IoslqfRpHNkXbEXJ0WERhAlN72IO14YKFHXF6gUM3RhfYEGgZ/1p5q/Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="hzT3sX/N";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.33
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010033.outbound.protection.outlook.com [52.101.193.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D281606A320
	for <bridge@lists.linux.dev>; Sun, 22 Nov 2026 07:27:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D281606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=hzT3sX/N
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VSvgMcc3c+eQx8aK3fyDAtaiC9MMX1C1reuJzJkQikR75IoxjBVahUbngnb5y90RGLDzhgjXMKmqEmDvCLL6svhfoOMd8rnHCHyQKqayTd5jsSalM47x+OVmnZr6eLdrJQFNWpMHGyJojsOdPg95uuds+N0G5pnt3Wpg12CQ/68XzGLn1Gv9F03Y++Cyyzt8Yjfkjb1lN2l1jArGDn8djw9eKAy6Mbt08gVl758L21HaGztKuqdsx5N0w9GzQl57Y/phTRW0LtenEoDz+Kl9dk1CXbdR/yPRR+Gs67bh+FQUuaY4iMTDPeQ8La1AzoAtlI0nbDmV9CNeV90H3jQSUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WCZate8X2fWlqf2Jlj+3L5Aa6pNXKCWjylCRCfTpxQ8=;
 b=KTzVEvLKm/QZ5p/FqQg/FoMg7cMQdIAq+4RiL25gquF1pG1WclDwObTrLPYzIOcR1Ivb5PDfdKkEYASgUWYahgabeyYK4PLKz03hnclUKrEjZbaIAGwbnMPEKv4oecKs9eSQENlScetCQFIs01xb9ffS2QWD38FNXn/tiuTvU/eHFUuE68Hk/QopC8EqWJuuHbfIL3te6n+44emdkI2fy2BrOUlBXjes4WVWqGEFG13P88wWMi7IoMtYFpSLIzhfAUFGf+p+UEYo1j3d3tdCwI83kQmoHjKsFom2ZqyUZmkg6noS6qLM4pZo8jfoDIjJeSM9sZ3SjQVKveufbogsNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WCZate8X2fWlqf2Jlj+3L5Aa6pNXKCWjylCRCfTpxQ8=;
 b=hzT3sX/NPAy1gGwtcO9kM1n0/z1tkB2UUflZiRnxIIddOqowBfTiud4pAsroUHU4s+jv/lPDFVwaB4/xkzYtrocCRWaZZDATyuQHIxvWClUQbiB6LN0dgZ+GMaHGJYiBHiT9h7TH4yMeeIC+VozzsKrvsJrK+JQakUNAeeQ4cyTCpXqwyM0pT2VRIxtZvt8z19LixySbLpPAXZWib7jqsRxi5CqF8QIaCZHn5tMfwcmf5TaT4VEufimEBVvHnZ26Yq4YwwxJ/KGaNEBWUIEq70pJvgNYWl/ROSl7vYMFXiwIaclX4xMui/gVx4oKQdEPh9iV+B3nXFFKftyhwBXQcA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9407.namprd12.prod.outlook.com (2603:10b6:408:1f9::13)
 by SJ2PR12MB7963.namprd12.prod.outlook.com (2603:10b6:a03:4c1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Sun, 22 Nov
 2026 07:25:36 +0000
Received: from LV8PR12MB9407.namprd12.prod.outlook.com
 ([fe80::208b:424e:47e9:8a96]) by LV8PR12MB9407.namprd12.prod.outlook.com
 ([fe80::208b:424e:47e9:8a96%4]) with mapi id 15.21.0639.012; Sun, 22 Nov 2026
 07:25:36 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	willemb@google.com,
	horms@kernel.org,
	razor@blackwall.org,
	dsahern@kernel.org,
	shuah@kernel.org,
	bridge@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	kyuwoncho18@gmail.com,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net 2/2] selftests: bridge_mdb: Test failed source list replace
Date: Sun, 22 Nov 2026 09:25:04 +0200
Message-ID: <20261122072504.2623702-2-idosch@nvidia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261122072504.2623702-1-idosch@nvidia.com>
References: <20261122072504.2623702-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0025.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::20) To LV8PR12MB9407.namprd12.prod.outlook.com
 (2603:10b6:408:1f9::13)
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Post: <mailto:bridge@lists.linux.dev>
List-Help: <mailto:bridge+help@lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
List-Owner: <mailto:bridge+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9407:EE_|SJ2PR12MB7963:EE_
X-MS-Office365-Filtering-Correlation-Id: a781b6ae-04d3-4201-c0e6-08df4869cd89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|6133799003|18002099003|22082099003|261009223027099003|3023799007|261021121427099003|261021123027099003|261022105027099003|261026140227099003|261026121527099003|261022075727099003|261028144727099003|56012099006|10067099003|261102123227099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	onsob16pgyXZ/V+i/merykmMW53OAEusdqSQ3LlqrI6nva/eQSH61H3wFy3i/iO1eYTMEQgEj8IM/YgJOuhMyOK3Ax/LcInCQH25ZGgr20PXjPhooH5PkTAfsM1zcHmZZET778Dfb60g8fVa8w8k6FBgk1EN0yDc6TQ0rebAFxEPvINfa8xbu5O3VcOZM/qfJcF/rXERQ+y+7IK9Ub+5Yn4j8qz5B3GdNFNbHfB7DVUwwP0kf0Gs5NUV0M3cOdWtSoAWq2Fm8N1R8YDshwmlN2gSz6G/nnvfLpWzE2kYGNjzO263MuSxKcfD2AtLDw3nLNDnVfBlQfKTe5qNw35LSo0BOUkTC/LXKMg/fvG+CIeldwpbyU3qNcMdUyTSosRE1miVz5f3NmKfCSBA/j7KRTSp11Nb6ARKCTnGQWhAFSIg6u3NsHjaOu3+EeGkhrubK+xtbbTX45OHE5T8h8JmIz2zZSep9gJ06e12RH8SA+MFy98twwZLJtKvzWAR3onSk27a4rYTYJbhfATVy7qYWsUeRziKxVAb3o/zpE+Ckv9OpIy6o93D6nyJsh5PywxVl64KaU/kvO2YtXI8TftJab+0kRZPgpaBWle3gQP+esUlbRdPOi435WniO7SwFkSYS12RjfgfyLQm5v1y0mty8jSyy9YDE9kPqGn3Q9Cdzes=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9407.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(6133799003)(18002099003)(22082099003)(261009223027099003)(3023799007)(261021121427099003)(261021123027099003)(261022105027099003)(261026140227099003)(261026121527099003)(261022075727099003)(261028144727099003)(56012099006)(10067099003)(261102123227099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ugmnoDz266Cj2QpE7hXPgHLfiRYNMKyUoVWj5wvcWXW/1t1VufP6TqnphMhy?=
 =?us-ascii?Q?tbNHvC9kSx8eAaoXGx02MpQXlnfDFpmdxB1WYQTXyQErJt4YSgVpMjGxrDV6?=
 =?us-ascii?Q?JPqR6yK2KG8ZPWw8hXuutdzj6BzUtntG017sIFfcHAlCoN5Lsa68qmG2ac68?=
 =?us-ascii?Q?dmcobQ/hEqFhLdcql0FkhJkMe4cvfpwvqEAZY4gfuJf8+EZtDQwlDTiGGPdE?=
 =?us-ascii?Q?XLL8sAcCzdsM3VzHF1EMGiy3vVT6YIu+pDYnu+3i21E+Upy9REh4pZz1iPLQ?=
 =?us-ascii?Q?KRM8oR7McGCVwFMHYSUq9IgNAoXEmt05pP9XUNKDQsrz8XtiWgmgX/w9hUFX?=
 =?us-ascii?Q?NOtnQMuQqaWkBOgjd0c5QWbmAZKtU+v9XlBGOhqplTNa8hb7okN1ZS7u6qoU?=
 =?us-ascii?Q?qyvmEUTmttbot2PDyJeimiI5WfSOp+MhOXFPMWEkbDhOX5VkTFVVDMPOgMu7?=
 =?us-ascii?Q?M7OJ5JsLqW+Ia+ATCyk8HexyZu2tyFvtiJKF8rL/WDpgMRFU4fKEF9AdOiu+?=
 =?us-ascii?Q?KdcUcg4FuXTC4uptSvXUGmNIOcjvGwlKbog0h/PKc6OZ1kTa9+CmrrRVCw3g?=
 =?us-ascii?Q?YCWswJXlOLSdWzW2Rh1AN0c/R3HD6Y2TBKROC5sg+Aiw6XSN0X+B4epRf/Ok?=
 =?us-ascii?Q?VYMcQjQD8Dk1OxhH2AQQbd5IJFsSwOSj/es9SxzDnuod7litFYmfIZqnzIF7?=
 =?us-ascii?Q?r/1j7n1iUHsJvKERITo/c5IGk+FBCDcAhwQi1f7kYPPYZrzCFlKZUa4IrbXD?=
 =?us-ascii?Q?xE9WbAzK5q3o4d9rntMbQPxXjnhDIOFWPhfTFFLh07JLxPlh9cEMPrGk+Q7w?=
 =?us-ascii?Q?CYZdF2DGfKN7ECep9N5E0qYY3qUvQ0j5I/LYzMz+66YMBpWBCyYkNETAF7/f?=
 =?us-ascii?Q?qq/JtbFLCN2l/nmlBRwqrLWkRIhR22samLpWmfiwBy6e/C9ItD4G7CiT1zYG?=
 =?us-ascii?Q?SMXjX6w3sUC6gzVV45yj7R6W5P55p0YIKccw5wRmXpyn/OSaaOF+m1z93rHI?=
 =?us-ascii?Q?vIHa5Jex/O5FuVYLpO3RFkKvZQ1hnbcinhpEr8RBYX9UHAGGb9HIdys9G+Ar?=
 =?us-ascii?Q?OYfQL+foB72BESw5MuI075DbJ/d81o/kIuplxjoX2/EKCGTuM1rGy/3dkiSC?=
 =?us-ascii?Q?CsG9URJt0Q70b5//W+prO5akmsVhEkciAam3ygiPkPTWF/Nznqj4fJtdWinI?=
 =?us-ascii?Q?+UBcP4uaJ1hqRCFJwMC67dbPsH97XyBn46DXG/Q4cAh6ZDR/NTH01STdM1JU?=
 =?us-ascii?Q?fDxRgSY8nCwji1GRmzvmCwguvroAEmN9blo1EDyNUg7NtEEFcdjyfCCQrdGK?=
 =?us-ascii?Q?iAZg5/9lhB2sFw8/59YhuDKHt00hGwVr7kYEoO79hZ0J9D3KYz1x4DJ3m0bz?=
 =?us-ascii?Q?bx0xpVJaBq8q/J28ZlC1zfJ/aziw3o+Wo2SWToQ6IMdHWl1WrjTpzHWUyuba?=
 =?us-ascii?Q?GiG47mw/ruzGp1gQ9AkZlKcCBpTaDrMBbgj5snnK2da03UDSGzZPg0hntPmZ?=
 =?us-ascii?Q?Wis91hf5UURlCcLrqpN8RU45Mm9ghA6ej4eEXpZyvWPZaTk01lKwm/xWkQMA?=
 =?us-ascii?Q?1hocA62pnYeCQ3QcWDLTlaxgpgxm/oMCM1ajPCwWxYTctU9Nn2xDMCxAyfPA?=
 =?us-ascii?Q?NpNKGw9W1Qmz5rUoS6/OEaQGXFdCSNQCoBmlTkzmJpdu9HIpApR7PIWcrm6z?=
 =?us-ascii?Q?iEFzmAUxDbWCfsnb1NOYBGgSD2zBTYJ0l3W6GDz/QPsaoOS5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a781b6ae-04d3-4201-c0e6-08df4869cd89
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9407.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2026 07:25:36.8454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CL1K2dt7teQx0VAxatqjAHjcUbK0gpepItTud5dn+rz+YJ3+upMsOUTl0gnK9+GzqrRW3XZjcf2bsnWkGXttvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7963

Add a test case for the issues that were fixed in "bridge: mcast: Fix
source list rollback on failure". Check that a failed replace of a
(*, G) entry does not change its source list, with one of the existing
sources specified twice and a new source.

Output without the fix:

 # ./bridge_mdb.sh
 [...]
 TEST: IPv4 (*, G) port group entries configuration tests            [FAIL]
         (S, G) entry for source 192.0.2.1 deleted after failed replace
 TEST: IPv6 (*, G) port group entries configuration tests            [FAIL]
         (S, G) entry for source 2001:db8:1::1 deleted after failed replace
 [...]

Output with the fix:

 # ./bridge_mdb.sh
 [...]
 TEST: IPv4 (*, G) port group entries configuration tests            [ OK ]
 TEST: IPv6 (*, G) port group entries configuration tests            [ OK ]
 [...]

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 .../selftests/net/forwarding/bridge_mdb.sh    | 23 +++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/bridge_mdb.sh b/tools/testing/selftests/net/forwarding/bridge_mdb.sh
index e86d77946585..712b9a5a0e5f 100755
--- a/tools/testing/selftests/net/forwarding/bridge_mdb.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_mdb.sh
@@ -293,6 +293,7 @@ __cfg_test_port_ip_star_g()
 	local grp=$1; shift
 	local invalid_grp=$1; shift
 	local src_prefix=$1; shift
+	local invalid_src=$1; shift
 	local src1=${src_prefix}1
 	local src2=${src_prefix}2
 	local src3=${src_prefix}3
@@ -487,6 +488,23 @@ __cfg_test_port_ip_star_g()
 
 	bridge mdb del dev br0 port $swp1 grp $grp vid 10
 
+	# Check that a failed replace does not change the source list.
+	bridge mdb add dev br0 port $swp1 grp $grp temp vid 10 \
+		filter_mode exclude source_list $src1,$src2
+
+	bridge mdb replace dev br0 port $swp1 grp $grp temp vid 10 \
+		filter_mode exclude source_list $src1,$src1,$src3,$invalid_src \
+		&> /dev/null
+	check_fail $? "Managed to replace source list with an invalid source"
+	bridge -d mdb get dev br0 grp $grp src $src1 vid 10 &> /dev/null
+	check_err $? "(S, G) entry for source $src1 deleted after failed replace"
+	bridge -d mdb get dev br0 grp $grp src $src2 vid 10 &> /dev/null
+	check_err $? "(S, G) entry for source $src2 deleted after failed replace"
+	bridge -d mdb get dev br0 grp $grp src $src3 vid 10 &> /dev/null
+	check_fail $? "(S, G) entry for source $src3 created after failed replace"
+
+	bridge mdb del dev br0 port $swp1 grp $grp vid 10
+
 	# Check that protocol can be modified.
 	bridge mdb add dev br0 port $swp1 grp $grp temp vid 10 \
 		filter_mode exclude source_list $src1 proto zebra
@@ -568,8 +586,9 @@ cfg_test_port_ip_star_g()
 
 	cfg_test_port_common "IPv4 (*, G)" "grp 239.1.1.1"
 	cfg_test_port_common "IPv6 (*, G)" "grp ff0e::1"
-	__cfg_test_port_ip_star_g "IPv4" "239.1.1.1" "224.0.0.1" "192.0.2."
-	__cfg_test_port_ip_star_g "IPv6" "ff0e::1" "ff02::1" "2001:db8:1::"
+	__cfg_test_port_ip_star_g "IPv4" "239.1.1.1" "224.0.0.1" "192.0.2." \
+		"0.0.0.0"
+	__cfg_test_port_ip_star_g "IPv6" "ff0e::1" "ff02::1" "2001:db8:1::" "::"
 }
 
 __cfg_test_port_ip_sg()
-- 
2.56.0

