Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013025.outbound.protection.outlook.com [40.93.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4E444D035
	for <bridge@lists.linux.dev>; Wed, 19 Aug 2026 15:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787154606; cv=fail; b=A+nE1hJZFMfLL060+AXkJy93cik+IfoglJdsgMkzBr72nmkrE+lyWqKofG4I9kYPlXGCrc7TlgusCTdpwzoHbqaBaO0LP933hVFAUg+PFKKsp0PsCbPuTog9mM8uAezJcIiW1XTSZp4+SOtUBiV/rXqA2ORjYnRM6VePyaniPnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787154606; c=relaxed/simple;
	bh=eWxVKKbV6fYP+8gTobSXDDxXaYBBCfDpGoDuaWvWG8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ssaQ5YPVch7mdjSm0f/RvmYivmuiWuYLhrJ8wL64IK33MKVLECp948z9vg/IsBYqgu4T7u6jMjZ7WNMoXMmoHERArEZS4BoNwKSBuK7uHhDh/nErvxan3EaLupmZaCCGRoDQRSbiciTDbtofaBhxNZEIsOm1pdbPVJaumzasbZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cVgXRd0U; arc=fail smtp.client-ip=40.93.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cVgXRd0U"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dgn38EtH45FXKXSA9DvsFAUmBiqpJM8tq3OoLC5ncoORJ25TNuIRD5gyh/+S/YTrgp5c8GemSaCDXpXICXft617k5TP3FX4JgWypMj/OdljUff1i6r68uyjdiAe8uxbymiW0Iee3UfF/xUv9l35KRE1pFU3UMqlqx7Sl53Blr/pFdrzJmn+/pORwYp8YCCxDjUJjOK8+v9H3ft0+YuTUq14RZAxuXWqia4YvAWFNFv2JJI1QIDttIxMBL0EpWh66tQXYo0Lejz8ZAgTh4OOY5+KSq08sDXlgzixzv0jX8K6fgHZwvyLBZB+Ha4CNU5xi1yG6nc2W3usA4B9dtJX/4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ayv4XeWGAmoUFvbJFhvwApSWNF5497dX0axSg+oLFqc=;
 b=G/VnqEZV5rBr5YAEFg9ay6B27P2waRCdm8Sa0exJYrbHFyzJDh2uHxcmQvoYSYZJXxVnkz8SaRpErCHOUtCQIhwi7DEgKEagIXa4pS+RaA76v9gNLQ3nSfH3W9cnlSwwJ1xNqxX1dJZ3BuTo7e6lQK0hu+CGexX/UtN1GgTH06/eKY+fXZ2nEKhboQt5cIcFxpl0QxDl1D/pclF1cwOxqR7Wa0LDrMQIo692jElOhbpiaG6UjcXX6HoEFL250o3CFtNf1Dbjxti7ne+aqPFYrb3MOL7eAJSBdU1x93p6nUo7IwiaTeZdIrf3nCCuMLy2IbRC3S6OQdmqbDYJ49ZEXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ayv4XeWGAmoUFvbJFhvwApSWNF5497dX0axSg+oLFqc=;
 b=cVgXRd0UJBuW2+PxVnZOfzP91LBF8oryueXtZF9uJX7ms/T3YevR5xqFjpUYU+NYHS96cYuRQyPlLbLqAXmWQgzFVwLY7yfcQjj7/n6t43OW7BviV3XJJCAAbgRPLyG8HsPf91LqN6iKdHrZR6b3UUeq/GA+c2DyOeXjRmQaaXBwAhHt5ZPsaQEi5wyZciSF1G0B7pSZHiXEZkm3fUuvplhijdT3d8z7jsEoduP9SALRaW/OyYLa1ql89kKmSR+IESkx2K2UQoBysvoe1Hp3hGKXzRnd/a9gh8AyqOmoMlyF70Hvmp0zAS9ciTLAm+9Sh7ayL5R9gATZXdUz/ZQjgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CY5PR12MB6036.namprd12.prod.outlook.com (2603:10b6:930:2c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 15:50:00 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 15:50:00 +0000
Date: Wed, 19 Aug 2026 18:49:50 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	roopa@nvidia.com, bridge@lists.linux.dev, andrew+netdev@lunn.ch,
	dlstevens@us.ibm.com, amwang@redhat.com
Subject: Re: [PATCH net v2 2/2] vxlan: fix reading neigh ha
Message-ID: <20260819154950.GB1280224@shredder>
References: <20260818150756.890025-1-razor@blackwall.org>
 <20260818150756.890025-3-razor@blackwall.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818150756.890025-3-razor@blackwall.org>
X-ClientProxiedBy: FR3P281CA0185.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::18) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CY5PR12MB6036:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c360469-3523-4626-e227-08defe0986d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|56012099006|10067099003|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	DS2xWI//nr0pQbSrsUfGkWiZsxFO2cSGC76mK92T2nNGetqnmZjuWf4anCbRpuMhV0pb6copqQ90E2ufXou7Ekt/eKE5Ck27JaFYzYONy1QTpXmmQgzIZwdrTQdVztiVw+Z7ZHesbxHx06KGzm8iLqillGz23yvG28WTeaVMaSHYCSeLxpiG8uVEGfd0WxbDYu6IVZ2pgYxK81Qjz75YZWnyw2JVbQFC2qDdxlwBz0UGVjDmZMr7aQAvcr17mC7CUFtfsZWNAsaTJhAcouJ+8J6Pr1irnuITcrUioSRyfMryHSOl24cykFRb4oiVjctTwtCyW3kyFtmhjyh0V0ttZ9ckLy/wgQChOqy4I5i3RfMuJF3zt0ZZ6I3pZbWpotc/1RybPSUfxeTXlToPkEK8Y1TD2PrTVQFSXmnulon42d1M8J7DjGqW7GP1KieCfhwNgc50WN6AsZzgbmh/FJSvp/O/213RUWsViG+AKs13+8LBnGdY4XtRkh0urzz1YfHK1JtRSxhcsUZ/2bJWmftL3RUgZvLKqoGytQpGRxw4Qid7PKSF3uKvd1PFExzrj9DsCLrn3C+a1snNUi+8Ie8c5YdliOvr7GZD5rtWZgL0QOlTPHzFpXdg0FxOo42sE1klKsdmRC6n1FFaeKStZfVcRAgl46LTYUbKatS9i6pbcFQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(56012099006)(10067099003)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?34DkQJe63EBH/hwOXPq0WLcd957UK6HhgfthafwakBvnU6VlIo6TPTMgyn7M?=
 =?us-ascii?Q?o834nBL5ycXublbCjdfpcdbMQXOTWKTQZ9C9pJxWLSZ01DALDCaYspZTCjkV?=
 =?us-ascii?Q?vyQgIZpZ3cggWkVp8rV+owN5NpQr3K78vnOjUarT57v66oRmtCG8meYNwx/U?=
 =?us-ascii?Q?ed7C19JisTE7b7K63vZlXTs9F+nQb+0Myzfl7dZUfB+OojI9T5r3UIfqZq+I?=
 =?us-ascii?Q?7tRKNDyx+PGftvizNoDEK3MfXsPlJ2rDIPCPlmeAc0mVRABPohfnVQes0oSS?=
 =?us-ascii?Q?4hrkQDQDQNQ10va+aoBEhzdol+o1qfa70EwJN5uo4zFKWVCSXgisXTYOijxH?=
 =?us-ascii?Q?oN/OkwipKEviexpw9HRCIf5txWWTx8vKq1BRXyW/2SVzOdqWFVIG5SBEqPzy?=
 =?us-ascii?Q?sH2AZfg3B3/RD1ZfSFYLoqF6nge14C507JP8h8Omjjz6MEU77Q2bmhg0O0w8?=
 =?us-ascii?Q?EeOxT8KN/K3bmf63qF6SYLxnsUyDw6DrA3Ot+rJ1XZVOKMp2mg/zNHwWqCZd?=
 =?us-ascii?Q?RWrLp0YyzW9EW4xVv8H1nnksGZ/ZYG5Y7Y0EuMc6rJknEAirJQnCO/C++E/W?=
 =?us-ascii?Q?Xhyljj5w7I3dl1YrHFod4xgaDeE6W+/bt/yA/DoTRE70Q+sBTxeGy03Pgw38?=
 =?us-ascii?Q?oYomP/1DT5N+z9ShDKo/9WRpDUn5yhbNC9pJ+StIMTLTtrCAEj4diHBm0pKt?=
 =?us-ascii?Q?9upFOflI7sq6+HS01rDufiIg1MTcTTSRq2F8XcbQBaQ+AVXIkCVJ5b4KMuxW?=
 =?us-ascii?Q?fFM6C4huwAzfyBGoMcK1nawY4rRCBO3yGYGfEt1wm95Whz/tzR8Fz+WCfAfJ?=
 =?us-ascii?Q?Ga/EKOoJtwtl/d3eHC+B3RQmJ6LaNHZGZe7yc8OwbJ/knwon33Sm3WQ3JbDx?=
 =?us-ascii?Q?NKejMY2Wd4yKhm8/75RiEYFrSwdaaWh8iiaGkkXbo36E2knUhIGGG4HDk0Uh?=
 =?us-ascii?Q?pj23BdKH/M9TEKMZ9Pw5cZ+DQERX0wo2SCJhZ7jq/VQzKnMqEmJKqS3JbbUO?=
 =?us-ascii?Q?fGHyKq5rMZprldRsU4IZPWsH3Upds6PWFBToI88rtzHfl+99Gw6TQQNwGUCC?=
 =?us-ascii?Q?rAHTi2eEC1ULqbsIzsQJnbYWZPgETyGkuWrYZZCNeOLNYcvJ0RpIPtBGvHGj?=
 =?us-ascii?Q?13IAKNKkxuaIb0froMyCvvD90pGjNfYB6zxi1llHa5NJO8iIAZTvlJE/iDhG?=
 =?us-ascii?Q?5rkotl11/etotga7GLjROKdKntlwKOJzb0qnGLftDxh9ebf2j4ikVFhtzz+7?=
 =?us-ascii?Q?pJOPFrIz4ViWdqsMNIUqhyvJ9MlaH3XGDh0bxZakAzZr0Vd+tZJ2vU561AkQ?=
 =?us-ascii?Q?iC6Olb2vyMoxwmNrjS2oEza6cy5ilkOnPnPeooSENqIxDyFl3Z3Xr8olPn/Q?=
 =?us-ascii?Q?utuhJUNqyqtFobPtGXlEJ9qFIdLOD3w1gV3OHYv5TbU0ONQ0G8Her+l7ngps?=
 =?us-ascii?Q?vIxUxE0Fk1WxqwGGMAMIegdIetXU5MtzR5mepy+lMTuPQY9c7fAY8Q7RYL42?=
 =?us-ascii?Q?G93zYHidL5aMeiTwfq1ev7FnMJ18ZE0iRgTyUytjWLcIfyXbHXxU0uKPjtKe?=
 =?us-ascii?Q?AWZnDvKvysL8wGK43lU1c6h94jpzG6fSAUhhjtis8nACD3VXq8xFkwiZciFp?=
 =?us-ascii?Q?rlprInU7ofYpCBOrClQWZcytEBKQyzeLY2WET1tgI4b5XwZTR7hXuMqHzv5t?=
 =?us-ascii?Q?H7ZpP6yV6daNvyCo6JZWYpBHovMB6cYQq40RA1+ApdyomJOq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c360469-3523-4626-e227-08defe0986d7
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 15:50:00.4420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oDVJ4WpNQz1mt4eUZg9kWZQMLvkdTTPFI/l+0AQ7puio4cHfwc2TTCrBZFN63w/rr3wyrSnND/cww5BT5S98Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6036

On Tue, Aug 18, 2026 at 06:07:56PM +0300, Nikolay Aleksandrov wrote:
> Currently arp/neigh_reduce read neigh ha directly which can lead to
> partial reads while the neigh is being updated. Use neigh_ha_snapshot to
> take a stable snapshot of the address similar to route_shortcircuit which
> already does the right thing.
> 
> Fixes: e4f67addf158 ("add DOVE extensions for VXLAN")
> Fixes: f564f45c4518 ("vxlan: add ipv6 proxy support")
> Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
