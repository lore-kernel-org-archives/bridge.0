Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011028.outbound.protection.outlook.com [40.93.194.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D7A3EA953
	for <bridge@lists.linux.dev>; Wed,  5 Aug 2026 08:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785917207; cv=fail; b=WawQQMZwl+/07z1Wgnmjv5HrvjMfG3VUAthJpUNRFRHKD7NglJvC8Q0lc0LsT81n9rd3lCnsHpMnHMx1QKfe6yhhiwBaMZxvrdsYsOIMC1yRFYxJlRa8iNOdaYTutSgMTA48ZJx5LRSCBrQkihkKGJVXj3G8ZOA2dUrM8nn92vE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785917207; c=relaxed/simple;
	bh=A3UA4SH33CnqGtfXiqSZrgJyIU8j1Ck2L1WmwmvqwLk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kxdkcf/kyKPoLpuai5bfCLUg5PJInYYqg+QFJBSylmZaAJenYFkk8rZAS2jraM3PYHYmrb+Nz14EdQzX+ZsjKT8+5FPKCqvsI4xWvgAqFURdZfjMAtftRnVBOHP8b2FuFYwp4HzCN/zMKNhT6xagvv3QGri7cONAYQzHH9iWboU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=U9frkfi/; arc=fail smtp.client-ip=40.93.194.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="U9frkfi/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UCNjSMmqDa5R7Gk1Jfpim/O9adlMq/q5uMF+4j2DA6/T1KfhGj97j67BGvbrydvCenu4aNEowRETu1v99cfsdwcglr/fM5QJTUEwb3O1AMRVCgHVA23ER8inVO8lJEYrsXtI16lAXIavl/KrZ+vCvZutz3chDlmiAzMwoL4f6k44JjbKXfLI5H0ieS7OhOsdd/FPmc26l+IVOjSz/1GH7L/4IRqsCyk/w8VO2Qu7f4SVfSJo7CRbjXLnVRsZgVM/a2LQMLHUHSL9JCY/TUvTpAmGa0TBnTzof8vh5R+AlgX3nfLXwucYEpS2XTKIyJXMF6jR+ZLO9XcrwybV49hkDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A3UA4SH33CnqGtfXiqSZrgJyIU8j1Ck2L1WmwmvqwLk=;
 b=voIbxxx0W+9DYu4bGHVKoMjvN15CDolB2fM5ksKcU98HP80S5/ovMUvpHk4Dis7h/QzjvU2nm7D82YdD/nbjhx85gj3VaqDTpV8g1hDuez2u3lTLEnOjyCJlabMOTuYbloTGC5dFFarXoKN99OJnp53tn9N/MLRkKYZtAeJmBOLOmbmIy6EXBPNUCe49WZgBZPOks4gQ9iZcIFh8XAXq5lFF+LJ4VC4Hf3rz/yyCw1JGGWInWrVb+iObFU15H3sbcUnxxIaEk9gaM2gHaCUlPC8wa0S3wN49KZEktgyTs3lTQanQJUjrRXeVx1/JPqSt8+bGoQxD3XOCYcHMxDkmwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3UA4SH33CnqGtfXiqSZrgJyIU8j1Ck2L1WmwmvqwLk=;
 b=U9frkfi/j/u2Ox/BC9f1KK+iOBL3Fj070S5PVcr65ORnav5d37OMDLa/s/NWz1HFW4+oicYRfUs9ADd6O297N+VjwnRVUe85B7ZZ4Rt9eltLorSCzvJQwbmHmpoFl2arDU9fhd96lDubT5i0NXGlZOWDCYN8pTKhC75qSGufbFw+c0gizAcR2zCs+P6ec4R3JifTx9VPK0bprMwOdnObYgfo87+BljJVzJTNSBrN5RO2Y7l+Nqr9OEEOxCWQOepyKCqfZat/wSx2f9hIyAx72asxRjnNIYpqrXxVNgmRzRXrrh18iv57s4fVGwU/JDp93VPxHNEBCYxwj/qCt4D5gA==
Received: from SJ2PR12MB9008.namprd12.prod.outlook.com (2603:10b6:a03:543::19)
 by CH1PR12MB9576.namprd12.prod.outlook.com (2603:10b6:610:2ad::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 08:06:34 +0000
Received: from SJ2PR12MB9008.namprd12.prod.outlook.com
 ([fe80::e25c:9cce:637a:3dfd]) by SJ2PR12MB9008.namprd12.prod.outlook.com
 ([fe80::e25c:9cce:637a:3dfd%3]) with mapi id 15.21.0270.016; Wed, 5 Aug 2026
 08:06:34 +0000
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
Subject: RE: [PATCH net-next v2 2/5] ipv6: ndisc: Add ndisc_check_ns_na()
 validation helper
Thread-Topic: [PATCH net-next v2 2/5] ipv6: ndisc: Add ndisc_check_ns_na()
 validation helper
Thread-Index: AQHdIzrXnl9Pf984IUqskEIIO4Lyc7aPFykQ
Date: Wed, 5 Aug 2026 08:06:34 +0000
Message-ID:
 <SJ2PR12MB900867A45A16107E993E955BD8D32@SJ2PR12MB9008.namprd12.prod.outlook.com>
References: <20260803112505.613873-1-danieller@nvidia.com>
 <20260803112505.613873-3-danieller@nvidia.com>
In-Reply-To: <20260803112505.613873-3-danieller@nvidia.com>
Accept-Language: en-US, he-IL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR12MB9008:EE_|CH1PR12MB9576:EE_
x-ms-office365-filtering-correlation-id: 9f6e7b1e-2536-41c9-20c1-08def2c87795
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|23010399003|7416014|366016|22082099003|18002099003|5023799004|11063799006|56012099006|10067099003|4143699003|38070700021;
x-microsoft-antispam-message-info:
 52bms+fdIsS8tSK6mzLBtOCuGJJc1B9j6KxRfmQ7h8Qvy0WToDUQMQqo4fUYrB3fROQCftR075YMLTb5CbCVLnBSHt7cm7OhyOLwiMnax3ndLDNRcAHbriwy0wIKpDmjX173+K5/Kd/2z7XNmfgj5DTKHkAF7/zBkfh43NM4MtimSftkL7qCr5PbOCEHc171cQjOZf2AAbHuz+Zuyehq62DCpN0ejnwQWrQ+HWAZ4MKjwJjIBmQf4EZti6iiGL2pkhMO2bfFokhJvuAwHG4YaN25zSLy+9Ao3L5AYy3oyPGLwB8qQr2+NgSHVQ5bbTNjTNmSg+aU8fDjvVujvFglkkEgzDT7bS3BzKno3YDo4uqGyLNcU69YS7exbxti8g8NUBh+gahaKw8OhqumqxJaHwtESgyNMddik77rzmOVwiOt6OF7Devmr367FlY676bpD1rePGms5jH3X+8irAPQ8k8OpXjKKAyNiq7c4jMojxE847gP4RzJGKbm8AulDU/voq9iA+EQUJBXHQXmjARebLW0A6U8gqQgM3V7xOeCeTO2GXp8jY0hNPpRTeX106HOBWov59+Cbtbms8FL7A4BqthPqHkZvWI1qa4aVp1oWStzv80hhzia6vGpyve9oDc6a5drHJUTriFrecUCRsdAkpITxNmGBRZLm4+qiqIaPXpHKytM35nA2kRnUm65OjZMsazmaJzJxX8mN0ZgDle7AJvuRS3KwOUqviqY3xthXwQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9008.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(7416014)(366016)(22082099003)(18002099003)(5023799004)(11063799006)(56012099006)(10067099003)(4143699003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RnBIRmNkNXM5RE5iMnMwZTdVa0lHRjRYSHdyMnBCMHN0UXRiVXJhRkh4dkJk?=
 =?utf-8?B?MTl0UE5xRk5YQVZGNFQvTExFZDhvN3dmZllZcGt2U3VnTmVTWU5rdjJ4RllH?=
 =?utf-8?B?YXoyc3hDMVVGK2ZCVWxDcFJiamZBT21pQzd3M0hkNkRRcTFFdFN1bkJEbUE4?=
 =?utf-8?B?bER2aFp2N282b2F4RkQvVFVESEc2b1pOWHZtZVByQ0l3cENteFNhZEV4cEVT?=
 =?utf-8?B?NENrWDIvM21uRlZhaEM0b0NDRG1MMFdnMzRib1ZQcUFGYTJ5R3dBZ2hQazR6?=
 =?utf-8?B?TWd1d1FxL0hScjV6MlJlNGk5RlBJdWovSllMek9vODBveVVZMkg3Y0ZNdlhr?=
 =?utf-8?B?T25zblJnVzB0akZGektReldLdS9KVW9XK3JTVFpjZGw0TmhDRWFGTStOZDZs?=
 =?utf-8?B?Q3lMbmpsK0xzZWJ4MHBCM1hlSUxkM1VmcTgyK3dIOHpWY05UYVlJcC9PdFpx?=
 =?utf-8?B?SUE5U1hBSEd4MlQyUmJSb0o1eEhaVjFyOUh0dlkvV3VMbXlxMjhNdmtJa0w1?=
 =?utf-8?B?anNUN0M0cTA3NGZ2aW1DZVBKaEhVMGNoM2lhUTBBZUFZeEJWd2pTazM4QWty?=
 =?utf-8?B?bjAyWjRUZEN1cFhxekpWdDFxd05MUTN0Wm9zeVp2dHB2Zmg1VTE2d2QweUFx?=
 =?utf-8?B?TUFkcU4zNitVU0hoV2M2TlFQZmxKSTFBU0xsOFJwWGNua2xBZWJScjhsYmlX?=
 =?utf-8?B?bjhNT25WcHVLUGtpK2ZzQ29vaUd6UWRMNVc5ZnJ6YmVJKzBCemwya2tRS1ow?=
 =?utf-8?B?cFFqUDNxVjdHUDM1VkU5Wldtb1IrVmZwZytBaWF0VnVDQlRGcnZKcEwvU1dU?=
 =?utf-8?B?bVJCM2dVdXN6eEVGRHhXdm1lcXhKcHozS3lxVXYycEhOSDJhQ0RxdnJJTHZl?=
 =?utf-8?B?U2VFOUtxK1E3dkpyNTZJeklKTCtPcktrTytIdHhNMXBuanhmSDltNVk1Z2xX?=
 =?utf-8?B?bzZQSWpSSUxZRXpScXJNdHh6NXZUaUcxaW8rc3FNYXhOZ1RPMkV2WGNJc3VG?=
 =?utf-8?B?QWs0ckZWbDJ0TTRlazJFSVgzMHhWRVJGSjIwU2dsM3B5Yzh1S3JSUG8rbldF?=
 =?utf-8?B?d295VDJ4TDd3V1Q4T0lhUk82Q3o5N2VIWHU2K0gvSFNLaVRBMDBwOHZnc25x?=
 =?utf-8?B?KzNDN254VC9ScFJYNVRnRVdjUjJpMi9MZ1EyMUM4elNtUi8xc1pWM1lxbTNW?=
 =?utf-8?B?U1kxS242Q3crNmRwZEZMZk1DbXFrZ2R1cWtGcGpoWmJqMW42d0xmaExRVFFC?=
 =?utf-8?B?T2UzT1FVRGJBMU96b0paUEdVSjR5QTRVRnkxeVY2NkJyQnpVejJweGJnYm1l?=
 =?utf-8?B?WWNOSDFIQUpDcStqRUVvRmkxRHR3a3VKMFlpL1ZpRi9rK1BEZHVCM3dOeVZQ?=
 =?utf-8?B?SXlXcFdmeW9NQTl3LzdPcFVzWmw0eVNnRzlhMVFDT3JYelVFNHFuRXR5aTl4?=
 =?utf-8?B?Z2tST0F0NnVBR2l5cm4wRTVobUFSNmQxWWN5SS83YzlLT1AzWDFsSDNEZ0VY?=
 =?utf-8?B?NnRTcUZZbjROeDdyczkyTVZQY1ZXNlBzbFBnRWU2dUVUTFpub2hQUlhaR1Uz?=
 =?utf-8?B?VTdhbUpmT1R6YXhvd0VOYWYyVkVkTkk3SkxDc21yd2R3Y2ZPMFl2Q253OW5Q?=
 =?utf-8?B?Ni9Qc1krbTJsSWdRYTBsWWhZUElYdm5JNEZKVzlpOVY2OHFpOW5MR1pxRTFQ?=
 =?utf-8?B?bWJDY3NzK2NpRFQwM0VEUjl1N0VQNFR1dVlWZkswcTJOTUQ4a0VUeU0xa3By?=
 =?utf-8?B?dENEUGwyZWZLYXp5UGhoTXJOUzB2bzF4Z0I5TlRIbXdEUlY0b1JEZXFJdDJi?=
 =?utf-8?B?WGZpSmZXYTNuZTVyZDhUbVVXNTNlZjlIRVpuMWIra2F5a21TdmV5WG9qZkhh?=
 =?utf-8?B?WXpWYmtqVDdKb2R2dG5pMzZNRndYMjNEU1RYZk05b2hsUG8vanZ3aTlOeUpm?=
 =?utf-8?B?bFFPNDhxRDhMbTFxakhTWlVzeVhWckJHTnd0SmZZRWRjMW5BTVNiT3BPWUZz?=
 =?utf-8?B?aVVTZHEzbUtkc0g3amwyc3JiOGg0dk04d0JqZkFrRWN2bnBMNGNYeWhLeVoy?=
 =?utf-8?B?aGorL2FQVCs4YUkvMGpHa2J1STRUTjlHaUlBN2x2dlVzclZCd3NkbUVGR2JI?=
 =?utf-8?B?a0lYaExQSldJYzNZbVZxT0kvdW1KY29PaUJqUlkxTHF3Um9hVVV0RnluUTc3?=
 =?utf-8?B?SUJ0NVdMd3dJTnp3eEFOYjJUUnRVcFVEeEdQa203TTRob3lBaW9kcnNMdytV?=
 =?utf-8?B?c3NZTk54aWEvcjZCK0JkMW55RUVWV1ZKNGQ0dWtvdjZzd0JGWC8rcE1LUndl?=
 =?utf-8?Q?2s4kYpmV9+FDk73LiA?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f6e7b1e-2536-41c9-20c1-08def2c87795
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2026 08:06:34.5695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xRe5hybm6XhH0ObJVSCWh0B9NzFyjcJ/lk6SAUgKoAuq2AH0UHLRdy3DNI76qjZx179BmRj8Z43Q5HofcF/X4Q==
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
amVjdDogW1BBVENIIG5ldC1uZXh0IHYyIDIvNV0gaXB2NjogbmRpc2M6IEFkZCBuZGlzY19jaGVj
a19uc19uYSgpDQo+IHZhbGlkYXRpb24gaGVscGVyDQo+IA0KPiBBZGQgbmRpc2NfY2hlY2tfbnNf
bmEoKSwgYSBzdGFuZGFsb25lIE5TL05BIHBhY2tldCB2YWxpZGF0b3IgbW9kZWxlZCBhZnRlcg0K
PiBpcHY2X21jX2NoZWNrX21sZCgpLiBJdCBwZXJmb3JtcyB0aGUgUkZDIDQ4NjEgc2VjdGlvbiA3
LjEuMSAoTmVpZ2hib3INCj4gU29saWNpdGF0aW9uKSBhbmQgNy4xLjIgKE5laWdoYm9yIEFkdmVy
dGlzZW1lbnQpIG1hbmRhdG9yeSBjaGVja3MgdGhhdCBhcmUNCj4gcmVsZXZhbnQgZm9yIHNvZnR3
YXJlIG9wZXJhdGluZyBhdCB0aGUgYnJpZGdlIGxldmVsLCB3aGVyZSBwYWNrZXRzIGJ5cGFzcyB0
aGUNCj4gbm9ybWFsIElQdjYgc3RhY2sgcGF0aDoNCj4gDQo+ICAtIEhvcCBMaW1pdCBtdXN0IGJl
IDI1NSAocGFja2V0IHdhcyBub3QgZm9yd2FyZGVkIGJ5IGEgcm91dGVyKQ0KPiAgLSBJQ01QdjYg
Y2hlY2tzdW0gaXMgdmFsaWQNCj4gIC0gSUNNUCBDb2RlIGlzIDANCj4gIC0gSUNNUCBsZW5ndGgg
aXMgYXQgbGVhc3QgMjQgb2N0ZXRzIChzaXplb2Yoc3RydWN0IG5kX21zZykpDQo+ICAtIFRhcmdl
dCBBZGRyZXNzIG11c3Qgbm90IGJlIGEgbXVsdGljYXN0IGFkZHJlc3MNCj4gIC0gQWxsIGluY2x1
ZGVkIG9wdGlvbnMgaGF2ZSBhIGxlbmd0aCB0aGF0IGlzIGdyZWF0ZXIgdGhhbiB6ZXJvDQo+ICAt
IE5TL0RBRDogZGVzdGluYXRpb24gbXVzdCBiZSBhIHNvbGljaXRlZC1ub2RlIG11bHRpY2FzdCBh
ZGRyZXNzDQo+ICAtIE5TL0RBRDogbm8gU291cmNlIExpbmstTGF5ZXIgQWRkcmVzcyBvcHRpb24g
d2hlbiBzb3VyY2UgaXMgdW5zcGVjaWZpZWQNCj4gIC0gTkE6IFNvbGljaXRlZCBmbGFnIG11c3Qg
YmUgMCB3aGVuIElQIERlc3RpbmF0aW9uIGlzIG11bHRpY2FzdA0KPiANCj4gT24gc3VjY2VzcyB0
aGUgZnVuY3Rpb24gc2V0cyB0aGUgc2tiIHRyYW5zcG9ydCBoZWFkZXIgYW5kIHJldHVybnMgMCwg
bWF0Y2hpbmcNCj4gdGhlIGNvbnZlbnRpb24gb2YgaXB2Nl9tY19jaGVja19tbGQoKS4NCj4gDQo+
IFJldmlld2VkLWJ5OiBQZXRyIE1hY2hhdGEgPHBldHJtQG52aWRpYS5jb20+DQo+IEFja2VkLWJ5
OiBOaWtvbGF5IEFsZWtzYW5kcm92IDxyYXpvckBibGFja3dhbGwub3JnPg0KPiBTaWduZWQtb2Zm
LWJ5OiBEYW5pZWxsZSBSYXRzb24gPGRhbmllbGxlckBudmlkaWEuY29tPg0KPiAtLS0NCg0KU2Fz
aGlrbyB3cm90ZToNCg0KIiANCi0tLSBQYXRjaCBbMl06IFtQQVRDSCBuZXQtbmV4dCB2MiAyLzVd
IGlwdjY6IG5kaXNjOiBBZGQgbmRpc2NfY2hlY2tfbnNfbmEoKSB2YWxpZGF0aW9uIGhlbHBlciAt
LS0NCmNvbW1pdCA0MDMxZTA1MTA2MDIzOGQ5YzU5MzIxZWIzMTcxYzAwNjM0MTc0MTgyDQpBdXRo
b3I6IERhbmllbGxlIFJhdHNvbiA8ZGFuaWVsbGVyQG52aWRpYS5jb20+DQppcHY2OiBuZGlzYzog
QWRkIG5kaXNjX2NoZWNrX25zX25hKCkgdmFsaWRhdGlvbiBoZWxwZXINClRoaXMgY29tbWl0IGFk
ZHMgbmRpc2NfY2hlY2tfbnNfbmEoKSwgYSBzdGFuZGFsb25lIHZhbGlkYXRvciBmb3IgSVB2Ng0K
TmVpZ2hib3IgU29saWNpdGF0aW9uIGFuZCBOZWlnaGJvciBBZHZlcnRpc2VtZW50IHBhY2tldHMu
IEl0IHBlcmZvcm1zDQptYW5kYXRvcnkgUkZDIDQ4NjEgY2hlY2tzIGZvciBzb2Z0d2FyZSBvcGVy
YXRpbmcgYXQgdGhlIGJyaWRnZSBsZXZlbC4NCj4gZGlmZiAtLWdpdCBhL25ldC9pcHY2L25kaXNj
X3Nub29wLmMgYi9uZXQvaXB2Ni9uZGlzY19zbm9vcC5jDQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0
DQo+IGluZGV4IDAwMDAwMDAwMDAwMDAuLmZhODY1MjhkNWNmZWUNCj4gLS0tIC9kZXYvbnVsbA0K
PiArKysgYi9uZXQvaXB2Ni9uZGlzY19zbm9vcC5jDQo+IEBAIC0wLDAgKzEsMTkwIEBADQo+ICsv
LyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vbmx5DQo+ICsNCj4gKyNpbmNsdWRl
IDxsaW51eC9za2J1ZmYuaD4NCj4gKyNpbmNsdWRlIDxuZXQvYWRkcmNvbmYuaD4NCj4gKyNpbmNs
dWRlIDxuZXQvaXA2X2NoZWNrc3VtLmg+DQo+ICsjaW5jbHVkZSA8bmV0L2lwdjYuaD4NCj4gKyNp
bmNsdWRlIDxuZXQvbmRpc2MuaD4NCj4gKw0KPiArc3RhdGljIGludCBuZGlzY19jaGVja19pcDZo
ZHIoc3RydWN0IHNrX2J1ZmYgKnNrYikNCj4gK3sNCj4gKwljb25zdCBzdHJ1Y3QgaXB2NmhkciAq
aXA2aDsNCj4gKwl1bnNpZ25lZCBpbnQgb2Zmc2V0LCBsZW47DQo+ICsNCj4gKwlvZmZzZXQgPSBz
a2JfbmV0d29ya19vZmZzZXQoc2tiKSArIHNpemVvZigqaXA2aCk7DQo+ICsJaWYgKCFwc2tiX21h
eV9wdWxsKHNrYiwgb2Zmc2V0KSkNCj4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+ICsNCj4gKwlpcDZo
ID0gaXB2Nl9oZHIoc2tiKTsNCj4gKw0KPiArCWlmIChpcDZoLT52ZXJzaW9uICE9IDYpDQo+ICsJ
CXJldHVybiAtRUlOVkFMOw0KPiArDQo+ICsJaWYgKGlwNmgtPm5leHRoZHIgIT0gSVBQUk9UT19J
Q01QVjYpDQo+ICsJCXJldHVybiAtRU5PTVNHOw0KDQpEb2VzIHRoaXMgc3RyaWN0IGNoZWNrIGFs
bG93IGF0dGFja2VycyB0byBieXBhc3MgYnJpZGdlLWxldmVsIE5EIHNlY3VyaXR5DQptZWNoYW5p
c21zIHVzaW5nIElQdjYgZXh0ZW5zaW9uIGhlYWRlcnM/DQpJZiBhIHNwb29mZWQgTmVpZ2hib3Ig
U29saWNpdGF0aW9uIG9yIEFkdmVydGlzZW1lbnQgcGFja2V0IGlzIHNlbnQgd2l0aCBhDQp2YWxp
ZCBJUHY2IGV4dGVuc2lvbiBoZWFkZXIgKGxpa2UgRGVzdGluYXRpb24gT3B0aW9ucyksIHRoaXMg
Y2hlY2sgd2lsbCANCnJldHVybiAtRU5PTVNHLiBBIGJyaWRnZSB3b3VsZCB0aGVuIGxpa2VseSB0
cmVhdCB0aGUgcGFja2V0IGFzIGEgbm9uLU5EDQptZXNzYWdlIGFuZCBmb3J3YXJkIGl0IG5vcm1h
bGx5LCBieXBhc3Npbmcgc2VjdXJpdHkgbWVjaGFuaXNtcyBsaWtlDQpORCBzbm9vcGluZyBvciBh
bnRpLXNwb29maW5nLg0KVGhlIHRhcmdldCBob3N0J3MgSVB2NiBzdGFjayB3aWxsIHRyYXZlcnNl
IHRoZSBleHRlbnNpb24gaGVhZGVycyBhbmQNCnN1Y2Nlc3NmdWxseSBwcm9jZXNzIHRoZSBtYWxp
Y2lvdXMgTkQgcGF5bG9hZC4gU2hvdWxkIHRoaXMgdXNlDQppcHY2X3NraXBfZXh0aGRyKCkgdG8g
cHJvcGVybHkgdHJhdmVyc2UgdG8gdGhlIElDTVB2NiBoZWFkZXIgaW5zdGVhZD8NCiINCg0KVGhl
IGNhbGxlcnMgb25seSByZWFjaCB0aGlzIGFmdGVyIGNoZWNraW5nIGlwdjZfaGRyKHNrYiktPm5l
eHRoZHIgPT0gSVBQUk9UT19JQ01QVjYsIHNvIGEgcGFja2V0IHdpdGggYW4gZXh0ZW5zaW9uIGhl
YWRlciAobmV4dGhkciAhPSBJQ01QVjYpIG5ldmVyIGdldHMgaGVyZSBpbiB0aGUgZmlyc3QgcGxh
Y2UuDQpBbmQgaWYgc3VjaCBhIHBhY2tldCB3ZXJlIGV2ZXIgc2tpcHBlZCwgaXQncyBqdXN0IG5v
dCBzdXBwcmVzc2VkIGFuZCBmbG9vZHMgbm9ybWFsbHkgKHRoZSBkZWZhdWx0IHdpdGhvdXQgdGhp
cyBmZWF0dXJlKSwgc28gdGhlcmUncyBubyBieXBhc3MuIA0K
