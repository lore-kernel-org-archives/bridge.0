Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013050.outbound.protection.outlook.com [40.93.196.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20B33B813F
	for <bridge@lists.linux.dev>; Wed, 19 Aug 2026 15:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787154574; cv=fail; b=CEnyPyM0Ve41vEQ7r5jJFCgW06G9/B8JTUIbu+bYz4ZW92xaQUKFH3gSvqtBGnvWs2zPFBzOecub9qlHwTRLSop0LO3Ps1OgZwcech/uh54wceScsAeXLtY08waAJBUA0wghBNojJgO886h/XDDqV18cFGIT0DH7V/u4cSyK7cw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787154574; c=relaxed/simple;
	bh=Hggy+/6ZPOxnJj1J3v0gOAe56EhndcDycCL3bm2cobw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DaUxFjrSAdZ/0MBsiX6utIopsxG6QRHHhvyt7HTtYhNP5P54qAC0U5FLMZUf8kzLfq98rHogJ7xELH5zteCvLPQzVLRSBAO+c8ZDZLlOxDi/XG4JYf6BHwqz16muImBfGNTFLA0F+EIX3SFCnwDxaywRZXPgbqnWZoC/xQkMQrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RxyPxPoZ; arc=fail smtp.client-ip=40.93.196.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RxyPxPoZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=evCgOLz4MPz2sJaX8xF0N+kSLZQj9+0LK8Bmw51qZEg0l1+GUF4zPGVTe4YNf19rMKZ+Wn2bmo62nnwYvtCtueNhkaa8YmrQZ6buuofHNf3AwifTpnKRFPA3sva7XDjDZGJ5RKZGsSXCcSyytZhP5XrQPgmlLxGk+RoOO/+6hocIyFSnb+iS9Z+Ix/kgStpExVxoIUVM71Xq5YEga2GmLacxnrLAdclOVfWuBD8O99eQOGlOwpkbxl0i4EA6g5Y2MEdP6k4uZNnYZ2VowzYRKUViQl8IpWbUa59a1AZiMuDUasWn5RtTgy4fMYoxYCxJCbnjmzW07oAihAIPWwtsjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C6rBP59WJAceWlsOjbbHNYY/RyUDsLcpogphM2vfsX8=;
 b=YwkZfj9/FRv3CTwFeWEfEoc+6Spuk7wFSANtEjnYw5Q7lehLEAbiChE26NhfnVwVdS7Q7JM1jli2VKnQaPIEHq1BeqXNi+Soe1bwVxc4GfeHMCKlELCiF0vLzvW1q7Ob05D2tg8OD2E835QZIf0VEDYjvEsilxaRqry0+erOlk0PARwmedVq0M96VSK3JtFtEuWziWcp/R5LZpiZLu/7CnlTOw+Cm0tug7R/zhh1F4Y5lvD1Sd8Ik/ZKm6BlByu3edQPFz4+z/Ry654cWQrv4/3vp0CjGMRHXLMGHP3v4Q1PI9LVFwUIy4wW6dzEC63igU8kVUhmpvXFLDyqA67kLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C6rBP59WJAceWlsOjbbHNYY/RyUDsLcpogphM2vfsX8=;
 b=RxyPxPoZMW18vg+O21WQIflHr35/4Gmf50D7tTWfPD9hKd9xEdNy6JcIEl8NqeieQ3fgSF0uwJ1Smf9+JXwlHwR5sIkxC/fhHNR1/xXLx6wUsAlU+TjYXG8dXf7F10T8sn1zXfrMz8fHaMAzWTTWJJWSMGV8vdvV4qT5J8uSNs2hencT98W/TnKeqx2S586sko2jJR30IwZH4mSzu5ZlpEfJs3ej1GDh4wgaoWlBoHtb2NpTec1CEK7WqegrGQx61ns2fPCDNsOjGER3WGelVTTd8ORFDb31Pr3lhQCJ5KSAHn5iYpLeV+vmh3C7TO/DY8ZOeyIeDghgBzRnjeUR8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CY5PR12MB6036.namprd12.prod.outlook.com (2603:10b6:930:2c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 15:49:24 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 15:49:23 +0000
Date: Wed, 19 Aug 2026 18:49:14 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	roopa@nvidia.com, bridge@lists.linux.dev, andrew+netdev@lunn.ch,
	dlstevens@us.ibm.com, amwang@redhat.com
Subject: Re: [PATCH net v2 1/2] net: bridge: arp/nd proxy: fix reading neigh
 ha
Message-ID: <20260819154914.GA1280224@shredder>
References: <20260818150756.890025-1-razor@blackwall.org>
 <20260818150756.890025-2-razor@blackwall.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818150756.890025-2-razor@blackwall.org>
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
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CY5PR12MB6036:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d2f1d46-207f-4b4c-c2b9-08defe0970f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|56012099006|10067099003|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	R2D3BDYziqlVBVGlWKvw42y2OeK+5yz9i+GOXuUWNsgFAsTNxMkU8s4mmG8MnXQzs4UnF3th2T3H71jXMchqybaVuEMn9v0/h0TLHcqXGcx3rRPC49Uwv4sFSEZoc1F8K0tH6g0ZpBO4WZvfF6yF/nfbgKasB0GfU9+9i+GZtJxJHvZ6TIwLb4D/rJ1JOBlIVFjuz1f4ZOGupsTBAAb4AIEkX2LN00YwopywzhP11Vul+lwMm5iEICxWJHGjo7xfogzVF9zQgR3d37ZQ16N2Y22SVM74I1BH1gal16SNOphyb9XV9XfkfNJVE4twCgz45AFWpwMDa2qLfa9Pjeondn+TM+KfKM7XDV2Cbecr+rly5tpgnPdB/JkUW7rGA+uOgEoGNf+zXbMnkR7NQl9P44l846PWRa8kxCL5zf+ip+MbIBYI2vDTdoO/MnkBcLGalbBfx4tKYgSFEqoOKlAs6bkL8w39LQxo5N8WvcrRV75roziXeMCqz5IRYl/JD9y227OkwdXVEMShmY2hh+4a0n0Qdy2K37rKsr5OzVEIPoZm2x+ML3RlzcBxN303pBpIwZWqNTlyG6eKdLg6oCOq0YLewvhh8yJCl2VvV6L4lvZ4MdaJebAMHYMzA9GBQAmfUQEaWbyyfEWcORpaGoXdWJvl+Hv/6HVOEp+kPsgdzSo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(56012099006)(10067099003)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2Nwi5v4CJo1Rt7IWwfNeYnHt69DU7HplYyUZPzgzP7v5gkz0aMmRbQ6iun7p?=
 =?us-ascii?Q?c/I44IYpNmb0Q2x7I1a8+dZZW+FNWWxGzXdVUccMAS93UEkU6WJ0NwMQiE0C?=
 =?us-ascii?Q?8hlOFgn4ugB97zl9LhKkikYkdmjSlB0wTjqQAnGW5GqI8gcPCltUNuTGknk4?=
 =?us-ascii?Q?2K7kZlZXmqVkaEMeINPSUJSph4seuFp9tQCMTGDGqHBlbuojowNik2MtHnix?=
 =?us-ascii?Q?kW9iawPFyqtcT2D7JTkOulmQZA9E3/uzW5F98hYtQLMOt8TpkKTGSu/edF31?=
 =?us-ascii?Q?mrWxdm1l6kTovqqHg5cWABLBhrtez0KwyQ3QOZqSPqY8Dydr4L+7Wp5Kxn1+?=
 =?us-ascii?Q?wd27S0VaJlrtMH1sa4ipIKMW60rBh9NRoTwCKIqgFri92a73+A4Mgb6LbQY0?=
 =?us-ascii?Q?AHjN6aNUi0c0ue1l3/fnhXOMJ9pi3ECB8/tG1YsnvLDJivO1/Y95+rxl+dIt?=
 =?us-ascii?Q?dJC0bbanCx8V5xIudSKV2c17U7+BEqlER2CQHXI87BptQOEmrqoCGMKDGGzk?=
 =?us-ascii?Q?NwLYMCrCKU9mP9yOiKKFff9JMIk9e9bE1V+znXPoc2nZlOJqMRLQFQRgeoTZ?=
 =?us-ascii?Q?2DH1lfI2Yl26OgpuGKr471Icr9TGYkISl07Yx4OhtqoWcEqQzzr/qHNwGf2e?=
 =?us-ascii?Q?FxhG+sTEssU5QX1oy390jNI2/gedJeXPO0h1IQDMy2HtQAC8UobcPqdDQKvj?=
 =?us-ascii?Q?ldI6WhplzwHLsaSgaYYjli13ntsk8I4/dgkuvdWiCVbkGGPXs7dP5dLsDmxk?=
 =?us-ascii?Q?njrRKRv52M7qIvAjZrtpEak4xjtXlMkmMbCFMEKExc1uhh9wLRW3dvXvieS1?=
 =?us-ascii?Q?DGJ18deelLZw5fXvLNuCKXi5KNP1EeMNGr48dHTVk0WDm0dr/hDr+XwfjtWI?=
 =?us-ascii?Q?hjk3Ag0x4AjxQ+A/Ja66ylbW57IkUyDuTFUVfyCTyjCgracU5zWoMT2ue2Z6?=
 =?us-ascii?Q?E9zMq6z7K22wbtFQXm8jbsYb3rGStUSQgDMlx/SghVVp+CKdB7w8vJHCToFN?=
 =?us-ascii?Q?LROjLzGKz0ofDiuFFghLAV6SGFvFJcCzjY3LteChQHlepe59uLyLO0gq8DQj?=
 =?us-ascii?Q?qigcKx9eeMIAKShAYH4+3j53n/l88w9wg9dGv4GI7lKYYU9hUO+7f+QkZ+wE?=
 =?us-ascii?Q?hBU6ymkagSGQz9iS04gLlxkK5msTnb5uog5rLDLv6txk9aQSDllPsYYlBfDL?=
 =?us-ascii?Q?FObyMf6a34JszGkMwmDNriLhSOrqslaZPO/+wdHbRBJ04WrJuQ22Klcq4G5B?=
 =?us-ascii?Q?Lyhf26cEmVd1Is3MTcGbaQQ1SjlQWKJ2t+jUhSyKqgfUTqXG1ot30gMW7mM9?=
 =?us-ascii?Q?bHfk0y23Qy4iSQl/HhDV20HxGbUFZDaP1je8QGrv+V8DSIq/xN+9jsKwx6hS?=
 =?us-ascii?Q?ajkltyQpDwXg3DGRdXjSQCZUFTdPLc25ceTnki54H9pptfMfnVFDRQnGIzA2?=
 =?us-ascii?Q?X4vxq7Q0mPL3AA91fNRjp3/cLzDNStpktV/HEOxbmBD+BwdzoRsB3FjCFna4?=
 =?us-ascii?Q?Bq2oKe5U3LLvBf06ngs0BBBPHMR6NuGkhMdgacLp+laCZG7lisOj+Nrtg/oL?=
 =?us-ascii?Q?nkK4EnSGDCv3VDMjEbXK41G27v448Yn8GDV7B2uToB7TJnt5i67lpn3VF9hk?=
 =?us-ascii?Q?MfI7PxnGGFme0qG9Gq6xX8XOekkNcSC8eIDGovi8IYGPzC4qm+cppKtOF2TN?=
 =?us-ascii?Q?SLQvN/vrWOJM3nrR44ZwK2idTzt7kc330CAcUnyfmcmK/meo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d2f1d46-207f-4b4c-c2b9-08defe0970f8
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 15:49:23.8086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E6LYNMzj8AnvCutkb3VLH5zrgD7VkbzJTjmvUlDumU1aZOzLNOOnNjXB5G4e7ZsQzgy/2jSdng6Stirky4vVHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6036

On Tue, Aug 18, 2026 at 06:07:55PM +0300, Nikolay Aleksandrov wrote:
> Currently neigh ha address is read directly, but that can result in
> torn/partial reads if the neigh is being updated. Use neigh_ha_snapshot
> to take a stable snapshot of the address.
> 
> Fixes: 057658cb33fb ("bridge: suppress arp pkts on BR_NEIGH_SUPPRESS ports")
> Fixes: ed842faeb2bd ("bridge: suppress nd pkts on BR_NEIGH_SUPPRESS ports")
> Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
