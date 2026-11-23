Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.5
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795421435;
	b=LDY4Q9TPMk6aJQ6uUSdPH8NkJBAPI27Dl8JjH07bQ3FqgHtm0sQNfP3OfsKh7IKXGdWo
	 RNahlTLX+D2lZo3msOapJYaZyrTN1FjAFj/B0c+2XciV+9cWLAP1P+9JytBJ9cYio2Vh7
	 WXdy3A+pomCGswJv325Og7R8t9Nlm06wK+Z8KM5jbLez4dmFiapHUolZKyQnGrcJVZV7V
	 Sn1io6prODBExRf/+popCGknKwmP/Wl9yUsEM9mKiDeMDl7ZcNDDhxv+6M1nswInKqp5D
	 pt9BufcOZig18jsqefdR5P+XCNqpBDulDRajyHcbs3fm5d9PphuSJS/SK0XyCo0QboA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795421435;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
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
	bh=yFCqd4c8p9Cms/L1QxIcwZsgx91DTEEaA9d4yZVBpyY=;
	b=1wHey456BolUAf5UYfBijOPYmdhq3FG1z7Ob+pRTrv9BXUOjX7BAye/PFZ80Bi6y8Feh
	 ysoCWwnm56mxI5K1vs2NwiNQ3pN1+3w0lLRtb+aGYoYTBIQV6w2MaYhMO7RG+zTgsHwYJ
	 dE6adbWpQioLnm/rTMXjCBoEZSL5jXRXW6wM8Pcy82uco20Aw4ttmP/VlC8WjkTf1airx
	 El/XJcAaLcn1HQkV8s/p+a9Y0kEJFMTURpQ1VJKQVU7NuujH3qyrMt44/FfKdcxNVs95L
	 Czm/BWHQ+WMjs2BYfRrkhQQf/SzrQCHw5i6GEbO6C4/OfMZl93Brx5sTKj+faHP8qBg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=khLgo4PX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.5
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013005.outbound.protection.outlook.com [40.93.201.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310D8606A6BB
	for <bridge@lists.linux.dev>; Mon, 23 Nov 2026 08:10:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 310D8606A6BB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=khLgo4PX
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nj4ixymjJgCoD+lNcWpDXYEd001ZiLS2yH4MiSxTricbqEyV/RaIxyQQlyLZli1CnkdfovDOur3Ys3Lv+/ce4gmsd7B6jp10qZZjFDnQP8X7Fsi70Q85jeqafM2PGaMPsayXsPyhkYF6K4AjrdT0ODCYMAbnIdnxG51kCvG3fAk+lH5EPvkJfzfxrbKcbgY1kVrCw9fIwqwImPVG8+r5ufLtuIFiyrfYJS4gnxKxMeISSeAFUyE6mCfbVaiFed3Q74H1FFvB0EM8dUCi111kXnyvy2zI4Oc4MUr92JtOzfWqgUltNnrqFYQ/RNGBu6rpfOv7BPKCNWC2MJP1QoniFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yFCqd4c8p9Cms/L1QxIcwZsgx91DTEEaA9d4yZVBpyY=;
 b=egNXAv7kxCONVx5yHntw9NH8DlmzM7/Xqp6vzOBhpYM2kNSU8lgRzjmj57cDWlD9nExazwH1oRj9BmAhm8kgqyYoH6hcyjGeYQOPLghgd/MRVW8LsxiahwUOMis0Sk9L7uv9rTlHtTo0Gpp4jCM59lmvR5fUpUVK8UTbbJub8to6VYeQwpB9N1o3b7NN00Qh/FXc8DVbFLerwKgw5fvH8tFre2clctb8f222ZHWSgS3fRgxc7qTs+AR/2BnEpbAfvllAanS7O+P4Pg2zPEu998JGU1gtPuyfTd9+w9QxDpD4djufgI9vhA5hFY3/lavbIm5FJZjg9S5S+huv5wQ+mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yFCqd4c8p9Cms/L1QxIcwZsgx91DTEEaA9d4yZVBpyY=;
 b=khLgo4PXEloBBRhk2wRUurzufS6ke9cogIIBdc/Q06t+L94fzL3AFFTOtBGGXFTr9GlHUr0g9/EFO2FE0Ll1HaNRHmM8aCj6p+/gJgmXWv0WCr0Q/Ek+bYm5xfTq1d6beREPCrcdF2HpKvsF8gw/eYJZimKYrhzOnvzzgXgfA1KMDeEqmonyWRfnac4GLbby0EdU1Q9b4Miz2KUOHqv20fePTFDk8jQ6SAecsub6hcrhCP3Qfli3kBjZpnAlIec1lmErpMvn8sbKiZ5fF7txLYuSM/aPtED8VPMDQew/oHmlTTCJqLPrNwmTIkU0te2lJShcZH+PoXp4JphOYmfBmw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9407.namprd12.prod.outlook.com (2603:10b6:408:1f9::13)
 by CHBPR12MB497579.namprd12.prod.outlook.com (2603:10b6:610:33d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 08:10:30 +0000
Received: from LV8PR12MB9407.namprd12.prod.outlook.com
 ([fe80::208b:424e:47e9:8a96]) by LV8PR12MB9407.namprd12.prod.outlook.com
 ([fe80::208b:424e:47e9:8a96%4]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 08:10:30 +0000
Date: Mon, 23 Nov 2026 10:10:22 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@kernel.org, willemb@google.com,
	horms@kernel.org, razor@blackwall.org, dsahern@kernel.org,
	shuah@kernel.org, bridge@lists.linux.dev,
	linux-kselftest@vger.kernel.org, kyuwoncho18@gmail.com
Subject: Re: [PATCH net 2/2] selftests: bridge_mdb: Test failed source list
 replace
Message-ID: <20261123081022.GB3126678@shredder>
References: <20261122072504.2623702-2-idosch@nvidia.com>
 <179541888360.3135.4706984344785286288@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179541888360.3135.4706984344785286288@kernel.org>
X-ClientProxiedBy: TLZP290CA0009.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::18) To LV8PR12MB9407.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: LV8PR12MB9407:EE_|CHBPR12MB497579:EE_
X-MS-Office365-Filtering-Correlation-Id: 70a4b1e0-1a0e-4952-1099-08df49393da0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|23010399003|18002099003|22082099003|261026140227099003|261026121527099003|261022105027099003|261028144727099003|56012099006|10067099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	hvVa3H+kK3oGQ/qDLC7J3zEKD/HieDSZ2r4n0Y0A9B1x17BAWnW5Fqm5m290h4ml9SYCj3LRhTXHi1ey+KH61pfL0kUOcif3EqgpCClJTXvMid0DbKT4ydowWI1D560PmNc+1Wf/Cx7nq2SvMkPClxNnyNRA+GnriAVgcdFdlRmVEPwPw8uyUlq5rJL1d1UjNem7RMHpPS/g2PhPGt/b9vn2GffT0A/Cqxg5jrktqmOVND/xexOkE/ZXUl4mphVuLPCYTUfDYrSyl+6ds0/8Ky/FAYi6CD1xkSLhtvCK9wFBjBnjdjh8ypYOVL2K9WTTdjf+exZ9nPT9AIGsYZ08q3BtaNAKx7Nq4VqDEssLkuhLkysoaxQXzwNqAdtX6NS2NkVgoJ9DxcQDlAt25tqW9toSrc/txMQjrr9oM2KC1u/hT8/ewy+S5hvV5DHBw56zLhdTKq/CIYdQJgZ/iC5w5wzB3SBirOwC/doH30TUNImC0omls6fpcH6TDPFno/G/JVfK0LjKhMqNUkxudagpx1soAx8AauyaY68+vycx/YKSjLOv0yh5fQm19KCu/be0XwZ777sDnddsig2CXCHcwMCy4VXsuu+CKUEwWOx/YT7SSgKCY4VY8V0YyhRW6rfdFAIo2t4lucijgB162hItuQVJdKwvSsHLkeU+wEo2N4I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9407.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(23010399003)(18002099003)(22082099003)(261026140227099003)(261026121527099003)(261022105027099003)(261028144727099003)(56012099006)(10067099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QOrY1kyXDXIIGhbmmdoNtbXLUoGPH+sRNmqVB7aVch+x5ykJII0gq3NItpFq?=
 =?us-ascii?Q?+zUmM6moa2HG3Z6d7L636he+giqpUEahcSrOYm+jc9VEdh7gAf/1zA8LU5MJ?=
 =?us-ascii?Q?5XDx0hyTT+HFih/eri6ek6p14VL2j4G23kzDX/B0+mSodYxWxpUnjhLq2JX4?=
 =?us-ascii?Q?GNEINUanLGSptMc9JyQ8T10DXueJGLR/3b4YtZzv0hWwimiLcXT/Q2alTEz6?=
 =?us-ascii?Q?sFXQxTf3waynl0UsX31uBPLmxh5ezctxIxWtBYVS3+jybwRSffjcTopFHy51?=
 =?us-ascii?Q?nEWqUMro4HsECVhTaf3e7muXvmJLyA3Xq+He+42Rr4nATy1b3OnfTV2YlXCO?=
 =?us-ascii?Q?jkotAhllQjt4/uBEcg6NAbM2N+QEbYfpGHbtBA7fY2DOk8o+jLX0U5dVldt5?=
 =?us-ascii?Q?oW4G9q62xFUjr2yzSrIOEOQAJEVJdoiORK45IVg40Q+ZJad2sd8qShu8Q6CQ?=
 =?us-ascii?Q?vT5JGkl8MUgNF6Bj+ZroV35e/e/AWiEbojOid0ODTY96jCNfPNhyDy11HJr/?=
 =?us-ascii?Q?wfbbZoqUOKndyKtcgdMHC52m9YbCfuUXaDP1crFxsyt0rHluIw2yLYpMJRko?=
 =?us-ascii?Q?237NA0cPVfYPcIOg1fgnTWIZMRS4cpCbMls4eZ4inouM0t0WRSY6HoglspIL?=
 =?us-ascii?Q?xQ9JiuxYrDrKYzkSxk5SodS2X/kscamjT/AGGXYW/gcicXtCJlBrQDgs3vsz?=
 =?us-ascii?Q?t6fqxtrCWnGR69o4HHS/JlhSBSKDNyOq5kCzAFIPfy3ReMoQflD8PAy9rhR4?=
 =?us-ascii?Q?PpVrlag00tMVvGhjIWpcjUCuUgA24PXSHvQbrh3x2EcA/pHl2XnxX1pRRpv5?=
 =?us-ascii?Q?YGD5sBzwP/e7V2bqDyoXK3GR4ckI1wqf4QuV8hGuNj1LaTJQaTAADs8VN5tD?=
 =?us-ascii?Q?3medhHz6LerDr8/OAehHskTxXeqIQ4bK7P1W7WpvyOhJ38yZ9B9R6bl3w8N7?=
 =?us-ascii?Q?tDX+0vgaNZEmGfqzoz9wCfb8n9fv5zFwJOb9Q1sS1ghtbkquqy2we91McpQg?=
 =?us-ascii?Q?WEnGrL11JrKiZsT8r70WIE2g0SKtW0k3bPH45V6IbVssUvUDUgzA2YC9gnuG?=
 =?us-ascii?Q?66gc3eH1wnja3IRc3T7KLjIHMAnBJRJP1AqmQB+ks9JD28YP+trxL475JW+R?=
 =?us-ascii?Q?sYCrig+91gEUQO14QEkg1I1NLdnaq2STJRlMj6zNc/OYZqV4bdlec3ibnAcp?=
 =?us-ascii?Q?zTgBOVmLy+A177I/CH8UrQfUdKha6IqFLiwI2cXSJWQS/FDNdp2KXPr7ovZO?=
 =?us-ascii?Q?NAYlIAs2l/f/nbYFP3rOz2DBKDev3AiOE1gbDAGxDG3RnxZicmn8qERlUBnI?=
 =?us-ascii?Q?b1Uv9kTH79ZJMsnB+Bq2QX5r5P3oH8sVWkCb/AIHIEkPGmbHKz9C0wBKnH4T?=
 =?us-ascii?Q?xs6aNGJxEne4RL1P6IvXT8Yhh34TtZj+9TsbXJNmvklT1YLaB1jO+C/Z6W3t?=
 =?us-ascii?Q?FajOBoJYnJWTjE0SgSrwRGj8wTWW/GvGFcjY9eyS/XMZGDQMqiYbKoUVAmCh?=
 =?us-ascii?Q?fJnNh5rH/sV82VxkFaXpt5D384asVkrjVHLn2hM0VSD9NXg3xsrZGxkw1Kzf?=
 =?us-ascii?Q?HxIRufQ9R9ZENyjp5fkR2Kg6SHk1Yv9lf5x3V9SphuiGScq7kHQ4mtk9C7me?=
 =?us-ascii?Q?FBF3NcUaW3ZrehGvLKnGeLYib5k663xxPcscgd+Tl9jy/gimGBJJXjBeUUuc?=
 =?us-ascii?Q?Oxv+IzXcjqBfCPssUa19Qk5gPyKirt5Mcj33vuRPd0N12PGX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70a4b1e0-1a0e-4952-1099-08df49393da0
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9407.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 08:10:30.6729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: REqVHsZpkX7OXYIHJBL4CiZM2oZDz9ZCckCoBriOrqp8h/UQMQNzgR4SA99MQZP18Q228DtklI7EcYxOeGrQ5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHBPR12MB497579

tl;dr - I believe the patch is fine as-is.

On Mon, Nov 23, 2026 at 07:28:03AM +0000, netdev-bot+sashiko@kernel.org wrote:
> [Severity: Medium]
> The add and the failed replace both use temp, filter_mode exclude and the
> default proto. The test then only checks whether the (S, G) entries exist.
> Would a partly applied replace of an existing source be caught here?

Does the patch claim to fix that? Does the selftest claim to catch this?
No.
