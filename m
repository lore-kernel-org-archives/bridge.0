Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011024.outbound.protection.outlook.com [52.101.52.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB4D44065E
	for <bridge@lists.linux.dev>; Wed,  7 Oct 2026 14:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791383775; cv=fail; b=sbhvW6Bacc4gvxV80HSrX/6HBRLftIOMHaVcqoSsKUq7sE/hEkQZnej3JnnB5iSTI3O5oruu5x2avjvNuc9iUqVQ8E6jXHODyN1ICyxRwgYDk9qDtmcfWRbFsK2PPWd8w6BPW77lLEmNoiAlYd2FmvFwMPhahEAs7COWRkCOe7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791383775; c=relaxed/simple;
	bh=TqdrBH4+xgUUy2NfpT5NOHGnrpniR2+79w4ruGmlgak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mb09i1pdifDZZDSOu9ySmHhWygsDKQeC0oMduQNQGqhbWjt/fw9TRD3gQWQlHacBX1URFIlCRn7RVbhnRAWW/gTDCtMCbYjj5JlYLllFXda1H3BVBWlQzbF3Cstl0Qp6SMEvJruNuW58Mqv83I4FBmGnnpvYt/F9jsCIRl5UhW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BpePxC0t; arc=fail smtp.client-ip=52.101.52.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BpePxC0t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g1nILJU2LXkKkRQ2DmUBDW5okBRWCU6XsnlBgk76LQCzo6NqUA9/UIR9AiuwX+d0K76P982NtsyUfSVXLTOnb/k5m0yPov48ysYWNUrhWMGKKn31ZPCgd3+Y9VvTRfiheNqrlIaRKSemajJLL7gQCX0hE9UsRO5d+1wynSYEwnphxt3cxH0lXE189msYwZyIym3WFgZcVd92KkugITuKr6nvAHFVbrXMJtIA/YbL+ZOdIrK5alyxIhQfcLFC7XflVrYB944jE/w9nBuUhuccaKZnPXUBq7N7wkGxK32hT2xb58qE0vBwh+vdCCfPJ0IxWJ3lWjfeSKjDS83VIlcECA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y7izSAUx3sH7WUIKNcvXRcMatvVlJ1avgKS6Jy0ppRg=;
 b=oSR3Xf8GW7ik3iHFE+U0uX/+a5y9fRm9htX375CqVxHYbJoZIzCYrs5Ct8jUX9e5nlMcNMHv7IFdhhd3Sq5wgOzJTeRtxfDXtZnr25GyV+LZZuD08jk/TyT6k66ulkf2LAtTVyvbBYJqzRv9TaL0aOt5ULG0wmcqe/CRE/wpkKNRgdhjHKTZ/sfeM/fccCiFFImksMkKb24Lw2PQ2qRbjNG1dpxnWbcdIsRrJfiC67ULTWWGkgdqnttR47b7HbTwzhJvq2ArA9gMNM2oIaboAjFbVwGEnPWwD9bz6cakFsP7lRsjoX+hq5O5c87A07OFgBVzFpfP8p9jgzUOByBNDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y7izSAUx3sH7WUIKNcvXRcMatvVlJ1avgKS6Jy0ppRg=;
 b=BpePxC0tDX2MiQQo1Bi9uGZdwXaAWCiYERfEeOmkpc6SFrK7sPTlQd6uasNaEkpkFipG41nMwiVGKavyPT3t6T6illJ3OpAsosjK6BZV4uCjn0Rt29Alz0C+TitIeWdrDT4nY3TLnqG0TAy5mZiSnfFe6p65b9kecaf0AaQXfVG2JCYAafgH1+LCpxgOvF3Ff0wI3QbacE0hlIQmhZuMJJylnjzHIvByNB5CNRE6CEOdppzgdvClNtmtVF2CiPb26ygH6pr40f7ZmPZf+gVDm8ISizxOrLhtJqMChjAuPpC4kOrSOiZEf/GHdHTdZ1Y5ApMhCs/n1XiT4IU4b3e5CA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB7954.namprd12.prod.outlook.com (2603:10b6:806:344::7)
 by SJ0PR12MB7083.namprd12.prod.outlook.com (2603:10b6:a03:4ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 7 Oct
 2026 14:35:54 +0000
Received: from SN7PR12MB7954.namprd12.prod.outlook.com
 ([fe80::2567:531c:cdb8:f544]) by SN7PR12MB7954.namprd12.prod.outlook.com
 ([fe80::2567:531c:cdb8:f544%3]) with mapi id 15.21.0451.026; Wed, 7 Oct 2026
 14:35:54 +0000
Date: Wed, 7 Oct 2026 17:35:38 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Yiming Qian <yimingqian591@gmail.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, bridge@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: bridge: don't under-estimate the VLAN tunnel
 info size
Message-ID: <20261007143538.GA1103897@shredder>
References: <20261007055939.63100-1-yimingqian591@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261007055939.63100-1-yimingqian591@gmail.com>
X-ClientProxiedBy: FR2P281CA0115.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::17) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB7954:EE_|SJ0PR12MB7083:EE_
X-MS-Office365-Filtering-Correlation-Id: afca9e8e-e9d9-499b-35b2-08df24804aa0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|11063799006|56012099006|6133799003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Sz6Pk+RvMb9VZT5fiAMzGGg7KOcRfQOefiop500vvv5sP6yzyy/7/s18iUhyhuiFaW/sfZ2GHaEU3O2zb4Q9mVUdf169t3w4LnaG0JutaC2c9BebCoCvFQMdsAzKTnfAQQ4INkf9M9rJctcW1EDUm0BjpAYs/REy9cLv4jUyv84axCNd33tlDpE3LB9Zec8IXulZMIm+wezITPOfQvXTC/5OUuZ9rAYJZpg1nLWfCLA0223lyNtUq+Mb1P3v4FZUoGUt2WKLOBilUGZzJffRg8IdzyDQjxgK/RbFqsNQZCpiwXwCW25CH2brmXM4tkVU+EAX4TdCjlFQE82Idtj9U3ORAnXN9Lv0YLrnQ6EawYI+qfp4+52vqdN3KXcv/rH0HBSss+BUHHfMLpGsjoRVUcAsruE1pWqdaIxQx2rVRXR3X2f2Rf+io/u+68qWgCKipRQenUbp6lZm3bEMJqujdyVi5ODh4SMwRpFzVZRIJ87kdJrDBciobCfkNn+Q2Q9elFTezqZ1HCyuEz5/x28pWhbc1TwACnUSfe/SavZXnuWwHWKBa0f9t7gPSmY9iqL5rBy+b2e4UJMLuaeS0xmRBT0h7zSAGGHN8Fhr2NyKIHcYB+FqBwTgCFzm17XRWXej8OWKIOoYhKeyq6Wi/qIBlDOjWzZn95zN2W5k+6h7shg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7954.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(11063799006)(56012099006)(6133799003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZlhiZXNCUVN1b3M0bndvcGN0b0E1R2t3OUlCd1lER1c4c1MwaFU5QTlNODZj?=
 =?utf-8?B?K0h3TmFqRU13cHI0MTJtdlRnS0MwMUY5Z0ljZ2xhSEF2S2dZUGJPajFGQ0lR?=
 =?utf-8?B?VVVkOGhVd1IrMEE0R3dUMlkvcHNLcWQxNkFMSE5BMVdYZStDVDZxZWJyWnRF?=
 =?utf-8?B?TVczQUw2S21KZGQzcmk5U2lNc0duazBUcjljTWRoMksxaTZSWHhmWVVoTjRr?=
 =?utf-8?B?aElCV0EyLzhMUW4rYitWaGs4T3dHck5ESm5wcHg2eHAzb0twSEhFVWpkSWla?=
 =?utf-8?B?VkdVZFgyeC9SNTF2QzNFem1VSUVQOUROR0hHNkw0djJlSGF0MktGMWVHNnNl?=
 =?utf-8?B?NUFMZkxjc0tyajVXbExtVm41anFETHp4Vko2VFlnb0lLcHFPTGxGSlB6M0xZ?=
 =?utf-8?B?QzFoejJSZCtPQUNURDJMVjgvYlNrMWppbVZ1c1QvVEZyVUQ1WVRTZ3Y4b2hx?=
 =?utf-8?B?VDdwdDJuWG8xWkNEUnE5V1E1aWRQT1o2RFNVZm82dWw4YWViMmxFeVNYWHZa?=
 =?utf-8?B?dnJEVnZsTlI2bFA0Z0dUVjBFRjBDcGllcW1wajZhbjM5TDVZQXpMOVBkRUNO?=
 =?utf-8?B?NDhBeVZtbUM2QURyaUxreDFaRHVJL0FucnJ3Q3hQTFRjenpoUy9PTEgzU3RK?=
 =?utf-8?B?U2xlb3M3MmtjU3dyNm9qT3dTRWtuWDEvb24zRi9KNEYyVXVKekxCRHR1Z0NH?=
 =?utf-8?B?enVNa2FmVEVBd3RqVlg3WnB1Q3NYNlZkY2Nod3h4THRIdVJLRXE1YS93UGFM?=
 =?utf-8?B?MzQyNHZ2VThOSk91L0FEbFZlRXZoTmV1eW9TQS9DZWpOMi9EOThBTXhKeXpu?=
 =?utf-8?B?NEJoYm1wQzlHNHNOQ2lGUGZ1a1llNkFsU2ZtSGpGczR4N2Eyb1V6b081R1lJ?=
 =?utf-8?B?bG5uam5GejRoMmxkUmNFWUtqZEhwM05XZDhJVzV3c2hoemdoZGtlM0IzSis1?=
 =?utf-8?B?LzJTZmpuUjZTb0xaaFRWN0lUUjJKNjhQZW83M1hmRVVacWNMaVpid045WU1M?=
 =?utf-8?B?OERZT3hNUXE0TWhwdXF5MzFTbE5vOFlQQ2puLys4UnRydXJqclMyQkdnQXFO?=
 =?utf-8?B?Q2p4L2dXZ2VlN09peE4wazcvZHBjeDdMWE1pMjUwL3FFY2pCVEhySDZaTWNn?=
 =?utf-8?B?K2pja2l6Yk1UalN5c3FtcTY3V2tiQUlDSnVWMFRyZlhoRHc2cWM4eStERE5Y?=
 =?utf-8?B?RVpUcXAzVktmRnVXcTRBT1FGQVlPeldqNWJMVktMdlVCK3BTOVk0SEh1dU1Y?=
 =?utf-8?B?Z21sTFQvdGlzbkNzUzlVNzJpK3RaVU1xWGJibm1RY3Y0L1Uxdk5XZVBaMXBY?=
 =?utf-8?B?MVF1ZUdyaTNUaXdKTzdWRUlDdHZ2THljUUlBUlVKY2FGVkJ5SmZYaDhQZXc3?=
 =?utf-8?B?cmxXMmEvQ0J2aXZKcGxDaTN6aXZPK0ViR1h3K25mTVREWTU5aHdCaXZUcEZX?=
 =?utf-8?B?TFlSRTdlckJFNUxxNWpzSTNZRS95UW0zdHVGZ3ExS2QrQkRHZFd3U3k3Rm9p?=
 =?utf-8?B?cWhoamEvcU5nUkhlZTVFMlRUWFVIajRhZjVGczBUOVp3M0dENlc3RTVpRitB?=
 =?utf-8?B?bzFYUExUOEY1SkM5QXJ2akdwa0VORWFqN0hseXNNZ0xCNnVlT24wL1IrMFpQ?=
 =?utf-8?B?RFpWZTBTVkJKVC85cDdQTFVIODIyR3pNL0pkdmRvSk45QU5MZEtwVEN1Tmdt?=
 =?utf-8?B?R2pxMzF4Y1VrWTQ0TGQvZTR3UFBJMVZQUE0wc0VGWi9IRnJZYTRoSml5bUMx?=
 =?utf-8?B?ckdhRSs4NWVteXRkZGJ0eHg3TmhxcFE4RVYwQjF2Y2x0WFVnV1NvZXR4MVBu?=
 =?utf-8?B?YW91eDZkUlhmN1gvZ2JMU1pHRDFoc2JNeFFhY3JSNnB0Z0Uwd1huTllocUVD?=
 =?utf-8?B?aU82cGpIUGNkV0pnMEViNFV1Q25ZVjllSUtONk9Xa3dDelJndTJIT2xTazlr?=
 =?utf-8?B?L2lrdTkxeHdjVjN0dXQ2L09SMmdrb21ZeWpteGlmaW52RERLam1tV0tZcXcx?=
 =?utf-8?B?SjkyNUdEdzhrcE93NWFldHlBQktGeFFWd05ZbExVL1UyTnpENWxZbkJKMXA0?=
 =?utf-8?B?U25JMEdPSnBkUzYya3dGZFhzTHRzOUxQdjZQQitSOGE0NXJHdmdYUUkxWXlP?=
 =?utf-8?B?N1pQL1dqQ0FCZ2lxenN2OExna2l4Z1g0Zk84S0RmYW8zbkhQUlBXbnR2Z3lG?=
 =?utf-8?B?TzkzMzMrclpha3B4c1JjaUtkK0NqMDVzV0JrTnhZNUVERWJLa1g2Y1JjWVl0?=
 =?utf-8?B?WW9QbG4zODRHUmJxL0Vvd3l0TUJ0YXBKb2Y1a0padmtMeW5VTzNXTDY1RUxm?=
 =?utf-8?B?QU1nbWRDU2Y1elRMdERwbjJUUHNsMWF1RUlKMC9FU3FKeXUxYXU3dz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afca9e8e-e9d9-499b-35b2-08df24804aa0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 14:35:54.1930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PLuOARUc2vEsQTv14s2wTjn0ICy+cTAkIzcFy1tB529n2TNAKKvNKI8RvqmAWGDKwGaKBM2L1JbyYEHK2IlkIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7083

On Wed, Oct 07, 2026 at 05:59:37AM +0000, Yiming Qian wrote:
> br_info_notify() sizes the notification skb with br_nlmsg_size() and then
> fills it with br_fill_ifinfo().  If the fill does not fit, br_info_notify()
> does WARN_ON(err == -EMSGSIZE) because that is supposed to mean a bug in
> br_nlmsg_size().
> 
> br_nlmsg_size() (via br_get_link_af_size_filtered() and
> br_get_vlan_tunnel_info_size()) only accounts for the VLANs that have a
> tunnel mapping at that moment, while br_fill_vlan_tunnel_info() emits an
> attribute for every VLAN that has one by the time it runs.  br_info_notify()
> also runs without RTNL (e.g. from br_forward_delay_timer_expired()), so
> tunnel mappings added or removed under RTNL between the size calculation and
> the fill make the fill need more room than was reserved:
> 
>   WARNING: net/bridge/br_netlink.c:660 at br_info_notify+0x13f/0x150
>   ...
>   Call Trace:
>    <IRQ>
>    br_forward_delay_timer_expired+0x1b3/0x1f0
>    call_timer_fn+0x2d/0xd0
>    __run_timer_base+0x5ba/0x7d0
>    run_timer_softirq+0x31/0x60
>    handle_softirqs+0x17f/0x570
>   ...
>   Kernel panic - not syncing: kernel: panic_on_warn set ...
> 
> Size the tunnel info for the maximum number of attributes that
> br_fill_vlan_tunnel_info() can emit for the VLAN group instead of for the
> mappings that are currently installed.  Consecutive VIDs with consecutive
> tunnel IDs are compressed into two attributes, so the fill never emits more
> attributes than there are usable VLANs, which keeps br_nlmsg_size() an upper
> bound of what the fill needs.
> 
> Fixes: efa5356b0d97 ("bridge: per vlan dst_metadata netlink support")
> Cc: Yiming Qian <yimingqian591@gmail.com>
> Signed-off-by: Yiming Qian <yimingqian591@gmail.com>

br_info_notify() is inherently racy when called without RTNL. Better to
just remove the WARN_ON() in br_info_notify(). Blaming commit
b7853d73e39b ("bridge: add vlan info to bridge setlink and dellink
notification messages") seems appropriate.

Note: "don’t repost your patches within one 24h period"
https://docs.kernel.org/next/process/maintainer-netdev.html
