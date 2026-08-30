Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010006.outbound.protection.outlook.com [40.93.198.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D352290DBB
	for <bridge@lists.linux.dev>; Sun, 30 Aug 2026 07:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788073398; cv=fail; b=XcBgPvdKGdbFwJkI01IByweOftyUibZLdPvC35o+nwwrPs2L9h8msoTYJ10Kos2dYfnLwYobETs0BWackFlUxp3s+0OpdbkQ3aI+7YYuaLaPPNwX6R2goi52nfpqcInF/epVYa7Yw2GmOQkGVRbluPAiGKEJTgRUGJY8sfUgTE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788073398; c=relaxed/simple;
	bh=PfZGQtf7C+vFBpgYSQDgpXDdSFBbens8vulx1+JHMmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AAAhyXWxoeJBoJcWzjS2sIJzCtZn8x1NKj1MIjYsZ6awBZIVXCMGkjd0NG2w+D0gtP2ySLIJaoMNzIQErYbAzGhOcA3oOBYaMudmCD2ZJDaB1C1HDM0TsNWTF3/Fym2G7QsuFlGxvBcq9vQybFab98TdwAzDOBqV5rtksmPoqu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e2/QZNDL; arc=fail smtp.client-ip=40.93.198.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e2/QZNDL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ynwd4QCYPWXs50JogvUN4IBs6PdD+2dBp9mKOkUhcTUUdgrIN4nGpq9925FugTmNGMfsd+4uP2rlkqSGNBfR2ytLLiSHnPrzbObF+dZWqSHIW/w9o+dNNnRfIpuQga4vUpSljpDfAHYTDe15tGKYrMceCrKEsn/RRQ7EusJBNQJJhRIJ5eme9xDdNuw1lWCGoYlrl91pkT8peirfaVPWASlDn57Nb4MPxQZe1726hMAyH6vKBJv2pkUf7+0xtoGaWSU1/80A356h/g4vCYyzWlFR/aLdJUGavX6rpq490F9U5zRFzW++6BqNBaxfpv+YuRLpvnnP5+L6BYWM5XviFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LI1sgWxaQPz9nBsgoGnnLC3heOuqvc2lOip8HRBmMRs=;
 b=WIcdO53hlKDrdjkqXgMSnVRbaTrRTNmgjhK243aEvZSILJYDh6QH0jaACjzTpZcwK5s0sag6w/BttmgHUFAd0iDSUzeWakpNVy7tDsA6flD/wN7cFIv+TY3pM4/qVDnxhee7hQljIat/mNOWFHxxfPXfou+Dhr8gE3MIPVATQieldbl3lA+b9ToKrqtg6GVov6eNyjOzhDG0KGtDY0TtjyASJo4b3HS20Mtr9PRpnlkS7taNOJleVXh17+K4CPQOeq/uzQWIudUdnbKyS1gFHzyvC4pQ3S2RPlNItJWPVy17Uo9QNpwweXEcYJ6JRY15p0Oca0Gz4lxAH9/mulY+oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LI1sgWxaQPz9nBsgoGnnLC3heOuqvc2lOip8HRBmMRs=;
 b=e2/QZNDLIFxKx0etL42aCTzz4VuZfwtq1piWYY/qlj8/dIig0rZhogWARMbE72Q5lc1wJcLN+XGZO7oGSThKWavOnJPyZetpXvck0ndlxEzovFRD4KOe1UGr21C+IsEBFmwIpXHB6sBLPSY/I9h7X/9DMvvKuKNcewhbyKlvxTamKq1KOs8ffJSwHshqOyDZB/mqWnh8bPQxFi5iOUvPQsf6Wd6kvdpcTM+EAE1pY8k0PopyHMhjnqHDyos4QDi45tD38d3oUz0id+1rHdFCFwCMg3XfHqaBT8EYBrtcj0BdiWjUgjpmrtpmLEZTC364u1ELCJeFZe/+CP1xP0nFXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by LV1PR12MB999328.namprd12.prod.outlook.com (2603:10b6:408:3f8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Sun, 30 Aug
 2026 07:03:13 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0360.008; Sun, 30 Aug 2026
 07:03:13 +0000
Date: Sun, 30 Aug 2026 10:03:04 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	linus.luessing@c0d3.blue, bridge@lists.linux.dev
Subject: Re: [PATCH net] net: bridge: mcast: fix br_multicast_list_adjacent
 rcu walk of mglist
Message-ID: <20260830070304.GA2757218@shredder>
References: <20260828100642.2664347-1-razor@blackwall.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828100642.2664347-1-razor@blackwall.org>
X-ClientProxiedBy: FR4P281CA0250.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::8) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|LV1PR12MB999328:EE_
X-MS-Office365-Filtering-Correlation-Id: 1432090a-9c32-4696-5e4a-08df0664c239
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ZQqRvPodmG+RTHHEitBuBSUjTCW5oQVtgCB7BAIOYmuhzIVQeJyXtPGHfA0RKbXEfiHL0aJbm7InrB2aMt5t0cdOl9Imj+aeQlW5cAr73BkxKikbNTyfm0Mc3dFQ1MTRiRT04iLifk1W2pnDU33zi5V8e7OhcegZrm23QU/CneEB3iKmz/qPWWLRDeg/oksrRSzA55YrbAS3dwt8sEGhgOUIrbMg1kY3XpGvaOOvYHBjUAbUJ/CYSn3fWH+75MCadbcTfkAFoXVRtyzvfBXm820BnfcckatYzwAyZ3KfhWOVr+UXrwgnxdHid1tVlkG2hLJ46wyeK1J1tZ5sdhxDDIKJcDlPM7AfB0o0mPIXfMSMQt6TgYPBYfxgmGwvy+maAzXqx8TXZEVj2uyC8IOaXry5lPeST5eglNcIP+ps3IytHCrOXpLLufbof0Fb2dnvv2oN5528jY9oMUXIUzPp+j/KvrBxiaRGCjY2AdVO+86VMVWgsbmlFjRIz3gc6LN2LseBnErowiYPTATDlnC+LC4DvHzn0U0gh+D/SE2IrxCvCR3rMoDQfRND8hCtwMQy3Zj65oc3Z86P+U4ev0wwldl2yde/dpVQWKfIDZ6x8srYZ5dvmvNbSwf10qyARlvBAoyXqT95F7sjSSNvxbBQdeMsBz1RlZE/+hxMpQ4is+8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KZglCVwrLwtIOFNeKG10dDfH2sOpikuF7qzyIChsDx9FAzUxcJeVtvOoS9nu?=
 =?us-ascii?Q?vDRGiGHwAd6Ba/5ng33MFd+7vz+/LkoVkQ9p7j6zYx7OQ6Fdl0KNKaJ4Yow6?=
 =?us-ascii?Q?/ZCnlD6odmu+49U1blGqk/tdcMs+8SCmZ5tsTOcW4/7O7CU9cJkZf0Q5ssQE?=
 =?us-ascii?Q?JZExbU+XdQINKu1QVBPZ3Pszah7styjH+Wgh40hjklMD4QzoCZQAmMTQJOkx?=
 =?us-ascii?Q?9y6Qn4+BtzXjhtYDMBeWdvO2QN2ZSdcaDEwleekBZUMriGq0H6hnoXLn0eWT?=
 =?us-ascii?Q?YvRJoNE7zCTIFFuPytIUHXMWWCzyevR0YXcNqa32u1SLDd1bqQxqws97ABNk?=
 =?us-ascii?Q?7pZEeuguSGKrPocVBz+TybG0/YyuXC9DIytMiHE6kDPfQcb8TP5PqQvB/JhM?=
 =?us-ascii?Q?BRXxiE7K+zEaIGcYgwdMYnbTDoGvJXOdcH2ecB7LeJVQGtdBIDob37T9lu/W?=
 =?us-ascii?Q?f9M5Ob1BBce3EXJ9oFzNxfkerl6FZ54wx2OojxrkNOwu+Ut6189sJBPErOwS?=
 =?us-ascii?Q?00SrK6CBNB3JP9DLKtpNmi65xJuZRf5gkWWe+ObMknvYWI2y1tkLmAgnG13Z?=
 =?us-ascii?Q?NGMvpzCk5afY7yvYpjCwUfbM3lwGdaRLDBp8FTbY5xsmzEyq3YfHcC8VvLv8?=
 =?us-ascii?Q?P9kGJO+Sn10AXk0zf1tyuwoawKlKgbW9DIzyXeWvRFsSIuyO2f9tfpG9hN8O?=
 =?us-ascii?Q?c8ndTiqwIwwmbk7r8YZejxmPvy9ADt6tE/s913jkubM1jXNMCNN5bmNq1Ynp?=
 =?us-ascii?Q?JUjbwVtNBo8+1LYGlX4iyJrnK8A9OViIjyxRUXyCMxhPsEpqK86jmCCUEhsn?=
 =?us-ascii?Q?9oRenToIuLGwiuS/3JlnYSn+pWTf+bfTcqfBPlAh7C9TD7hBKiDj5Klwf7fI?=
 =?us-ascii?Q?DrkDlmQd8Pp71EIFbnTh3PoMuFwl+z/BBzTKmkRNUlzA0y+3fBuco26K/Vcx?=
 =?us-ascii?Q?xXXQw8KV4BxAeyJYZiS8xKDflgkPdY28k8uFDoV62SPi6ryuzkHtVEbChqzO?=
 =?us-ascii?Q?3xhBfF40ivfieBT76ZJlh2fBvGqIfUmn+5HyiVh5+kJzcwYUPuUHUPj64z9l?=
 =?us-ascii?Q?Zub1pt2/ELXSEKU22PkH43JdEcxfGizDF3MW0e0gKLN9qk4Q2/oA7C3aaHs5?=
 =?us-ascii?Q?wN+szW74cAmxzhUzQAfM6pwxveMNLymDiLqcVY+G3lkBr7CUucUeYDSswI1s?=
 =?us-ascii?Q?zxuOSHbXOuPpT/D+inh6tNzETtIybqH4DNTa8/ENT2eSIhyVIKEeWNhu8uQI?=
 =?us-ascii?Q?uyMuxDL91SvjfoRpTZkSk7Z4c/lSBq7DOChHQ3XH8MKLC+Nbmnuz5zCjvDBj?=
 =?us-ascii?Q?BkLmH4FyZ/cgaaiAd216GE7qvnwO5eE14F0T+pNhrUvwmuCwc2j95LCCFAWD?=
 =?us-ascii?Q?d43sRK7cZhYE//QrfVSsdAacusLoKI8t7WxRxbYWPbFE/scTLymNk6tBQ/L+?=
 =?us-ascii?Q?KGUIDPt8UwDNZbJBWsujqYOhXE7BSXrIHwH7onqQZPmUOuVsgUV1HJxWTEoA?=
 =?us-ascii?Q?Sj1Sv4g4UXtrtLc2aoMPsBrGSoXjkfG0felIID2VNKw8BOz8j1+ExBALWhyN?=
 =?us-ascii?Q?Q4DmmCO67+KiG6Q5I8URqQMyp6VSEXQ8HbHrAn5Ii7UnVao/y8z4bfpy/w9i?=
 =?us-ascii?Q?6Edj6AvJQ7MiK4LUdnIGZlrnMeWFMF5V4Lp/lILBczvaRV0bFSnqrUWyBfLt?=
 =?us-ascii?Q?kyWbrFCkDlvqLCuAHvUGmpaYqoQdviUVtDo8wJALR/byP09Y?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1432090a-9c32-4696-5e4a-08df0664c239
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2026 07:03:13.7025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3vE7PkIEAKrXkSd87sQgTsF1MfZMF1YA0DUH8uVIDYS3j22WsQa/VlU7rokiYY2P7gKRkxvMqLWyI2XdzN73gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR12MB999328

On Fri, Aug 28, 2026 at 01:06:42PM +0300, Nikolay Aleksandrov wrote:
> Sashiko reported a bug [1] that br_multicast_del_port_group unlists the
> port group not using proper rcu helper that preserves the next pointer and
> after that immediately frees the port group without waiting for rcu grace
> period. The only rcu walker of mglist is br_multicast_list_adjacent() and
> it turns out that function has always been buggy because mglist was never
> converted to RCU. Fix it by acquiring the bridge's multicast lock for the
> mglist walk. We can do a proper mglist rcu conversion later.
> 
> [1] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260826014200.362304-1-littleddfu%40gmail.com
> 
> Fixes: 07f8ac4a1e26 ("bridge: add export of multicast database adjacent to net_dev")
> Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
