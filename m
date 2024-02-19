Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AAA482C9
	for <bridge@lists.linux-foundation.org>; Mon, 19 Feb 2024 18:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708367126; cv=fail; b=saa62qlxKHDyt5s7SSvy99YYkscFvhjPCndUic2b3fNd5g5Kg9YEWL9TXVBWmNspofcivTy/voFk5UFUzekQt2aSJbY7vQyOJO8So/vRx10aE7Vy+4GAO/wWHUy92tG3nOup0fRMcLWX0L7VIPH8vRm+IumxjpAEmqM4++f/2ME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708367126; c=relaxed/simple;
	bh=r/wQTooAskigB3ZeYS6punRpkwh963aBKrYFTQDy/FE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MVUpx1RjmRExS46WhXEMYIMW5C/vzAkSLw4VpJdqR5MdfODCqxYjm3gU5ZikAV4V/Sjj94/IuP+Vqi/Lbex/WejWZzGcgwIIxoPyZvAhCDRAlMiEaK101q81ob/vD/EOVaSjs8SGfToyNZXj9JXBNZen7hOFkW+KuVXXzZfJ1wc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tpv1MuCh; arc=fail smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tpv1MuCh"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CA9C26077E
	for <bridge@lists.linux-foundation.org>; Mon, 19 Feb 2024 18:25:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.103
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gvmRgAwsTVV5 for <bridge@lists.linux-foundation.org>;
	Mon, 19 Feb 2024 18:25:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:111:f403:2408::600; helo=nam04-bn8-obe.outbound.protection.outlook.com; envelope-from=idosch@nvidia.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org E132A6077A
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E132A6077A
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=tpv1MuCh
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on20600.outbound.protection.outlook.com [IPv6:2a01:111:f403:2408::600])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E132A6077A
	for <bridge@lists.linux-foundation.org>; Mon, 19 Feb 2024 18:25:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BZAJ4qsPUGK4TG3E5Fpa78LkdedWw9MEKHBNxbZvv7mPYfozVBLTPSrZM5qQJFSbcYq/1cKt0APaG58IVKPdyFbJvIsN9rrB1mZjyOIhajwiXe1hdbMq0Z5ONMwjciWW/w/NkqwhgDjD4HW+1HlcUhw4Tir/rO3McMSE7/U/i+5RwuSjUXzSCg3s1300y4hvbEyCVRLs6LSXEFQYaiXYvlr2Xm6KTv1eFFZ1UT6JCNHa29p0PXJN7lVrFQc0x0BG3WShOY1631s/x4jzEiEdktvxqF+iOt1M+r5WTLU3foSZZ34OERg+Q1vsJUjoB902EgAzetBsWHgHSQzuQB/yFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ljnj+HURe6Vr8VTcbaQS7ByYPyijZnPKRzUCKWfaSmQ=;
 b=aslQ8NSSOohnZE96HVy0zvhRkb2I7nXneItVrEIVf1pBkBup0+bgTv5Tzwh8y6jNToI0ObO/F2zD0Wms4klOEG8HyQ+jXB2o1soMw8Pm0eG41FToOeCZL0vrz0ooZ+ZeGli5HKCbZP6IHTa7Qvp+TO8KpY6RUvq20n8PE7c6ZJgGx1i8KjC/9sp5zs/6GFGzg4/hKEBOPS9t9bYx5LHEx4LELUf+AM7/JiOEHdEaDkq0mdmYS3meqdE2xZyCkI5PtGB8/svx+kTzUu41qJQfE4ZqdNgK3s8XYjruV27rXXZnHgUXi5tt+1qezG7yOVXkr3SaXN9Zc4DZUs5BJ0sKWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ljnj+HURe6Vr8VTcbaQS7ByYPyijZnPKRzUCKWfaSmQ=;
 b=tpv1MuChaD5uKJLxraTzwfxzL7fI39va9MXE3+j3aqg0ufuKd2B314hAa4nRCEiTgu81HnOMnQQM/eypwtpZBrzmkVkAWbu47l0WTXj2W2Jo+QmaD82PQbZWgO5a1ryKDOAlWjln1NBgLuDGOJBEul0xOZjj4t09Svvxqc2yKlD1sZLQaOE7tt6isMNqLOr7/OD1f56SPtiP23aNEEnfHnHP9geElWXP7S3qnDjBLn4A+4n9QUGOr8Pxp4N7pWJfQ5KjdkDjCLuvASh0ji6RRUKqF8rxlHysT3i7zNQtpYR5bSfSJ262wifHWb2JFDr81cPwUtNU7h3inE5vXW4pMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by DS7PR12MB5791.namprd12.prod.outlook.com (2603:10b6:8:76::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.17; Mon, 19 Feb
 2024 18:25:19 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::ed06:4cd7:5422:5724]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::ed06:4cd7:5422:5724%5]) with mapi id 15.20.7316.018; Mon, 19 Feb 2024
 18:25:18 +0000
