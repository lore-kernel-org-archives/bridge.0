Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011025.outbound.protection.outlook.com [40.107.208.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B344B3E8357
	for <bridge@lists.linux.dev>; Wed,  5 Aug 2026 08:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785917253; cv=fail; b=VKep/b4qfys8LRjjDZCaz37G6AWtHegXCe3d2/iqEp6MF5wsFH7uv7QF0LHP9ca2ATFqrsnbG98CH4kQOk/skvh7IJP+oDnCS56zsE9UuFAVOKiI8W+dZ8uukRiPbosLeMb+0c/iMnG/7x+VFF/+DCHLeNDxh3sRqg6uj0HOE3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785917253; c=relaxed/simple;
	bh=vmUQWWSMlwCS6HX9iJcYOHUV31JAZ/lIDc6XB5sH8CY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tT1O051ym8fhyN7aog2jy3alCtH1HVNCCnnyv2IGUbCdsJEKb/ywLtAVn8ZWO3yByt0llB/02eCfBA2j/i3EqfhxmZ0dkjuu3OC+OV41wwelZ+tWe+DmuEDua6zzbwC6raxZ3cK83VFCrjFoiHeGQ3VwKppDBHO7IvTRS2Txm5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KT8fUwNl; arc=fail smtp.client-ip=40.107.208.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KT8fUwNl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZCnrjhE1PADrP0YixNSvkHAR7CkO5/zmD313b6aDQSjS2DS/WLYvQQae/BADM/Q6fKp/YfxjeyHh5S3wm0YT/XK2UBkrBJ7GVHjln7BQx2oyG1ZQVeM/3v/pI59yrixmbo5EyRlwYEDoexgS6eFTD9KW4dPI7LkD8vd1W/hkPBCdI+KkZtymjPOz56t3cGTAXHRB1CCWZ+KIDa8H36OuvYCxhfWjrLdgRBNQAy8L3jck/Nqx6fmlHAqsF0T3rKdywmEE9A6Qt9sKMKz4k+gs3MuFZVgPpL3jyIjEmA2O1SZ2qtUZqfn02FH2b/yuZc3TEv6DUsixCuUhVRBfYF9E8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vmUQWWSMlwCS6HX9iJcYOHUV31JAZ/lIDc6XB5sH8CY=;
 b=lt7idapqU8DzRwL4plI3h7NdbICN9I0ROxEUKHFBS22HUWK7IHHdgPvQ3ahQn/xr5RuOtKzFObWmH7aUXkHhMltCoSR4RZqkKl3pL627oyXjxx+tfE7tCMb5gGL4M6mMnVRJXFswO3Gyfw3RARNkzSSb/vef/aLMcYQxcAKDaAqEOfclRlp7mSpcvZu5iEKl3iydYTrMyJ33ShGdHVTET1JXTgtTgvL3j6CReSGqeBmYBw1WSZleNdERBl+BCUOntFWGemMGA6q38WfLmO/jl/w8Fn5Q+jjzNZ7RMcmb9n9iv0UBc+OYkB9a/MpsKghZT7E2wlK3M0ztVdpX8jJOaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vmUQWWSMlwCS6HX9iJcYOHUV31JAZ/lIDc6XB5sH8CY=;
 b=KT8fUwNlcHHBGrEB2gIY4J44DhV5uSZSWoQPvEdonvKHIELz4VCLguGCOmpVKTgG67ja4Dc9gBN3OJVo1q8P0mqcWwq2lb/cvxw1R8aYcL0OEYyzvRLrRysd7oWEdtwafg7ZyaXZym+gVoxtbhPhBn+JM5p76YZQfh8KoCSx6BMETlsBad6+86nhb6Ie64DZMEXHDR8P66hZJ/04rv6MieOhl9Lxt1/iFkU6N/XjFctn//dvKLDU8+c1kmA4n8MoAqAT7zGBxbZXGtFyxpQT0QMdv8Txl/ItZUtg6+LX6LoxIcW1pPUDJ9AppA6YHuIgbZEyic5+tM1b/8vppMN0mQ==
Received: from SJ2PR12MB9008.namprd12.prod.outlook.com (2603:10b6:a03:543::19)
 by CH1PR12MB9576.namprd12.prod.outlook.com (2603:10b6:610:2ad::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 08:07:15 +0000
Received: from SJ2PR12MB9008.namprd12.prod.outlook.com
 ([fe80::e25c:9cce:637a:3dfd]) by SJ2PR12MB9008.namprd12.prod.outlook.com
 ([fe80::e25c:9cce:637a:3dfd%3]) with mapi id 15.21.0270.016; Wed, 5 Aug 2026
 08:07:15 +0000
From: Danielle Ratson <danieller@nvidia.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "dsahern@kernel.org" <dsahern@kernel.org>, Ido Schimmel
	<idosch@nvidia.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "razor@blackwall.org"
	<razor@blackwall.org>, "ja@ssi.bg" <ja@ssi.bg>, Petr Machata
	<petrm@nvidia.com>, "fw@strlen.de" <fw@strlen.de>, "kuniyu@google.com"
	<kuniyu@google.com>, "bridge@lists.linux.dev" <bridge@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v2 5/5] bridge: Use ndisc_parse_options() to
 parse ND options in br_nd_send()
Thread-Topic: [PATCH net-next v2 5/5] bridge: Use ndisc_parse_options() to
 parse ND options in br_nd_send()
Thread-Index: AQHdIzreD685lVFfj0G1ARSRRj2v9baPG1fA
Date: Wed, 5 Aug 2026 08:07:15 +0000
Message-ID:
 <SJ2PR12MB9008F360347287B97EAE28D3D8D32@SJ2PR12MB9008.namprd12.prod.outlook.com>
References: <20260803112505.613873-1-danieller@nvidia.com>
 <20260803112505.613873-6-danieller@nvidia.com>
In-Reply-To: <20260803112505.613873-6-danieller@nvidia.com>
Accept-Language: en-US, he-IL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR12MB9008:EE_|CH1PR12MB9576:EE_
x-ms-office365-filtering-correlation-id: fab641cf-130e-4e25-eb54-08def2c88fbb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|23010399003|7416014|366016|22082099003|18002099003|11063799006|56012099006|10067099003|4143699003|38070700021;
x-microsoft-antispam-message-info:
 fCZGa77xTw9vu1kDVCtYLtx1GpKqFNf/sPQh1MIB0YtaAPZff3fIq3q5MVdtsn0+OqEwB4xTY79I9ZEYnnnzDFFC6f6F9RSfRe6Q+mG30uIm5kPLXEE4DX4WeHssV2T2p6DIyHx2NH5nDqskpkWry2TNgLMHUEU9om6mwKgr5ikX5XXssituG0HGbXw6m7g2xnnao8zqnSIbypcF4MQkRjj3wAg1sqI6ahO4Wa5ucanPlC6czm21efnVoCTHHGa9twYIxF9LmNPv42JNL23K8ccA4hX6lgkM86+K8UArV3TY8iI1p2r8NkK0GJily9+7f7oX41eONg42j7FrLvDED1+T9T/4e6CqFA5jp/1h+nKnkA9hzujr0vsraTA3cgMtTqgIwW3Bqbxju8a5C72rGnte+amH1yDLi9q/gj0oH4DTFyZewm4ltIJ0VO6obGyj4lmXNRxGzPFZor7RYrKTqjOdeHqrFq5qKfF7TWr2etkYb37Mq3f4quiRE3Mj2WGo+kIWWght0uegDOTjrL5QSe2md8RjfrM13DF67Rk73lNPOIuLkHYhMSGeGOYOFWQQVIpVtQiJpN0bqqIPs9afnEuVudnNdHryNEwSyM44ml9Jc+X3XwxvkkIDdUEjzj1jYyp+cX7NzCcUbXGzMJblP5XawQwCn2xlhraKqIj6VMXcoLtPLFEOfz80wBzLoOq6+EHG1uKR8eG6vU263J5IN+4Wp4kLaTQsmX1EGO9g6vM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9008.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(7416014)(366016)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003)(4143699003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b1NsenRQbGUxd3ErcWFuZ0J4TTh5Q3p6aE82djZlaWs5YzF1djYzSGRKUFFU?=
 =?utf-8?B?K0M1NkdJaW9YQkl0SkdBdk9nSFhpQTUxaTljdWRsSHhRcEJXTCsyWEgwUmc5?=
 =?utf-8?B?b2szbkxoamNEeWpwRGlrNWdQV3NTSzIvSTJmRU9iL1BUbUR0Uk9PM0xTWjl2?=
 =?utf-8?B?MEJNdXNZNUI5VWNubi9CbVVLQ0Z1bEs5Si9LRkJWc1lZYW5pYVRaN0VPVVhT?=
 =?utf-8?B?Mk1NZnhUOUEvS2NYUEF2MVhWcHlGNmVUYy9lZ2M4c0Y1TGowQ0owMzVJY1g2?=
 =?utf-8?B?S0kxdzlOQVR1bDhGanlRdXV0NFFaTlBBS2hmUkRRYlh3Qnl2TzNjRkVtZnV5?=
 =?utf-8?B?Mkh1M3RRb1N5QWZ2blorWGIxV3FRTUdNR0YvNHBzenJZYWNzanVvL3EzZ0cy?=
 =?utf-8?B?emVVLzUrNXVkSFNXT2pKTkhzQ1lRS3d6THVFVU5VaEhJa3FnVVRBcmpOTWlU?=
 =?utf-8?B?VlZUQzYrb2ZDWmQ5SXF3c0lqYW13cURzSHBLaFRvcWptQ1NZKzNhWTI1cDMz?=
 =?utf-8?B?SjJiUU1paCtyQW84TFBNbzloUmhkYVplWFZZRkJyV1pFRi9SaW5UbTRwbDFQ?=
 =?utf-8?B?YVExVThyOWU3Q2MrYU5Ja1pJS1oyWHhFdnBxREZCN040UDZoWng0THRjcWJ2?=
 =?utf-8?B?SG9WMk1XY3hpRjBIQ09iWXpOR1RlY2llTTZCeStZY2ZtTEdZcUUzZzh4ZlNp?=
 =?utf-8?B?a0Ewc1ZSS0xSTGs4VGhnNFRNQlphVThhdFFHREwxNzlSMTczM1RlenFpNW5v?=
 =?utf-8?B?eExETzl2Qy90YlJmczJkYnNxNHI3RUczbU1UaXpHdXhmL0ZBejJvZStQbWhq?=
 =?utf-8?B?MVY4VE5Sd0xEbVhvNW9iZ0xzOGw0U2grblRIN3FvYk95Q0Z0dTJXMjR3cWpX?=
 =?utf-8?B?Z0VJMUd3S3lZdUF1RjBxTWtCT1dPYUVNREVFT1FyYm1TaHppTjlySlZVVFJJ?=
 =?utf-8?B?RVhKN1ExR3ZwdW1UNDh6N3R2eHFQeHk4c1Z1YkNaUUdWUGdQaExCU2diYlQx?=
 =?utf-8?B?ZWFlckg5N0VZZW1SR2wzYWpDaHlYK1E2d2V6eWxVdW1GQ29tR0FXcGpOMFJM?=
 =?utf-8?B?SEE1dU50NWE4TUhSb3Z2dk83Vjc5NWc4ZW02TzVBSTY5NGVXN2VTNURURjFF?=
 =?utf-8?B?Y1dHS1R2ZWc2bFo2LzVWdlk2akFlZ2JnS3hwaW9HeDlrQkpZYmNJQitWVGFS?=
 =?utf-8?B?K1poeWtkR0FjWU1nbUgvVWlZYVp1M1czUlVSbzN6ZVBPSkVyN2dmbUJLeGJa?=
 =?utf-8?B?Z1h2VUtxNWk2Q0pFOVM5VVNaNUhWS2hpenBZZFRGamVhRWM5dFNzbTdoWm1p?=
 =?utf-8?B?cjNUQmxpUTE1Y2hrOFVlbVFjckFkd0NwOE5paVloQlhMemZoUzBDRVVoK21y?=
 =?utf-8?B?V0g3RWNQT0w1SmRpeGtCVFE5bnlPM1kxV3R4TDlUUFNaazQ3akNuS1FxMUpu?=
 =?utf-8?B?QWFlVlg4c2RQMzRHc1lMWHB1TzhRVm42RXZKRk9qSExJNEptSDlnMDBQZUR6?=
 =?utf-8?B?RldGSjBIYXlDZzdoeGNtSytmam4zQlAvS1NLNmg1KzlVcFRka3JVVlRGUUxj?=
 =?utf-8?B?b2NURk1yS0hGNTFpdWpXVEZtaVI2KzR1dXdNRHpPVUtWcTNVdis2SDZ2SjFz?=
 =?utf-8?B?L3hlOWhQaWN3WkhrWkJyMmhlRC9qdFVWcEFqL3lwN1kwQW9tSHFjeXhRUXk4?=
 =?utf-8?B?anc3RHVUb3lWYml0NTltNlA3Z0h4NVlQSUhFYzFpSmRhVUYzbUVoSWQvc2Qr?=
 =?utf-8?B?cGU2UjA0YnVvZzF0dHRFTnQyNk1jVlU5a1BhNWRWRElaU3A3U3RJOHgwQ0V6?=
 =?utf-8?B?ckd1M096VG5KMXRhNE82Wk85Tit0N3o2ano3c2RsaWw1OTBoUWVlQXRSem1C?=
 =?utf-8?B?N1pGdjlhRjB2UmZNNXJuZGU3ZjYzWjZqYnRxUGdtYXFVbzFNL0h6a2d0d1pR?=
 =?utf-8?B?d1hZR3M1cHVyRTBHZ1RFei81T2cySU9xTDhLZmpLZzU0eFFUYnZiSFNYVlc0?=
 =?utf-8?B?ZStmNkpwRVZaWGlrbzd5cVY0VE5SZ1Zyc0VVeUVFYlc3NFJVN083OUFORDVo?=
 =?utf-8?B?aTNnUXUxZm5ubzk0Kzl4RUxud21XRGVpV1RmMEp4YTgyeWhuZncrTngyeERm?=
 =?utf-8?B?U3hJR0l2SUhhYUhRdW1JcEd6eXRqTm5mcyszKzNaSlJkbTBZemowRjBWSDQx?=
 =?utf-8?B?RGpQWU5qbDNYN1drNWtJT2JDT21nU2pzTmRpVFllaXRlbkJLTGZQY0Y2ampF?=
 =?utf-8?B?MUF4R05CVXBWQTBwcUd5SkJVc1NsdC9Ja1VzekxTaXN0MENMU3BCMEYycjQ2?=
 =?utf-8?Q?mwdfNrwHhrFZzMQ5g6?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9008.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fab641cf-130e-4e25-eb54-08def2c88fbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2026 08:07:15.1602
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D9hR3bz0Z+P3vxGeld+LNzg6ylWvjp95f2ilSeQDLZXZxH579/ZvnLSGRodZdbFtl//naEiTBP7tYZs+GEFcwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9576

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYW5pZWxsZSBSYXRzb24gPGRh
bmllbGxlckBudmlkaWEuY29tPg0KPiBTZW50OiBNb25kYXksIDMgQXVndXN0IDIwMjYgMTQ6MjUN
Cj4gVG86IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IGRzYWhlcm5Aa2VybmVsLm9yZzsg
SWRvIFNjaGltbWVsIDxpZG9zY2hAbnZpZGlhLmNvbT47DQo+IGRhdmVtQGRhdmVtbG9mdC5uZXQ7
IGVkdW1hemV0QGdvb2dsZS5jb207IGt1YmFAa2VybmVsLm9yZzsNCj4gcGFiZW5pQHJlZGhhdC5j
b207IGhvcm1zQGtlcm5lbC5vcmc7IHJhem9yQGJsYWNrd2FsbC5vcmc7IGphQHNzaS5iZzsgUGV0
cg0KPiBNYWNoYXRhIDxwZXRybUBudmlkaWEuY29tPjsgZndAc3RybGVuLmRlOyBrdW5peXVAZ29v
Z2xlLmNvbTsNCj4gYnJpZGdlQGxpc3RzLmxpbnV4LmRldjsgbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZzsgRGFuaWVsbGUgUmF0c29uDQo+IDxkYW5pZWxsZXJAbnZpZGlhLmNvbT4NCj4gU3Vi
amVjdDogW1BBVENIIG5ldC1uZXh0IHYyIDUvNV0gYnJpZGdlOiBVc2UgbmRpc2NfcGFyc2Vfb3B0
aW9ucygpIHRvIHBhcnNlDQo+IE5EIG9wdGlvbnMgaW4gYnJfbmRfc2VuZCgpDQo+IA0KPiBSZXBs
YWNlIHRoZSBtYW51YWwgTkQgb3B0aW9uIHBhcnNpbmcgbG9vcCBpbiBicl9uZF9zZW5kKCkgd2l0
aA0KPiBuZGlzY19wYXJzZV9vcHRpb25zKCksIHdoaWNoIHByb3ZpZGVzIHByb3BlciB2YWxpZGF0
aW9uIGFuZCBhdm9pZHMgdGhlIGNsYXNzDQo+IG9mIGJ1Z3MgdGhhdCB3ZXJlIGZpeGVkIGJ5IGNv
bW1pdCA1M2ZjNjg1MjQzYmQgKCJicmlkZ2U6IEF2b2lkIGluZmluaXRlIGxvb3ANCj4gd2hlbiBz
dXBwcmVzc2luZyBOUyBtZXNzYWdlcyB3aXRoIGludmFsaWQgb3B0aW9ucyIpIGFuZCBjb21taXQN
Cj4gODUwODM3OTY1YWYxICgiYnJpZGdlOiBicl9uZF9zZW5kOiB2YWxpZGF0ZSBORCBvcHRpb24g
bGVuZ3RocyIpLg0KPiANCj4gVXNlIG5kaXNjX29wdF9hZGRyX2RhdGEoKSB0byBleHRyYWN0IHRo
ZSBzb3VyY2UgbGluay1sYXllciBhZGRyZXNzIGZyb20gdGhlDQo+IHBhcnNlZCBvcHRpb25zLCB3
aGljaCBjb3JyZWN0bHkgdmFsaWRhdGVzIHRoZSBvcHRpb24gbGVuZ3RoIGZvciB0aGUgdW5kZXJs
eWluZw0KPiBkZXZpY2UgdHlwZS4NCj4gDQo+IEV4cG9ydCBuZGlzY19wYXJzZV9vcHRpb25zKCkg
c28gdGhhdCBpdCBjYW4gYmUgcmVzb2x2ZWQgZnJvbSB0aGUgYnJpZGdlIHdoZW4NCj4gaXQgaXMg
YnVpbHQgYXMgYSBtb2R1bGUgKENPTkZJR19CUklER0U9bSk7IG90aGVyd2lzZSBtb2Rwb3N0IGZh
aWxzIHdpdGggYW4NCj4gdW5kZWZpbmVkIHN5bWJvbC4NCj4gDQo+IFJldmlld2VkLWJ5OiBQZXRy
IE1hY2hhdGEgPHBldHJtQG52aWRpYS5jb20+DQo+IEFja2VkLWJ5OiBOaWtvbGF5IEFsZWtzYW5k
cm92IDxyYXpvckBibGFja3dhbGwub3JnPg0KPiBTaWduZWQtb2ZmLWJ5OiBEYW5pZWxsZSBSYXRz
b24gPGRhbmllbGxlckBudmlkaWEuY29tPg0KPiAtLS0NCg0KU2FzaGlrbyB3cm90ZTogDQoNCiIN
Ci0tLSBQYXRjaCBbNV06IFtQQVRDSCBuZXQtbmV4dCB2MiA1LzVdIGJyaWRnZTogVXNlIG5kaXNj
X3BhcnNlX29wdGlvbnMoKSB0byBwYXJzZSBORCBvcHRpb25zIGluIGJyX25kX3NlbmQoKSAtLS0N
CmNvbW1pdCBhNWU3MjIxODdhNDMxMmQ2MjM2NmM4ZjE5NzcyMjY1ZDkxNjlkODllDQpBdXRob3I6
IERhbmllbGxlIFJhdHNvbiA8ZGFuaWVsbGVyQG52aWRpYS5jb20+DQpicmlkZ2U6IFVzZSBuZGlz
Y19wYXJzZV9vcHRpb25zKCkgdG8gcGFyc2UgTkQgb3B0aW9ucyBpbiBicl9uZF9zZW5kKCkNClRo
aXMgY29tbWl0IHJlcGxhY2VzIHRoZSBtYW51YWwgTkQgb3B0aW9uIHBhcnNpbmcgbG9vcCBpbiBi
cl9uZF9zZW5kKCkNCndpdGggbmRpc2NfcGFyc2Vfb3B0aW9ucygpIHRvIHByb3ZpZGUgcHJvcGVy
IHZhbGlkYXRpb24uIEl0IGFsc28gZXhwb3J0cw0KbmRpc2NfcGFyc2Vfb3B0aW9ucygpIGZyb20g
dGhlIElQdjYgbW9kdWxlIHNvIGl0IGNhbiBiZSBjYWxsZWQgZnJvbSB0aGUNCmJyaWRnZSBzdWJz
eXN0ZW0uDQo+IGRpZmYgLS1naXQgYS9uZXQvYnJpZGdlL2JyX2FycF9uZF9wcm94eS5jIGIvbmV0
L2JyaWRnZS9icl9hcnBfbmRfcHJveHkuYw0KPiAtLS0gYS9uZXQvYnJpZGdlL2JyX2FycF9uZF9w
cm94eS5jDQo+ICsrKyBiL25ldC9icmlkZ2UvYnJfYXJwX25kX3Byb3h5LmMNClsgLi4uIF0NCj4g
QEAgLTI4NCwyMCArMjg1LDIxIEBAIHN0YXRpYyB2b2lkIGJyX25kX3NlbmQoc3RydWN0IG5ldF9i
cmlkZ2UgKmJyLCBzdHJ1Y3QgbmV0X2JyaWRnZV9wb3J0ICpwLA0KPiAgCWRhZGRyID0gZXRoX2hk
cihyZXF1ZXN0KS0+aF9zb3VyY2U7DQo+ICAJbnMgPSAoc3RydWN0IG5kX21zZyAqKXNrYl90cmFu
c3BvcnRfaGVhZGVyKHJlcXVlc3QpOw0KPiAgDQo+IC0JLyogRG8gd2UgbmVlZCBvcHRpb24gcHJv
Y2Vzc2luZyA/ICovDQo+IC0JbnNfb2xlbiA9IHJlcXVlc3QtPmxlbiAtIChza2JfbmV0d29ya19v
ZmZzZXQocmVxdWVzdCkgKw0KPiAtCQkJCSAgc2l6ZW9mKHN0cnVjdCBpcHY2aGRyKSkgLSBzaXpl
b2YoKm5zKTsNCj4gLQlmb3IgKGkgPSAwOyBpIDwgbnNfb2xlbiAtIDE7IGkgKz0gKG5zLT5vcHRb
aSArIDFdIDw8IDMpKSB7DQo+IC0JCWlmICghbnMtPm9wdFtpICsgMV0gfHwgaSArIChucy0+b3B0
W2kgKyAxXSA8PCAzKSA+IG5zX29sZW4pIHsNCj4gLQkJCWtmcmVlX3NrYihyZXBseSk7DQo+IC0J
CQlyZXR1cm47DQo+IC0JCX0NCj4gLQkJaWYgKG5zLT5vcHRbaV0gPT0gTkRfT1BUX1NPVVJDRV9M
TF9BRERSKSB7DQo+IC0JCQlpZiAoKG5zLT5vcHRbaSArIDFdIDw8IDMpID49DQo+IC0JCQkgICAg
c2l6ZW9mKHN0cnVjdCBuZF9vcHRfaGRyKSArIEVUSF9BTEVOKQ0KPiAtCQkJCWRhZGRyID0gbnMt
Pm9wdCArIGkgKyBzaXplb2Yoc3RydWN0IG5kX29wdF9oZHIpOw0KPiAtCQkJYnJlYWs7DQo+IC0J
CX0NCj4gKwkvKiBEZXJpdmUgdGhlIG9wdGlvbiBsZW5ndGggZnJvbSB0aGUgSVB2NiBwYXlsb2Fk
IGxlbmd0aCBzbyB0aGF0IGFueQ0KPiArCSAqIHRyYWlsaW5nIEwyIHBhZGRpbmcgaW4gdGhlIHNr
YiBpcyBub3QgcGFyc2VkIGFzIE5EIG9wdGlvbnMuDQo+ICsJICovDQo+ICsJbnNfb2xlbiA9IG50
b2hzKGlwdjZfaGRyKHJlcXVlc3QpLT5wYXlsb2FkX2xlbikgLSBzaXplb2YoKm5zKTsNCj4gKwlp
ZiAoIW5kaXNjX3BhcnNlX29wdGlvbnMoZGV2LCBucy0+b3B0LCBuc19vbGVuLCAmbmRvcHRzKSkg
ew0KDQpXaWxsIHRoaXMgY2F1c2UgYSBsaW5rLXRpbWUgYnVpbGQgZmFpbHVyZSB3aGVuIENPTkZJ
R19CUklER0U9eSBhbmQNCkNPTkZJR19JUFY2PW0/DQpUaGUgY29tbWl0IG1lc3NhZ2UgbWVudGlv
bnMgZXhwb3J0aW5nIG5kaXNjX3BhcnNlX29wdGlvbnMoKSBhbGxvd3MgaXQgdG8gYmUNCnJlc29s
dmVkIHdoZW4gdGhlIGJyaWRnZSBpcyBidWlsdCBhcyBhIG1vZHVsZSAoQ09ORklHX0JSSURHRT1t
KS4gDQpIb3dldmVyLCBzaW5jZSBuZGlzY19wYXJzZV9vcHRpb25zKCkgaXMgZGVmaW5lZCBpbiBu
ZXQvaXB2Ni9uZGlzYy5jLCBpdCBpcw0KY29tcGlsZWQgaW50byB0aGUgaXB2Ni5rbyBtb2R1bGUg
d2hlbiBDT05GSUdfSVBWNj1tLiBJZiB0aGUgYnJpZGdlIHN1YnN5c3RlbQ0KaXMgYnVpbHQgaW4g
KENPTkZJR19CUklER0U9eSksIHZtbGludXggd29uJ3QgYmUgYWJsZSB0byByZXNvbHZlIHRoZSBz
eW1ib2wNCmF0IGxpbmsgdGltZS4NCiINCg0KQ09ORklHX0lQVjYgaXMgYnVpbHQtaW4gb25seS4g
SXQncyBhIGJvb2wsIG5vdCBhIHRyaXN0YXRlLiBTbyBpdCBpcyBub3QgYSBwb3NzaWJsZSBzY2Vu
YXJpby4NCg==
