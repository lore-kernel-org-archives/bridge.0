Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011022.outbound.protection.outlook.com [52.101.57.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016E247F3B7
	for <bridge@lists.linux.dev>; Mon, 14 Sep 2026 15:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789398022; cv=fail; b=nii7nCeMVRm5vG8LU56GdDkIl6C1wFVGY5puOWbg468++DXICkyYlt4MlDDPCsoQfSi5Rg4k59xvLuU98LngnAtAzH3kKvWV9XV+V/zO08+BUq9woPMsFSyDI5j03sGhKXixF3UGOXSdJJ8nGkGlTlQuCLrH82JjTVlWViQGCGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789398022; c=relaxed/simple;
	bh=cAssMTdMKhN7FHBXGAIfYapuQecTvo3FQ155La+3Ya8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Tejc/n7921JI+puEdxk+hi//3eaYuqB25bvRF57Kv3Ieqxo0ozT3gxeCb4MJdK6yCxm3Bi8BW0oGmt2ofvF4y1+Az+ocI5G5SI/lRP/o/1/ssawDJPWaTV9Xf0nBspu0yTn2WTTgAbSnpjEbYxmwo3vcWJQhrw8zM69vnBb4cWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CdYZ+iBg; arc=fail smtp.client-ip=52.101.57.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CdYZ+iBg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CCHTE1Wf80KrE+/YVUQrJRx3VlXlnUh5ejF4r/IN8BbGglxoCoXHxXqIN1qVVMLfw9GKuyyu7R+7Ur69RfgW0bOfCJyd56UIH2Ch1eH0px5BLinpE0FsBdGrx33+JUdLEB6ZD8wywazZ8eol/RZFiYTeU3smom5TVbyIr/X31S4iS+Byv3bSn74yGyIolgc0ay4jv83aTo6//Ejhfsbc9Z5Mw9j8pJG+US4g+Gs6caggIeBUbTn2LZsMYAG8VlVXt2q1mVtDbj5IO/vBtrqJROwwzUhzkJMs/t/+Zw2xrBEbPXFfi68KaNvSi7RnPCBtEENWTGSq11Qopr1vxfPoWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DHc6vuqLQv87zl63V0IO2ErijATXRhvpRqlT9mWAkbo=;
 b=BeRuTr1yG7FFXy+pUVXPtpyg+saLvBwdjTr/ya4QwRkI91JCvlH7XarwPOzoNpBdxIvZ6aElBID9VHZ3hFl+S+IWive69U52vV/MsFI3ywGBFxWgIRVn9KFmeSTtpfJMadwRMAiSLzxRRRBqFXURe0wcJy1p0Kd7iOXIkEabgir9gK495Ex8oVxBr/F3u+J5ttZsQF3t/xkDiDuzaphWsucCR1Gon+v5I6OIIfiFraXXjs+9BzCKny8X8eGIOLmXp169SEWzWraFg4spcCnovmSYA+rvPazmgGrvK3e7lc2quc7Y+UEhM20VdbDQ05lqGDsxyNvGXO+Q21FAA00nUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DHc6vuqLQv87zl63V0IO2ErijATXRhvpRqlT9mWAkbo=;
 b=CdYZ+iBg4H+o7lGFB+SAZHavRkjMc22ZHgbclcyJpFZVUiyRyqUIwTs8xKnyiAZM8AqwfLelRnPihdAkEph7maO7SeY2t2ha2hSzbAJDsNbO9hk33g3fE6EOnCSObUIjJNn8Cqi7+/WHNFU0ToL9xmRCD9tSMP9h02toW9gTZh1sCZw45RRjepP1FeYU5NTYJADMNUAxKqIrifnYryYW70N+E1WKKemJNv+GY2Ue5O11/cqkHcB45M0Jov6zEmB+SSQXKegrfti5cU3v62wqK90iG24V/0tiGStyCEYEuGm6YbP+2e4DVnk64PNBfgEo8/GVJrUnC0e2JDdCD7mBHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by LV3PR12MB9355.namprd12.prod.outlook.com (2603:10b6:408:216::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 15:00:15 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 15:00:15 +0000
Date: Mon, 14 Sep 2026 18:00:05 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	vivien.didelot@gmail.com, petrm@mellanox.com, jiri@resnulli.us,
	bridge@lists.linux.dev
Subject: Re: [PATCH net v2] net: bridge: vlan: fix bugs caused by switchdev
 deletion errors
Message-ID: <20260914150005.GA391235@shredder>
References: <20260914105258.3436918-1-razor@blackwall.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914105258.3436918-1-razor@blackwall.org>
X-ClientProxiedBy: FR0P281CA0088.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::8) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|LV3PR12MB9355:EE_
X-MS-Office365-Filtering-Correlation-Id: 92ee48fa-b2e2-40e0-5863-08df1270e236
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	SW0xVfTJ/zlvjA5lDTzlb0TZ1JsT1CU++J1OlAhH6ZkQyq4DmnyZlhHio65sJFNlcqIbDSQ6AloFlBL0Rx8YB/Ojwnq23kTKlWV1F/JWbp9D9YZUQIk8qVTHhz4bdWAO6Fluvv/dzY5F2mLteg9Hl48ehxQKnfctYNgHCjumZK3RNmmEmPnxiR20g/OVvy4IQDndiTeqE+gTNngeA+t1mIMUZvm+ocGN9NMc9RMVSZR2mLV2b2/w+1A/Y6Cc46zRqiO1SFWxpMUhqSt1tBBmd2JLRHWZxi3h6wbm7Alp9QOWQSiDqq3FeIZAjYuZip7W6OTvVecgnLkkjHb7RaGFSnkcsefgZXy0I9TDSIJE1H+0ht+wHBQOSnbPEjxzvHhS1+zTQYGiNBNDZYpeVOsWQWHy+lvLTxHMPJkiVW0qx+aVveSfaANEsaIt7GGYdTtVZ2vz/lwquVU6/Ih7X/2SFSPpoMpCYX6o7UE9+cjsaWSsR1nKfpXtqHevrPWJThEQ5+Q9OqJJf/P0Vjx7vNeitqp2QCVaxw8F8DUSr05/C0UDKHsL4/5WHFF8CSJk74eVkPmxd5bGc36QNy5cjhjjzOn9cNLKWCcvjxm2V6AFlzyroeByZpHSAzaH91eUQrvBIz23gfe80M9iQNpxbSSVP8rhKRscbR1he5k10MhNIZQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ox4noyhJvOBFBq5aHTmRgMqPwxIHS6yYFqyF7SCraDCakyFTqgfzP7MPPrY6?=
 =?us-ascii?Q?ZKRjk6TLDjBntph+kPhqkAeyF5zs9A0la+Ntm02PzBMDm6Z1cyGeRBEU7mkF?=
 =?us-ascii?Q?n72KYdHB7Z7rs7LixO63lmNb+P+JTmn07qm4MBM34XvdD/AUT6aaEBATKnph?=
 =?us-ascii?Q?p/iRmDtfXNtBlTWp6CQ3i9JB9z+YrLlB2BWgM12xB0DPouwR1zFWyimIaOF8?=
 =?us-ascii?Q?6gmkQUm+UCkvWlR+v404AfveA/3yxz13uLyPF20Y7e/TqST/d0zsV8oyh+2B?=
 =?us-ascii?Q?VEUHm3MmSvDoVbwBE5wFUHrajcZHcvEM2laSYf8tjnp30Yu9vF+yCtVB9aaD?=
 =?us-ascii?Q?60X+YI/FzqE6fjX4YNKzy4A3V7GMp0G8I5eD/JUA7p82eZPOr8jDohblYi8/?=
 =?us-ascii?Q?vnUWC64/7u49k5Ja5ZftT/Zp2FAheMZow1+SoLJExS+ecb5kccFlYtc0C1/n?=
 =?us-ascii?Q?DEKycVlHc0vLNs2sJ3XUZqZOhSGv/bbg6zZZE/smPx3STJFoUV2PnleI9PR4?=
 =?us-ascii?Q?sqBfH7Ssb9O0lPVoyanRZVxV53Jitiw/4mEGwTDrzdlpo2JknfWjT91YsL5e?=
 =?us-ascii?Q?bfvdGbVPQhWEDqGoe6hin5Ix0vCdGcVFyYe9SzoPhawZsB3nv56yMb/+JDIP?=
 =?us-ascii?Q?XuO5giNWzgrN9r2//daAY3lzaqH7tPzJFtQhourSlb3mCWSZooqhFHS/fvPd?=
 =?us-ascii?Q?g/bCi2knGRLfMZSnEZsqWTMoHKCeEy3BrcEoVLP5Nosv5F2OFwVVBM+oQL8j?=
 =?us-ascii?Q?JvZ8MGOJNvuzK2MDIsBf7LvDPFF0toE2RkI1zrTGeNhM2u8FciuYVIWRL0r4?=
 =?us-ascii?Q?l4dPesMxwc2Df2JhsQ6UK5EcYbuEf5sbUHzh6s+is21X8ii6yVP25nMBSlXb?=
 =?us-ascii?Q?YhGVo4UNa/s+Cle6mX2NPqLBeHxZhSx+YgnOWpM5gJAutspXtWqIa7kUgbTN?=
 =?us-ascii?Q?0DbJpqDt3GeWDcBwv4NX8LoZ4Wm6ES6TU3UBMY265Eck056CKXHbYmyV7f8U?=
 =?us-ascii?Q?5xrwpnq5X/12RNFy2iTjEUfD24J7On2Hb9KYy7zTI8/gL01DwDxMacHiA2MG?=
 =?us-ascii?Q?i9+asjk71Tt0Wj4MsolXi+hMGzPBfVv+/ztiglLxCctE7BwNg+igNhHntnzs?=
 =?us-ascii?Q?3G82wnx3IWFm13noZWRDq4NiquExdylSLkgv480EjRfSN0Bsu8qirUOQ8oXN?=
 =?us-ascii?Q?XY3buZkgGm8LyTVZXhdNqpnDj5DGXmoiTjZpROYm4mybtYpqs5VMLp4jeACF?=
 =?us-ascii?Q?RaDPfDBkrFbAVO/IaN9tN+jywJG4Ie8HJ9kZ1TECfHWDsHtPiuj+MNdtiRRY?=
 =?us-ascii?Q?Z1+BROGal8syGn2Ea21dByw824MNqzz5buhTXmuIMXqIEajXK8hRWbZ4Asws?=
 =?us-ascii?Q?ygu+Z+YfSo7Dv6Ms1QiVfFPqSWRTOV8nNaS4TCCI//tcR0p4ZCvfDht1PfNZ?=
 =?us-ascii?Q?lxc72FBKqh4dUfkgLpzUF4EDyCORRH3tEVDkzfwvsOKvu3zjQNvfCcSazABZ?=
 =?us-ascii?Q?k13yFH1ckDbOp9apgOdd/WAVXx3xsPnzxPbGIrhQuwtUg1X+yvvR0rwR9Qu3?=
 =?us-ascii?Q?pMG8lwk+bOr4lNxuZhQYNNkplz1o8gnlZqunpoxsmuMSp6Qou72tff7XFTNX?=
 =?us-ascii?Q?aza7CW1CymRQrUqZYAdBygAk30WVnCEgOYRHQkLs1oun0XYnEF3CfpfB4U7L?=
 =?us-ascii?Q?+eac1jp/to1cFEAIx6Y3mzExXFSuTj1nFXSAxZjbCCXyo9MH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92ee48fa-b2e2-40e0-5863-08df1270e236
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 15:00:15.2639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8K2WMx6TLtBLw1IuIAQEyMMm6/nVrACsEiXxmpD9adZk6uc0m17GuV4YlotrjglysyRfr1jHnnIzganKLoaLqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9355

On Mon, Sep 14, 2026 at 01:52:58PM +0300, Nikolay Aleksandrov wrote:
> Allowing switchdev to prevent vlan deletion and error out in __vlan_del
> could cause multiple different issues - inconsistent state, memory leaks
> when flushing, NULL pointer dereference on bridge error when flushing.
> It doesn't make sense to allow it to stop __vlan_del, so log the error
> and continue with software vlan deletion. This is also consistent with
> 8021q behaviour.
> 
> Suggested-by: Ido Schimmel <idosch@nvidia.com>
> Fixes: bf361ad38165 ("net: bridge: check __vlan_vid_del for error")
> Fixes: 5454f5c28eca ("net: bridge: vlan: check for errors from __vlan_del in __vlan_flush")
> Fixes: 2594e9064a57 ("bridge: vlan: add per-vlan struct and move to rhashtables")
> Fixes: 9c86ce2c1ae3 ("net: bridge: Notify about bridge VLANs")
> Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
