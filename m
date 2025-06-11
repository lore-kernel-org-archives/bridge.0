Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8DB23AB86
	for <bridge@lists.linux-foundation.org>; Wed, 11 Jun 2025 12:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749644435; cv=fail; b=gUCoDHvAcS8k6baJI3+wq4TBwtkhGIjc41sch+BWu0TA+Q+0VxbBxA4Q1UfKlf0ESxtnfDoSyQ5NZBh7esrOtWncXfdyYOKSi3QmOU/Co6dQ3JXShGdXMONxiNT0omzj0yTX1VBosRrsBHrn18dk3W6T/ETVk1qFNlULyWeny1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749644435; c=relaxed/simple;
	bh=pfQ3/O5SLgFZCc0SytTE5kRQqU9yqLpzpTB4lHBXEBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BPRYHz9cD9qenrFhMe+MglwEumCd297aAsBp5AAGJD2ucPSmX46Wr3ovaO9pX7bTJlOvBbnL386oOVFPnr7m+vrlE0qsLbd0AOGKSs05vYdnBenOT0JVaztm3tZQyhpsFmVLhbaGHKO+5naR3q+hn0QfEwqv9NUYqRtKSnqeuX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bkkIKHp8; arc=fail smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bkkIKHp8"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4AC3581776
	for <bridge@lists.linux-foundation.org>; Wed, 11 Jun 2025 12:20:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.103
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bdShvwIPBYwh for <bridge@lists.linux-foundation.org>;
 Wed, 11 Jun 2025 12:20:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:111:f403:2413::600; helo=nam10-dm6-obe.outbound.protection.outlook.com; envelope-from=idosch@nvidia.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 249C9814EA
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 249C9814EA
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=bkkIKHp8
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on20600.outbound.protection.outlook.com [IPv6:2a01:111:f403:2413::600])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 249C9814EA
	for <bridge@lists.linux-foundation.org>; Wed, 11 Jun 2025 12:20:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ARyJ/Xvo4pYN5oRcarAC1/eQKKIdSiGen5Z7FrgMhr5U63+q0KqE8kMfYIRLrhvPXP4XYk5gCpmpkq+d0JMeaSjU4RxxC6uzjI9Se6exET6tfPv7YLRM7ahSu1aa307C3hzeRJz7DlnyRcrnjwxBhd1vgWt+98rVU1W3DtbKqz/yJ+GMNPZ8N8gFH4IjqEh6gHRVg280j1/uMxz8eqbcJNdu4SptIDqvWw9JeRWg3p2s/LaJqGtkm7bwWa6EkfwSimVWNxm1WsoXxdVqk2wKXlFLfF2jH5GWjw4Yhk/q8qOjASWe0SG5eRTnis8pZslFogiU090keoOXm+aRbjPNbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FxdyNyLDME9ykANbboklNS79azwDO/AI+m56jecuPt4=;
 b=gAN24Tltu9unay70R6lwgYDaFMU6dKqF2HKcgQFBMTG09gISotQDsg6+57qC3FRWgfhnVVO+4bHOECAoBz1mwAutfVe3merX78eRu1Fitq2R0x8cLMMFgXhF+vQUohQP7kkwdFloSeUvxuUnFYzoNBGzo4mvyKggFlrjcWoJt+nx7MMJqFy5v/AXEVqCOzEVfPV5wCnMEWYPILnori8O+oG+gShGvRaGQH56scDTg97WhmcGFqftxpsnhtTkfUxNCSdElU6Wdh0UnCcwcCAOx8jFHTAWZDJ0hMHonK9aXd1+pU/hpDajLT8PAunpoZs1VO3CVPTLiSsZAZFzCZ2lFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FxdyNyLDME9ykANbboklNS79azwDO/AI+m56jecuPt4=;
 b=bkkIKHp8W77TEDo4UmU+MBIvcnnH15OGL/5erz8a3SUEBOkJdbdMc8vopl2ZOvnrKtD6buyUnOyU1utoo1yqFR6nqdLSOrKiY7gvQb1Z3/7/S01clCGWUsdJBIbU7iJyFzNaSMw0QtP8Bn2ozvPk/x9wuUATRAbeVPRrs8djq17Oy8pjKdc/H+ltIdLpZL3X5HHE7OHXKNovhSBnSoN9B5PGz4uDVtlfJibZv4U+mtzgjTtZ6XiACBNeoRxQCX+DrSZ7Eg29mdLUbgsaaVMShd2z6avmcfYcL0V1yVFeQWN5DbJA5Z+K6RdghtaF3jeSthm3Zu3FfLIpHe6G6rrm7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SA3PR12MB7903.namprd12.prod.outlook.com (2603:10b6:806:307::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Wed, 11 Jun
 2025 12:20:18 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%7]) with mapi id 15.20.8792.034; Wed, 11 Jun 2025
 12:20:17 +0000
