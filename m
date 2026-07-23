Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010006.outbound.protection.outlook.com [52.101.46.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897ED3451C1
	for <bridge@lists.linux.dev>; Thu, 23 Jul 2026 06:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784788812; cv=fail; b=FRwsn09IcOquLXbfyvKsk0aoBlBk7RFqNd3ghuNqG/8a87JCQWTrLPufRA7SS5tc7oqLmUp6E36FGKrO1A77ql/4332YakJ7qAnbmbwaPQX3jENmASfoa18vjDINC9mmcQ2iV9+mYiHySQ/0oBCrsOzctyj0VnYQkQp7Hn3h3M0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784788812; c=relaxed/simple;
	bh=etwc2h2z38tawO1MPqfEisBBYRTPplNaiJ50sJHl9nE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Se+dqJgBLh8w5DwKkBBTYJFGHzpFca6QmjoDoN3S0ZxxHgBIgccbuZQdog3URH2eRwFfsB6xRFb83RQzfgDqe14xcjPvhdo3YmAsvWpBltrGgfvZRt+pxt+Szyotsc4HUrqFgHbtWehafjbXreAR3N5nKCzIeqNjjpX9b1rcrOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=g+UU4C7j; arc=fail smtp.client-ip=52.101.46.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="g+UU4C7j"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IL3ebPeGgdtwPvMI8/XP+Gxf1Lnq/8hfdr7allq0cdHofZusgRJHoqpqR2JT4IArehw1BkHtxWDdYwXgL1D+qlfDpZGtFfhZzzHMh72J4viHP+TOCvwvKzK7iETjKhn2Ob3KMVVF26oDa6wQX0FuiJONok8K55cZdfi1Idlmxwh2CUtWDq9sJ1lEM5L05VCIdT7l6aDtDJeje9AdaODdm7d3kU/qqVnzjAGzP1frLEkxw02v937XbSEyKjGJ34BGEfwfDF6pqCS1sBDIdzhuwtYDPCDiff1pMMRqeuAEHug1jc1o3VFoO38S72qnhEA/oTtH6gl7w+s3kkPx8SKdNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=etwc2h2z38tawO1MPqfEisBBYRTPplNaiJ50sJHl9nE=;
 b=U0Px7eijlmZi3+g1nOlypg9ryiKCUH9YOM2JygldipbQAgm2ylWef0hLox6QHagg6mCKchm8+PhMBPativmLJLQdazVXD3D7H2oRSycxwHbrfmS5D7TKInFOlQP5Rvp5miNM26gv/4hVI8IxZnakfQCXUBiPJ17lj1oJyQrDMinpJLYAXRvQWttGuIYJZrYc2O6KmNBN8DuwvMJM+hPK0L5H+WrJzCxec8z1qSrSEGRGuz6giM4R87O4CD5GpDbqTQ73FusouBUjCZ/7PSGjc51t1KKrFV1LN6SK7vXxoH+qD6BecQvuYPeosXSQKrBWtVhR65t1zSL0Ej+7VnM4ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=etwc2h2z38tawO1MPqfEisBBYRTPplNaiJ50sJHl9nE=;
 b=g+UU4C7jMp9IUkxsPEyQ/L73+ms5wvZEqhhAwVJRsQzdaaV2arzg5vt7fSk29/W/JJxfdAMhd7avHOv0JvDITS/bHDfPscfCr6jc2pYx7N5tp8LrzmDY+WcYcaRrYaW9b22H8cgLZsELxmhnGejGU3/l9Nbc6u/ZMKpoUgnyKy6c/QiZKuH3ROE9nmpsChOQpuaxIBvqiLw9HEX+X9Nto+t0e0rmgjyWxMuC7kEIiVk+i4P4zkNuAx5afGuRT5vQ6xZd9QqFaoSKZu4kQSFskOA4xOCl7E76Ntcpu9Qg8rPs6zFkE7PlkvcFSgnENI5LM6crzH91JRwWbCJHLJ92cQ==
Received: from SJ2PR12MB9008.namprd12.prod.outlook.com (2603:10b6:a03:543::19)
 by SA1PR12MB7125.namprd12.prod.outlook.com (2603:10b6:806:29f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 06:40:05 +0000
Received: from SJ2PR12MB9008.namprd12.prod.outlook.com
 ([fe80::e25c:9cce:637a:3dfd]) by SJ2PR12MB9008.namprd12.prod.outlook.com
 ([fe80::e25c:9cce:637a:3dfd%3]) with mapi id 15.21.0223.017; Thu, 23 Jul 2026
 06:40:05 +0000
From: Danielle Ratson <danieller@nvidia.com>
To: Nikolay Aleksandrov <razor@blackwall.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "dsahern@kernel.org" <dsahern@kernel.org>, Ido Schimmel
	<idosch@nvidia.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "ja@ssi.bg" <ja@ssi.bg>, Petr Machata
	<petrm@nvidia.com>, "fw@strlen.de" <fw@strlen.de>, "kuniyu@google.com"
	<kuniyu@google.com>, "bridge@lists.linux.dev" <bridge@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next 0/5] bridge: Validate and clean up IPv6 neighbour
 suppression
Thread-Topic: [PATCH net-next 0/5] bridge: Validate and clean up IPv6
 neighbour suppression
Thread-Index: AQHdF4N3NVckkvm8GUmUMQnLXemfPLZ2JfSAgAAk7+A=
Date: Thu, 23 Jul 2026 06:40:05 +0000
Message-ID:
 <SJ2PR12MB9008CFB1549DE9F3B7AC23F0D8C02@SJ2PR12MB9008.namprd12.prod.outlook.com>
References: <cover.1784463131.git.danieller@nvidia.com>
 <ad48b1da-50bd-4b79-943a-0a3331191b7c@blackwall.org>
In-Reply-To: <ad48b1da-50bd-4b79-943a-0a3331191b7c@blackwall.org>
Accept-Language: en-US, he-IL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR12MB9008:EE_|SA1PR12MB7125:EE_
x-ms-office365-filtering-correlation-id: 477031b0-8152-44e4-88cc-08dee8853b4d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|366016|7416014|376014|38070700021|4143699003|11063799006|56012099006|10067099003|6133799003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 PyadmISwuaP/8QaLeBE+FCDY7wo9mclQSy02+urHnOhqBEoPEo8KLkUy8nxQTw3s9LYUnoDZfdLMLwVunSzUrcLY8Q7ZzbHjB5OngbbMMTdNoZxF9390iSXEPmWInVPSZXtPe36e9O14UF8uLej38h3GTM2/d6wtGmClCNudPYM6/Y6cAVlSJmUzW8Rllw2NSq40+90iok84NXMeQM/XOTfxQ0vCVa+cqYT2TjqHZTTxjiHTBrAXY0t70Ofr+JTTpMY74jQGSZHetkTqf3nM2BVpdaR00h3zisRAmfhM/5XsNirRif76a1aNrMjLDi7RPiQ0UzIimRoKuc/egO5oT3me96hR/FUT4/JTSwsF1sS9oFItswtBZVBmg3O+exzJpPN2TsPKkgxIA7/lTlOwlvcApcMTffU3Cku7rNZtHaLV1mhMbMj7MOZYJ5wzFen2yKNjuXXV92PM93zDEOBzp9RCqCfeeTM5tHdyH09ZX9z1oDzydqmLJ6R2MWIWxbuA2gVD2fioMdr2fJekmnb5LfxkN51pv7KKQ/zEVmly7867DTnpZnAsdq86/tAan2iixm93aVKsDrB+tkHcdrdA5ehNMMMdHZyzwZe5gp1pNvf9gWZTTRAWDWMuPz8Qs/21slOZiy3KAD6EqASjnxMXzNK70xHwsNhyOQ9rkxGUYtYF05vQS9vmNF7X+P9NAjB2QunrE1rVM0D+S0nSweVmogQm9p6fA+4z6SDwaJAg+/I=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9008.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(38070700021)(4143699003)(11063799006)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q2xldlIzM3cwcVRKVFRCVlgrZzhXY3FpWHBOMnJqMFB0Kzk1REhQSUVVSWpK?=
 =?utf-8?B?RTlHclY0TXpDUmRzTEtKMU16SEdFZmlKRFJ6QzJ4RW44aEZSbjFpZ0VuQlN5?=
 =?utf-8?B?S1dDL3d6MG4zaVltZXp5aTl6NVVxNU9WejFtTkJuY25jaE1VSzNjcFIvN29t?=
 =?utf-8?B?R0wvbW1wZUN2Z1dGNVJvY0Z0L3ZhQmoxMU9JYyt4bGxXRWtOci9IbE41ak1J?=
 =?utf-8?B?M251SDI0RTRnNFdrNnord2pkVGxFV2UvTnc5VUZ1V1ZCTUZwM3RhZHJwT2gv?=
 =?utf-8?B?YVNQWG1rUG0zdnljbHVTdDJua0FRREtKWTZPNEZhL0hQUkxkd0NSazhPdUlH?=
 =?utf-8?B?VkozZVJyaEhOeXBYYjhJRXpHODZMdVFnRVYwUnJuRk9Xd2dhQXhkSzFPUHlC?=
 =?utf-8?B?OTFwNm1QQWJoTS9SMmE0VmpuYUtCajJZNXQrR2oxSmxwRGdXZWpNOEJRWDhX?=
 =?utf-8?B?SFE2bndTVVRJL3BXTldPMTdvWDFJeTVKUExJRVpkUG41NzBKa0lOY3dmekhk?=
 =?utf-8?B?aHdOSUFXMXUyR1I0MTFxVDBObFZjdUVrRHpkcWlsU3BtUDRYSEhJWEsxanBX?=
 =?utf-8?B?djBuWUM1NzhxNGhiUHNSYzhkQ1VacEp0c2hsUWNFQVdZaHNjY2JHdFRiZWNJ?=
 =?utf-8?B?d2xnRWFoWXB5OUlEZzB0Sm1ZSzVJT0w5U2FReTVGb1VzRG5ZbVFCcUI1L2hL?=
 =?utf-8?B?TDdjdllCN2ZLZCt5TFRZc3JwdFZIZmsrbmZNL2xIYjB5K3puOGYySDAwSGVq?=
 =?utf-8?B?SzRqUTJzWldrcnp6MkM1eDE2Vm00K2FNR1lRZ3l1UlE5bkxCWUJJL0pDWkpH?=
 =?utf-8?B?RVNWRUhIQXU3a01POTJzM1V6cUc2bWdvcW9CRjE2QkVGaUI2VTZMbURUSHgy?=
 =?utf-8?B?Z1lIQ3RtekltUFJUS0k1ak9jbUJiR29GZFZlemRnZWJqUGdZZ2t4Y2pKNkpv?=
 =?utf-8?B?UUF4Y1hSSXZHMk45d2gvTmx0M09CKzZpRis5Z24xYnFpRWwvcUpkMG0xRWpQ?=
 =?utf-8?B?ZUc5UTByd1V6dXlLUlV2VFlCdjdWOFMvUDhkc3JhQXVEb1BzYzFZWTN0Qm41?=
 =?utf-8?B?aU5PYjUzWjJ2Tk1WVkozWnIyZWJGd1djUG5Iais4elBia2kzQXBjRldtMG5V?=
 =?utf-8?B?QWJITG1MWHVzK2tCVVdzN083UG9ldmE3YXRmK0d2VmEwZkpPejFiNlRhcldR?=
 =?utf-8?B?WDVpbWdkK0VGdzYrQ3Q5aTE3ZDI3bUtlL2ZQTmU3OG9ONkw4SkRjY0Z2bitl?=
 =?utf-8?B?dzZQNkw2MzlOb0xGUmZ0TDlvOUFzQjBwYUpBWXBmS0RaK3lHa2hrTytrWHBT?=
 =?utf-8?B?T1dGb0MwbkhYNEpXeUhaaEJxeU5NUjluUndmQ05xRjMwZ1BBcUdTcVhxbytL?=
 =?utf-8?B?b0hHbkpxTkxOdkIwYy9TamRNZ3hFM3lyTmhSL2JsWk1SdXlZek0zK3VIcGdj?=
 =?utf-8?B?c1dieVBMd2lHRUVTSlhQSUs2c1EwcWMvbitoWE5RbHlSbUgxRHdxMkRFbVRU?=
 =?utf-8?B?Z3Vvd1BHY3VkZTFXeWhMenk4eWJML3cyRFRMeVRIUll4cWF5WExOdFltYnpZ?=
 =?utf-8?B?OXlHdk9ScW12RGlUU0p1MSszTS94Z2JBeVhMRjFiUWdlNmdhVElWek1rUERC?=
 =?utf-8?B?ZW1tMW9CL2VNakZCblovcmxOZzJRR2tXSUdZdjdWQjlNUVJuZ3hWZU5ZUjRI?=
 =?utf-8?B?RDh5V3Fhb2IyM1FiZUZRMG9Bbk5xSm90TGhJdTFoSlBWdmt4SnRQazdaVURh?=
 =?utf-8?B?UHUvVXlFZnZzQ3Boa0lZWlN4RGxKN3FTYmxBSlJtQkxMQno4YWRXNCtya1JG?=
 =?utf-8?B?Nm8xN21mNXdtK283Q0UwanVVdjFhd2dyNXR6MU0ramcvYVNQSWhvRVE4NTR0?=
 =?utf-8?B?TnRNL00vMHlhZjQ4WG5GZVFhQUNxQnh0dGw5SHhRVkY0NkhpaXBpM3BBK3VL?=
 =?utf-8?B?TzdBRmpYWmJEVWsrUTBkcmdjZzlTcTVJaWFHYTRnWjhXd3J1RlpyOVdOZHZh?=
 =?utf-8?B?T1RTMjFjbG5rQ2VYS0VvMnUrOGZVQzZlRHRUbmxDd05YL0htQnR6RzJORW1L?=
 =?utf-8?B?WUlxbmRkRU1YcDBhVWFMK25xR3pBWkgwN0YwajJEK25keFFYOUJNZFQ4eGVt?=
 =?utf-8?B?aFBaYit6OTk2dWJxMUNQQ2pRU0lHZDlXMlNQVzN1cnErSHQwZWpHK213TC9H?=
 =?utf-8?B?Njcwa0N1Y3dMZzdBWHhEdjRTcDR2OFEvajNISDhaeGtEK1dTdjVYSVJJaXJQ?=
 =?utf-8?B?RTNaQU5TWlJBcHJmVGRGdUVudmdyd2dkOVRoYU9MTE9aMS8zanhUMlE3Yy92?=
 =?utf-8?Q?/+8Lv1R8aF78IycK9O?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 477031b0-8152-44e4-88cc-08dee8853b4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2026 06:40:05.6376
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3r/YV4LRapfBUYPi3FwXqGRw37amlkIDCE7S4pw/F8hnRip9aZQqgvX0lv3Mz4jGt31am9TMd0//K+KbypmVOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7125

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBOaWtvbGF5IEFsZWtzYW5kcm92
IDxyYXpvckBibGFja3dhbGwub3JnPg0KPiBTZW50OiBNb25kYXksIDIwIEp1bHkgMjAyNiAxMjoz
MQ0KPiBUbzogRGFuaWVsbGUgUmF0c29uIDxkYW5pZWxsZXJAbnZpZGlhLmNvbT47IG5ldGRldkB2
Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IGRzYWhlcm5Aa2VybmVsLm9yZzsgSWRvIFNjaGltbWVsIDxp
ZG9zY2hAbnZpZGlhLmNvbT47DQo+IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IGVkdW1hemV0QGdvb2ds
ZS5jb207IGt1YmFAa2VybmVsLm9yZzsNCj4gcGFiZW5pQHJlZGhhdC5jb207IGhvcm1zQGtlcm5l
bC5vcmc7IGphQHNzaS5iZzsgUGV0ciBNYWNoYXRhDQo+IDxwZXRybUBudmlkaWEuY29tPjsgZndA
c3RybGVuLmRlOyBrdW5peXVAZ29vZ2xlLmNvbTsNCj4gYnJpZGdlQGxpc3RzLmxpbnV4LmRldjsg
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIG5ldC1u
ZXh0IDAvNV0gYnJpZGdlOiBWYWxpZGF0ZSBhbmQgY2xlYW4gdXAgSVB2Ng0KPiBuZWlnaGJvdXIg
c3VwcHJlc3Npb24NCj4gDQo+IE9uIDE5LzA3LzIwMjYgMTY6MzQsIERhbmllbGxlIFJhdHNvbiB3
cm90ZToNCj4gPiBUaGUgYnJpZGdlIGltcGxlbWVudHMgSVB2NiBuZWlnaGJvdXIgc3VwcHJlc3Np
b24gYnkgc25vb3BpbmcgTmVpZ2hib3VyDQo+ID4gU29saWNpdGF0aW9uIGFuZCBOZWlnaGJvdXIg
QWR2ZXJ0aXNlbWVudCBtZXNzYWdlcywgYnV0IGl0IHByZXZpb3VzbHkNCj4gPiBvbmx5IGNoZWNr
ZWQgdGhlIElDTVB2NiB0eXBlIGFuZCBjb2RlIGJlZm9yZSBhY3Rpbmcgb24gdGhlbS4gVGhpcw0K
PiA+IGxlYXZlcyBpdCBvcGVuIHRvIGFjdGluZyBvbiBtYWxmb3JtZWQgb3Igc3Bvb2ZlZCBwYWNr
ZXRzIHRoYXQgYW55IFJGQw0KPiA+IDQ4NjEgY29tcGxpYW50IG5vZGUgc2hvdWxkIHJlamVjdCwg
YW5kIHRoZSBvcHRpb24gcGFyc2luZyBpbg0KPiA+IGJyX25kX3NlbmQoKSBvcGVuLWNvZGVzIGEg
bG9vcCB0aGF0IGhhcyBoaXN0b3JpY2FsbHkgYmVlbiBhIHNvdXJjZSBvZiBidWdzLg0KPiA+DQo+
ID4gVGhpcyBzZXJpZXMgaGFyZGVucyBhbmQgY2xlYW5zIHVwIHRoYXQgcGF0aDoNCj4gPg0KPiA+
IEFkZCBuZGlzY19jaGVja19uc19uYSgpLCBhIHN0YW5kYWxvbmUgTlMvTkEgdmFsaWRhdG9yIG1v
ZGVsZWQgYWZ0ZXINCj4gPiBpcHY2X21jX2NoZWNrX21sZCgpLCBpbXBsZW1lbnRpbmcgdGhlIFJG
QyA0ODYxIHNlY3Rpb24gNy4xLjEgLyA3LjEuMg0KPiA+IG1hbmRhdG9yeSByZWNlaXZlIGNoZWNr
cyAoaG9wIGxpbWl0LCBjaGVja3N1bSwgY29kZSwgbGVuZ3RoLCB0YXJnZXQNCj4gPiBhbmQgb3B0
aW9uIHZhbGlkYXRpb24pLiBXaXJlIHRoZSBicmlkZ2UgaW50byBpdCBzbyBOUy9OQSBtZXNzYWdl
cyBhcmUNCj4gPiB2YWxpZGF0ZWQgdG8gdGhlIHNhbWUgc3RhbmRhcmQgTUxEIGFscmVhZHkgZW5q
b3lzLg0KPiA+DQo+ID4gUmVwbGFjZSB0aGUgbWFudWFsIE5EIG9wdGlvbiBwYXJzaW5nIGxvb3Ag
aW4gYnJfbmRfc2VuZCgpIHdpdGgNCj4gPiBuZGlzY19wYXJzZV9vcHRpb25zKCkgYW5kIG5kaXNj
X29wdF9hZGRyX2RhdGEoKSwgYW5kIGxpbmVhcml6ZSB0aGUgc2tiDQo+ID4gb25jZSBpdCBoYXMg
YmVlbiB2YWxpZGF0ZWQgYXMgYW4gTlMvTkEgbWVzc2FnZSBzbyB0aGF0IHRoaXMgYW5kIGFueQ0K
PiA+IGZ1dHVyZSBORCBtZXNzYWdlIGhhbmRsaW5nIG9wZXJhdGUgb24gYSBsaW5lYXIgYnVmZmVy
LiBUaGUgZmlyc3QgcGF0Y2gNCj4gPiBpcyBhIHNtYWxsIHByZXBhcmF0b3J5IGNsZWFudXAgdGhh
dCBkcm9wcyB0aGUgbm93LXVubmVjZXNzYXJ5DQo+ID4gc2tiX2hlYWRlcl9wb2ludGVyKCkgZmFs
bGJhY2sgZnJvbSBicl9pc19uZF9uZWlnaF9tc2coKS4NCj4gPg0KPiA+IE5vIGZ1bmN0aW9uYWwg
Y2hhbmdlIGlzIGludGVuZGVkIGZvciB3ZWxsLWZvcm1lZCBwYWNrZXRzLg0KPiA+DQo+ID4gUGF0
Y2hzZXQgb3ZlcnZpZXc6DQo+ID4gUGF0Y2ggIzE6IGRyb3AgdGhlIHNrYl9oZWFkZXJfcG9pbnRl
cigpIGZhbGxiYWNrLg0KPiA+IFBhdGNoZXMgIzItIzM6IGFkZCBuZGlzY19jaGVja19uc19uYSgp
IGFuZCB2YWxpZGF0ZSBOUy9OQSB3aXRoIGl0Lg0KPiA+IFBhdGNoICM0OiBsaW5lYXJpemUgb25j
ZSB0aGUgTkQgbWVzc2FnZSB0eXBlIGlzIHZhbGlkYXRlZC4NCj4gPiBQYXRjaCAjNTogcGFyc2Ug
b3B0aW9ucyB2aWEgbmRpc2NfcGFyc2Vfb3B0aW9ucygpLg0KPiA+DQo+ID4gRGFuaWVsbGUgUmF0
c29uICg1KToNCj4gPiAgICBicmlkZ2U6IFVzZSBkaXJlY3QgcG9pbnRlciBpbiBicl9pc19uZF9u
ZWlnaF9tc2coKQ0KPiA+ICAgIGlwdjY6IG5kaXNjOiBBZGQgbmRpc2NfY2hlY2tfbnNfbmEoKSB2
YWxpZGF0aW9uIGhlbHBlcg0KPiA+ICAgIGJyaWRnZTogVmFsaWRhdGUgTlMvTkEgbWVzc2FnZXMg
dXNpbmcgbmRpc2NfY2hlY2tfbnNfbmEoKQ0KPiA+ICAgIGJyaWRnZTogTGluZWFyaXplIHNrYiBv
bmNlIHRoZSBORCBtZXNzYWdlIHR5cGUgaXMgdmFsaWRhdGVkDQo+ID4gICAgYnJpZGdlOiBVc2Ug
bmRpc2NfcGFyc2Vfb3B0aW9ucygpIHRvIHBhcnNlIE5EIG9wdGlvbnMgaW4NCj4gPiBicl9uZF9z
ZW5kKCkNCj4gPg0KPiA+ICAgaW5jbHVkZS9uZXQvbmRpc2MuaCAgICAgICAgICB8ICAgMiArDQo+
ID4gICBuZXQvYnJpZGdlL2JyX2FycF9uZF9wcm94eS5jIHwgIDU0ICsrKysrLS0tLS0NCj4gPiAg
IG5ldC9icmlkZ2UvYnJfZGV2aWNlLmMgICAgICAgfCAgIDQgKy0NCj4gPiAgIG5ldC9icmlkZ2Uv
YnJfaW5wdXQuYyAgICAgICAgfCAgIDQgKy0NCj4gPiAgIG5ldC9icmlkZ2UvYnJfcHJpdmF0ZS5o
ICAgICAgfCAgIDIgKy0NCj4gPiAgIG5ldC9pcHY2L01ha2VmaWxlICAgICAgICAgICAgfCAgIDIg
Ky0NCj4gPiAgIG5ldC9pcHY2L25kaXNjLmMgICAgICAgICAgICAgfCAgIDEgKw0KPiA+ICAgbmV0
L2lwdjYvbmRpc2Nfc25vb3AuYyAgICAgICB8IDE5MA0KPiArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKw0KPiA+ICAgOCBmaWxlcyBjaGFuZ2VkLCAyMjQgaW5zZXJ0aW9ucygrKSwg
MzUgZGVsZXRpb25zKC0pDQo+ID4gICBjcmVhdGUgbW9kZSAxMDA2NDQgbmV0L2lwdjYvbmRpc2Nf
c25vb3AuYw0KPiA+DQo+IA0KPiBOaWNlIHNldCwgYnV0IEknbSBjdXJpb3VzIC0gYW55IHJlYXNv
biBub3QgdG8gdXNlIEVYUE9SVF9TWU1CT0xfR1BMKCkNCj4gaW5zdGVhZD8NCj4gDQoNCkkgZ3Vl
c3MgeW91IGFyZSByZWZlcnJpbmcgdG8gbmRpc2NfcGFyc2Vfb3B0aW9ucyBhbmQgbmRpc2NfY2hl
Y2tfbnNfbmE/DQpUaGUgcmVhc29uIGlzIGJhc2ljYWxseSB0aGF0IG90aGVyIHNpYmxpbmcgZnVu
Y3Rpb25zIHVzZWQgRVhQT1JUX1NZTUJPTCgpIHJhdGhlciB0aGFuIEVYUE9SVF9TWU1CT0xfR1BM
KCkgKG5kaXNjX3NlbmRfc2tiLCBuZGlzY19uc19jcmVhdGUsIGFuZCB0aGUgbmRpc2NfY2hlY2tf
bnNfbmEoKSBlcXVpdmFsZW50IGluIG1sZCwgaXB2Nl9tY19jaGVja19tbGQoKSkuDQpIb3dldmVy
LCBuZGlzY19zZW5kX25hKCkgZm9yIGV4YW1wbGUgaXMgbmV3ZXIgYW5kIHVzZXMgRVhQT1JUX1NZ
TUJPTF9HUEwoKS4gU28gaXQgbWlnaHQgbWFrZSBzZW5zZSB0byB1c2UgdGhhdCBpbiBuZGlzY19w
YXJzZV9vcHRpb25zKCksIGlmIHlvdSBwcmVmZXIuDQoNCj4gQ2hlZXJzLA0KPiAgIE5paw0K
