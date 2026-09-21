Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010026.outbound.protection.outlook.com [52.101.85.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B2B48EC69
	for <bridge@lists.linux.dev>; Mon, 21 Sep 2026 13:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789998424; cv=fail; b=YWh2/989pQj0t/zWcnnr/hqJ2q3i98wOHHckaM9iBXM1ykNPTRTZYP+FQDs1AAYXM7CcLwo/HeiCC8d/MLLxzyGaTRgJY8fyLrgjgZ++R2K6WHH4VKzS8NVRURpKsqt22xofF6eqM6OXDm+O/JqNUEk5mWnrk/sOWIgG9332Xsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789998424; c=relaxed/simple;
	bh=1lFC5J7WBOuLKojC3fL0djRqQ7qz5BE+bM9kT6+s4tk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=O1XSfIoyHk+ci+pZVQIyQl6wu8RnlHYfa4L+bDlhDhdvAeFw4PEyQeVz6IsqemT5xffdQGnVrTdJudEK8dQL5n/Fnnjd5WkXPylS07vwqxFnlwoT5uiH/mdZcpqq88XP4XMONNkGXScXvF42+cjWd/fgIKU5IYjGVLxLqoiuUeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K1oGb1/z; arc=fail smtp.client-ip=52.101.85.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="K1oGb1/z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ggKAdQpGOOtYfZUpcV7H9O2C4MIcGBb2hAmPGN8ETSx5eSR0ZUJA1M3qb/Fy0SmuQuB1HFkhLBA/qMlmu4w7uzfKTiNt/h6WtPlQtiGLliakiLVxr48JzGDWPVogXZp4jUkP7mA+9vu8GqvNUprtoRMkw2lBLERgSQEctNXzCbCCCRBmLQ2FZrVfswu8WbW9WxnEKxIAffkmtSFdhM9HnAQlmOSdvzSvcCC5CYBknUE1nq00tSqJ3PNyD92qtDOALp/vUSgvzjJ4bjlcAQBDxmsGlR6c0i3MxQzt21mjeW3INTG4rekR7zxPykRDrP21UH773+3QtuSZUSWfSuCJvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BDTy0i9KNlH7L22D8QfHsGM2Uwh00uLyo/1QN+tRomc=;
 b=zKEy8IpiSeEWtBDGDklqYSBk0huchL2CGKIbSLKo5+i2w+kvxPrcgPJzJUlPL/tPu6E8OFjCvrI4Fl3gRaL91/DgJXx1z/iL3zwTx5oHwwnfFpsBK68ZUzcp9U0oeFATLfZNzaeMfFIuEJGkgPEHNt8Aa+M5D+Qcx4ciyFWoHss11gdP6C4EJMcbzgwzXHq9vqbO4H9fhGcroNJY0zzhsxC4rbKMwA94xYzovK87N8nQx+jltSYiFMEmHJSTtf1pkbNgkCeyJSNiVM8719N3JmqVxkQGoRwfA+4xABHyiRMVhlAQnikq6jRhHV/HipFsEkGmso+Vwdhtq9Sxo4Z9wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BDTy0i9KNlH7L22D8QfHsGM2Uwh00uLyo/1QN+tRomc=;
 b=K1oGb1/zZSKinExUCjgBTHbtEzJQmxCOrCVXP3LyJ6XG+LAfKg3BYmz3XT0QRilEADVbsZ6cmL6cHBq+QvIeMppztEtjQB6Z5IUQMIPGrOTaIIK3p5UAnlTX2PlmgS02TP5Bqs3ym2X4J/41Q/yAztRoQrSt6xYWSgdUVD9fqgPnqugxB46Pga1+7E3V3Xhyjv6mAo1qKI3ni8J22+K+ldB/Xo2w4cGWmyDsDYAw4kekQ/MPzxbvfoa6Fj+zdI3thnuG+qUZpWKSnsjSo9MQep7sLNDyjYAANMEzWo4b/FWcnKuTpLFiUcToUC652JyOVOn8QTLsz9pycHqplZ0JAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by SJ1PR12MB6314.namprd12.prod.outlook.com (2603:10b6:a03:457::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 21 Sep
 2026 13:45:10 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 13:45:10 +0000
Date: Mon, 21 Sep 2026 16:44:58 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	bridge@lists.linux.dev
Subject: Re: [PATCH net-next 0/9] net: bridge: vlan: broadcast fwding path
 optimizations
Message-ID: <20260921134458.GA2199421@shredder>
References: <20260918152950.1938259-1-razor@blackwall.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918152950.1938259-1-razor@blackwall.org>
X-ClientProxiedBy: FR0P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::11) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|SJ1PR12MB6314:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cff5bc0-3dc9-4833-cba2-08df17e68e13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|18002099003|22082099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	yPrKR7yrbPbP4f85kg8/5k0iiamRqtUTCfRPzpt4z4HntZQDm6arSg3QQ42+rxMi1FhznpuYvBsj5fGN1zTAoagkupuR1JhgMiOqbV/ZchkJH09VrVPxmhlwstN1ntjiYo3sT0HmO6dCvNLH3qYxv9YxOWRpNNNNxEJa2HUl2Tmm7vHVTJIgyrrOehq/R9abuZ6Y+vKqHK5o863zAvC31zBpGVMtvzMkn5g0n31fGe8TBPQWC5aUXImVoqjZl4iuQ/kx0fSlIu3GeeoNpwS3qEYv8Cy1y5tUNcDZDRAv22tNSohIn0ougV71iwkoWHf50rix8V/HFmtuAcRru/RL8Vr7U0SXM1ZRZyxb3bOnj49zM9z2mNstfNW+HrvQM/cpqJTMe3u3KWG/GYTrLp8bYkNMnkxF7ErsaskjUCHk7ziiue/zMTbMy27WPIYZPOAWZS+LfT7iRhB/eetSIj7GgVHi9vZkD1w//RNw/R9aajuKIu0LnM/Y5+VSMD9YJAiJuukErX5HJ74eVlTjvpyPuwaO4QHAYS73xOlUd9qCu1/pgDjlrwlCm1iIMebjCeOuEAvuNs8wMoR9HmVY6X0/ImmZtl8OUBpKtscaOIel9KAuTDSeuMNA17NbncXg7qTmZYOO9bylXvvorx0QBR0eqenp6oi86HYmc5EJD1WfLCg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2lyCwxYNJfhgE3laxlgFTTWD1xE0Thn0MUasfgx7V2SosMHaeHLuUYQt9jgN?=
 =?us-ascii?Q?pSOfTQx/wb/os41SPsp5qD2WuQOK0w+ev7e8RFeUK0yB8gMJ9xAB+VPUJq2/?=
 =?us-ascii?Q?4nZ7/e+FbUHnSbysEdfIHHQNuO3RVfSaV0TyccE5IsQUgIhDZEPWeN6SwK9W?=
 =?us-ascii?Q?fP1aMg8vHz3/qSDshfXA6HZQSZMFdSy6ZsN9rIzaf4ZBNKSlpM+4hdVtul6f?=
 =?us-ascii?Q?n5h6udx4eS2nyHMwfm9aYV4esSwbNgi9krp8GY8kVQ/pHEaZoPFOdLdsatST?=
 =?us-ascii?Q?PqaTlG2JVKRs9DpkIMKmfunPeuNRpk5cZLUxH8zOhj0wqynbp45tEtHC5WCs?=
 =?us-ascii?Q?Ui8AxgGte1hHq9yToNmRN2jOou4C38R9zB+qTPUPlq8+3Ra2piULH1CzBN2v?=
 =?us-ascii?Q?qV1W089XWqqGRzGf4H4PCl2ho7sv8BDQsK4Ob19/g4TQ9EKxeSEQ1ZXWLfyM?=
 =?us-ascii?Q?ZiX6wQ0dzAsWoRbiXTOmqUzJihNkoDyNsNE5aD4Btm+3+6m9qPOjPlOfLZg6?=
 =?us-ascii?Q?m14i5B7R/lMh5EChivtgY2MbE1rn46E0OKfXPcLwo2ybY3amcS6lJtzC7JDm?=
 =?us-ascii?Q?sZXJfnqXXTfeccFoFkLTj9wDswdNS1vAcBXLd/yH6+e/2Lu69hUj+N9H7lCU?=
 =?us-ascii?Q?Jh5j5yTfWKo9iO6fuIHc18MHrz3Kb+YwI9XQYqR/8TS/x875vPx9gZOtInO/?=
 =?us-ascii?Q?lKJx5ZL/5RjM9ePXkjXJFSWe2Pio+ErANnB0YZTUrOzHyMUsn2irnyYWP7UP?=
 =?us-ascii?Q?ZgAZQ3La/xFsSN3E8CoSalXagV2dxOxTg2w7oufcEEFeazPeNIUMxwD+0uUo?=
 =?us-ascii?Q?SUcOlLejrJkGjY4tcmgG9uB9UeA6/bSmB58PQFVM5Qra3fFwNvs4jCTTud1q?=
 =?us-ascii?Q?WcgVE/7kJglZvhYewo96uZQb2WNMRZobowQ7HAw2ilaYs/fSBzaMftTm86Wg?=
 =?us-ascii?Q?9HUYWMWoq2jLpZfuru82PfwRpLD5bwZxiLavjjuTpHpjtr+KJkEFV1PxY4Us?=
 =?us-ascii?Q?tUMc+turrkfd1taoFGnD/NGgrZP38m8j9joD3z+35s2MLxX0rTr5v0c/d4CY?=
 =?us-ascii?Q?BUU2GxkIprctKStOn2Rw43coBaXskeXebxyJhaOeatbsKh4pFppy0CdUZbDB?=
 =?us-ascii?Q?RXI0GjZjHywugPCr2Y0rJH2joyN4Q9u+ui2+MYIiqJ805c3+r5cO6HIaT9rQ?=
 =?us-ascii?Q?55I2PHqNaHuxszRLSK0gQKIOnxGL8WZYQ27WdEcvR+DkNHxbIqDQ+sC28h3P?=
 =?us-ascii?Q?dZpyhqXu3CeWISHCiWKNVbkVJUKfGneC2u1M9cyHeZY+u4l5YHQ3LSKrbQyD?=
 =?us-ascii?Q?2TLq4XX7j0SPY07Vn+spnVu8cRRhnxGfnpZmGY5IXPKGSCud3fn8bvucwJXV?=
 =?us-ascii?Q?Sgmv1bUwFfQy9J7HINUi1iCuAb2r5mH95ekt7s1SM9n+nFKe4PYHmairE+hh?=
 =?us-ascii?Q?V8kpiqWl3B7K7fa55PxiRPhcrW3jpqatVtubIJfZGDJi9FfFXfxk/flz5cBe?=
 =?us-ascii?Q?Mbjve67bJqiSD0v+VBt4I1G2PEzcRQDsknTn/XkVAXMvXxRZj4QwPLL2i9PM?=
 =?us-ascii?Q?z9Ei6XBXjuP2e0tskevCQD2E8eZm1Iu4h9fJp2uLMv2cNTgjPfcc14iZIwUN?=
 =?us-ascii?Q?SSsPsv+91HMYWL5d0cwvxnCvcXboB1ZPOc5o7h0Lm61AVpJTii0zDpf1mEgP?=
 =?us-ascii?Q?7T4wkrQA8MFxi0V+V0rsYfk9aWOY5IJ9S0BhbllcGXZ7nKI7W9e2oYAsMivf?=
 =?us-ascii?Q?eQK5fJ37xg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cff5bc0-3dc9-4833-cba2-08df17e68e13
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 13:45:10.4560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uU9WhyszPoWt1wNV5nyloxUBsv3tMTWYai3JZSrth4+wYp3J4Ie65mHKni/ZPiAhidJ2SKqEWZahV77Iiw8XFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6314

On Fri, Sep 18, 2026 at 06:29:41PM +0300, Nikolay Aleksandrov wrote:
> Hi,
> This patch-set is the first step to removing unnecessary VLAN hash lookups
> from the bridge fast-path and also provides additional broadcast path
> optimization by considering only the port-VLANs that actually participate
> in the VLAN instead of all bridge ports. Combined these changes bring
> considerable improvements[1] and open the path to do the same for the most
> common fdb forwarding path. As expected the pathological cases have the
> largest gain, e.g. if we have 1 client / VM facing port and 1 upstream port
> only participating in a VLAN with many other bridge ports, we consider only
> those 2 when broadcasting in that VLAN.
> 
> For up to 8 ports we only use the port-VLAN list as the array doesn't make
> much of a difference and is unnecessary. Note that the array is rebuilt on
> every member add or delete when >8 members, I tested that and could do
> 2000 VLAN add/delete with 64 port-VLAN members / sec on my test VM.
> If it ever becomes a problem we can optimize it further, for the time
> being I prefer it is simpler.

Very nice!

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

A couple of nits that you can handle later (or not):

1. Patch #3:

__vlan_delete_pvid(vg, rtnl_dereference(vg->pvid));

Can be simplified to:

RCU_INIT_POINTER(vg->pvid, NULL);

2. Patch #7:

Initially I thought that 'fwd.vlan' is never set, but then I realized
that in the only place where this field is actually set it's called
'dst.vlan', which is a bit confusing given that in the context of the
bridge driver 'dst' is usually an FDB entry. I would probably rename it
to 'fwd' to be consistent with the rest of the code.