Date: Wed, 11 Jun 2025 15:20:08 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Fabian Pfitzner <f.pfitzner@pengutronix.de>
Cc: netdev@vger.kernel.org, dsahern@gmail.com,
	bridge@lists.linux-foundation.org, entwicklung@pengutronix.de,
	razor@blackwall.org
Subject: Re: [PATCH v2] bridge: dump mcast querier state per vlan
Message-ID: <aEl0eD0qm5xYgvE7@shredder>
References: <20250611121151.1660231-1-f.pfitzner@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611121151.1660231-1-f.pfitzner@pengutronix.de>
X-ClientProxiedBy: TL0P290CA0011.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::13) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SA3PR12MB7903:EE_
X-MS-Office365-Filtering-Correlation-Id: 48a5ec0b-8202-4c50-e25c-08dda8e2539a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GA0SblYCxz8aWzFLUFcibZSli5dMv3hFOxSnpH/vfwHo83mP4/z9Up1FJoPx?=
 =?us-ascii?Q?DqBvmW39DaWAhC5s4wNPrlr/Qt1dzZnSj3mrwr3RXVKe3Xg1S5Num3/JvyMP?=
 =?us-ascii?Q?G/x8/QPZKtTOfvPKqnF7f11ZHCJut+T0nP44eyq9fFhDvm4OiWgFQCSY9Cav?=
 =?us-ascii?Q?iLCt5OUa87W1aazugvNQd9bNYQbiqoI43w1CYBSf+8bDaKSrsZB35A/wef+F?=
 =?us-ascii?Q?ynYjc1wQeT9zP6EPEveJzzSdvhYTANxw3wewwpaMrxJrvMBvwwc7Zp3XgdKO?=
 =?us-ascii?Q?Xe/hKiFPloiXY/2cp4em5vat+avE2m3kRYyRpZovkJnSq7+2/lSvY/YzqqUp?=
 =?us-ascii?Q?uhPHaaP4OQkChqfdeOF7ZZwegZQSESuXNepKmMYI6j/UqCfyJUEckcCniQfO?=
 =?us-ascii?Q?HWdCuWUoH2hjXVyFN0XNIB0goG5c1CnOFJM7av7ZvoaLjZmN5mTVfJhQSFDw?=
 =?us-ascii?Q?VhkfYDiV6Mya0xjhkEfwrzGNygrg7n9HZFkp8mEPOvk0GGTxEngYd+fHiepm?=
 =?us-ascii?Q?lf4ZukTTXSwnc/wtjnUNTIILarp24wBPS2g+TkpPVtml4Pv/9bLq8ZbV4KDJ?=
 =?us-ascii?Q?Pw+nA8diwKtfDvL9Gj/xf9BnVUySkPyxu3jZGdHERuMG38VPbnHuwAV0gqQb?=
 =?us-ascii?Q?iuDnw/1gP4VnonHKDwFpyNH3S+NdaNOmGBF5oTxyx95OLudlrjoglWIBz9qc?=
 =?us-ascii?Q?iXkHW58VcMqflmy1b+8f7K/stoCpCxRf1lLlfJkWJ0AGbiO0BVEWBU9CifCG?=
 =?us-ascii?Q?arLtqzKAz/1nZelxZeGFF2Bo0DdUQIJU0i1++KueBOLxYEL4m0SaaeMwqHJ2?=
 =?us-ascii?Q?3CjX0yH+2ZBGudmNx0MBNkARAlQUVEsDEDkADdPm3OwsNCFbUFbsgl8xgoo4?=
 =?us-ascii?Q?bnwEsqhk0CXi46uCbRu0GRroR1LwaDwnSKHKbspb5MxO6B3i4esTtLstnZJY?=
 =?us-ascii?Q?7FbFbPdzfkH9Emrwb+9teWxznsJAw8v0lwuP2rlhzuaUPQ/zk4Q+iJXc/6Kv?=
 =?us-ascii?Q?Z90uPJsh+EqVGaOeee4rnraCXiyzx9KoMzkAe+H7NtlkCdmPEa5OH3vWbzz6?=
 =?us-ascii?Q?JK3JuNByJ++XdgOzi85DzsfWDIT/D5h+Mk8cdJBp0uxuZUtLFqzrV18wZW9h?=
 =?us-ascii?Q?KbL8z4hIp6ZvNpry8dM24rSB+8o9iMcUIagOlKFG9c7dnYyh1KTr/Wu4u5DT?=
 =?us-ascii?Q?D/+eIWepXKhOzrhlrTaukpaocm6DgPBEHTpLSK32y2NbryUjMz9qbiPEyrbk?=
 =?us-ascii?Q?ON2DBTXk4ln8G7O03ASOIqX9kfULn4Uzc48nTQVw/1ZKCz58MQcEW3Wn5um+?=
 =?us-ascii?Q?UzbNBeWZFQBmKi9RNkwujuQco1UKC7QDSqU2D9Szm1KqYQ+88P/6us4LCr4S?=
 =?us-ascii?Q?ETR6MhJj61wA070xth+EB+QVVtcWsREsALKALUDt2Qzlk2qnDG1qtvQhn0Jq?=
 =?us-ascii?Q?vdHPoqWuz6Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?97N8v/cByzPW8hFJjU2k8YnGamnfroUv3VCCiCf0MlJ8AZIc++mgPl+1wiqZ?=
 =?us-ascii?Q?lrWEC1t3Ih8LzlNCmjMGQ0QGH3Mnw1Amj4b0NbtpsLysBHoBTdN/sFnVvmV2?=
 =?us-ascii?Q?yWJApoXxEx9qrB36U2KwoLhoYGCnWFrRZcwENFkoTW6CTYO5f4mAw24wETva?=
 =?us-ascii?Q?jZR21R77oVeo6RU/Nj2QX0eX/9k67yEiFRWTYnxZlrNVsFuOGz+mJbreDV0n?=
 =?us-ascii?Q?NejlhcVVMXVyvTgGG4dvyBHXrsPpEWHrhcx5/lGTXt/Odi1km4N+dpfg8Z/t?=
 =?us-ascii?Q?RQbgiv4dKlkH+iBFpWEFt++9Ou1gBDM7XGi6ET5bwTbVv7/ebe/EHPfYlYwy?=
 =?us-ascii?Q?dJqYglt4f/6LybYquVKfYBwfEVbMjPiqNNK+5e+7CQ0PQKu2moRZbHZK/ZWb?=
 =?us-ascii?Q?CRv4NHErpRpQ6YFOVUrmSQTyyoWXGmegqD09i/tBxX1AU5VcFanvuWAxhLX7?=
 =?us-ascii?Q?sBSDULdzWXYjcnZcjBOloPP/+yi9u9z8U4tz3nzHltohmBG7TbmhuM3a5or1?=
 =?us-ascii?Q?tKi4zKKH9fvlalUqxPb+y03RNWfO/N3ExIVxRejhTiC234+pRO8KyO4tBGjo?=
 =?us-ascii?Q?YYWAxLrY0H22nyZ76s2SvzGcWlgn6qGZooaZennNQ+z7sQPTJOqJC2Lm68Jb?=
 =?us-ascii?Q?ftl4Qv0v55I/RcnPNBSbi52zCEcomgeLH/P3QRsmAVcevJIEwfEyfaHTkhn8?=
 =?us-ascii?Q?0UfdlqB9vlOOqOAGKoHzE4ceRRISfDCEY+JOokaTI/B6uhO8oFAuJVaOwtpM?=
 =?us-ascii?Q?A4SCZDL9w50Wd/eYj6uQWcg3CYtxFNYl+IPUBxd8B0xNstSxSR+9gI+TIiyB?=
 =?us-ascii?Q?ox8Dn306VbuzLjdCmdB4RtHFIJ8apTDZMeuS0NXsK7jOMFPNTIpTxRyg0fwE?=
 =?us-ascii?Q?aQvIYHdZsT5wm5QqKZk5irlQU8RwW0JjtqtNa/AowEFMlJyC30VUwaLNmOpH?=
 =?us-ascii?Q?AdV1IbRyZmli7USNjBozSZnTnX7wgBdLdpFHhUY7clMGYXP1o/Va+FpJyZ94?=
 =?us-ascii?Q?9GCDuyN9Xarqs+wQxkJETqD8mvtwzRkFLfV4QrhYdefDQ8H5lOCsTmMkqIka?=
 =?us-ascii?Q?sK2uTiscaLEE1DMvfB9br1Gn8XQWGkJOh7NWb3IZOKo556tTOG1M8rjYs/cp?=
 =?us-ascii?Q?4LdqqVmdlvW5bK/P+I5Xwws37NImp1RlcttyIA+hOM6eugzA4W9pymZZMxkd?=
 =?us-ascii?Q?0YmfBFbsc95kgHbwxI7sYdKPEoSnbsY8xJSH/9sX1MAMvBo88ZnZCiFtv7Pi?=
 =?us-ascii?Q?J+SBpHEIrCRO+QeRiPNAuRGwE7+QN3uCb44bOpyfl2VSi3yDXVQWVCzbgTEA?=
 =?us-ascii?Q?4V4bfA8hbg5MijiitE+ZAfV6mlPz/Vnwcxqc+7iukgkxAXV1vjACH8ZajyZx?=
 =?us-ascii?Q?F3uihsyMnX07aF6gpm+n2uMBDwXAXWCVKuqd5TVksp4nZzvOyP0aKQSAwZPY?=
 =?us-ascii?Q?OQpbVhTuFCuS+VAHB7uG6nTYt0eViir0GqzbkMYQoibZxpB3Fh8OsyONhwS+?=
 =?us-ascii?Q?zBtwemoIrERIvVLikF3Gi9fi79S8zp+1/IOWWnmFNjF8sQVe9KccrYCDf69N?=
 =?us-ascii?Q?rMEgDouPDy5Gf3PFXL79P86KBc8Mj26fCo6RMw6M?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48a5ec0b-8202-4c50-e25c-08dda8e2539a
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 12:20:17.8380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5PNuvOYHDJw1G+qC2pSWDmOUMw+EteKD/0oyF3+vI1lCpIl6PaydInMowWBUo7I/jjsL5ynI8uwUshziKlYKDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7903

