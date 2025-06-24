Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC9F284682
	for <bridge@lists.linux-foundation.org>; Tue, 24 Jun 2025 11:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750766150; cv=fail; b=DuUzW+5m2bICDOEU+z6Ur8DegXTV/d7WMza9aQTUsN8O+2XF+xFBzTaoK3je/ecTxFvBDGsLL6p4Gsmd00ck0PNaj0EEAF7WfzQqLAm+LHZfSPRR3OQf0dmVGtJKmDobrCmuMCq7ROldmuCaX87QXiHN9bVU1lnD/vfGtJgQQgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750766150; c=relaxed/simple;
	bh=dimAJ+JgbZvDWWH3bYvtau5Oaq+qhz2YXiuCoar81co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LMqdvNPpgk9sIdl6/Wp0uPhdmWaCBbBnGrH2RZdYRIuBr/f4T5T8PQm4jDO0KeTOigkFTx68DSVwyNMF1farr/GsEFfQ5JJWKJw9fbrlP/5lUnAjomu2jTQGNytPwtksCrDIBWdTCezVdkQANo2zUEYeOdoOaytBBZXTulx7gbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=INbLtnqh; arc=fail smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="INbLtnqh"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BE068405C7
	for <bridge@lists.linux-foundation.org>; Tue, 24 Jun 2025 11:55:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.103
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Mtn0OJCSbMlY for <bridge@lists.linux-foundation.org>;
 Tue, 24 Jun 2025 11:55:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:111:f403:2417::621; helo=nam12-dm6-obe.outbound.protection.outlook.com; envelope-from=idosch@nvidia.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 22103405AD
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 22103405AD
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=INbLtnqh
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on20621.outbound.protection.outlook.com [IPv6:2a01:111:f403:2417::621])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 22103405AD
	for <bridge@lists.linux-foundation.org>; Tue, 24 Jun 2025 11:55:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sieq7CqrzmHyU81eKVkuyMSUKV/HmdYJNneZhx4E/uMnWKyDn3cSqW04eZWFa8ITb6z6Tno5mnrIR3jtgeaTLt+He5Tcp/utrS4HMNzesMEqenrg2XcjscnXdyr7T5R0XSd7W58yjSW+2fKqn05RYWMNQv5LLeBlbWRqHDCnKpeXmu/JJiR12m0SWKNuZ0W66II1AUnbY0GJL/mZuhdOIhVX3oUccJWfO08Xl7cWoE3jnpvvU4N3ereULTAOxgv6ztOLzFHKeYuWpUsh4ohw2hvu9ATtHJKBT+sZWVGp4/vhzQZIgYvhWJa8cO3GTFUPGjuutdHHOGnERLRzWKa1oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=shF2H1L92NqPAdGhjcn+L+yhRfC86av5YM2lSn9AedM=;
 b=Es8RfQzOTfxy/HqYSLuB3/h4T2BkG/tQzCA9BjgXczMjTFbIodlAnB/fIhrUP7Kq8Y4cutn9BZbiQTrFFbTU/73DiE9JVxE6NIxgsCM1LU0yqWCHFFCNxxbm6sgPYPAuvtfbszlvGTsIQC5cg+qWRSa8GIJhOGJVin7ksmJWNZHXGV7NDXiB5YZA+xLJy7FRzNj9N/IMK8xuQdgTy1IzHyAUJhzoXXA/gurdMT3w7vnYiuq6YmrjRrxqoWWLnavsj3w1lfEZDWKfZ9avD3pCU+9oSQmwl5+mhgR2w5gb2WNTisxUEJWvh/SKR7wyRH7TzCh7Rz4bpij4RK0lXqP/xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=shF2H1L92NqPAdGhjcn+L+yhRfC86av5YM2lSn9AedM=;
 b=INbLtnqhs+STvFSQ2BZjMbejeXnIqOByNktVS73RccoZvnZW3cM6cJKq4d/qoCJk+j6W+ouHIwK90NomN4snIgKXXC5EcfKSsKjdBFH4Yuy1C8GykpcrEbbOY3le7YvoLt3QOo/mrUMqh0U2B9ehpAoQh6OEXeC8rUNh1X9qqU6TMVtr2BwUQbvN9xSgdH1yP1X/DllhiwSAUY71+K81niZUWRpYAvx2kIhnSBOOSxnDTqulVkujjQjsITkfkYnBTmAMQ+/UPRMimKMoJUEP6V5UWJ6xd/PC8Beappw99ZkQdZJ5bG7UzReODrz3aUDqkdJ0aNowJJnrI0ODpF1N0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by IA0PR12MB9012.namprd12.prod.outlook.com (2603:10b6:208:485::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Tue, 24 Jun
 2025 11:55:45 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%6]) with mapi id 15.20.8857.026; Tue, 24 Jun 2025
 11:55:45 +0000
