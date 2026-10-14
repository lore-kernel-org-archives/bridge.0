Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012055.outbound.protection.outlook.com [52.101.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7F43002C8
	for <bridge@lists.linux.dev>; Wed, 14 Oct 2026 14:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791989177; cv=fail; b=IX+BmWexfPxjYFTRpViriDk8ZwaSk2OCJRUAlzwoEtM/qX8/e6qUwJRXflZZ+s6/Yc6jZku/T3rjNan4OIdkCsqPn5s7QuFJSSaDU59P38YmCVbKkTuKA90ecJOAbU4XhmeAKXtMuYdRkDPej0JQ/NWzBsGiAuGTno0RW/s516A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791989177; c=relaxed/simple;
	bh=leReLhp0LxLrxznjORnrxcfa7Hnmz1NInu6IENx5900=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TXl8dGM6FnyxBItmIEPIiiIfFgC7h0R1X5kf5DEKd7ZpPQTt+APi1UwA5NK8cWxgZ/2gEgMaJbvbfMDthXOHwEX79D9pegBxdP9hNUc3zYoY+Q8RVaaMl61HAOmaauRmZeA0w0yBnRXnk7s42OM91d0HcttRUM64KnnaVeN9OUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ok0+0iKB; arc=fail smtp.client-ip=52.101.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ok0+0iKB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=buD/LRxJQbE248npeOuJKp/CbBWEOdn44Rex71C0E9jEsP9io/3eWAs5V1EVOgXSJGT3JDJFNYzwC4ibKrbGmFwUK6EOmVhvbAeBNbJlZee6X/p+XPub7vo3pvo2mUJjWL97KtNOD5aJGveps0a22usomXkioNWTnJSJHZQGGcqdlwPELXFF1KEyB4NdVvNeLiu6SA/q1sPu7aw3VoylFZRNOU8ai+wCB2KAMlPrT567TVv7ya7YAvppnKTkEiBvcgBgwilU1amUzzuxmADI8+C6ThF+wdNl6FnGARNnMfzHIvnu1QYN5LuJ70xBy2ljcCSCSxnEQN6xPIKV3KIFeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K7UyR4fAatmHa+fXBVMVJCUrGz8bw21gal850oVk9QM=;
 b=TG1HRc47B5FEP2W3qik76xWOFuMQWTigW3cLBXLNrGuRKNy6S1BFMSiSHGcpi+RmSXt9+451TgBLTWoVJNEjLKHTiG1wksRd388dVo5Qu3UCw2LvK6JXs8eTk1twvyLbvkaqQ7HQvG0cioGHa7dk7v/I5LJetSUetd6fz5WQWHmLjNQCqgFLIzH7alyrOdMSbyhyWpAnDMeCPvNX+OMJBvIJ9On1CJXnATpp9AQH5vxz21qFnZoyqSLx4VlPQ+nfpPsJVfRe+AV/LfIARLvNazw7wuPX6BCoUjdTK9DkngG1mkdHd/Mhv7KlRb794ZmGyGjLa/CD3OfgtHsT+DQcGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K7UyR4fAatmHa+fXBVMVJCUrGz8bw21gal850oVk9QM=;
 b=Ok0+0iKB4aEHwEipsOa55g+skp4ZuIln7eTSt2dChSPB+MYWSs5Axp5TG6Lu2uzJ72WxXvBjG930PzP0ZSkOfTiV546MC2mi9tYVEhRm4a0EDr7v7hb8JgdLniUwcXgIq4G9lf6TxEYKGeuIv3hnhkVABW4/BQ0QyYkn7d3frFJAe/p3tdjvb+uowBfHSLR/38H7YdFzFwjCPHoI0U+sUSkPGoboJxURaio7MvwIOa98t1KAydc+tGg/4DX6syaeMP6i0NsOPkBsSBmRHiSke2KeeDsBeuxMtIbbAQfCKDJn2MWbD3z3rp3d/Hj6nhWPYHRhnec/fTdSidDrqvhiJg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by PH7PR12MB5595.namprd12.prod.outlook.com (2603:10b6:510:135::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 14:46:08 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 14:46:08 +0000
Date: Wed, 14 Oct 2026 17:45:59 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: =?utf-8?B?6ams5LqR6b6Z?= <yunlong_ma@buaa.edu.cn>
Cc: razor@blackwall.org, bridge@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [BUG] net: bridge: mcast: rejected report leaves an orphan MDB
 entry that can disable snooping
Message-ID: <20261014144559.GA1445548@shredder>
References: <2f5b61e2.1e71a.1a11fcb3809.Coremail.yunlong_ma@buaa.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2f5b61e2.1e71a.1a11fcb3809.Coremail.yunlong_ma@buaa.edu.cn>
X-ClientProxiedBy: TL2P290CA0027.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::11) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|PH7PR12MB5595:EE_
X-MS-Office365-Filtering-Correlation-Id: 12963516-ce58-4757-183b-08df2a01e1b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|56012099006|5023799004|11063799006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	IxGLdH6QMY5JxAyxnAo0QZSTj76YqZYOYdK4pabS6N1zlWRsho8IPlTQdU2WT/ZoEXAtoUcuMKRiI6SZd8SlOPn5PKq7kE6V4j4gkBnd0WdxzyKYEDrqCvPfcp/kucs8aD4qCTPZQWvtrp2UkoBc39J5Vlm1vrbqm1+0t38oEV9RSY2f0ofo7E3t32YgY91jMPw+gcOFk8yKDdG6raF+lP7mszVkPUbgsM4jojZs2fWDmF9tqqoUxKjUtQ62PmboaeiUnwYWd9cCO+V4wTK0Le4lGKmIMU6tX8sX90Ra6lQRLTLGQQ8k7H4j1v3GqfAqzZ6PWjNOmwbQsR4Gl81b/7xq90Itjqu4myKyVx8HWCYXguxLOLHHu9y7Dv0F7SyRcN6L6WHPgIAQGcEbd2xPD31nHGL00EjVDgyevOVJugq1NsbnozNMnE5Ub+eaWp22YR7bQ5vD8a9RoqdyxGkKRgUN52EtIVlypUHszjAbgfUBjWiU2hMzYdzG3LWbv6fZbjZnNUridxnGdnzEC51CVVoqcwd3sMbgOb85LMnfHraLGOCfCnFYW6SbjVie4OSIhaFXHE/iaMTYhsscmemv/bi9RMGdSN7CuZXIKsA4t7cw8Vqog6H+quJHN02rM5MesOaC1xXTRkl6s5d7gacTvYvhAWQIB6gFsJGVQjATx6c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(56012099006)(5023799004)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b1NqNlFIemJZelc5U3A2cjZQeWdLd0hiRnlaRm9YZzhMMlNDcytPRFN2bDFB?=
 =?utf-8?B?bi9QK0xBMGJ6dUJvejdmSC92QTdMRzcvSGhzc0JWTGsrWjhxcXdGeXloTC9S?=
 =?utf-8?B?RDFWekpHMkpjd0hZY0xVRXZRZS92QXBuUE9ueWtzdys2RGtmZURTQml6R1hX?=
 =?utf-8?B?MFRORHF4YVlEejJZVWd4UC9za3U2S2VwcVBWd2I2TTZ0RE9FKzUwOXVZZ3kx?=
 =?utf-8?B?ZldWQ045cFRUbmZxS0xaYjM1bTBsTkltNzhXSjcva09yMjFPTVFqVXpjY09X?=
 =?utf-8?B?TThpTGVxaVFqdFQ4Zk1KSUtGakNpMDh4Mi9jRUh1bVd0S1RVc1hlZDQzZk4x?=
 =?utf-8?B?SkxmT3d0MTM5VDVGQ2N1NEJvUi9VT3hsTmV0TTd6RitGalNqNWVXWjhWZDNO?=
 =?utf-8?B?dHUvZ1hPeTkwQThqbU5TU1RPMENqc0lCbHdGQXRia3BBaXduQUNzOXgwVnpI?=
 =?utf-8?B?UmNUQi9YbUFMN0tTQjNDRmE0U1pRSlVBSzM5NkpmRVdVMkhUcE5CajgzNWRC?=
 =?utf-8?B?RUx0RzVFenh5bDJXbi9rQjhVS2toRncxeVpHb2tERlplT1h1SEJrRXF2bTdS?=
 =?utf-8?B?Z2h0RXZIWFFOSno0MXdCKzJ4Z2RGS2pjOEVIT0NURHl1OFE4SHRTaUhkWDVo?=
 =?utf-8?B?QW1WdllYWjVNVER4SzREY254MGVPNFZ0NlRrYVVLYmpseEdOYzRxcE1KRTg5?=
 =?utf-8?B?VS9JVW1NWHQrSzZpRGdFNEgyU0tYYUh1bDE0WHVsMVhZU1Q3QUMwZFZsYnJB?=
 =?utf-8?B?V2RZbDR0UnVaMkd0YzJpOWRvYW1xK0luUlZ5VXJrQkpQQnBQVzdZeXgrSGRN?=
 =?utf-8?B?akJtU2Vjdi9LOUlpSm8vT1luY0NVcWZFWlk5b1dvbUxTUk9VZDZWY1pITGly?=
 =?utf-8?B?Zmp4KzBFcDB2aDJvOE9VY2orMEVSeTh5ZVk3ZG5KSktDamVRN3lFWXJ0MjBs?=
 =?utf-8?B?eUJrSUY4ZU1HU1hyVTlRU2kwcEpxcWF2Q2NSMUcxaEhJZDYvN1lmQXNCY20r?=
 =?utf-8?B?bStZNFI1WjNvWXZLMkR6YmVnYVp4T212L2t1a3dVVTVES0tLNXIrTE9DTDdW?=
 =?utf-8?B?bFpJTnFrYjV4bk5ncVZ3OW5STmpPNDNENVRsdTFTVVdhVWgxa1BySlI2Rkls?=
 =?utf-8?B?QVlNNjAzZGpmVFNLYi8rRlVDRlFTbVgvSVlVVk55ZGNYZ3B3clMxMnhYRjda?=
 =?utf-8?B?UldlTUFYQStkR2RGazF6QzZ4UlRmZVhoUk1PZ09uOFMxT1VIRS9FRitHbjEx?=
 =?utf-8?B?VDJlMHJvd2VwUDhDUG45R0d2d01NaVJpbUxkL0dEenFVaEhHSXEwRXQ0YlY0?=
 =?utf-8?B?S2Y2dEJOZTBZMkd0R2ErWS9Va01DWk1SNHoyMi81THFEUUwvUXdrUWx4bjEy?=
 =?utf-8?B?cFVtRVAvOWNIY3BBZ0VDTFR3ZHdVYm9iK1VxeEw3S21QTFErcytZT2Noa1hQ?=
 =?utf-8?B?bWh6bnhoRTEwRnRnMUxxWHc5aDdhbldoMVJIenRvdUhVRkJnNzlWeG1XVXdh?=
 =?utf-8?B?eExoVTVORWZPNjcvR2Fpa2VMd3ZBQ0FLZHdLYXNJY0RSMjJrSzdnbGxQWlVy?=
 =?utf-8?B?TXQxMWtFblFuYmZlSEZ4bzd2T1JiYUdkOTA3NjhIcXptcWk2M2RMSzYxTllT?=
 =?utf-8?B?dityZENiTTF4bVRrYzFrbVpsN1FJWG9tZit1WnRWZkd3UUVibGlUajVSazFT?=
 =?utf-8?B?U1haYkpuR1hDRVJNSlJOcm5nOERRRUNySVNwZDk4TFRhWmExS1VhMGtuMFRK?=
 =?utf-8?B?dEFDeEROZC9XZUpNVkNsWWJWbVloUjduYU16bXExRFBpK3hWNzBPU2lzYTF6?=
 =?utf-8?B?TnYwZnhneWtJQVZVaDBOcHhQVEh2N1l6ajZmNStKeFhkaFd3Q2hLVFlmUDMw?=
 =?utf-8?B?Uk5ndjZ4SzBpY2FPK3AyVVRGczJzbDMwd3RVYlJiVlN0K2pSNHdoRlhXOVAx?=
 =?utf-8?B?T3p0MzllejVadXdQU3IramdkeXVic2EwbnovbWkwcFJxb2NmZmd1Y01BSVUv?=
 =?utf-8?B?MkVQOVJRWmwvdUVFRjY3T1dYTTNra01aNVh1UXd3Umg1SVB0ZFkzZTk0Kzc4?=
 =?utf-8?B?SkcxUThoZEFVMzd1YUVDZE1nRVY3dkhPR0MrbVZsYm13aUlhcENUWDlzdEUx?=
 =?utf-8?B?eTF2Qmo3Um92d0wxM2gybG5yWGVRdFMwYWp2RXZqYlZMWEVaeUl1MFN5ZUJp?=
 =?utf-8?B?NmwvblV1SXVvZ3VTN3dBZVFSVzB3RVFuZ0wreUIvL3FzZHowU2tTUkNmczRT?=
 =?utf-8?B?dGQ4Vkg0Ty9SY2VuNXU2ZWFyOUs0VmQzK1c0K3A0cUsxL0RtQWMxWi93S1hh?=
 =?utf-8?Q?v7G2NglgYM8438YZbo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12963516-ce58-4757-183b-08df2a01e1b7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 14:46:08.1442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xSOQeroDUVgoADUhY4HZ5OHey0WLMzIlAMo/0S3mwvAVK3V/Z1RuyOE7KORILyiYySMAJMZPvkdYopljtUInqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5595

On Fri, Oct 09, 2026 at 04:32:54PM +0800, 马云龙 wrote:
> Hi Nikolay, Ido,
> 
> When __br_multicast_add_group() creates a new MDB entry and then fails
> to create the port group, the new entry is left in the MDB hash table
> with no ports, host_joined == false and mp->timer never armed. Nothing
> ever removes it, but it still counts towards hash_max. With
> mcast_max_groups set on a port, a host behind that port can create
> these entries at will by sending IGMP/MLD reports for new groups, and
> once the table reaches hash_max the bridge turns multicast snooping
> off.

Thanks for the report. I will send a fix.
