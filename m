Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010046.outbound.protection.outlook.com [52.101.85.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419C32E737E
	for <bridge@lists.linux.dev>; Tue,  6 Oct 2026 10:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791283386; cv=fail; b=iGJRgTpkeb4QMqvV7s5INuaeq96DERfK8JodhvEoqBVrHF4CPVHHdmOGGKCgihXkY/XIpL8AMls2XfVVqamFSTxWIm5W6R1mGeteVBM54A/zHExH5qWsNUT+rLJ487Spb5wjKIRiuIWricsGVA4L0QkN1MjX13xgkFQaJzpb82o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791283386; c=relaxed/simple;
	bh=tnlaK/2JwbkZ/FSIKlqTQ/EeoO2r25jKP3cM/Q6FmWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jXr7qnFsRd0fYSE65KFU+KvrLao0vxf5flqbdhRJg1z1sHexo3dx3l0OPTkbRNJmnaZt2A43M6L1qtnu2qZRTz4WRgNm65aCNnPGBSZ9IB/R9ynRTLp5qjWN/ynuJAMEPvP9YfLeMDUAW2or6lC+bjW41BssAU6X9RraOUK1bXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Tb+ZLvjY; arc=fail smtp.client-ip=52.101.85.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Tb+ZLvjY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ccmF1gUT1tvzvyRUTuiEi4aHXnnfVvmqhjGRcI4JIpYi1yU3QJvNBPe4XT87neWLJqPIwo26oBY2K7dtHT/v4pHard4sLW12V1nUPpWnvrUKJgTd8E8GP0sHS5pptoIatqFxaJFSOVhfsv0EqCtvDGJBKPGcERXcCFYeS5oSeEjlRDk6tpYLbhraRdQxMND88UzXcGnW16cot/m5IXrwwYFPk8MJr7Tlu8cpLmroWX3ScbkWn1qEulNhOc3ouBCJn2WfWB40CNfb6r4j9uQFCROAHPl+Cb6KzSFkfPU9fc6MQeEuJw6f2S5xgcDXvjdbhVhMKHDy6yEyDm4KxU3t4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MubZlh1XT/dwS2sxWvZoh4dJIW8ry73/A0hcWPBCylA=;
 b=EZHOQKp1dXN/bmUr+VG7B+Qcvhlb1fulrOi/v/IfzPLlfVBLoIK+Z+AHnZZARtOVXo71PJS8ryl2qTvyrVLSM8MnDFcuXOQIS0D9ldlzdW+cOJS7qmnZnp4LdK8NDmOidh7SkLrJGEMohHQO1pA8ghFIVEAJ7JiswhR1dBk8+XaEksDkmGzZKr10n05+7aEJ7pWjkzcU3WyGvf9Yv+iflT3N9xtw1RIxKvs9aI6eIVmLkeEulRwUckAJi9S2vD5tF9QgJCuSHQjUbT7nCb75GM3/0ZHRrvMeR+NWMTyVq0rEnwSprnS13I9ltpolf5rQGmSoQx+XbmYQb+oE8rS4Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MubZlh1XT/dwS2sxWvZoh4dJIW8ry73/A0hcWPBCylA=;
 b=Tb+ZLvjYhsmbg+6E5K5I4WpSbVt0YltDFwBpLWKg4KNN4AqWZv93dvwuRmbPNq4vtBI6vvp8Y9Dn9nDLyM+Rd7s/UnDJ23YiPXHgK9P10sRwqKY8wDMBVzEhwASwyJNjtFpEDqRWxtBmZsV5rb2dh2HxZeJtx9UDqqvpY8V0//qmDEJXd6lytkXB6ngJR6B2tUgrjCHFA5UfI4p2c12qIUhlC+4jOzgH7RRKp8XwuNMrrspVqmaKokIkukTizoY9odV0xv+EVXvz+xdz9D5EMFft7/NZLHlEdFbHZri1vWwJTTqbJbCo2oINMOFIFLdzKv7D41ik4brhyBGvuzDgqA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by CY8PR12MB7265.namprd12.prod.outlook.com (2603:10b6:930:57::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Tue, 6 Oct
 2026 10:42:59 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0451.026; Tue, 6 Oct 2026
 10:42:58 +0000
Date: Tue, 6 Oct 2026 13:42:49 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Abdul Wasey <w453y.me@gmail.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, stephen@networkplumber.org,
	razor@blackwall.org, horatiu.vultur@microchip.com,
	bridge@lists.linux.dev
Subject: Re: [PATCH iproute2-next 0/2] bridge: add cfm command
Message-ID: <20261006104249.GA643161@shredder>
References: <20261004041307.2683990-1-w453y.me@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261004041307.2683990-1-w453y.me@gmail.com>
X-ClientProxiedBy: FR2P281CA0161.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::20) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|CY8PR12MB7265:EE_
X-MS-Office365-Filtering-Correlation-Id: 69d6b492-7c74-4b22-be3d-08df2396965f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|11063799006|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	+U7YxlAngGmmEBl/XkaKYELvQHCgenVX7ioMetOq4DYBjbw5rBSZRrQD85Wdjr9jc7kSm/geCCUOyGV1kaqGHzqwBzEnjv/jtljUSMDrhVE5RUqMIeLPX73bUAsPKc664CxWZGpc4eEuYat2eScu09/Zkj+F+Zs+thNeaXs846nF7vth8UxiVRKysXtjSoFNBcOzrbU9yiXn4HxOufXVLf+hU43q1fvbn9ysvtQCUwST8xQ3ZHWQ1q3WP8vmtA9UhlT9r312/Cvg/4ss7rX3EuI+By8/trU4vKRXEOxBiG6InMLl0SrRzeU72QAWcx8gxt3mXjtDw9jflvajK3W4KjAFtGSD3Sc6Gs9zRHlOYrspFEEjhxBUw88U5EZc/eFkqtSn9ZslFbC1pKvNZflVzgytwT20t7P3j3RqlRBoI5DzdD1MCTVcMlw9tPL+FFxFlbMVMstbcyzR4EU+V1aMKCjcJeMggIVEVhU00QSH+kYMsQT3n8QX0POTYT68zXDKvUDqV+Hf3gKBUSqLyXtd/bcT4gRZKwaLh1JFrrQV5NZ5LsZQSLysBEBeuNmC5dgPEQH1Y8VBzF1DzRp4dzgpTk+Rzicsu1Vr0TZYV0zt7IM8DyRk1A7SV432imwXjlBfgibfv7WijtyWOwsxwYDYs7umHMXSylQSvaTiW6595DI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?in1fNxI0sCtPHJuvFR+7I6ATfrhadtqsDuieT+oXdg1uB3jXYq1VsHt0TLFK?=
 =?us-ascii?Q?+00st9Gi9O8eOX72yrl73H6+N1bXPHJ9BdRr76cqP+oJvuzYYO4owVhPzp4b?=
 =?us-ascii?Q?+alyUTmOafmBwTs5QOHlYL3WCSV1LhH2EuSxTBoUQ0wBmDQcrIvkbl2HwrNl?=
 =?us-ascii?Q?3b3vtHRnHvPJXXg8sm5uNqlBz7+FKgsLdmZ388k4aQNagq23mkurnBz/Y4og?=
 =?us-ascii?Q?gbZNPSJvI449A6idzCJUQ6nL7lVq7ZvYBaJmZx1FlSbwyayUfDFhZk7oJGKp?=
 =?us-ascii?Q?iaZut5IzNTT0ZTzrTiVf20N6tDmi5woSC8lwjDQhhlfBdrmZAVkWkG4CmPe8?=
 =?us-ascii?Q?ZpdutFin3w0CMzbmb3s7nmaqxSpFwusQ4PfqYQlPma9MXpnr3N5d/8rCHo3D?=
 =?us-ascii?Q?QOKktjW7no3WyVvT5+luvlLODifN+DcaSP/zxZJ3fQcqLn/4hz7hLSIX+eDU?=
 =?us-ascii?Q?0KORVbv3MqOlyyN3EGG+ZV2CMlRmF8v4tOxAFqPpayE0+RNpmwNvy21u++Nu?=
 =?us-ascii?Q?nrrlgZYRAwGNnQ32QzYZ9ssTtvXiY/zyxcMLv6d+E83hUy8d3q/e3chgSIYj?=
 =?us-ascii?Q?w+JqlSKg8V0r9aulvoJX/uX57j7iKMzBr800qLnF4l+4waJfvAi95Vz9ZNeO?=
 =?us-ascii?Q?utjRpUQfbo0gKQzqbcyX9rfAC4QpD6jErOPM4A7nyr7Dw61MG6+RV3W4CZXz?=
 =?us-ascii?Q?JawnppZViTUm/ccCo9xjxJL/F8CxouTydhIXFTdKdt5/qEAFAvW5VUerpafA?=
 =?us-ascii?Q?9+IlRNY8vSjwRBHqu6s/aMeelkiA2FCVoax1ytg0Hm+gHzIVHuWEAA+eyz+c?=
 =?us-ascii?Q?K9brLl0GnX6nlp51IKxXthOd28aoj/wJiHzlBNFmQ6NTIYFzuSuhgvYvm0oF?=
 =?us-ascii?Q?8tLvlOhE3mMZESacSkB1fl8BvEV5O39ndxdbD57gcK/8s5USysmp4bSoczEo?=
 =?us-ascii?Q?R8CA66ArXT5Wrn59N9a0C4iUcsFNOxaHfAA37r8QmBgcXTSx5N5GZ/MDmQi+?=
 =?us-ascii?Q?YzOhgV3eEWsH/hVzLyqpcL9xcF4eyxEJATQ2+sqKi9bS3JzX1a+AZzy78Cti?=
 =?us-ascii?Q?V1LsBbpwlXiamBqS4b6sKDFvLhMJm/0bz0d0Dg14yw6i1fY9eS/Ep7iRmS8F?=
 =?us-ascii?Q?6aAU9mnL8S5oBuakgpDnYfISFewRh2rcQ4OpuQ7+ID5Em1Gcfmir2MaBCZPi?=
 =?us-ascii?Q?dt8DqGVWG/e+r3T7vKkdVKMOm62MPTNT7d8ygqP7LnnbZS9D6V4cu5jjoEH3?=
 =?us-ascii?Q?sXMHPJBKT8Dn9XwBnED9QahwujfstcmN2HhN4q7t0GAnkN4CeIUky7a2BSmN?=
 =?us-ascii?Q?JNyBmRO1KxGlXSq15Bha9p1tV0hjloHyGPN/TsI0B2jwMy0NpHX/5cJMY2L+?=
 =?us-ascii?Q?b/eKN2agWdlopXf8RgiEKQwwTdnLSe+8xwv8VO9/lnKr6JgMpCjRLjxwKjSJ?=
 =?us-ascii?Q?LExr/i2j87DCV6mDr89YW1nVjV/VAAxQesp9akBMmb+IrMZcxrdrzah8VaSK?=
 =?us-ascii?Q?Tshz/SkTtuGheWqCbShaxatc05ktbuF7ODeARIW6jFIseXyPoAfEyVCWZao6?=
 =?us-ascii?Q?fDY6Rb92stiJaKhOY3uGh5T5ArqyEsTpvpOUOAgzdpNcV6t1NwdtocKLmNbh?=
 =?us-ascii?Q?5iEfxewh82GEVGgzyoT27tSH26/+IbE411GfoH0j4A3TkS0DLEipBpyrJ9I7?=
 =?us-ascii?Q?x42Kd5ZnS4f0WaKoXlt0p+s7xRT63xdxYLm1YW+PNVJNCqCs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69d6b492-7c74-4b22-be3d-08df2396965f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 10:42:58.6791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZqnPyuD9w5UmE1YfbdwkPaYEiDOeMpSG3vnrWMWNGKOHImi11c6OWi3MdmdbtdZ5oFfwr1Jf3FNi5Z+Ww9VEUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7265

On Sun, Oct 04, 2026 at 04:13:05AM +0000, Abdul Wasey wrote:
> The bridge has had 802.1ag CFM support since 5.11, but iproute2 never
> got a command for it. The only userspace for it today is Microchip's out
> of tree cfm tool. This series adds "bridge cfm".

[...]

>  6 files changed, 1321 insertions(+), 3 deletions(-)

Please elaborate on the motivation: What is your interest in CFM? Are
you using it in production? Does anyone? Who needs this in iproute2?
What is missing from Microchip's cfm tool?

Looking at the kernel log, since CFM was merged six years ago, no new
features were added and the only bug fixes are for issues found by
static checkers and LLMs with no reviews from the original authors.
There are also no selftests.

If nobody cares about CFM or uses it, then I would prefer to start
deprecating it instead of accumulating more code that needs to be
maintained and that nobody is going to use.