Date: Tue, 24 Jun 2025 14:55:34 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Fabian Pfitzner <f.pfitzner@pengutronix.de>
Cc: netdev@vger.kernel.org, dsahern@gmail.com,
	bridge@lists.linux-foundation.org, entwicklung@pengutronix.de,
	razor@blackwall.org
Subject: Re: [PATCH iproute2-next v5 1/3] bridge: move mcast querier dumping
 code into a shared function
Message-ID: <aFqSNpyVFt85XJbm@shredder>
References: <20250623093316.1215970-1-f.pfitzner@pengutronix.de>
 <20250623093316.1215970-2-f.pfitzner@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623093316.1215970-2-f.pfitzner@pengutronix.de>
X-ClientProxiedBy: TLZP290CA0008.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::20) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|IA0PR12MB9012:EE_
X-MS-Office365-Filtering-Correlation-Id: 097ce176-1445-42a7-3e7e-08ddb3160d5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y5fyNbQYv5iLlMjCKQazvzeUMbBwl9l/H4ptyHddgMZOW+88rGCukiZEaedP?=
 =?us-ascii?Q?9nU5XPNZ5k+zRVu1WhwN+XfxuDIg+dzu8LKrw61KAp8RVEsfMjh4vVg99nHB?=
 =?us-ascii?Q?AIfDqM/ZJMg7p2ukAXrMoPepkgtW5U5S4gi3KNYXV+goBzQDL8fx1T+kwRa9?=
 =?us-ascii?Q?YrI2B3kaTISOnXblEyPgIfZwvTr0jv5AazPck5JCP0Er59q2dmOQDP5QE3O2?=
 =?us-ascii?Q?X28soiCpqacsw9ORxhxAoejAT/kc+JdINxcVVkVqmP+/bfcq9Umy32L0aScy?=
 =?us-ascii?Q?qfDjPZ8PtFG8DTuof2zKUlQS3e8lYpigvXwX+UD0Zmc0eN1kPGpBoqUt88Ff?=
 =?us-ascii?Q?r6njbQyzOX4CQTwcRWoMwVoB1T2YmI2vbJDzZ3JuCKp5T1POGjduJMnow1OU?=
 =?us-ascii?Q?6Lc/Ik0BzUjLsvBm0zP8VmqCeJ+evz4mAWzkeFMo9g4EFPj3nsShKa9FdXqZ?=
 =?us-ascii?Q?lWa/sTGioc4OmQ7ZuCt2MC18EYXhmbf58IqTOr8liUqbGHCfOMgaa8JFfdY6?=
 =?us-ascii?Q?AW1MhqZub7doQxanyh3cfuvXte44FGMvyzoPu44wifxQ6fqh0MdvXEtDolVi?=
 =?us-ascii?Q?NYPeSBp7fjAHNn5uuyxOxbNHrRqvnlFHysFK32ek+xX23xaljirK31h6W185?=
 =?us-ascii?Q?oz56qO3+ZoShfjkxR/OWqZoAAmtEdcXy3WWSuVjtbhIUAPjQOzEPDMCHKNDY?=
 =?us-ascii?Q?MxlH9oXTh9HStx9soSdJuJavssJSCMS3hXcot23Wxq6Cu4vQM57byn4EqJia?=
 =?us-ascii?Q?JUf0wTW3AV9FhxkxqhM0qDTuYVXYhriw8lr7lJCLiEOwjL/6GX1IebbuTTku?=
 =?us-ascii?Q?JtLC4adUOX5m4TXvN9ZlxpUOVy61YnJGmS5wrAt+UolV6/fEz0BSKh221n22?=
 =?us-ascii?Q?rTJEDzPmyXtYKFrmifV9VI9lVg23mMJR5+CbcH5EDe47VcuctTIvEu4/P+Ol?=
 =?us-ascii?Q?SQUV/R63407ue2SDZkfXBBuUqBXmSHRyASqETUaUtMMArv9WG80yPqUVFqUl?=
 =?us-ascii?Q?b/ROLhJKZfEFuIa/BgpndqiMKwXKy1t3asCW4MKX5evTz3PheoMBs5HuXIA1?=
 =?us-ascii?Q?nwnratNIAd+ElUVIqx80/A3g2M5y86VYXe1U7pUzGptNozKjyDhB5XA616ok?=
 =?us-ascii?Q?mCpWeBMbM7zcoHoU+Xkx253UAZ4G92Yo0/t37LNyL0kVTLZKaFRkdM5v2s7t?=
 =?us-ascii?Q?Ku2bM5XgEew5nGfVARqRSZvX5rSv6IZV30ev0TFLHCrkf7xDXp0KoBE9QqMz?=
 =?us-ascii?Q?vg04rAJ3mpxdcIJLX7sL34Ev4W/Zk59rhjOeps/5A+T/6O2vJori0CXeKWy3?=
 =?us-ascii?Q?xo0LCSP7D8ivRpmvntKj9vLqclLT5XbJxInoX+W0YvBxvGNO69PbJqovPPqm?=
 =?us-ascii?Q?1TRfP4qm8dMLv1zBrJi0N1TElgDIgeG9t4FViI+XNnPMXfelt6CWq5Ty+HR5?=
 =?us-ascii?Q?hEvEAmjsgcU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kqUHNR/rW97pObQXCpBLCHjfzSRXiNolK95aWAzTIUZ6VvB1M1tP76/oZAE9?=
 =?us-ascii?Q?iv19wFT0NQYCRDXNL8yG+m0VuYU3r+Kzqit+smVJXoyd2g88s5pmPoh+2PzX?=
 =?us-ascii?Q?YygUNjFdtUkDSCiwqiVJu1Zt6K0YZ2FHL52dqkumcy+d0oML+lFVrNbwqcVX?=
 =?us-ascii?Q?UgmjUzqioCuUKVJhbizIlGd91dG0HFlv6LcktBorOPaI8PoZclrPJaZnNT4d?=
 =?us-ascii?Q?eFm7VkVn+u3D7Ty60E2+DgfEOtQz1NOZtHsKBZMH8Iylna1PWEWBgsLZ9hSg?=
 =?us-ascii?Q?n7/gbN5dyYVgVp28//fXS/eSL1iNhgDz/ra1Ar6zqUSUkQmCnvSnGarG05je?=
 =?us-ascii?Q?scnKIDClu1+gIHzvRFyKSF1RlitqtuwPOLbdJu0biFp1xBgvlpwUx5snDrtI?=
 =?us-ascii?Q?6MjJfV4DVmATq4z6K5sqi9EzyPACjijkwsfpVnC39Rv+ATpuLbCcmTCtF1UG?=
 =?us-ascii?Q?dgHBg8WKePnRy8SYWgno4a6+FSFPi141RwiUmXHfpvBC1I0Kbez5ddmZTtLy?=
 =?us-ascii?Q?twRE4LhX9cCYhS46rkVegPRjj+K+xlS+8LrEcB+0ESyKWPRKQjHQprKGiPWW?=
 =?us-ascii?Q?dpYZ+ISjZkFYzCdLoAOq3MHv6L5CjFJCWa2gotRWyfunGs1Ld0tP9FlF/kpr?=
 =?us-ascii?Q?fAcTfexG1cCLlqL5KOIlz1kl2fQoLYDKcOqZRzHA3XbB9Cd1rCQgsjxOL0Od?=
 =?us-ascii?Q?FoLNMN4PM3gZeaisdwY2BQCGTbNYB/l3w2T0uA9sO8BLx6k0Wyb3nQqlIhDd?=
 =?us-ascii?Q?Crm9DKHdRXzumFns43xsLulO0JEFvBMVR/HN9Uhth0YfpY86A6Im1m/w8uUK?=
 =?us-ascii?Q?yLuuT+InDuznbeVs6W3m54sbz9F/QLrGWhy8JVGnieygs/fJGMZigNzl2ka5?=
 =?us-ascii?Q?LEQMg+66p1XWQ8s5lWdYZoc+YDqzoIjHEuGUs0EXnz2g636vVqp/Dvsmg3v1?=
 =?us-ascii?Q?dr8lfnve9DTW4nG//n7C/nn1fA+NCca4KDidSdYjOWa9vQVWU2X7H8az3oNs?=
 =?us-ascii?Q?ZM8xgB4BdedWIq8b+LXP1m5cxpec+BizVVO0A3sAMj5P12X4lin7M+H4JzIZ?=
 =?us-ascii?Q?OXhBz/Mg1mXd12qLNZK0Cqhmtsk6PINxt3esbmB67+1sWbW1vGw9tewf/FgP?=
 =?us-ascii?Q?SuKcJU6bqx39z0KNpsSzOoRVELE742xc4J67Y+rVWQhxTab6jg3nrLLajRpC?=
 =?us-ascii?Q?kfA20AVGtVkhH/nS/1/+voTBFQ961T3DToZarpnox63BjWvuDRdy9YV3i9Ya?=
 =?us-ascii?Q?NKILqrOhhkFKkXjzvA+2VJ8qfaftnD27nQinSClQ/XwQX7/yArs8cdM2a+L3?=
 =?us-ascii?Q?hTN5WoJZsDbA9ejZ9Wl4I3Px0/6rPnwv3dJ8ckdALIi/DhqZQDS2eP/UhNyY?=
 =?us-ascii?Q?RZ6YTZg1f9hvEnRulKQVvXJevGYway9/w95FA9Ww2aAcMunwUuInPnrCVaSH?=
 =?us-ascii?Q?ABAF5Jje88Xdv3iPv553XEwQ6OVYcRKS5HEKS2m4KaNnpF7QXIvYx0tpbVYt?=
 =?us-ascii?Q?6oFS326KANK29lGA4wDBOE1wgl+0dgDVbt/a8YR3B+tpdf+mJiGAx1QdA/dc?=
 =?us-ascii?Q?lH1cDf0xbFecRLW5Ya0WorSMNtKSj4h1SV8paVoD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 097ce176-1445-42a7-3e7e-08ddb3160d5d
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 11:55:45.2550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ixfN33+R2E/jpajXUDBilmFtUqQ/oWCz5bqtrQIPVtdncYvnKhardMy2S1q/mrL5KTbJ80ShAyILIzEov+MDrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9012

On Mon, Jun 23, 2025 at 11:33:16AM +0200, Fabian Pfitzner wrote:
> Put mcast querier dumping code into a shared function. This function
> will be called from the bridge utility in a later patch.
> 
> Adapt the code such that the vtb parameter is used
> instead of tb[IFLA_BR_MCAST_QUERIER_STATE].
> 
> Signed-off-by: Fabian Pfitzner <f.pfitzner@pengutronix.de>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

[...]

> +void bridge_print_mcast_querier_state(const struct rtattr *vtb)
> +{
> +	struct rtattr *bqtb[BRIDGE_QUERIER_MAX + 1];
> +

I assume you added the blank line because of checkpatch, but I think
it's wrong in this case.

> +	SPRINT_BUF(other_time);
> +
> +	parse_rtattr_nested(bqtb, BRIDGE_QUERIER_MAX, vtb);
> +	memset(other_time, 0, sizeof(other_time));
