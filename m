Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010011.outbound.protection.outlook.com [52.101.46.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2CA416842
	for <bridge@lists.linux.dev>; Tue,  6 Oct 2026 12:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791290390; cv=fail; b=p9MXVYaoXYw9ZLvAr5ocP6x5lyjhxj6H6Cf3NT30z8kTLcj6gCWlnAe2PsMwyw85GiBDtd7I5kv72LbK6gVDEY3we+cwnw+bgfvOCzGWJBQaddWF/j8qMJEVCzK5oruVSqaIsJbobmBLLSa9rx4IKgjLhexdoj5guJnQeNDCNTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791290390; c=relaxed/simple;
	bh=El6g/ugILN89fwW3dv+Zv1pWOa8/TFe09I+0C1v7vN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VS9y8FXztE6LhJC7lyd53Czm1x5KgCi8JcFOvmPq3dBExiYtj1eLj1zeq8+wH36gMy5JvLeamZv5/zzG24ETVanfq36CuQlVMGPMkNKtAicDWB5C81JF9DbhVg29sLnNdjzEnW6OBWobDZHrbbveCp+dGFNpxMXyfRoYW7VExE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gwD7lVIK; arc=fail smtp.client-ip=52.101.46.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gwD7lVIK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SdTmmv8zUPnni4sXaLhU93qw49sjWSXJPjIKnLIVCu+4yBvjCHBfWoPLthvluxI3BXkLGwcVnZl+EfHWpKMnozpLNhcZKgrNfTRxnI+nwzmlevfSk/wMDovlm9ryRlJXFNlNmns8JE55/bzXYrqrufEXWm1R/1V4cUfEJ8UDMJOTtSF2AuJmizicTfSPDdTAsbrgrQlrF008aeL7mfHbdQkKcgCULP8p/LAqKdfgZE1W95D1dADh7QB2+9SmI6dCUqf5cD+BQX5pSWaYdw0X1maFN2JnLOo/jxQ903lDT9ZfQNBwHJbJnRsMI6S9ZzJQ6rnlkQp7I6esE7j0I1qWqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=El6g/ugILN89fwW3dv+Zv1pWOa8/TFe09I+0C1v7vN4=;
 b=MmcJ3knYQGUrMgaLpCPp2AKtOMl+I25mlUhlg4srEc7aXxzHj+jBcoh214+3o9cVgrcfxMcDRJvdVv92kEAktCqjwnzC+S5gSk8MtQgt67FucOc9m3Yih1YIMRwmg2FAL5OD/tlNlgF0pyoxiioK7vZrYB0TzVjU5h701znE+so08l9bHDTaw5Huho67o4fRYzHpgHAgZfC6W3zRhfYudMHcW1egnlgZRfHsZf/VVuclPa6Q3bxQ6cKKxVFMcLtxX77djXvW7pWPJMwvxZpqDUfOFDG4vP4LCD3woQ8jCyk6M3L+awRhRZIYwi3VeKd64IYjO+xcBklOc2OdWoHUcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=El6g/ugILN89fwW3dv+Zv1pWOa8/TFe09I+0C1v7vN4=;
 b=gwD7lVIKXpPowxmot/N4IJW6PxJQ/GE78Vyy0oKNRRgy9Z+9vQY7gj2tPnXq/NWjjmKh5d/3aWlR8oTfeH0O+d9gevmT5YHbtxQiq6SWAC0shRqdrYiEQOy7GZe4fuM/ZMk1P7GbVm5EO3zLE/pYMp+08g+07EJzE7PIK7zz0OYd7oH+rBQralwtmQfuqqhzh+FaaKUkj58BL9DcZnN1zLtAivWlR5CQVOXvhBSvSBBvaQyrvxD4oMdtfhPypfbT2cNlbAw7lcxiEZn5GQKKsFjNwqPpchRaN6glnoFO+wXR7XG6SIHb09X250Rj0FRvAZBO7xeRi4NUDSCkoS47Ug==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by DM4PR12MB6160.namprd12.prod.outlook.com (2603:10b6:8:a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Tue, 6 Oct
 2026 12:39:24 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0451.026; Tue, 6 Oct 2026
 12:39:23 +0000
Date: Tue, 6 Oct 2026 15:39:14 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	bridge@lists.linux.dev
Subject: Re: [PATCH net-next 0/6] net: bridge: fwd optimization cleanups
Message-ID: <20261006123914.GA752362@shredder>
References: <20261005143937.877466-1-razor@blackwall.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261005143937.877466-1-razor@blackwall.org>
X-ClientProxiedBy: TL0P290CA0009.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::6)
 To PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|DM4PR12MB6160:EE_
X-MS-Office365-Filtering-Correlation-Id: 27240c27-7e36-4e34-6545-08df23a6d9c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	5XFLixJYkL+A4ABNvn5KWyj7V8IAVWRzArn16t/dd8TeWLpV1pe4X44+CsmnltEHx4GXuvb2Lbr/YLNxa9bDReOnRAt94AeWmDEVT/4W4Kt777Qwz7qCsCW+e9rXrFNUC/ENIGJK6FzOACzDWFaGLL5oz2AWNwub6Iuc5z8QnCCXYhN1jgpTyuYHUEIDARKO2EL80ZqSXLp0HwgrISuZzJFXlwn0PlKSvk37prFXJisM6fYfvrJN/f7/r5P9enPG6UaL5CiFEq20KmGN3FhfrbLgBkSx2XlDojBlATVZzDB3yInKOJfOFzcjfvuoJpXxuI8D3ej+9iF7vhgNlMupTsnVPyvAxPUrsf7vjZrAPpPht5BJO2N+Wjmtv6PBostHoz4LT5bJWgaT6jN5JQNa9OgB8giX7uVrafV5dpJj77XJm9CtpJuYHFeejauIipo2y2C//Vy/Btk/JuYrUKJU0zdiW7tMcmc3XSxD79SX7OSocOL7nqS7MmamNI0W3pLNmHEnJRuMZhb9Z7fEBlq8oqsDn60Lu+U9i50UKv6nKoUWtuCj9rfHQXh3gEi4TlU31Svx77f1nf7muah61CFKvB+RAwknuw32cVx48dzmWn4N4xmdB9TaEinENabQAk0Ul0c6VY8wXDZ+x2L/8Kp5MA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fZqfi3YAPGRzbTkKU6HqOZF7QCwam0wAY9e5vc6GRCLxj182tIMa/ssXn6wF?=
 =?us-ascii?Q?8VchQIYsLQF6Z0CAv1bwVTAU6COZC92+u1XaiUv9BEU1I6fELrcmA7jAQHWC?=
 =?us-ascii?Q?FKkbNehE5psOfOcyEpQq98AuBpIh1qRC4juIi+eBf40LJ4W+LW443w3aHjMl?=
 =?us-ascii?Q?RJ2ReqCHiiYLCFhnhEVoDNMYbMA/xJ/F5i9tVDJpri3TyAPJcv73KK3vWml3?=
 =?us-ascii?Q?Nop/JrC1LoApZhn2vjAtqwD71tsPWKRkdmluBeOnZS4AdArV16kNC3LPtpi3?=
 =?us-ascii?Q?df9osSx7y3H5/iOpVgNP9fHH0iCVPG/xvlJbTdubg6IqQuGXUzv3XkLfb0xD?=
 =?us-ascii?Q?zXopSB55BCkt0nXowMB5Ni+G1idoyxOQOVcTFQxKh7FMIrgqUEXO1J5JiaZm?=
 =?us-ascii?Q?ajTQQw+WvkOMPjVkpdm0DbC6WX3n9thc0sjTl1Axy8EsNzjNVS32e4m/VXEW?=
 =?us-ascii?Q?z3zzrIL1ije4+LGz251hGDdynMPypP+0nrC7SPibvZLqkcIGxboNSWCrqROq?=
 =?us-ascii?Q?a3gx5caiBIi4Vml6lYPm86haqnFDCDT0LzYvGL+eEncBM8f+g5HdgPTbD+qe?=
 =?us-ascii?Q?9Cahtxl/rEDEYT8rkft1Cv9WRfKQSYsZV1WhoIsyeyAdJu6JAfo6CHIx9RnF?=
 =?us-ascii?Q?OdKoxG9UD0ix8/poHiQ2F0dgKA0Rr0k1/wQADIVNLKeRUBt6wscqILD6SC5s?=
 =?us-ascii?Q?YZJru1UFzyfPen515iAFwwNftib6AGTZCGfvtcuP4hi11U7Wd4Nrej5ajSQp?=
 =?us-ascii?Q?+h3PMBmAlYH2F8uSeTN4/NtYF1owND9ZXGxdaatUjCH/Fc/+oesRxUalSXKb?=
 =?us-ascii?Q?jH/99hKLFvoyXr23QurktlOPbhQr+3yeG7gooA/F7DHFKCNjnZuzxDIuurFZ?=
 =?us-ascii?Q?ZDheWTIpckdfgArb1mIZMmp+MB2UQwvcpbsI642nfPZywrVhMmhXAizgV9wU?=
 =?us-ascii?Q?JRwrI3enpmBdyUf/5nyv5Sws6/3R7Z6YjXVi1Y+MNrLmVC/RNksgG7uL+QgV?=
 =?us-ascii?Q?FkTXvzspUTg/72JepUWj8nQCoPHHJAlQHH3MD8TROqBZh5b+RmQRU9ql+4sG?=
 =?us-ascii?Q?wbc9Yp33ZkOTwUUCTA7tSH0O9u7y/Kl46jTxbPX6tDdJOosKDyjwswDn+t2G?=
 =?us-ascii?Q?Q6s9UADx7mnJWZpuOof9Tgrk2nMvNwlQlJU6Ec7QwF2g8pXD3LSAQWSNoPHd?=
 =?us-ascii?Q?HndP/DbmLRWwwGzHmMYZgpPL6vd9OnhorYTFAFNTJiZahaclHxTagC7vWBTQ?=
 =?us-ascii?Q?2PnYLq+W5UY2D6jpLvIJavzhxaTv0hoELdDcb57qOMV+1LiT5qI+XIJ9tb5q?=
 =?us-ascii?Q?b7C9pO93knrWDBAkkYeo158ue9s/AaAbI+XFQWs/ePK3ebX4LM9TWZSQfyi5?=
 =?us-ascii?Q?6b0QSW52pbBsQFBG2aso5zhJBlLFg5JKWQOD56+jGomtmmMTBT5q3oD64KhL?=
 =?us-ascii?Q?//ur61gq/WrgJcLUSvEeN2Vv1AsAmFk7HcGL8OwEv8ccX/KK6+elx/3U7MJ8?=
 =?us-ascii?Q?MFMNdtxtXpyZPuWdDtz/1Q3V83qrbCSNhJNGy2u3BsGEHD0wKBy7l8lgCxID?=
 =?us-ascii?Q?u43UGvtcPAOWm2dglV8ZC/xU7BJuKTTOOZCrpWVZBt4FmY/BGsK37BNWmwim?=
 =?us-ascii?Q?ocsHoP0qn5Hldk70tAJX02hHvlCjLKShmRxXEIiXSIXp1ZMeCa+vxSnK2bHz?=
 =?us-ascii?Q?KohoF643g21ZwWgsa3/udBVQMSCEkGI3n/ucHB2bFHvwF4J7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27240c27-7e36-4e34-6545-08df23a6d9c5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 12:39:23.8612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9sGqDhbuJaYfkCrJ12poAiA4iVjc0tEtSp6SVldlIsLq/7nJyFwZoNU5l07Sr+v9dDomtnl/U6iikwIwTN8nJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6160

On Mon, Oct 05, 2026 at 05:39:31PM +0300, Nikolay Aleksandrov wrote:
> Hi,
> This patch-set takes care of the review comments and also does some
> additional cleanups after the recent forwarding optimizations. The first
> patch and the fourth take care of Ido's comments[1]. I have folded his
> suggestion with inlining the pvid helpers which aren't necessary anymore.
> The second patch takes care of Sashiko's comment[2]. The rest are
> additional cleanups. No functional changes intended by any of these.
> For more information please check their commit messages.

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
