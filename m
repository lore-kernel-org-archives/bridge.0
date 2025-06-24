Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C05028468E
	for <bridge@lists.linux-foundation.org>; Tue, 24 Jun 2025 12:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750766504; cv=fail; b=dFTDK4AJ9z2/nXDQ0IcmkgZCu+MSoBnMUJeqHVqgpp0I9PpDEqliKAaNbbQidIt4RgrNWyn6M0PjxmM3RheLVKPAfrZmFbXKAmcqggav4UhzF+7phq460DNcgLvlyZ2jVnxVlG9eq4pmsuRc3Tn0Tk/gwG6wCXXYz2NxTsUuy7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750766504; c=relaxed/simple;
	bh=UddOvc7Z1aYVb1L8Gw6K7Imb4n0edoLs9l9GDnbVRwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WKr4IXkiiknT2L5EA3on2H58M/lIqUDchCorsP4YSb7mWAV6iEwNCV6ecD6z9GLHpVvKmuL48tkJybAop8UZQ1VNVoyCSAhC1m8Eq6HI0W7Xm3Aj8sm2K5J7AbuQg1x8bdPAKD5ptkOKHedj0gnqt+ItbwOKK+uF9yWVIXsCVhY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Le/poUp+; arc=fail smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Le/poUp+"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D609E816E4
	for <bridge@lists.linux-foundation.org>; Tue, 24 Jun 2025 12:01:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.103
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9ER2bKlVtfiT for <bridge@lists.linux-foundation.org>;
 Tue, 24 Jun 2025 12:01:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:111:f403:2414::628; helo=nam11-bn8-obe.outbound.protection.outlook.com; envelope-from=idosch@nvidia.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 42BCA816E1
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 42BCA816E1
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Le/poUp+
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20628.outbound.protection.outlook.com [IPv6:2a01:111:f403:2414::628])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 42BCA816E1
	for <bridge@lists.linux-foundation.org>; Tue, 24 Jun 2025 12:01:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F2hq0QfXNKfr0Ye6FeeE2SNcjS0k/wUMmk16lLIYPkRAoi3ynmN6wjEwds1+62FwLDBrPhl16dAjHMgTAmSYoSzIqSzKd/t3Ciz7xhm5g12KEqvVimrycaIpKcrzUdZb48sbsorIcIn8vZbTpWKX1GhFMz9wu7EoYsYy0QFYGzYrdycIT5v3akIw8P76roxvHPngLFR8DNJQBaJ0d2NrvmiS/Xw6ZIFE5bcKX3n7rpF9wesbEi0X+Qk0l660+hQhu/+M8/evcexRK8H5Q91FDKgpQqwRANyGPpVPA/1RPFiXO3n0EivAOVNyzf9sIA7nZ6IVO9S1r4gefmtE5jTqAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QrkorpCT8dZtHxcu1BWHL7iNhj2YnCGiimPzXOZsDY0=;
 b=iwucGjopeTUZrEQe+RSIEl8/eVYWD/r7tB/uQZZI7fx+xbi7Ns+Un85AVweT5ch2DQqZ/Tb7ylNTWudF9mgrFBcrC2r7qDEoZKdE8YV+fR0KcXXIO9z1l1ZqsJ8gxoy0WKO35Ocu1tt1SzW/OASQjfVNtUL/LnY4IZDKaWtQyEqyJj7X+L0fZ88gzmO6p2UbeTvK9QZfZdD9HnbPwYN/weqTByVhD2Qr206Ob5WyNqinxZZ/7D9px64oKcX/gQC9WR8yt3rWS45oXJwgPOtX+ioxpBz02D6DjZ0KjagHoPZMo5PsnYKkFDfojuAQPEAHhbeMyVLCbdhSsPAH5Bhkhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QrkorpCT8dZtHxcu1BWHL7iNhj2YnCGiimPzXOZsDY0=;
 b=Le/poUp+K2wSrMre8rEQHQh/1CqUJ00ZOcosggaU7GJGkbQbnn7gSGEGrThw98rFZRpIqClsrJrsVoMicuxHKdueDkzVJ8xUoM23lkQwMpXuZfL5UJd1bbAEurgC5o2DQj8Afpfhz90A5xTydguKcMB+WqGK3ZANs/HxQTwt6Mu9lxztgB3l0kxliOyb+ok5n03/qmYTVXsVj+17reDGnfOJZeMh8iwd5ukkW1fPeO4hDFcaVgMTxf1lFWQbwCJIJKmP3yZYumDajU/Pi5yxdB6GTK08cygTodHeOi69ppPkyeob2pq+lgOcvcHKWRm0qZboqhZz5ITCsQe9UuKxTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CY8PR12MB7099.namprd12.prod.outlook.com (2603:10b6:930:61::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Tue, 24 Jun
 2025 12:01:36 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%6]) with mapi id 15.20.8857.026; Tue, 24 Jun 2025
 12:01:36 +0000
