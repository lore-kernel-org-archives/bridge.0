Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010061.outbound.protection.outlook.com [52.101.56.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F37734A3D2
	for <bridge@lists.linux.dev>; Thu, 26 Mar 2026 16:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774542645; cv=fail; b=HmC3+NQ7bH0jBba0WwL9y6BtsON1fnHJQQ7aIzY/wfUtm5yoRLTBGeGaL2UKPRW7Q2ZeHN5E1iK0A91VPeFKuSPi+q1ESUKFEjeugU8aB4GMAn/JzYjopTik2XMhQLa3q5EwcxBXEXFEBg9nXjhqvIDrsXxz/Vy6t5hLWj0Qx8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774542645; c=relaxed/simple;
	bh=p3BkoAAlsCUjUdVMLxyCraZ73IXFMuCk8jxCIqp2VNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=p+38AYt9h7SWUVJuVEkM7GMIi7ThgC4m7FVJSeelH2snLKbk6211kG+nExLYjqYqBVcEEsd2qpStY0hZp7Xpqq2k4OZObFJ5CHiIHH9d1Y2PjFHZ70R+NzcfxqRtOCubU72PiOx8Rt+MmkgemDhJdRcZW+mjx84KOMhjIgK4xqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QNyyr6cr; arc=fail smtp.client-ip=52.101.56.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QNyyr6cr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xuIfPNsUp+tRRJQ3JZHMF3XfZGv6/sNn7tFmUwdqh6OZ5X3aqqrVw0GSQjaWsWD7AXDIF3jBmLe2yjGrnhBmqQMzqyvRUhCsQrCFwSl4cfrJBeryy3fhbyFh5FZ0iaUEpk21JRLtG3ZMFEdDgOv20qhJ2Pa0iK54gseSG+TVdtvP0mE2KzNbIH2O3yK/Xa5bqbAFYoo4Qec1krxGOaUZzvhrPo47HziF5Jly3uaVWi4rLj05Pz0aXAD8p43VkWmpYS4ur75KJ4Qzsta0tQ9C98KGv1OpzX4lebNYEoL9XhRhfq6vZkTdb6roP98LC1glnYLl29Ppp8Jx5Y6fk98CsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K8Y0N+56kmUj0vfpiu7dvIrUPwg7n4hVUFN7i7tctWE=;
 b=xal5nPSgDzr24QElr/0C4HdOyPfoTuF8r8Gen2yGMbv4+PODV7HnCnjxi/0ZZdoT4ELnO2ZrTovKe7yJT/70/ypkUhclszD8TrcaHmr+YKZ1dxBdCvvcol3FqcauDJAcHk1JO+rISjXrMHFlpVvco2nYigRIIWI8tOm0jFtqmb6dv+YO8B8kRC0euh/UPzIqMvXHfQ4biuPeEdAg/X0FPXLTA5ECpXPPCb3XYKn/dh09VF+SzfbnVMMIzhR0jbSYIO0l+MdzjCAvtUCfCGi5b5M2MZ0Pv+FxWz2Qyk3wWPb5zeEd8dE41zJ/2YgieDvCG/4c9i6bjVPnQDw4ddxtwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K8Y0N+56kmUj0vfpiu7dvIrUPwg7n4hVUFN7i7tctWE=;
 b=QNyyr6crP+U7Eicx/bgrlZ8LHNGfLddMPkjPF9MAGu+DJ6iLKQ973kVEWgqKQ6Phc3LLDH3Pr90MR6QKEZJ7QK/jpKjo+O6KmEW3/8wIMs0IZbfKawfjWHuGyBrvLH+cd4UvLaYyeHsBAkpxufwx2xFrfr3lMYYqeBHTZhBKIo1AMeaZmKSUvljaa1tM0r9VGzYna7lVSgEBSrhNKyMPKFtaYy43iRKGWYAjqFpBb7/xlweQ0NW9Kv9R6vvPsnPgxLNmKxUyt9NGjbEJsp21pBcOwVZeY273kVP4EueEje4bk+2YaALgOBdp/B8yJ/1+QEPlcJrUtqs2bo2Km533Jg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CH2PR12MB4120.namprd12.prod.outlook.com (2603:10b6:610:7b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.10; Thu, 26 Mar
 2026 16:30:34 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 16:30:34 +0000
Date: Thu, 26 Mar 2026 18:30:22 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Yang Yang <n05ec@lzu.edu.cn>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, razor@blackwall.org, andrew+netdev@lunn.ch,
	horms@kernel.org, florian.fainelli@broadcom.com,
	roopa@cumulusnetworks.com, dlstevens@us.ibm.com, nb@tipi-net.de,
	netdev@vger.kernel.org, bridge@lists.linux.dev,
	linux-kernel@vger.kernel.org, yifanwucs@gmail.com,
	tomapufckgml@gmail.com, tanyuan98@outlook.com, bird@lzu.edu.cn
Subject: Re: [PATCH net 3/3] vxlan: validate ND option lengths in
 vxlan_na_create
Message-ID: <20260326163022.GC1051615@shredder>
References: <20260326034441.2037420-1-n05ec@lzu.edu.cn>
 <20260326034441.2037420-4-n05ec@lzu.edu.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326034441.2037420-4-n05ec@lzu.edu.cn>
X-ClientProxiedBy: TLZP290CA0011.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::19) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CH2PR12MB4120:EE_
X-MS-Office365-Filtering-Correlation-Id: e800b3e4-1c99-4ba9-3997-08de8b5500fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	SORdCVEHKTfD5QzqldKPtUWwyY8omE45xsKH0fYHhFB6ipNlEYWsM451Z38aPJDcGwQeLmI90Cve543nEHXCXf4QKPiHlVOemhNoBXaybjElOSOZVwTsgEpvQmo3JIZkkgTxXAf+Zio4Zof20bxZ6kcVR7L4Kn39J6vXAoWLQPL2SufM5yU8iClzNykZ38avhLEuncBS3V5aP1RjkClxq6M/ee3k4qFyWmNJCceDmqDhtqSgrs3u9xDD5ICeYt83pS8DxmClp1Sa73MdSnysXJdbbARyh1PSXlXpUANGr8Np8wOJnITbhf6rpXoHwjsjytr5CliM75dFVY1M4mNzLMmYveQquf1cS3GZxka9BjV3RcYMBYiPIGxL9WwadCrfKlQvScSJrgRz3Ak8yV+s1W7Hir3ZExRf83s1XkYF3VHbLHI/XBSCfPxWEO8YGZdjxXn1xb+VGX/L9v/n7MAjtSvNqKGoezf9/cMTqfNozrb15kgwI/wdHin7R/lH2fxATFSVem1Y1DeTGJ3mmZikFLGI7MZUk3bqXyk1JavMgWO6GHlT9uRxLsg9Hgt7xa2IcVpqd4gIT40qUrS64+kInkNney9OPAYatDWaSkZC+YLEJ5v7mlgs3K3PV6eYslEH4RAehnvNqMyNYPlGFJyCA6XXhBxQAyIfNpG7enVL2Pek9dIyemsixWmCZMbzjdPcsVdHpvgnJhLwBu+ZM0/ZwwsDmmBeVW5vPLYyWdxBAyc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?74LljVB1CnoF5/lNrm1X/3MLqayL+f6uBH/qeAjMDBL6jUAuZcFp0aiiUUwU?=
 =?us-ascii?Q?32/Hu3RcRR/MoClHsh3+hoOy0Hg3RdR3q2Wmk9tVKH5UvspPluU+WPAcGqnJ?=
 =?us-ascii?Q?zRo7lYoKfCnrkS6y956nviIm87mQCXUJ6hKY9zUKCCZqXGeFPxCWV7kSCuAf?=
 =?us-ascii?Q?f6E2Pc2mHHZKMMnm2nxFZndLMBi78sLswELxHvvY3WCIUOb5NhFKNvYY+gwN?=
 =?us-ascii?Q?CtVZxU2QA0FI9ObAZgD2b3Dp1GbzchmQVqIwBP8zdm1+mgcCosU1ddO9TnHk?=
 =?us-ascii?Q?k6WaQ96g+Sw4VKE3+MIsXM07f2OpgZ0BVM+4bbtGN8YCB6WjwmhhVtlkUU6J?=
 =?us-ascii?Q?/r+n41SpY9vfMF9G1ztd5NNz+1R90vJCZJLtglkx3wZw4SOEGuQnV8uPRFpV?=
 =?us-ascii?Q?vE+JbPBUl4cwHu3Vj+b1Isvqao1Fp20O/9VzEamVp07qFs7ZeXT5scB9FzQw?=
 =?us-ascii?Q?1y77dDUqoUQDx0Z+fWytX9cyWQrkonOc35UyfKJNv5bL0nv1Nw/9WMHxUKPr?=
 =?us-ascii?Q?ONdteWmMCQ7EyvlqSJJz+1DHbTSdfytWNvjyVhE4eBnKiacnjSinriNG4q+O?=
 =?us-ascii?Q?80YigSoB2SiMsh3W9ngdElVl0sX8JvdaIy2BjIA1r7vG0vkSPtW/DHKOOWD0?=
 =?us-ascii?Q?fdjlmEfXH5aXo+ge4J4yCc27SuyGowE4PAXWOhQ8eybR4nva0tYi7pe6JfQR?=
 =?us-ascii?Q?NgAfCAqA/UbVeHUNv+C9PA9eBHArrmaEVkoU4+XK5cy8iaCa5RzZoosvS4t3?=
 =?us-ascii?Q?h5ZdsSBh7ctz64bYIiMNuu0Vj2Rt1B4Yp+kWpbbklZQnD2uWkQBAqU1keqmT?=
 =?us-ascii?Q?bILc0gU62HXlMGRGzvXT1k/qQu2FyTGA+zy689e77H5Ru6qBIgruap8Eh7wD?=
 =?us-ascii?Q?Rr2vnrqkX3+QglqeAGq7Z9mZe7nG/jYU/tRbQkaFt5tLl7eUPDBe7TQ/iPUl?=
 =?us-ascii?Q?7MFm7FMm7SwUloeTYHoQXOM+taHkf8f4LyWaLPqE9ZxuSwLrUum07aklATdq?=
 =?us-ascii?Q?KejepmR8VAk1NadhxmiNhIpksxS+QEfAEDj4Vx3jIChqy85CkqjvPT+3+1pG?=
 =?us-ascii?Q?Lwf38a11USQz5jIMbmCvFMhM2jMpFN/n7In/CxfRFX7o9KuIzRWBaYkwBGQV?=
 =?us-ascii?Q?3b60u2Il0TRevBoiNMnI582g55BOgCbwZPXDPr6NpHlUvkWOtIF+CZGnvGdz?=
 =?us-ascii?Q?KVeDrdPesCczmH2+VDpkDGpT5m6qqL2qXeKWHwp20LS2lfaxdOPuIV5Q6ASo?=
 =?us-ascii?Q?BjpnwSM6zcWkSLPf72zS7GmJfxXD+ceCXipaf+x/daFmjiU5TfBjm1fuZLHN?=
 =?us-ascii?Q?+lTJSqrETQl0r/ySaxN/0is9g/oSqrCTJQRV+mZjRubcPqiyueDwagqv9Lqi?=
 =?us-ascii?Q?TLc9IM2FFrOi2RMalG7DUMXbXmpkva28ycjdWB9PqqlxNamkRDN9Jfsdf/NR?=
 =?us-ascii?Q?yUrHFRSYBTvOELdDwQPRVmD7BWC3tCKZWqoGFRIXxVNSk6xHetZWktGvk/9r?=
 =?us-ascii?Q?BleOz7+Ti9xw5973MqqwMphFYx//MuDqR909z1Hs45tG/R60zQzQDqPHOTz8?=
 =?us-ascii?Q?xxrv1rEfXHFWQ9jtYBeUOWULpU4FD2aKLicN7usTV+Yn2VCekRLOay9P8DFN?=
 =?us-ascii?Q?PGXwSvc3IBivYOJz6qenb2yaNWOg/YiZ5xyRZpOyRkQHiPXFEne4ijaj7WTj?=
 =?us-ascii?Q?9hkCs+WPFt8J13vt+Albjf/p+R1WP8q0KAoTpqFtbaLhaEWJSekYKWR9r5dZ?=
 =?us-ascii?Q?h6NL6N3MTA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e800b3e4-1c99-4ba9-3997-08de8b5500fc
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 16:30:33.9676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jZUH2m+haUeaGu8F3H1CIqfadNvedeWvcOoJdK9dWhnBn869QwYaBqf5nK20kwEbRIWiLwcfO9kKQFN2ddj77g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4120

On Thu, Mar 26, 2026 at 03:44:41AM +0000, Yang Yang wrote:
> vxlan_na_create() walks ND options according to option-provided
> lengths. A malformed option can make the parser advance beyond the
> computed option span or use a too-short source LLADDR option payload.
> 
> Validate option lengths against the remaining NS option area before
> advancing, and only read source LLADDR when the option is large enough
> for an Ethernet address.
> 
> Fixes: 4b29dba9c085 ("vxlan: fix nonfunctional neigh_reduce()")
> Cc: stable@vger.kernel.org
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Tested-by: Ao Zhou <n05ec@lzu.edu.cn>
> Co-developed-by: Yuan Tan <tanyuan98@outlook.com>
> Signed-off-by: Yuan Tan <tanyuan98@outlook.com>
> Suggested-by: Xin Liu <bird@lzu.edu.cn>
> Signed-off-by: Yang Yang <n05ec@lzu.edu.cn>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
