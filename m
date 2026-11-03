Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793710330;
	b=dk2AnygB/sjyt6She5UG7ZvLsrcuyd/0oxeH9WNbQ0Gw93mWybLJrDCbSWSHVF7JHTm2
	 ixR0OQllSP+0g9qpVFHNc4ky14cUdjWi385CpWaIKhAwrlNeESw5uy/iqX/jjvrcrVspg
	 Sru3qNC6k4xdhb17BhNlP0ptkCksr6yLHeVzq72TOiJergfnbFzFbbO5wCxbviJHg/bhZ
	 TCwRUqumUgxnOdy1TRTpObf6+v7jNRH1rAoBL8gYQPev2jpAOA+844S41Azg19HA5LE4i
	 PfK+mosgL5DEgiq1o5tvCgpjDYnmFQn8N5o0Z9ncFmnAZ/e7MTuBKL0/swgz7BpI6HA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793710330;
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
	bh=qDVS3fI5EAPNe5VPy+e6tXLKgQzezE0kJT2690jU7Uw=;
	b=HSAv5XkfsrrarQ1tn+lGPXkXNJjRBv9/4CsvKYtKjMVLU2omTqmJsqCXab9pJFH5beq+
	 TNXN8y7Rl8AtKCPuNSHpNIzBtWlqwAwBK4OF7xiBJ0vxCZgvVA3sXkGtYz9N+7lcu+5wt
	 LpZZtAXNN/PAyFUyAo+SpGJuk1bAeMhgKJl/mJhHkDR/tV/oH+FqUTDWuRltVNWJtqb1f
	 pTnb6EHn2Jrk3fUaWCT+BeunyiQlJzGmUKWIrk8IG0AvRffvi9veo6KeIyJaEzvPC+Kfg
	 SnGzPT1K32AJLcC7lLpgdBQSBX/eWbgx3Qm2VOfaCohw7m6ZF5m6ytTB2v6EVtQCXyQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="QxW1O/v+";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.13
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010013.outbound.protection.outlook.com [52.101.56.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DB9606A327
	for <bridge@lists.linux.dev>; Tue,  3 Nov 2026 12:52:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56DB9606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=QxW1O/v+
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UobqOqgxXr91ZCNrXC9oTdjIqZ9NczfDFNK7LfJk6JRMgHJPF6pCiIl9qz8F6l4PGof/HHMFk/wm5nYXkyUPxMsWKVIaFTnMajs+rOslZWPwDjKjxqZBApzubbu8Koz/BJi57fWGim6XNHSt5Mu8poEaYy1Hq1COqiJkkl1GR630Y5zYIMM+C1D7xgrDPiON+msoF2n1Fpkt6rAuFPVHnalMO8y1r+RmUAxda+6hdW6l7ZEdPlDoy4KV4cMGHX3oabmhKYCsMfP93ENS20t62qvgfqO9a4g1o7eNaDelKaKU59NFgHwdBxphSSt5xGmtWr/UWbuLec4BY45dRHUyhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qDVS3fI5EAPNe5VPy+e6tXLKgQzezE0kJT2690jU7Uw=;
 b=D4jxgQiEt0Wl5eTPOk5XI32PQ57oTnmZCTW4ZpPxGbLJ5LolumzcyUNUO9IDgNXd5HlTVzRK//vcRSwI3j73AmKbe8TE/XBLHWmo+0Gi/KRPbJkM9pLDXivayQqQbklITSiYKqzsyp0PfKalAXIkNTlwlEl+oFGAAWBzcEJ65kv8sJmNEsMfGuUVNv7PSA1SS8GVBMzf70IgG7XT7wjU7h4PwV8v5cm6208h9xuicSxKVrtVSAmjmNcOulVpxmAWGi/7zp477tGbVqCdaE4ApQ43sfhuMZCi7+GYyHEoJPtwyp5tRysmJtjJIifTg1D18CQ0SNTeLpcqLbD1FABtKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDVS3fI5EAPNe5VPy+e6tXLKgQzezE0kJT2690jU7Uw=;
 b=QxW1O/v+17KNNJ533l1AK/hpGChxlakbCht102+KeBFnU7lcp+DGFXEKu/YzTjMyhngt8/dZOcAUoeeUjQxPQ05TjsI0HPnz8Pgqoidc96sX/qcWvxdnW3TMsbLdoywOYuJPUN1rU3bQeodzKx+rPxGKytU8U9yTAURoL1rgr8MjTFQaTFNGTyb8rbO9Y8IiFfN/KfMUlcXnDaLLMC6NIoCM+61W6NBssmpOcKHTKRQLDmC6wMfnidm2LVjSFTMF25gZ0lLDeylFOAhwvXl4Ae+OsY/2BoVCxgbF+a1viUJougDI3iuyOwzLD/XvCUb7bV6Bsu4sHy0GedEIKv+FDA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by LV2PR12MB539562.namprd12.prod.outlook.com (2603:10b6:408:417::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 12:52:05 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0569.008; Tue, 3 Nov 2026
 12:52:04 +0000
Date: Tue, 3 Nov 2026 14:51:54 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Jun Yang <juny24602@gmail.com>
Cc: razor@blackwall.org, davem@davemloft.net, edumazet@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	roopa@cumulusnetworks.com, bridge@lists.linux.dev,
	netdev@vger.kernel.org, Jun Yang <junvyyang@tencent.com>,
	stable@kernel.org, TencentOS Corvus AI <corvus@tencent.com>
Subject: Re: [PATCH net] net: bridge: use one headroom snapshot for ND replies
Message-ID: <20261103125154.GA1169667@shredder>
References: <20261103075439.43644-1-juny24602@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103075439.43644-1-juny24602@gmail.com>
X-ClientProxiedBy: TL2P290CA0017.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::7)
 To PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
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
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|LV2PR12MB539562:EE_
X-MS-Office365-Filtering-Correlation-Id: 48e75f99-4c27-413b-5d54-08df39a942ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|1800799024|376014|22082099003|10067099003|18002099003|11063799006|261026140227099003|261026121527099003|261028144727099003|56012099006|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	f5gpt3IqY5M36VN5e7wBJWxNqqgNx71P+M8X/4v+XB5tLifY1GA+uUOQzSgBNYdXOZyNZWjyt/OeS+OxQR/N2QCIi0LAFHWdDgfLkManAJyGO8jBzKhLs58KEjUXosRVgMAX4p7Phau86O58y4zIJ4YreD/cXEaEdEiQ+gj/0OQdG+GEQxKuJ9HTeCWRoUeWR4U6XGeK0XV60CtQlJ59+JMCn6CMR1QQIboUXrqdueusv70Y5l4VzOvvdGvhLkubil4E30Wa7z3f0ZP4zyYlTbEUOlyrIm+rvguv8PIP4BPrkrbsl+6sOPh9MF464j4nVlfVixxtJVomz39uQw90w5C/P0G5oJogOACeVRcZf6b1+bf4fUupLVux71tjFwpG1eqFWfQoZjaj86gpiCrwu/CRiAnkdJNlKePFmGCDi4OujzI4A0EXtrNF6669KGWXMW+RGFUR/UROYUt+TbNh9Y9U0fEKEc9AouB54EyySdVVM9Eei1VbqC7gwHQvr6vuAz7VHeMcPBPWsOhSevwR6YsjYTA2KKqVQds2ov4IwRuM3sY6j45F9Y5NQJpLKWafHYtbnIwpogcDCsOkeMunkq6T3woNFz16BphBoATsDYKWkV+bElltuiw+qmZcDlq8p9kTZCaFiXUM4GIkkdoet9GDFLMk+mYfmP+0BAto0GY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(1800799024)(376014)(22082099003)(10067099003)(18002099003)(11063799006)(261026140227099003)(261026121527099003)(261028144727099003)(56012099006)(261022105027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kTQi/mK6UYTD2FiVsbH8Y00xjgP8gBjy29nPeLtLGWoDk66PwHOgZLfWVP8r?=
 =?us-ascii?Q?DdSnRGCEpJMmqQK/w2cBp7n2MYEgUTWBlO/n+r8fsIpgrfqoufreqy1kwM/t?=
 =?us-ascii?Q?6QWr2MYfzctA+Obl2IN/RLSgeVQbmmoMNuZ5f8mj2Adh7FwWIKmRcYwOu7vU?=
 =?us-ascii?Q?BF1u0HRIYIOK1s941D0IDSyr3irV1DinuEyjv/oVuWpaDWgKPggQEoMJDS7J?=
 =?us-ascii?Q?soYj8/yvmRQJApquEgkk9hpIWdaxoFjLvXOHmpZ7sCm85WqBn7lxYyI1TlIn?=
 =?us-ascii?Q?VKh9MX9vL0M/H3L9fCzBrJhxZCOYD6CQzUU4ftDBTE/2OvOv28uTTBU4on14?=
 =?us-ascii?Q?2Y4zedLuuj90JZWag1zDwKsWRwiGLH7WkHB+J0IwjUhoFjTi64URGnPKYMxL?=
 =?us-ascii?Q?DkCVNa6PF2hMbtzIIRY/8ThqJOx7nrmytxgVX+eUMtjU+Ix1xL2J8GB/IUEO?=
 =?us-ascii?Q?bcsAHJD9cZt29UZWLk1Y5OmF9JZquxJJ4pzlWKgYPsJfQXXtbO8RAP+G5WUe?=
 =?us-ascii?Q?Mx/vzSVi/Vnb59A5u4NzyrJpm7qJwWIUsC1JoRrNGDfH1Tc30p+I0C4q+g81?=
 =?us-ascii?Q?aIj6/PGLSOPbuL0yv0AkGd3AlZvksAoz5R2biJfwf4lsiFqQVFsoa8p8KW/S?=
 =?us-ascii?Q?HSpiy7Og8KL2MvkzpPqX67Lq8UEnld7//42DMc79h+WTjDHvJ6uXCVakOkJG?=
 =?us-ascii?Q?LeHnKsxf1YhA58+ijYfvSW7fr93ifRafFVvnJJocD4EaUELeK86HmLJVmMv4?=
 =?us-ascii?Q?ALGNplEmoNV4cl4s39ZrIyeu3LiLou7gJNpg1BUT0vtXs1Efd94bsPtWozLz?=
 =?us-ascii?Q?/ckHjPHgKxK/lQMuOPIgRfMBjh8IDxdIaUQGpdoY7/vAMctodDbYHPi8vB2n?=
 =?us-ascii?Q?N45RA86tzBA8InSmoWZvLUH7CShvPFl0G825PpvsVUvv3XsoeNfHAjlOdnCi?=
 =?us-ascii?Q?dy2lMBVuH8TT1boGEIUsPcRn87RZgctma7UnRRvpb5wuBRpX2ofx4EAdDR/M?=
 =?us-ascii?Q?NTMoM4oLJpjL2T3w8wGPgdVHm5oJ4xSKSzYsL1PEBizWqkAHo74MmYuLooS6?=
 =?us-ascii?Q?mr+Amif5nhkxJH4fS4XPT2ZzZWH8ReiPEvdDQ0oVS7ugKF916GtzRonH51IA?=
 =?us-ascii?Q?AE+fg2WsH3IUo2HVNvyS0pCHwgCgB/+nUGynyacyxH5/VZS/JFDUvN7SlY/n?=
 =?us-ascii?Q?/YPtrLyubggDb0f6Np4I2dEyF7rzVsMZWFZzo2zQ0TEluBmeeeqtXHKyZgvS?=
 =?us-ascii?Q?80h1DYZWh1IbO6NJJJmcOKXFsbbJxdOmJVaLUSGvF64B6TgM1Pl84piKCTyG?=
 =?us-ascii?Q?c2mSUK5+dPYpS/KgqT3vMqz39shdf+/hrfhGfKBv3PYBT3NYn+Owv0suJPbK?=
 =?us-ascii?Q?qSm6QNLrIbQ92BmNJCUg3BdbsW4jIIhM4HMW2jcwR5yaz7nvAowyo9Pfqpwg?=
 =?us-ascii?Q?KTL25HqjtvdDHh/7icGoHAkJuIA1WgWcAgunodhS23gmij38x0cfsNXvPmWI?=
 =?us-ascii?Q?LwB3OR7hGvBfjgNwU0+RlhxAzQcWYd3oePlKk/92/4wdcBkUwmG1RSXhl6gC?=
 =?us-ascii?Q?X6n1k3A8e78NVC1FsGGtWHx5CyGDg1TAsv7BWqL2UWCB47L/+3QDXRHcyvks?=
 =?us-ascii?Q?BQZZB5QVZSIHrwNYmUtrjRCXPfClQX20IFiPOyxuJ/FNdebWLqw4ThoFzdTh?=
 =?us-ascii?Q?irqbS11ut7Eh1vk41d2J7oxhlwJzSqTlJ3NCaJWvvTAdyhg/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48e75f99-4c27-413b-5d54-08df39a942ed
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 12:52:04.6134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PwC7ZA/6RAyEvej8jyfqiAqAOwRzdwBDQDWIRBN9edMlw+btozBSn1B6H9RvrNQLRp8ZfBPJe58tf+FOA1nBUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB539562

On Tue, Nov 03, 2026 at 03:54:37PM +0800, Jun Yang wrote:
> From: Jun Yang <junvyyang@tencent.com>
> 
> br_nd_send() calls LL_RESERVED_SPACE(dev) once to size the reply skb and
> again to reserve its headroom. When a port requiring more headroom is
> added to the bridge, br_add_if() can increase dev->needed_headroom
> between the two calls. The reserved headroom can then exceed the space
> accounted for by alloc_skb().
> 
> Take one headroom snapshot and use it for both the allocation size and
> skb_reserve().
> 
> Fixes: ed842faeb2bd ("bridge: suppress nd pkts on BR_NEIGH_SUPPRESS ports")
> Cc: stable@kernel.org
> Reported-by: TencentOS Corvus AI <corvus@tencent.com>
> Assisted-by: tencentos-corvus-ai:hy4-preview

This tag is deprecated since commit 1e035297ffda ("docs: remove
Assisted-by references").

> Signed-off-by: Jun Yang <junvyyang@tencent.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