Date: Tue, 24 Jun 2025 15:01:22 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Fabian Pfitzner <f.pfitzner@pengutronix.de>
Cc: netdev@vger.kernel.org, dsahern@gmail.com,
	bridge@lists.linux-foundation.org, entwicklung@pengutronix.de,
	razor@blackwall.org
Subject: Re: [PATCH iproute2-next v5 3/3] bridge: refactor bridge mcast
 querier function
Message-ID: <aFqTkm2SH7189QXL@shredder>
References: <20250623093316.1215970-1-f.pfitzner@pengutronix.de>
 <20250623093316.1215970-4-f.pfitzner@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623093316.1215970-4-f.pfitzner@pengutronix.de>
X-ClientProxiedBy: TLZP290CA0013.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::6)
 To SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CY8PR12MB7099:EE_
X-MS-Office365-Filtering-Correlation-Id: b644e2f4-1075-4a19-f500-08ddb316decc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XXANkan97LVWhqpeLLSm6ySmqq0b7iBeWSmLnmhOR67i6CDWkAOTcjamVbKK?=
 =?us-ascii?Q?hJGRXyda95oIeuYpDvrctreP6WqEwln3a3AZ7Smb4yga0dCGmI+K7p8zTHLQ?=
 =?us-ascii?Q?Y7VWks3/XoF53OpXHIoSf0/ZkoODpKYi0cMX49k9tTVcAFgQdyjVuzu/nDxn?=
 =?us-ascii?Q?aMBfE0e2tsuDQQbO+qcZ1soRgWZ8RdsqWQygQgtg78nfIL8Q6h3lXLjffgKg?=
 =?us-ascii?Q?6XJKRFG7y6FCdEpK88FxbvYnVmlWJvDeLrxJJSIvZ4eE+4EV708QMZeZm5Nw?=
 =?us-ascii?Q?tFfCBq2bjhU13cJ1hr2X3tZXb/YF8lOmzC54LmqCueMeVfhLZ709nJcYnzw2?=
 =?us-ascii?Q?jFXv+8T9P2vMG435GscBxYz517pjWzvFXS4Tj+Gzqz5Z7MWzMjoj6uo/ZzR+?=
 =?us-ascii?Q?UIS8cmZTA0lqsJWhzeeC3/6M3BiGJkpzZdJDdWl8kPkFZPN7KC+zw2j5lp3x?=
 =?us-ascii?Q?xH7uhlHTCYXjljJDECcYPHLUEIa3bGp6e8nizR7e+Cspc11ziX7kPyNRZgS9?=
 =?us-ascii?Q?b2e3OyWPbAEAdOlLgRt2Ke2jZ56TrhKDwdy6USeCGAc9n3BPU2k2oQ/ww4Mo?=
 =?us-ascii?Q?g2RMVsm1MGfHClAolFHy0+SehMjrCbcgGS6+b8kdHyU1FEE5bHYGZ1RXosol?=
 =?us-ascii?Q?k8wigq3og7QMWyKNfbeVXnnttJGGmu4Q1LKgQs+OUyOQf7aNOoij7AMAukHb?=
 =?us-ascii?Q?XupzBJy80FPCbO9WEgn068foYVz5U5x51Xwn+Mf390BcGQ1OmTwnKJ4D9vSL?=
 =?us-ascii?Q?V64V+QcC0qQIuY17uyN9W4KWiKzv15Qxeu+7DU3+5E1YuZpSmh01KWBaxkJ3?=
 =?us-ascii?Q?BsodjplrfugUEReZy1pQTGIg+vQplQhz8YCgmHyneKmGrNLyc163lSg0L78k?=
 =?us-ascii?Q?DZ3uv+wBvXUJZvbHXK0G75m3x+tveWFQPiAkBzkewZQVPwY9v/N1N47ytB/O?=
 =?us-ascii?Q?BnH4jt6bijXA53Mjif3bwCYRGG1ET03ZFVTEyECmQgX+bLsBbB3+u7oSxEBr?=
 =?us-ascii?Q?/+OcG3xWFaUG0SxmwswT2lol/BuY6l8TRIe+ll7VqKD2buBQXPl89dFsaG27?=
 =?us-ascii?Q?qI91CigdkCjRF8QjFUJqnVuFzhGHK4L/see9JDC9YzenoVz87AzkhR1Wk604?=
 =?us-ascii?Q?4Rg40CGGRg0bvLB4Cywx1hhuGGAGmTULQtOLeIKeo6X7bLVFKeKto0C3Dddd?=
 =?us-ascii?Q?BeLCGS4fANiN0AGGQPj3QdqdTG2cR99LyFxmwzmTlale3rCtskxlrtYYtcNo?=
 =?us-ascii?Q?RinapZ2FAEOzrIZiliujyZDcYGnNFPRkFEbUKNJaGc3GpsmYEdNX9SBUtjqX?=
 =?us-ascii?Q?xUQ7QlaQzzbCbuAdg5fzQrYpGSFcQO6OxrTHdtfTp7yOPMOwe8jYlx98KrvP?=
 =?us-ascii?Q?Nai9+ebBlFGJkbfOD7nTKTC/MQKZC4pjDE0IjAcbuh+gjzI29A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CRFztu0OR3SCAm32cm13ww8DSS2Ab2OJ8r5qluYwxjUI5fCsw5c9pCYLXMjo?=
 =?us-ascii?Q?UGRUo3XF8lCwpL+u5pAjTPiWbo83VI3Uzjz/85pKpNi8gV3EBIb0v6SgtmyX?=
 =?us-ascii?Q?xavxduFPDXvLPRkhbnMHRwCsNDl8WcvabINVpqKym+KlJlnCAw7MDWxL/K/e?=
 =?us-ascii?Q?884Ts6I7rhXRXTKtTJnXDYVsUvqxNktXl5W/OkQZGOwMQbVgWsmDuxU0Jkwi?=
 =?us-ascii?Q?ltiPszWbDilTxL4f5hklKaTjigDbB1kaNUSzKrRRUPW5H6WjckFtwi7EY4BD?=
 =?us-ascii?Q?Bs8M6EkY5OzqBczRWE9QIojAO9SsOTmJs81J7jpzefz65PkrkTWDP5Rn9HGJ?=
 =?us-ascii?Q?1SRKuAs0bU0RK6QrYxdVbkocD8+d7aZSJ2Q3ytl4WCT3aaLCBM5fAKU6r0aN?=
 =?us-ascii?Q?GFUu+yzbsiEr7t72cyEArXCRlzlBoDz3Uf3EdKu8fC6hQuLehpq+eaWIzrns?=
 =?us-ascii?Q?CBvgZ+1JxgzRecKBOhLVsjB7/HtVMubuJPEE+T9ukI806YBy5kZ+700tJLWv?=
 =?us-ascii?Q?SYw8xaPdQydgchg7KlW6jVG4mnWLydpLVjO7vvykDxeE26FHoyFPXwehJfS4?=
 =?us-ascii?Q?56weaHib6zZx5vChz0Tdtq5WS3e2kGLIAoqMQLAJ8OkfOL1C7YRwP/1wTLoG?=
 =?us-ascii?Q?xh9cG2Y8FR3uV854fFKuAwwGE49b5MD5ylcbbbWCfooC9yqmqaBWNPTWA7G5?=
 =?us-ascii?Q?hanOr3pJVQ4ZfrTAMZsN8E+Js8nG1buJZqD7oAWuct4sfBWgxTphQe536emI?=
 =?us-ascii?Q?B/bctOferov6eSIKt5/k7ILdS8YZ6rvZEBEdnxs74gOhxGH3KfLdTFoYnfcF?=
 =?us-ascii?Q?RSZxQuHWDeJm5cS1KAYWi385pNKZO4JTzzaBtQR6O3cFDxiK0M06Nb9snrR6?=
 =?us-ascii?Q?YbI9bQnwgYllpJAlP9/7CbP865wwfX+rYEkP57WRnT1tsatjlGAnl7+VrCYf?=
 =?us-ascii?Q?ldQVCyOkqsUsxJrkd5AYnvY2gjYQmzBMm/AwgtagifZbfBMURUIryf5A0V53?=
 =?us-ascii?Q?L2R/E9EcdajAF6nC7AEH6OEjyyRQPCNIoUOPT9hbN3SoChBb+0+KM6kQGwOf?=
 =?us-ascii?Q?YobWUlIfzUUjztvB07SoQ/oIh3UMzcslysWFrRtBLOBsGzshwClnImb7zX+8?=
 =?us-ascii?Q?ckP5YAw32oo7c9pg98UIQRI2iaBDJ57Sd/VYpzjuMXsxIHQBNxQxBoDDPw5Q?=
 =?us-ascii?Q?6AitysBU/AFBP1Qh/ztWSezgTZLwuAt37hXPLDYWe+SvsYN/JqjHNU63X0vA?=
 =?us-ascii?Q?Ha37HPJyTwSlGp36mrMTMjqaiH95JIGvh2b9GmXl2xIuZHMmLTqnehciVnVe?=
 =?us-ascii?Q?plD4C9cA4oBqJiUcazU1q4Mr7PithW8TouXZ68ITuNgtLvLRv+t1J8cDvUkq?=
 =?us-ascii?Q?CHwXbLv5BXkWFAD5dJyy1pwxuN6Kxyw43z/Ec0UizwSC0TvT0u8RiyCbLYUL?=
 =?us-ascii?Q?qsgHImLA5ZuqTZaBbJ3ajBoT48irizoGAPL5ANPJdERbI2MRognFfuclH5LU?=
 =?us-ascii?Q?TWAjD5kFv/4018ggnuZafwAwrhjF++Xag86CoKbe/GEhkfgcxCtMuRwmEWHB?=
 =?us-ascii?Q?SBjb9OAd2RO+BA+zDm/qJF8F/dH/PzitP7RlxrdI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b644e2f4-1075-4a19-f500-08ddb316decc
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 12:01:36.6183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gj6szEP7TwhiMsPKgyMHEY6lIwl7PTlnEYYXSzOTb8B/S9n9RTjJvA0/eX2W+oPuBGfNm3Esvlo974k/gH+8rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7099

On Mon, Jun 23, 2025 at 11:33:20AM +0200, Fabian Pfitzner wrote:
> Make code more readable and consistent with other functions.
> 
> Signed-off-by: Fabian Pfitzner <f.pfitzner@pengutronix.de>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

> ---
>  lib/bridge.c | 72 +++++++++++++++++++++++++---------------------------
>  1 file changed, 34 insertions(+), 38 deletions(-)
> 
> diff --git a/lib/bridge.c b/lib/bridge.c
> index 480693c9..23a102c4 100644
> --- a/lib/bridge.c
> +++ b/lib/bridge.c
> @@ -49,60 +49,56 @@ void bridge_print_vlan_stats(const struct bridge_vlan_xstats *vstats)
>  void bridge_print_mcast_querier_state(const struct rtattr *vtb)
>  {
>  	struct rtattr *bqtb[BRIDGE_QUERIER_MAX + 1];
> +	const char *querier_ip;
> 
>  	SPRINT_BUF(other_time);
> +	__u64 tval;

I suggest removing the blank line before "other_time"

> 
>  	parse_rtattr_nested(bqtb, BRIDGE_QUERIER_MAX, vtb);
>  	memset(other_time, 0, sizeof(other_time));
