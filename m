Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.63
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793308028;
	b=NXpn4RfTymD62vsPqZU+Zeo+cdq5J79xo2rFl3uwQo2Ec9E6HeIm4gUmfbuoE2zJMGpr
	 c35WGjwyx8OtQwCdOwt+L5eNjVkoQRkvxfp9XfAvF+Xz1ANxgKt7MWOpYexGf6LjaX7OI
	 3mDM4A1WK0igEfyZbMwsnVhLyC0rASJNtc+zaEWWQOPXIkOF+eKQ+iA68MCYmspAJdYYa
	 jrWUsPnSQDlIVCbNdLkQ7hotVk9pfFPGjCpeakRTo2yzw9lCnxHLi49CPbQS5Ah0mZKTg
	 tvEkgYtVtlVo/5ivwZVssqz1YCZLrzta8T913P7EP+19dRgExXTcjFUPvRZ3vfHoMZw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793308028;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=BA19MkknKHlwmK/pkrg+bh9QKov5Bs/Vn/UrvuF8BS0=;
	b=3QXK6i3VRF3gByDEG8oZ75KS6J5Tc3Ac4LdMKK30znEly/jFS7zdA6yWxdEzuXbyqGJc
	 lY1+N8HiLorzOHwp3sMvgsQmuCrK6smmkvfJsOVG+GCneuxX/cNSlnMLPiDmfxHhBSLLX
	 z4SKEPVfIoMkg0pihe/ADZQGt33QoxZA/Ryv2Kp9H7nASEsYuq8zHCzOZuboreCWbaiiX
	 wniPRIWyVB/J+1qsLwOGPVOFYG9j+7op1fYEg2Fi5Qti/7pIkTg9IR1g4x0k6PLFanar/
	 k5aGPsbbDNggkk8aN1rOV+aNrQs3nHe0IEMkjcre3VKqKKbwp/o8iT7OjoQv0nskRPw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="PhbvR/Gw";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.63
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010063.outbound.protection.outlook.com [52.101.85.63])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B884606A31E
	for <bridge@lists.linux.dev>; Thu, 29 Oct 2026 21:07:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B884606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=PhbvR/Gw
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TWcYCsWnEJ3gcCBMCWgS1pwArUKJ7cPZtyTIzL2NvnhaDuAKD1P/Jo5re2d6qgt/99tqFtdg1ck+xwybSesakpgq6vIWhA6yGyL8LsitN7+6QDLjQ8iGqbYHDK3xlsKDOlOSzXlI+YliQZgPVh81yfdctehMj4vQ+Jw24D4WVDyOmpxebTPuxURetq32+Il7bNz6F5kmjNWmYqiDDPf+2zBYe2j0prNh9WYx3gnVjLFXYXlD/d/xDyYFzXHkmaxTv/pF143+VKgdobYq/rTRrVRWkMvkcYRM60SxZCR2un+a44Pavmv20IJAHUuXfaCdaDvKdtnhdkrVgNS5m9SvdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BA19MkknKHlwmK/pkrg+bh9QKov5Bs/Vn/UrvuF8BS0=;
 b=VZW9bNnwDoKYSS+3ldaDAgyVafJFr6K6ALGOmfhNDxyNmuVqCaDpJTRUxxzgL+l/EsZFCTr3JQffl+a+K2HQfLeGv38LeiBZuEkIhPE7e/jL96UGVoSAK0n7kcM4RS4uyLhNn0TnxdbjP4Gp9/gCKK1aUMXm/TuX2o19jN7u5YHDdILfLKPTKjcc+2Ip57+0VftUvHQcRhVCuhUIpwd1LCQncy+HeNPDg+TimAfoI93p4fQyIhr3I7vvmLeMdkEnwEh8sdM2/oD9mWvtqgHZFj0O953CxfmTjevlheqXhjN6i2qnVqLZRr6KB0MuPaRfShrd/W4z3+TNXAUSSV4g7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BA19MkknKHlwmK/pkrg+bh9QKov5Bs/Vn/UrvuF8BS0=;
 b=PhbvR/GwNc2GkhIzpNqhqL34udgwZtJJIXa6BRWhRKEnxC0hCHWMNRpn3eLQrYlnW1EO2j8IXUQ8arZUUM0tBtZgLmghBnxsUIoHN3ynGJ7tr2dgbPGsKaAoLJlLZD8P5urfBZr3/9ilhtXuBx20Spih7JVVYGpNkK7Px/cEv7NoL61hKzPazCx/WSUTEGMzJ7pZbfg9lflT/VNoWt+VYRJj7DS10CFbkcrwDCD6Ue/+1y8Rc/nd87TPJ4E/k0H54F3doS8OE/pkQE7ZzqJi5dl2vYd5SeU3PEy/dBSB7QitabhBO+7UE2kIJZxAEoYQUJ4ppG0oJqGXIkBp/7CIrQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by DS0PR12MB8574.namprd12.prod.outlook.com (2603:10b6:8:166::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 21:06:57 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0569.008; Thu, 29 Oct 2026
 21:06:56 +0000
Date: Thu, 29 Oct 2026 23:06:48 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Cheng Yongkang <teel4res@gmail.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, bridge@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: bridge: mcast: validate the source limit before
 replace
Message-ID: <20261029210648.GA1492006@shredder>
References: <179328314075.648427.9644307795980106759@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179328314075.648427.9644307795980106759@gmail.com>
X-ClientProxiedBy: FR2P281CA0177.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::13) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
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
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|DS0PR12MB8574:EE_
X-MS-Office365-Filtering-Correlation-Id: b9ee638b-cd5b-4cfa-5953-08df360090c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|11063799006|261009223027099003|56012099006|261026121527099003|261021123027099003|261026140227099003|261022105027099003|261021121427099003|261028144727099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	N9RirD+kEz+9PD6ueVmVF3FQdu5jvT1/Cz1rAnyqIyozX3gj1Qllztf9Y8xrmZnMe8vUmw9j20EzUwVcrI3AYnIBYF5pef396eHQz7W8eJPWoVrG0TPrGypDJ+Z4BMqzmnyqs2pij21CwOpA96JFQWJcY87hKi8xNFVBMjMW4EE5CZkIGx3YRl04XJEkcdf1r2P4892oZ7T98GkDLfyqUCUgZodCakuNZTMZXjJAa1krbKT2ijlYRmwla/TROEKcZYDY31Urctv6pnJAv3NXVxFmDusl22LXbjy0yYv5YE2bixG9VVanR5U17RaLeA0LTAzd5P9s/tDZFpH/XxIBqwyvfTjBD54w2tMMGPFmB9dt8b15YRvnVT9MC49/9MxbrJ72bbArjMytnjxnuFi0f8VUDXCPLAP9QA2Com9CR0ju6Aw/ThzkIrIvsVtAe7x3g6fdfgsmRUkazVmwOdVsPU1kTIZkgCiiOFMzfh8Safl95NybZ4hh87qC/PnBERheHCI94Sny6EpPRaP8t/5KX078wQLoxRiR0Lbv0MFI/MDBGJzRIq4VCkaK+p4kom1Yr0x/wNP4kUvdKz1FjyjZSRYMU7Fz0GiK9XJL56nwcfGEkrqSTvWd9UocLwROFlpuKCg1CZhlAJYnP+LlwX6B5FZ69nsfFtliMFWv/N/k92U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(11063799006)(261009223027099003)(56012099006)(261026121527099003)(261021123027099003)(261026140227099003)(261022105027099003)(261021121427099003)(261028144727099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d1SWfHLvpYycC2ZKLaUtaHSLu7ZO/g5j8avKB/REzqD0gXTgemcY6vfpkoeS?=
 =?us-ascii?Q?WWI4O6A7/uLGvnBBrkkqdK9t1fJY2UF8Wttys+NX0JPzZAmMsIjiz2P7Rd1y?=
 =?us-ascii?Q?mmGTHem/HDFeChnqoCOqD6gDTYQ2GqEf5WLemUAw30zSWXhqZ80q2+X+zSLD?=
 =?us-ascii?Q?YkzjacN4SZprRHV81RGOznpoPUZF9nIJmuaxSBBnGL9fFdBP9CJWvsKjBuku?=
 =?us-ascii?Q?GKS+UjQiLUdlmtusZkKb8WSP2Z5t2yIvO1SBYMYgMpNSS7YBrZixkg3Tkmwc?=
 =?us-ascii?Q?TkPmbsdMjuBzTQ/zRtDDLOx9pUcCPYodgjcmVr4NVs/IhVhUsa+Pg1/fMxdE?=
 =?us-ascii?Q?zHi13b+d2nAeJXtcfQmDghF7mvY15STBbg//tyoNApIKRCIA5xgM3l5qEKCy?=
 =?us-ascii?Q?g4ZtDpnplDlh0iV9jCwxRY6ymzo1Z2wOCvdq80120iKdwIBFnhX1FwzTSPf6?=
 =?us-ascii?Q?vhgiGnjxc4GudasKtf0Yv7j7KCzTI5KvQemq5cuPeiX8oDIheM1AYIEFdC13?=
 =?us-ascii?Q?OqJZRM+OisciRZcCBasHlyUz1N4QbXfxy4ddFQQdUTUlIC9j+HTYbi+0yV9N?=
 =?us-ascii?Q?4fKzq3UuW93zTXxCWo7dQD3w39prwWTiZjDDgNTL+9WDJNlTWFjBkLTxzGV1?=
 =?us-ascii?Q?dIQgYUW4slCZgpz3g7jZK5Z2f59AYrIbBZUr1VjM4H84g+U28y+z6IT+V8mf?=
 =?us-ascii?Q?Rrz8j4umKQDCXDhTznx8GYOdhiM/VIobcTfeO6kCR0vcnftG6LPjXu8m9uWl?=
 =?us-ascii?Q?4WpDmc4W3OeLt4RTHfZkSKFOAW57k+8nh0km5mxi/8wrULKOEKoFWsE17j5Q?=
 =?us-ascii?Q?bAXFTBGbTXpeSNBlizscmR9N8Mpvq9K4MExfvx3jtSViRVv/l5EYU+8g7Gd0?=
 =?us-ascii?Q?nmUcPxes5G3gjKKpeFb8oou9YFpf2aU/4RygbZXDC+fl2eoXGuT1cuukH+Ko?=
 =?us-ascii?Q?kRqVdBG0045T8sLL9nGfWoGOZPwFtP84UpVhxHj5+FdAmMUwuTLINqdHc0Da?=
 =?us-ascii?Q?AZ3PKcFU6sgk2ywUjx2gtDJ/a4cYf59NkI2xpLPSV9AW2oJ4zFd+y9NVmWu9?=
 =?us-ascii?Q?jYtN7NG90X/i2TrMa36jRBt2cluQ8IUsPP2cA3k2iGZIy2dpgVkdIecSlqhe?=
 =?us-ascii?Q?6Pm4hM0XyKs7FSVt/UMCcA6A5+PTW9DZDQW7M9k0x6DeCtoyhVkN7vxSBDzd?=
 =?us-ascii?Q?yXGiDE+F67oYgk807+ZCZobqTio8W9xgYb7QLZDyhN/kBHgJjl8q00dVmgip?=
 =?us-ascii?Q?vTQD6JHbe9Fsr8QVRpcw1X+ONlbybO2wdlCRe76PWTenmZJK/IDTrXahv5Fy?=
 =?us-ascii?Q?bGjv0ohCa65A88yi2AB53LGKBHG1m0m4Gyj1YQcXOlFdyMeB80Whoe/8TNx8?=
 =?us-ascii?Q?Q1PTn53LvxVnSIT1Ags/oJvXFeJO3gNQAEW1Y5arTj4GBzcSjEGWcnwGMUah?=
 =?us-ascii?Q?S7kYucAIgnd5FP7q7+2EQaTA2wFo+r+UYnC6mB4hMs9B8KjMr2mYZb2QRCAe?=
 =?us-ascii?Q?Ogfk5LsS6+NgRKqy1yMRA4Hp/O1w+aNcsPiAxAUs3jjFE8P4cuNrUlk8qOvY?=
 =?us-ascii?Q?4efmW+rCmb52SYem50lN0AtE0UZ/pXV6OFpj1ckctmu5bm+6l6QjCrkWySri?=
 =?us-ascii?Q?sPl9JxuWFiFtW4TLBD6ti4e838smgK45NHPmAaSZ6UzZ7nKo1Nn2vHjHscrJ?=
 =?us-ascii?Q?FKwDRn0ALYVNw6Nv2p9qAi7z2G1zRNd6CAM7ei+O8CNCKLz5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9ee638b-cd5b-4cfa-5953-08df360090c4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 21:06:56.9125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D8l9RpSkC35eIoZ4jDXAIHZ3W7wbwjyv43CganrcrNj2UoElu+tTDgxahqUC2mkZyi/XEaYaKyPjX2hgBfi/Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8574

On Thu, Oct 29, 2026 at 07:12:20AM -0700, Cheng Yongkang wrote:
> br_mdb_replace_group_srcs() marks every existing source for deletion and
> then re-adds the sources named by the NLM_F_REPLACE request.  The add loop
> checks PG_SRC_ENT_LIMIT before allocating each new source; if the
> transient source count reaches the limit, br_mdb_add_group_srcs() unwinds
> by deleting every source it processed, including the pre-existing sources
> it just refreshed.  The error path only clears BR_SGRP_F_DELETE and
> cannot restore those sources or their (S,G) entries.
> 
> A replace with E existing sources and N distinct request sources not
> already in the group fails at the limit if and only if E + N exceeds
> PG_SRC_ENT_LIMIT.  The rejected request currently leaves the group with
> one fewer source and removes that source's (S,G) entry:
> 
>   before: (*,G) star_srcs=31, S present, (S,G) present
>   after rejected replace: star_srcs=30, S and (S,G) removed
> 
> Count those new sources and reject the request with -ENOSPC before any
> source is marked deleted or added, so a rejected replace changes no
> state.  Valid replaces, including ones that transiently reach the limit,
> keep the same behavior.  Other add-loop failure paths are unchanged.
> 
> Fixes: 61f2183512a7 ("bridge: mcast: Support replacement of MDB port group entries")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Cheng Yongkang <teel4res@gmail.com>
> ---
>  net/bridge/br_mdb.c | 51 ++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 50 insertions(+), 1 deletion(-)

I'm not going to review this. You already sent a bridge patch [1], which
I reviewed, asked for changes and you didn't follow up. I can only
assume that the same will happen here. I'm reacting this way because
this pattern is not unique to you (see my reply in [1], for example) and
I'm tired of it. Get a patch merged, then continue to the next one.

Also, AFAICT, this patch doesn't fix a regression (never worked) or a
security issue, so should be targeted at net-next which is currently
closed [2].

[1] https://lore.kernel.org/netdev/179268538303.70821.8213834342995341232@gmail.com/
[2] https://netdev.bots.linux.dev/net-next.html