On Wed, Jun 11, 2025 at 02:11:52PM +0200, Fabian Pfitzner wrote:
> Dump the multicast querier state per vlan.
> This commit is almost identical to [1].
> 
> The querier state can be seen with:
> 
> bridge -d vlan global
> 
> The options for vlan filtering and vlan mcast snooping have to be enabled
> in order to see the output:
> 
> ip link set [dev] type bridge mcast_vlan_snooping 1 vlan_filtering 1
> 
> The querier state shows the following information for IPv4 and IPv6
> respectively:
> 
> 1) The ip address of the current querier in the network. This could be
>    ourselves or an external querier.
> 2) The port on which the querier was seen
> 3) Querier timeout in seconds
> 
> [1] https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=16aa4494d7fc6543e5e92beb2ce01648b79f8fa2
> 
> Signed-off-by: Fabian Pfitzner <f.pfitzner@pengutronix.de>
> ---
> 
> v1->v2
> 	- refactor code
> 	- link to v1: https://lore.kernel.org/netdev/20250604105322.1185872-1-f.pfitzner@pengutronix.de/

Regarding your note on v1, there is a patch under review to add a bridge
lib file:

https://lore.kernel.org/netdev/8a4999a27c11934f75086354314269f295ee998a.1749567243.git.petrm@nvidia.com/

Maybe wait until it's accepted and then submit v3 with a shared helper
function?
