Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012064.outbound.protection.outlook.com [52.101.48.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F0D3A1682
	for <bridge@lists.linux.dev>; Tue, 31 Mar 2026 14:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774966624; cv=fail; b=GZ8i7LRd3FrtUoBXNrJ6iTfJe/UHEU9lCUCIdeMCegn7gK9ozVFAI3l0pJlnFO8M8aCfRC2+m4OdHC+kSEiIOYVUUIe+wXwXiRf6Z7DBdQZXDupGhySvzHR75zdyMJnuMx1LlMVhGuAw0J7G4h13YHc3+dVInTRyZ2p3WnUicHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774966624; c=relaxed/simple;
	bh=R+KtEfLWpZq3nGxGz3e1lxApNw7F5q71cNop0oqp4bY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nxc5kCn9CCase3ig+D1zd7ILeQU/CavlGpE8bM7ltG+RGeQEoEYXoAiLhX01SIuShdqnhOjL+HfKSO6Oic6hWLjnwtcP10sQEfpuv5uoOXBZDGLQvohgT2tKlPCQTkK+xz9uY0Yrv3GMrKhCq+zHHqdQgYfDe6cbCXmwYE23zmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rmtWeLd6; arc=fail smtp.client-ip=52.101.48.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rmtWeLd6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ICUGJHcQqE8P/b+koI8Kf7b1Zz3uSH/wo6veGt5lbnodJJYDRkEikW6dLrMVCEIdU3NGybJ2TqRi/Y5GqrmWP36PX+ZPZSTtVvByZFdd3Co6yf8/ivHLXOgWS7e1eckN2YRDgrCZBiDbqFLkCHfuODsEi6wbK0lPVvhmDGh6SxuD/v2fu7FstryK4kRyYTu6CiiH4g9PxAVZtJikDVV0+2MVrVNk5jwbs7e191yJ4hKIRGlYH6YjmTliPhW5DoMXjsTZdilJs1f6XVawwAVPpKBkH0cSSM5CMacg6ipSpFK+4QHfoq8s/2zKo/rR/FFXd6ZxTeTAZOHxkeqZ/f3Ddg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R+KtEfLWpZq3nGxGz3e1lxApNw7F5q71cNop0oqp4bY=;
 b=bflqHgHr+wuQjtgTMOCSOC0nmBL4EQiJ3LVTbgkU56ldi4tFdG4Q4gk1F5Q6mo+IUrvUa3x6vJfxcyLfWgF21uPSjmG+FKYuTucP4pvPfWMROu7zAcblSixXjJtbeCxBqrJYle0fvcbUdYcNtQjq6/nBwYHBGPLvvhD/tjfnsSso+Mn/akD8fs9urWgBmnPqu7Ucf1nLZLm32dxW2evI6cppP6Ih1F4EPkZXmlOeTcVtufcuyeT7Jbbs/bZgYcvFNQhZLowWrbT1jmH4ap3nO9KI9RgBzjXoy0YMGtzjoZAjWt9bsa+249LO7cfR+O1kX+haGpTnQPmh43u1KmpXEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+KtEfLWpZq3nGxGz3e1lxApNw7F5q71cNop0oqp4bY=;
 b=rmtWeLd6vPwSxObKvsJJpcAoND2cYBpfTX2LrP/EefuCClpcip/rfYTVAguEDTQELX1WwtQWxJs7knRSHm14EHfpfCh2mTgTWFEslssYvPwCnlS+xsyRhIXY41xxI1M3Mf+Qbo+VHl4Z8FubHlAHJOPrrtjVVugmVmzQFS1b9OeYE5jBR8qp5GIHoh7I73x2QS2owQkYBqnGSYlz6sBZ2r91mS6wggKwOp0ySYGaSN9lUtiNrHX0+U9wm7ylqQj0ZcxMLNyMg9fedjXdR2vF6UvpgGIqyqQa6K9l2jKJ2le2SekEF3m5lgdGDUH+0KhCloeLEb0/RoIjbXRzqpMYeg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by IA1PR12MB6625.namprd12.prod.outlook.com (2603:10b6:208:3a3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 14:16:56 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 14:16:56 +0000
Date: Tue, 31 Mar 2026 17:16:47 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Ujjal Roy <royujjal@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Andy Roulin <aroulin@nvidia.com>, Yong Wang <yongwang@nvidia.com>,
	Petr Machata <petrm@nvidia.com>, Ujjal Roy <ujjal@alumnux.com>,
	bridge@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/5] net: bridge: mcast: add multicast
 exponential field encoding
Message-ID: <20260331141647.GB1637150@shredder>
References: <f23ed1b3-6321-4e6d-9cda-ec5d34304f3b@blackwall.org>
 <20260330191611.16929-1-royujjal@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330191611.16929-1-royujjal@gmail.com>
X-ClientProxiedBy: TL2P290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::16) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|IA1PR12MB6625:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e02e5d2-7a18-4239-602f-08de8f302a6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	R4BKUWNdLgRsNa5D+Bv0uHAQ1AS837r4GyhF46vJjWt6zQ/z7vvmGR3Yh3ldc8V5bjTA/CWMyFE5so+gQi2ILP0KFRQyg/ho/H4czTRr1cKR/ULcxnkhPkZ6frSs+7OPeX/DHFBZGv+krKu7JY1xGkai4xfDWY8oZ3COjt5ra0LByH+uYxnPeWlpiEnVu9tZs46tU6lsPnUhOCk7+BDo142AhBneDnah2FWZj3aiC1swmznSfsGo801J8hNnlp411ByMOt2B+AojJMxrjF/yqZwDkjOjsiF6LU5T0ARx2OSlfzCQ2etiegRx7/Ysr9ZY2IBmWzltOoW8ybHOYeX37zf74yrQA1ILPuzI45exZBvXHCd3/U43YdbIdZLW7GzK57+5o5L8Y++OBHQc1zfIDMTTQOj9hGQsDYdXYOjiOl3RQ8q5p8uivI2/V+NfNJptfANGRoO3GcSqShgccVCihhnPOQUsKjoj7GSlgoh7OrAq9SlgxyLUZryKZ/va1vh2pdgAFRm2gcgJ7OZHoj9/Lq21xrg2ul7bkCO8t5QzWznj9dKjsHoEUo1mQsGTKjxeVYyEaEl9tnUzVmkTdQSEI5N9+6IRHYuyZwijVUHRQMWUutsR01yvmkza4RZA9Ka3qtCKDWLQ6XAVCG7EDwAO2K+lHPql70kLdjNZBC+uvIG1ksBRDpa9pofulD4ArG66jqjh6ZQ6AcIHIbYdL7Zj0d+Wr8rWTqMwd9X1r4PC9Do=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p4NCATYAoRjHt+1coN/4N2BdHlhBjTN8pcyOenXYN+/7VynVmBSqvb3tlye9?=
 =?us-ascii?Q?fbgJLCxvXR0nd7HeEQ3rM8qbe9PMt//blRJKP2jXBUJ27VXzkHFir/FZExPG?=
 =?us-ascii?Q?ZH8DgqZMBw1POflQsnenOeCVCvuUUZPDHyiIhoXwGv0N7pnx4RIGJRIWgcyA?=
 =?us-ascii?Q?AO3CIOWT7C722HwHZE0bkBeWJ03GAtihDYgOHR7yyHsY4oWPNJZEVsb1IU69?=
 =?us-ascii?Q?qI4OLCXiIH1/j+r9MsRN1k/ZXdxxpODGVIzboqpFrkSWxi2Sh2W44rX6gp3P?=
 =?us-ascii?Q?zEpHsvo7eqnxggx4STwsTlLpQqo1E+dbHnz/AHT8RLh4N55Lz4w6hMiLWmkT?=
 =?us-ascii?Q?dPPEKGJj1r7Nsj7huuPwmuf38Sgl/o5HThFPbYR75R3Gxlf3NFYgJT+4oszM?=
 =?us-ascii?Q?da3k0UOhcVGqblgIkvTDtVfxUyFZF+4MJmOiJbFWzuxQYXY4X3tPA0AnfZeH?=
 =?us-ascii?Q?sG1GCs1pgoaHRu0kdRxarvgmdwgRVlm9/QUs9Js6aG5Fm+0WydZcziPVf/hV?=
 =?us-ascii?Q?6yJdwPdTxDh9e+YNy3Hlbq2sU6cvQI2TM5NoRHwIIPqOSxteT32ktBtgBk2X?=
 =?us-ascii?Q?cV80j+OP+2F5nGeTiSnaEf1qszo4W+t2hyhBfwPTzccUaFAtBFCoyddfEHea?=
 =?us-ascii?Q?S7AZ9WyfEDZS/8s5XlE+wL13rA+2TSZjEHMgOaMZNQrHfkh2rmwRLBivaJYC?=
 =?us-ascii?Q?xi60RcfnYWC8+SZeRSFyjVSa7DD6qPXq8uF+lESTqX8u31GLiPsa78i3ZMK5?=
 =?us-ascii?Q?7C1rowAjzK5PMQDxd0a8oRrZF/Z2NUSQ6DEacXeMc0myHRJI+e/a/p8eEvDB?=
 =?us-ascii?Q?YAB6N2+iye1HG6OXnPrtKi7wFkHnarvdiRhu3MCbOB4eHtyQ8z7irQ5NHu0y?=
 =?us-ascii?Q?dmi2WFm1zYoVsp1o5oqxvmZoFt4by7iuWJEBjkd6K9v4zLqF1cZqsQaI5x+2?=
 =?us-ascii?Q?qZfS0ioovGZ6vtk2LsaKYNf6Hq4DpuaTyRyDuODfu6OO9bPOcpP4Mu9KVFzo?=
 =?us-ascii?Q?KzHo0CzGfamvdgXvxwx+WthWhHSX5UxobKntjTJ12q/OEPZgfQwTa/S68Q5F?=
 =?us-ascii?Q?19vIoMFEvuX2smvjDyrNi3b9mAqb/N9m6hSjWvpelP81mIYkXgMqBgkq+NpE?=
 =?us-ascii?Q?1GfdriMLGXMdaNNKs+qxKBd/5AbrZ+9ypHHDh32S5kT29npZbuKCTMk2tSZY?=
 =?us-ascii?Q?UoeNDIjBDTOOP9tSQd+m5zMBys6UMWFUkeAwjZBOYOrP6B//mFD+drNeispR?=
 =?us-ascii?Q?cOtM5jrvlLm/OE28GX4wk7yuSnPwzWdie3cbmDlUZZne5x6Mv1JsP3bs6pDd?=
 =?us-ascii?Q?wTFnfsQ3CyBMEISsGqWbHasLJo0yOxLJ4NjEuxelvf74DK0+ZrsGtG5O7ZY3?=
 =?us-ascii?Q?AQmi3Hq7KTZVXAdTNhrzsiDpeNVRFH0ole9B/DAtWFYoHour8OzG5JWvcAaw?=
 =?us-ascii?Q?0OHTlQBp9R2AYpvDbQKQSYj/9KVj13zw6Ii3WK+kISJfb1YY9lMRCA0it3fX?=
 =?us-ascii?Q?cG907RKY6/zslPSc6x7KeN9s9R5Twtv+qxevipQ2KoJNAnODTI8273i7MGet?=
 =?us-ascii?Q?FPwP8dSqbINPVlulcTYiSLOvg8S8uLusinbZBRPgTeVK4XBAFNeXKU3lsMu2?=
 =?us-ascii?Q?E8tXBP1qVz+vcOi7lqj5mhw+BRiZohQRjZ2KN55Tk4D+tDnmlKziETCY4gk9?=
 =?us-ascii?Q?KBjbYcrtdFhaR/hmrTX9AHp6Vn5Enwz6q6LdZNeRUZA1IPmmxs9rTF4Sm0EO?=
 =?us-ascii?Q?0+JXVE+NwA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e02e5d2-7a18-4239-602f-08de8f302a6b
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 14:16:56.7793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z+zjZXcQnkSoiA3jwWHrfv5+nANHUlA6uNz0JWmkqqUO42iscLwtBXfr0TNsmQogb2is+ReWnw2g+C+Ur6IGtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6625

On Mon, Mar 30, 2026 at 07:16:06PM +0000, Ujjal Roy wrote:
> Description:
> This series addresses a mismatch in how multicast query
> intervals and response codes are handled across IPv4 (IGMPv3)
> and IPv6 (MLDv2). While decoding logic currently exists,
> the corresponding encoding logic is missing during query
> packet generation. This leads to incorrect intervals being
> transmitted when values exceed their linear thresholds.

Thanks for the patches. I will take a look, but please read:

https://docs.kernel.org/process/maintainer-netdev.html

In particular:

"The new version of patches should be posted as a separate thread, not
as a reply to the previous posting."