Date: Mon, 19 Feb 2024 20:25:13 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Yujie Liu <yujie.liu@intel.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org,
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, roopa@nvidia.com, razor@blackwall.org,
	petrm@nvidia.com, lkp@intel.com
Subject: Re: [PATCH net-next 9/9] selftests: vxlan_mdb: Add MDB bulk deletion
 test
Message-ID: <ZdOdCfU3k6yZzE2V@shredder>
References: <20231217083244.4076193-10-idosch@nvidia.com>
 <ZdLtGPglcpI55/J/@yujie-X299>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdLtGPglcpI55/J/@yujie-X299>
X-ClientProxiedBy: TLZP290CA0003.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::17) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|DS7PR12MB5791:EE_
X-MS-Office365-Filtering-Correlation-Id: 4305471d-ad37-4000-0c8d-08dc31782058
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MzyBTfmWLOT+OMxYNmDYKzygVeTQ32fLwkUPqv7NnvE3U84CIKkeDyhfwIkWIOLwxE8B1/6fJ6UopgecUqfvAbxWvb7Oz87V47LeJAg8dsdODVlDR3y8JaNneJMIpy9YLud+IXB6WCuZ7R06110dNZKgzdTKFr+Re18vB4JiNbiX3XNQqMzHcqm98abnwIwvu9hcljzS93jBRVeMeED6JtXnpx2ecoJXy67dJaCD/D9hwA7x9mYBy9O6Jqz8BFMPKghbsBmtlfi6HpIybTQYnQeNnLf+HfNe9ina+akS4UEBh0v/CNuwIT0BzWcZKxc01lo8xMWlmZhylSxJdDM/ZG/+NmqRCWAxbpVzVumZcbIQWSLGRJV0TNCpPRWxHHRHzs8l43f3vh7aW12F1lPRRgb1nWJD+iCXxX8NKUnWjfa9p8YKpmGtywrOKOJwNK8I271ZeIaBx8H8vN7+1tqw4T1cOyhBEu2drWlAhD7Te9P7u2CM5vaK6FufltyNObCRvEKmSiklzvIMA6rnO33R+bQ7HUt4fepoNf6E3rSN7FY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YSkaPewmCUNz+EZwnW1QkjmLk8pUI8PLIGTh5DFCtizTSmi7tXmwFBjbU/Eh?=
 =?us-ascii?Q?vRLLXBks2PqVa5VjLWcL2BL0NqYcnrfBCFMyWNz6oRQrjSrC4hQrop8hZT14?=
 =?us-ascii?Q?/hmFqkuW0o1altP6B/wNBIdvir6s+URLtD5rMhNA0+oBdEboGuiwS51EI06e?=
 =?us-ascii?Q?1IFcp0M3NEwroMUwTo3Bx1HQQ7Hj5qclBoTHUJ2EIv9mmX0pfdZ1USbGgGjg?=
 =?us-ascii?Q?vwO/SKfAuWlW7mfzDEDtsUrEB1aULrAKxWOy4BuiBXmLVo9D+x9Z6z68fVhS?=
 =?us-ascii?Q?gn+yMmGMD5YCiFoeuYng7jqNsrm2VJjIS+CuhacxIuFCV/i6W4F2Xvtx911R?=
 =?us-ascii?Q?u2nDzuEUemdzY1VS2vIK4aIA4O5cNHGshxnho7NVPOeT+hfY1j4d96Saf7/z?=
 =?us-ascii?Q?yfbqprXqKSOekUvd0SFszZ/6rrV8clY5wHlqjLzYkXGAd5G2cfq+kwnXJe6F?=
 =?us-ascii?Q?hBBPZWZeK7icAL6Wnd4zwNEEXWpIhVhUqsVwRidSFn5IlgONsxoJipm19t8X?=
 =?us-ascii?Q?/kEeeAgJ2CzDXXZSMP5PaJpcF+U/fIauvpVJ/L7AKSk4prXeFTDttL41eM/K?=
 =?us-ascii?Q?a7oVoQIOytKYU4KoFaLjUUFfoqa4ZqCES9YX6DIPkFqi3MEihPIAWwj+YVXm?=
 =?us-ascii?Q?kDxqAR6I1KUlYbzrjI/TB3zLv6UE7Qs73BXW0eha0jagTS3VA0u3ZmVj8ZfT?=
 =?us-ascii?Q?WfBflYqvUxFdEE8M8UfiEL268M05Ta1Cp/7YujVubiHk8Ni9etufji9UzZ5z?=
 =?us-ascii?Q?QLeSB/TYNmhLbLVed49+Ct5bDfgEQWS7QgZI6A1o52wXdjWKpv0BK7CN3Y4d?=
 =?us-ascii?Q?/Hkn9PKhQ2yatWGQZIW8BGw5u7bamPgiEW/YTu+4AAyHG0/gQWnzIRU0RXv+?=
 =?us-ascii?Q?QGZxXmSSrCWSvFNUtG6FTyRW9GL91nMc0OlU7V9E/REU6VMmvY0tRKioS8XL?=
 =?us-ascii?Q?k8U7/L1zmpvMwwiti7VhPmrCpKEhGBKeHqKtuIjXFrEbRiz+giP+GC2dPSpj?=
 =?us-ascii?Q?x8+8WAswaKsV/yIgaDczSBJP7BOtUkYP44RDNYbQcc1k2mCWYe8sFAKsEY6M?=
 =?us-ascii?Q?RUDSo6gRDPo6oAM5mAh1u1j5UTKvyFaSnY9raqVEhjry1PnkEhhAkxkPLZ7q?=
 =?us-ascii?Q?FiIjfe9+pvmH60LGf7Vw2viXi5bW1JsDgbiPtKxm4hF+PR+H4kwA+qTLEMAv?=
 =?us-ascii?Q?XJ2H7ntqGYVYjXIX01f1PKapXl/6zd/Nhv5VsDGVmRTGn0zi/8jPC97sy3YO?=
 =?us-ascii?Q?CuS2RphTD24/CtPE6paDV2twQGKk23u09Gkp6BnlsvFoVuSYz9KmzqtIZlje?=
 =?us-ascii?Q?+PA3GYBC8sU/vni+33/1OqYxM227Dt4mURBeKw/JNr33g4LPL5enSLikXQ+K?=
 =?us-ascii?Q?beplX3drDi+XrMV6d8yis6IIj89SDn1U7my5qTPNVcq9zq4AaCpSTl3D17ri?=
 =?us-ascii?Q?DzRyjO9l4zoEMkdB1Q8sKTsdWgwW7tp+6K1IE8shUy0KiDsrKyGMyzBq6I5g?=
 =?us-ascii?Q?Tg7+UDWOuccW2+FWlhKGDIiboIEufflsmulQ/oRsgHKQ/vzTz6rATEM+ZNsM?=
 =?us-ascii?Q?wWiWQEKMWelihNgY0xjTKJbJX79LxMapOynMf7sv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4305471d-ad37-4000-0c8d-08dc31782058
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 18:25:18.9421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BRMaXRMEK9zdo9tl284N92wqavnec5IkYGIK2WT1vWuB3BnzYDfeBZCImwGdOVuj1carYYq1yVqoAvjDor0jYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5791

Hi,

On Mon, Feb 19, 2024 at 01:54:32PM +0800, Yujie Liu wrote:
> Hi Ido,
> 
> I'm from the kernel test robot team. We noticed that this patch
> introduced a new group of flush tests. The bot cannot parse the test
> result correctly due to some duplicate output in the summary, such
> as the following ones marked by arrows:

[...]

> Althought we can walkaround this problem at the bot side, we would still
> like to consult you about whether it is expected or by design to have the
> duplicate test descriptions, and is it possible to give them different
> descriptions to clearly tell them apart? Could you please give us
> some guidance?

Thanks for the report. Wasn't aware of this limitation. Will take care
of it later this week (AFK tomorrow) and copy you on the patch.
