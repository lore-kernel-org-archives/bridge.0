Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794938325;
	b=gl4minw4o2/Mi0k5raeT5l/tn2gF8yuwp7/1A5Ohf+q7BIaM5zAhserx2cNZbvRWglpv
	 bnAOKmc1csmIehdnopHx1nklSDyNTjMMNfu6Q1lvu+ruDVMUqpNHYvFxVN6BEtA4fr42f
	 Ni/BLxNmcjksswbqvrZGoHgVT7/6Zya6sJrdNknyM1F1vtwBB8zRtaTykGclKx+IrUaSi
	 c6QuDCXvZg0ABmILAsmrj7YV897EFc1TtF4ewRhRoue2eFQqsJ9YOYOgOAE2N4aQBrp1C
	 6hk+7UmlkrQ9FRSSVKHzQGvbKHk8vzJLQEyckmZ8fyrJlkOc8tqnH/fMM5pRnN76bkA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794938325;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Subject:
	 Message-ID:References:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
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
	bh=65J1YVyWE/9j0aORxASj0IBFc8b1EKlm8XfT712/Sdk=;
	b=m/6suvF3X3DcDiS/YGIcjS+55DEsAXr19s4J7/qj6b0lAlgWZhkW63MLgyYqT2oSltX4
	 EgmXFHoh0B7ZZ0/HtENZVRQXipslLQEXhuXlsXC4ovAztQ6S/CbiOViz4pNXsUAVmOMC6
	 9m+dguYdLN+0CEjN01AuVRPCQmS/ZqRi0iPgUSBsgnPuaRvTYSw9olkIqQOdBX483N93L
	 FsTzXvovk64D5ZWuuVTpW0FBOk/xOQvaJJkZule8gBeoUbyy43bursRWhAC0Y79qxfGYT
	 rBPkIeZs+mfm7SuY7aoheAPfKmKn4qXovgGd2vCA1evMtVPbF0AMuU4NQjIgy/1INfg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=heuWy3El;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.28
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012028.outbound.protection.outlook.com [40.107.209.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48260606A31C
	for <bridge@lists.linux.dev>; Tue, 17 Nov 2026 17:58:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48260606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=heuWy3El
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LO7Q5VPefpkI+CMOMLTfk0McKYABImCoTRYt1Kw1Jl8OQ2VDK5iPjJ3eulTaSZN9r4aKzFQCShDbcEnH9e8fuMcQpGYjGYzlAXWpU7JsYxMB4LPn1HXHtRadoTi2gw45iCnmbcFQUQTIlQfsNhd1AUolcv5cs3ISpcEmxQyLi+l9RnTMqM7aujiC0fFQTIBME97NiFhjz2eHYMx2QdOYWG05Fuc76LEH+XrtJ58eLjLYgTD/b4woJpeNagPi7CL0u2LAjxDlTUYYsTJKZgPPlEmWXSZNCfAfKGgPW1xUhxJm5Psqf1xqFjJX77Nyjbrt6Qad61+DDM4ecI7RGBb/aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=65J1YVyWE/9j0aORxASj0IBFc8b1EKlm8XfT712/Sdk=;
 b=TFewnFBEOUEnMVGH3V75KHxt9o61F1wR7uw6FaP9lNdbYlnN8psRWXqbefj92rgl3b6krA/wxm5X+UQULuA59IGKm2wxozekv0c5jhzUcxMoYiMINvvf30hhqKIapxMyK7eHzV8neYn4syy31tIRJSgag8g1hMDaDUKVBZnvzaGtMp77DJkCok58CiOJQVMDb9jFMl7Kl5fDYVnMsCz2j+6Wx/vQ7I8KVvnH0gPnJQJ7yAPRdPh5Xjwa9RGfvStjp3auMd5omoFV4SvkC1qWmRODE6glEDEVyqkOnrbtRy/Uqi5hDSOeXUsvlW9yS5fxMKS6dEsWX4MZRndqGpl8Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=65J1YVyWE/9j0aORxASj0IBFc8b1EKlm8XfT712/Sdk=;
 b=heuWy3ElUENZBXptyzUOJKhWDEBfHdx5Jvi8yZln2ny/NSBHWBe51YzrKrZ9lzspivCABJ3jrVB60ygY4+scQfYO335VbBl2pBTNQpWhqTtzZOjTRZUUvJBEvQ1bpe/NHRpiAEo1PBzDrjymrGMs+VMW17u/kEV2TC3r33vlHUNG6sdrq3zVFYtERrzMj+0p7Npi7pwV4awJKv+0VwPmLFD5Ym3Zq2gJnNafaJ6Fgx2/w6bktszwe0XARHIzbn58cn6fChONpdPcDooj4xblerp7U+bM3SAYbUYZe9FaX56RKkrCWmnbb/6k6dkv7zL3BndQ/boxvFJwDTEGZ9DEOg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9407.namprd12.prod.outlook.com (2603:10b6:408:1f9::13)
 by IA1PR12MB161209.namprd12.prod.outlook.com (2603:10b6:208:5ac::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 17:56:58 +0000
Received: from LV8PR12MB9407.namprd12.prod.outlook.com
 ([fe80::208b:424e:47e9:8a96]) by LV8PR12MB9407.namprd12.prod.outlook.com
 ([fe80::208b:424e:47e9:8a96%4]) with mapi id 15.21.0615.009; Tue, 17 Nov 2026
 17:56:58 +0000
Date: Tue, 17 Nov 2026 19:56:48 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Joe Damato <joe@dama.to>, Dmitry Antipov <dmantipov@yandex.ru>,
	Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux.dev,
	netdev@vger.kernel.org
Subject: Re: [PATCH] net: bridge: avoid redundant strlen() in
 show_backup_port()
Message-ID: <20261117175648.GA961425@shredder>
References: <20261117165106.635733-1-dmantipov@yandex.ru>
 <avyTnnR3xnUSnPmU@devvm20253.cco0.facebook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avyTnnR3xnUSnPmU@devvm20253.cco0.facebook.com>
X-ClientProxiedBy: TL2P290CA0016.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::18) To LV8PR12MB9407.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: LV8PR12MB9407:EE_|IA1PR12MB161209:EE_
X-MS-Office365-Filtering-Correlation-Id: 34f2bac1-24b7-43be-0c2c-08df44d42c3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|18002099003|22082099003|3023799007|11063799006|56012099006|10067099003|4143699003|261026121527099003|261022075727099003;
X-Microsoft-Antispam-Message-Info:
	KOQ6/rj5yiUMsZAaf/WaaV4LLxrV7WSZGvjq8cfLfInwTN8irNZL2g+X8/hg7Ab63k4/J612fm7RgY1L9WrN8HI18RF74MnyFlqqik63r182IhKQBTBIRSqlyBHZB6EEjFilBBKinmKgre1M8qef5oMzgk4OdHEn9iJdPSt2Jd+/a0LGFbV4wPMtmGPrkZ3oCqX1uEYfKn+1BZmSyJFhM746DGdo9ibiIiwfY8xD4aLvSMz/BrbyBcg4r2NcRHPnXWm4gM/wgIclseGqCmeUKUIH6pk7QNQ7TVIIL3nrs0scBt76xKwmRR2CdxYF9JTsCb5nT3aBQQcFrdUGCZPiJtUTNmQOlWzPk2QoXbEE+80iAPVHNZCPaDPaCFeJw6hUj/nuiGH9b4mTV6Q6+2TO4Lo+VZW1WQTSVKKrtc+pAGA8zgwF2OCshpvJVeh/KsHk9zIerjpkxIutzt4vnzeZ/LwKIvpm6VDWcOdEKhLQpm754gMjUzZhV66EbCt+0yWadX+ne8zXBhkswhq0Mc5xuvg22HYeSCb1TdyKTzZwa4Bc1neWWu7fywqMrTVHPOWBp3VQNNTgbIDdlrf8DeViqopTtMwa9j+P+bRgjMBlAgdVtne4BcC3yywSM3lIcE7ker9LKEYLYWZGmHyaXXVOZDeDMUV/Yq6lSsTagepwxtc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9407.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(18002099003)(22082099003)(3023799007)(11063799006)(56012099006)(10067099003)(4143699003)(261026121527099003)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SuhqiB5mRPwI91mGqZ7vQ+NBfThMNyE112fSjM/bX6DzpYq0TDDpsnYubEt5?=
 =?us-ascii?Q?DYy8P5RMO5P8LP04e7sVEe+qyjPDxw7un4Bo8YQmNhaDfopCTaFJXC5vr3al?=
 =?us-ascii?Q?VUV3GsLO6qOP/XjJ7VPqR7eMBH6JitTNHEIiudtzUfFRO6OLpWDe1G5cdkon?=
 =?us-ascii?Q?TJnZVLy/PexuAACTVuqPZfJrKUmoeOuPUO/aWGSa+fwyq4RMCErJWQMxs5Ls?=
 =?us-ascii?Q?4c1+EeCLiaZcT+kqZaOBfih7gK11s1E58PuvLQNXxwzS2w1pvfSzlUVi4wkx?=
 =?us-ascii?Q?9MFcV9Ri2Bt/ONoS9hl50ZDDqNyIiiGgtKUaJKQEtYP0V1CDWXyRQxJWn7TT?=
 =?us-ascii?Q?82Co33DUUE5scsofkBA5iKXkyuLQBej6Fm22EVHLw413nPiQILyLAuRuqxF2?=
 =?us-ascii?Q?Rk7+GYE9iWdZPakHK8Iz62JIPQ1pb93XSCdJ+mR0MABCpJxjHjl4wEMlR/ZS?=
 =?us-ascii?Q?vr4z0ZuLEMqdmYFtO16oSeSzHI3sH+pNkLcIEZjIuY0zze2M8DV9JAvrhYDv?=
 =?us-ascii?Q?751TeOX7ECKfejJfwOIaaQaLpeP3f4NTbSE8xGPagM7hSHW9w88ETAoL/jft?=
 =?us-ascii?Q?QAwCtj2cUEp7zmg6v8MpB0BwwC/lgPW5W8rVg0jBDaSbsKyZRAodfShHh5vy?=
 =?us-ascii?Q?3/h/TthvULvoKw4ws3yCzHgKmZP0joQcuqyGFxSwwZBodFe0Ur+lD+Iuj9AT?=
 =?us-ascii?Q?YTujL2hndKu9V/Q6hWOU9ZOy2jiKwhhNJR59xO+UUMnS6LMv4l5iVCxz5M16?=
 =?us-ascii?Q?6Bze6yrSQRm6fMhk+6qAQRjBrhXduh0X0JBDMgXPqYxzI5fzq4YljEnhOc1f?=
 =?us-ascii?Q?/7IqTelWrnhgBe7kd+8+wI/e6/N8j9SFNaa6jv/I/cKyi+qZI9dzr51u0mTa?=
 =?us-ascii?Q?gTn2AKQUVcITUH7ko5iU6CWEZtG80KyZlPRkbGuNMzTosUySe8ugtxvnSOoB?=
 =?us-ascii?Q?+Ee243BC8N06KZcosdyP2X1fchhE6cMISeQ4oO6dZhyRpDlbwCR1a0XF7lX0?=
 =?us-ascii?Q?9zLXSMBf+E6iR/XaTjLuDDOPG1kfGn+u7ILGQBOCwo+oytr+iBMJVVF4SatP?=
 =?us-ascii?Q?gyCnUDMpLhCqvFAWgNsH3YH5/clFWYnw3QHhiKTaKQYEm1dyuHL8UAnD29UE?=
 =?us-ascii?Q?6KvBbYGeFWjSoKj9ESuqjG6InC5wIcfTD1kxrSUAF+7hmPqwFZwHlg8PeBGr?=
 =?us-ascii?Q?AJX9qM/Bb15O8Uk6LE6+lPlaa73n61g8VJpszNaKxFGOETWmhgL2aB344Dfz?=
 =?us-ascii?Q?iTUHJ+I0TqGie0ElrLnaNx2imiru6fBJ4Shu773oOp2nG6O0eFYgZBCUAioO?=
 =?us-ascii?Q?6c71zqHwyvhcfYUzxHgZFcHbTG00LXjVMdQNbYHJyTBHvR3/XWwQMniBaQnJ?=
 =?us-ascii?Q?bePajs1BgGuE4sByWMc4uPiVCCUm+dhBsZIoWPwuDIoKvHgkfRL35Hki8YXe?=
 =?us-ascii?Q?0NZUbw1oz1IThVL7gTLz4zJQBIEYSs7BoBfINBQUun6LiZBmaxsv+ZOYMRE6?=
 =?us-ascii?Q?dWhxD9JRosSsapC+U32W2qD40lRcnFLjrkBCaN+p8dz/C7LrDJGA8lNF9JSE?=
 =?us-ascii?Q?gGl65Qw8A7VNbKFZ+9W13yfE71SE7GjaNSwQymlZfN+KehoRI8fOykxSc2HP?=
 =?us-ascii?Q?JLwXNS8b1h+0EjFACx2v5r81oxZv7nS0RcmTjYEkR4a4vRuPEXhvZiu2eArb?=
 =?us-ascii?Q?vsulsHrdJuWXZ024r+UhGIhx2ZLnD401k5BoH2EgsVDLGklY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34f2bac1-24b7-43be-0c2c-08df44d42c3b
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9407.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 17:56:58.1641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lLdDsnqZ7P7vZFUeQo3uH6JPwnXv7N2hQ+F3VQFIHbU/XdBw2tPgkIrLmnDZ21si6R2uiqvp2d+en9yp/HdX8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB161209

On Tue, Nov 17, 2026 at 09:49:18AM -0800, Joe Damato wrote:
> On Tue, Nov 17, 2026 at 07:51:06PM +0300, Dmitry Antipov wrote:
> > In store_backup_port(), prefer strchrnul() over strchr() to
> > avoid redundant call to strlen().
> 
> a couple things:
> 
> - i dont't think the change is worth it because it feels like unnecessary
>   churn in a path that isn't a hot path. how many bytes are we really avoiding
>   counting here?
> 
> - commit message mentions store_backup_port but subject line says
>   show_backup_port, so commit would need to be respun
> 
> but imho i think this should be dropped

Yep.

pw-bot: rejected
