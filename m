Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010047.outbound.protection.outlook.com [40.93.198.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A343EC2EF
	for <bridge@lists.linux.dev>; Wed,  5 Aug 2026 08:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785917181; cv=fail; b=CV6Vmzq2aGwQnG/McJCs27Gs2W7bD+kMgff30hQ2eihi/2h6zqzAfnihfdvCZTG7lxhgjiWakjb6wGoncc6YBhffpRr+dLH4VY/1EPzYGjrOVm/U2vfV9f0qCg5afnEZo03uDaJyivrf8XnmN+L8psPfEoPiUVxyQdaWNOIrfDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785917181; c=relaxed/simple;
	bh=H7x9aYixIsvxw2ymn6vyhMGnnfeOoS2Wl4g9tgBbn3I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qlHojQ3wXD4obmGCSFeAt0+wm9hnTg4mBQs0dGd013NYr5hXYyMarh3ae2cdLrKR47Qym1/JFEIbFtsLD1sNOpZs8z1ubXY8ompXYPhagiKEv855PmtQF1CUwJcKTXadnTYkFL7YO75Pdm8GK57CtpZnOeeEIZjqbqm2rcIRXXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=smpytZrx; arc=fail smtp.client-ip=40.93.198.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="smpytZrx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UGhzHRVT9ZjpPQ1t1sZ3SMalaLJNnr04l1mudNFxBsmKkZa6wJ5MEdfgxW43tHn1igHGkdVbwgVoucaQ+43I/Nm9IFF3agHSTi9tpMVJowQxHYe0yTIWroIFNQjPj2tDjCIpSCs0Jv2DgWG8QmjmIDHX5HZg8F2YNZkqK2k7g5vz8WwVCRnEdC5HiRFiBJmfN9buRrsCC2F4r+zrhIL7WqIGtCm3X2KEaY7F1Z2eT4bMLbpUN/Jx/rzMuQzYJe74H2x6nyxPtjG0YeBFr5qCGf5T4bBoPAUAXg2GeL+0w/bfnwe1Rg1a8c94QDOMyPGVVwpRZs5M1ohjsMOZXMf7ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H7x9aYixIsvxw2ymn6vyhMGnnfeOoS2Wl4g9tgBbn3I=;
 b=FsFuNIpnL8Y/BeKW/rj3L7J7JizkTUvIlxvhwIzYs/CuH2JF3yCzqzLuTabfviZlYlM/UxydDgLpZCiRS6pd++9Fbth+MnguFWuuxTzs/Tymt3Os5IeSPUfbd5iyhJextJNw3cA0qesMusBhuiRfdsKLTopttzQmGidOBTxx9JRZegDw6mxLSnypkrfurq3wYEpN+k5TbGQPG42XQdum4aKX3g1BuOnyvAKkYKlLBhXrWtpzthjx4VCaGekxuRnSb7kmv4qDr7UFFB8xtdZV/JyQsk2XntLrPLq500HX7Z3LkMK/y66UaJtcujNLzTVSIx6PIQGv6/yIrVmHGeeFJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H7x9aYixIsvxw2ymn6vyhMGnnfeOoS2Wl4g9tgBbn3I=;
 b=smpytZrxZHiYOTjXtKJNYVHx4Qq175vWOsoWCn3lCcVScj3HVIMp3/xW4PT+Z8f6D/Kwqj3WXyxU7yLYPPqNITv/p7NiI31nuNDbvuObLc5Adgc+4qpO35FGxbmgNMexUODqWVeXAuK0DwG1pzbReA8tAVJ0VpSnwHUUD2u/MjN+7wgzjLJGTghkhOCxRQVpPgRoNB/LFSwGs/ao8aJjIff6j13ExYHgK9+DKkChn2Pe000w3FeJ2Uk4+CjqC85oTr518QVIIl4WpCMJFgkb4qg7rhueIPsv8ixZKr76h+dw2E8zOk7SvIp7JPjMw0mCHoffRttNcmTTT67Va1kINA==
Received: from SJ2PR12MB9008.namprd12.prod.outlook.com (2603:10b6:a03:543::19)
 by CH1PR12MB9576.namprd12.prod.outlook.com (2603:10b6:610:2ad::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 08:06:09 +0000
Received: from SJ2PR12MB9008.namprd12.prod.outlook.com
 ([fe80::e25c:9cce:637a:3dfd]) by SJ2PR12MB9008.namprd12.prod.outlook.com
 ([fe80::e25c:9cce:637a:3dfd%3]) with mapi id 15.21.0270.016; Wed, 5 Aug 2026
 08:06:09 +0000
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
Subject: RE: [PATCH net-next v2 1/5] bridge: Use direct pointer in
 br_is_nd_neigh_msg()
Thread-Topic: [PATCH net-next v2 1/5] bridge: Use direct pointer in
 br_is_nd_neigh_msg()
Thread-Index: AQHdIzrTlIw2YDtqu0W5JhCRtIyVJbaO+l8g
Date: Wed, 5 Aug 2026 08:06:08 +0000
Message-ID:
 <SJ2PR12MB900899F8686070DFA256F52BD8D32@SJ2PR12MB9008.namprd12.prod.outlook.com>
References: <20260803112505.613873-1-danieller@nvidia.com>
 <20260803112505.613873-2-danieller@nvidia.com>
In-Reply-To: <20260803112505.613873-2-danieller@nvidia.com>
Accept-Language: en-US, he-IL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR12MB9008:EE_|CH1PR12MB9576:EE_
x-ms-office365-filtering-correlation-id: c1afec5f-89ea-4011-b0d1-08def2c86844
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|23010399003|7416014|366016|22082099003|18002099003|11063799006|56012099006|10067099003|4143699003|38070700021;
x-microsoft-antispam-message-info:
 kRL/DpGIVTHkwWxYM6r/XxLk1XRPXzPPKeiDx0axJjKQaz5DOYbV0rn2OxS89kF8SaG4ix9SwUO/U8tOyMLinxKV+hBSWFsSs6l+UgwVthRkf/I7OSbNje+JXNbtVFsOvturswM/fia95mfe+5ZRt/HD1kDNs6WPY33wjPE+vkbic92etXB+aHkBcmxiqpSI5O+v/lDA9U2qQjShYqy+buwY2fs7+fZxFOVmkZAw+WRldiJi6qV76pqjID49KOaBrjhgithvR1P7gXjHJRmVjR/0jl3uFcoG3OAoEoysx/2okX0YKAW2j8XTc/4Kde2P0ZJ5GK3MXw1BTLiqNCEAqnLtnIynDlBD/AH8F0O9VJ+lfltBsT5yD4P4t7KumIOp+iP9XTfyI0Vjs6rV+eVg32DlhF6agBVXxAQhrvIvcj/cbbRTJ7gqDaQJJuYXGXOcdQSdnS2PJy0/8sKnpC4I9PbJ4I9O5YaD2kM9Gkg1up6ZS/QKtpKHYyHhzc6ciSGIL9HxH7b2p7XL/nWMc3Zd/1qqhlQHELZGnWOEF2FRAVeQKCla3t2NdqL1pEcYSFGlkFl/J0vFeQwTwGAIXcx2VX1+GItDQ6CklB/s0hh23f8uOegHP1IYxz1JJz+vUKEIhZ3i4tRizLhmGUmrATqog93St3Y8PDWU3E/3cPOFR1/uzbVTjO8pHImAakG5scH/cS8iNBhRx1CSjeMFvpgBUoQdP76/oFKsSmXHA4wjUAg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9008.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(7416014)(366016)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003)(4143699003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Nml4U1RYNUdvbkNqVnFHdUkrNG8yM1dEa1NicEF1Z1BwY1V4SWdET2o0QmRP?=
 =?utf-8?B?V3FTOWpaOUVMamNzY3FQdDlxdG5zQk1WWUxjblcrUE5pRkJ2U2VNbTFkdDNK?=
 =?utf-8?B?M01QaDEwenBnMmpYRXNHdS9IRGVRQXpscWVTRTcrazdYTXdvbTlOeDZyZDls?=
 =?utf-8?B?Mm5TMXRpek5MRm1QZXdYcldPRFFVYVUyMnJBeC9hMlZRRDc2QUxoWGxNZFZx?=
 =?utf-8?B?NnZQa1lNYXRCdVA2RVcyS1pXenRuYmt2aDhOWmlQZUZEOHhoRVUrOFNJV1g2?=
 =?utf-8?B?MUdoUlNvdHZGRmZnMmRQcjNxeUNpYXNzajhteHJFbGZEL2hGaEV5b3VrWkt2?=
 =?utf-8?B?OExqWDIvaGgwY0VXdXVHckpkUFFMZWZXV0doTERtSDhoS0l0ZWRGazMxejF0?=
 =?utf-8?B?cXphNmtDTW02MTBqajRZYk9rZzlZaldKaDhpRlpIOWROblhNczBIRjVKWDBm?=
 =?utf-8?B?ZEFWM1BJMTdjRWd0RnRjWGFqYytESFBKdFpTYlhha3BCUnJ3RGhwdUx0SUpp?=
 =?utf-8?B?SWZ4VWNWZDc2cndPTU90Z2JCMk5VUTNTcGIxU1F4Y3ZlUTlBa2RrYWZJZW8z?=
 =?utf-8?B?a0ZnVkdwMnpMaW9QYTNyT25zWCtIaENwOUxnYW1UelgrZUZOam9jQ2pNaUEw?=
 =?utf-8?B?bmE2STVIVlVDRUxqT0tnWW9VUjhiOTdieFEvNkE2RmoyU0FqQWZVVGM4SG5x?=
 =?utf-8?B?MnFaMW5yaElSMlpGeDEyQnNmY1JJWU9uYjVDeEhUVlBwcmRseEllak8xM0ZS?=
 =?utf-8?B?TlBIRm05M1NDSVd6SkpQTVNhVVJWMzlpc0RjWFlPOUR5eHVwTEJqN08yU1hT?=
 =?utf-8?B?blF2NjlCdW45VHhEYXNvMFBpemhVdlhMOGMzeWdDRURxMUVaVlM4eFF2cGlG?=
 =?utf-8?B?V2p2RW1CeFZGT0tKV3JSMzRZRzhwMnZ3bUFMWEJaNS91L29INkxSc2Nxd3Ry?=
 =?utf-8?B?TmNoNk1BdFJIVml3dktqV2s3bmlYR21xby9McDRrWFk0TWJmWTZtcEZKUTZq?=
 =?utf-8?B?SUxRcm81ZER6UUhxUVlSUElVaXRIY1BLVWJyM2U5QzVDR0RSUHMyM2txTlNa?=
 =?utf-8?B?NlNxU2JuSENsV2ppazNNcVBiUlRjRDVjV3o5V3krN0trc3M3OERwRmp2Vm5X?=
 =?utf-8?B?Sm1pZ0JlaEU3N1VuOE1NQUJqWmRFR1dZWmdoSHkzOGhwdDBRbU5zdU9TT0pH?=
 =?utf-8?B?QnR3dnZuZ2xsQTRyVlZoTGRGVldQcDJYQVU2SVU1aitlQXJtMFlGNnRyMHhs?=
 =?utf-8?B?NzNBZUJDV3NUMVB3aFR3YVllOGgrTkM0WC9vanlYa0c3YVZqUUp2N01rNFIw?=
 =?utf-8?B?KzNUSGdhV0JyTWJYZURYZjZ3bEplNDl0ZlV6VmZGYkkzN3ZUOXd0dkdmTWNy?=
 =?utf-8?B?MmVMV25Kdk53aEpiTlJ5OU1vWkc3dEZPM2NEcnh0M2ZjWkxzQTZENFU0ZWhS?=
 =?utf-8?B?ZTlEWDJoaVJlQUovMXBta3pxSWdncVJHK0hRMm53Z2UrZTJPdnJvamJmcExD?=
 =?utf-8?B?THNVcjVtVTVJVzQ4dVNoZDlYQWpSQ0VlSlloaGdQNXBRQ3N4VG9tQXUyc3N3?=
 =?utf-8?B?aldUZUxpZkNOdDVqbDZJeDdOS2M0L0R1eWEwMFQ0TVBvQThNZmxHK3BYTFhR?=
 =?utf-8?B?ZmgxOVJRZWNvVFNIcUFSOFFyUzU3N0NmTXZiKzNoTkM2UFNsQTJXZVUvSlcw?=
 =?utf-8?B?NiszZnJydXBDMDlMVUw3YlNhWGpXUWpxclN6TFlQZ3NHUkswcUhQcitmc2p6?=
 =?utf-8?B?NUJXZ3dxUkdxQkVOU3paU1ZNc0FsY1hxcEFLbnA3dUNTY2d4VXN2d0QxNWhG?=
 =?utf-8?B?dEphaTBkcUZPSFpURzUrUjI2UERTeG1TcENTa3BDdWozWWZMc1pyY1JuWS8y?=
 =?utf-8?B?SzdKdjhpL2o3cXdpZEtFV0o2dkNxWkN2THFJd3FBLy9pekdvcyt3bFVGZUJu?=
 =?utf-8?B?dU5uNmRKOGZZNEpnN0NpMy8wUVVLL1oxNEZWamlPdnZtem96UWZOSGxOK3c3?=
 =?utf-8?B?Y1R3ZkNqYURQUmVYSXBNZDJSdzBFbDYralNpaUxhMmdOdXFFVGdqUzQ5MDEz?=
 =?utf-8?B?b3QyYnZYNTdBc2lnclo5c2lQbjVqVm5YTWs4OVJLSllWWVkrN0JQaVF4MGpD?=
 =?utf-8?B?cldPekdFVXNhOEFsUXUwSE9JQTkrSjhMMStvZXJ5bzU2VXF2c1pLN3lZR3pO?=
 =?utf-8?B?REdXZTVyUVRQdDFmaEdDL1ZnRURmKzNKVDdsMWRtaEc4NVJ6TXJ1MGE3OVF3?=
 =?utf-8?B?VE5xem1MV3ZrZnNEamFJbnFJTkFsbXNkcko0MHJwN1JVN3NldHZVK093SjVT?=
 =?utf-8?Q?mcD67d7+1rpWvvoeAh?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c1afec5f-89ea-4011-b0d1-08def2c86844
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2026 08:06:08.9623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iPRHi6c8bY3ctLsX/iFkwk+Ae4jE0m0PQW6LXbRbaEp9QhwXS2ISTGCUPKm7jTHsZtGkBuNMnoWK+feRVxKz/w==
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
amVjdDogW1BBVENIIG5ldC1uZXh0IHYyIDEvNV0gYnJpZGdlOiBVc2UgZGlyZWN0IHBvaW50ZXIg
aW4NCj4gYnJfaXNfbmRfbmVpZ2hfbXNnKCkNCj4gDQo+IEJvdGggY2FsbGVycyBvZiBicl9pc19u
ZF9uZWlnaF9tc2coKSBhbHJlYWR5IGNhbGwgcHNrYl9tYXlfcHVsbCgpIHRvIGVuc3VyZQ0KPiBz
aXplb2Yoc3RydWN0IGlwdjZoZHIpICsgc2l6ZW9mKHN0cnVjdCBuZF9tc2cpIGJ5dGVzIGFyZSBp
biB0aGUgbGluZWFyIGFyZWENCj4gYmVmb3JlIGludm9raW5nIHRoaXMgZnVuY3Rpb24uIFRoZSBz
a2JfaGVhZGVyX3BvaW50ZXIoKSBjYWxsIGFuZCBpdHMgZmFsbGJhY2sNCj4gYnVmZmVyIGFyZSB0
aGVyZWZvcmUgdW5uZWNlc3NhcnkuDQo+IA0KPiBSZXBsYWNlIHNrYl9oZWFkZXJfcG9pbnRlcigp
IHdpdGggYSBkaXJlY3QgY2FzdCB0byBpcHY2X2hkcihza2IpICsgMSBhbmQgZHJvcA0KPiB0aGUg
bm93LXVudXNlZCAnbXNnJyBwYXJhbWV0ZXIgYW5kIGl0cyBjb3JyZXNwb25kaW5nIHN0YWNrIGJ1
ZmZlciBmcm9tIGFsbA0KPiBjYWxsZXJzLg0KPiANCj4gUmV2aWV3ZWQtYnk6IFBldHIgTWFjaGF0
YSA8cGV0cm1AbnZpZGlhLmNvbT4NCj4gQWNrZWQtYnk6IE5pa29sYXkgQWxla3NhbmRyb3YgPHJh
em9yQGJsYWNrd2FsbC5vcmc+DQo+IFNpZ25lZC1vZmYtYnk6IERhbmllbGxlIFJhdHNvbiA8ZGFu
aWVsbGVyQG52aWRpYS5jb20+DQo+IC0tLQ0KDQpTYXNoaWtvIHdyb3RlOg0KDQoiDQo+IGRpZmYg
LS1naXQgYS9uZXQvYnJpZGdlL2JyX2FycF9uZF9wcm94eS5jIGIvbmV0L2JyaWRnZS9icl9hcnBf
bmRfcHJveHkuYw0KPiBpbmRleCAyM2ViNjkzMWEyYjRhLi5kYjA4YzMyNzIwMDFmIDEwMDY0NA0K
PiAtLS0gYS9uZXQvYnJpZGdlL2JyX2FycF9uZF9wcm94eS5jDQo+ICsrKyBiL25ldC9icmlkZ2Uv
YnJfYXJwX25kX3Byb3h5LmMNCg0KVGhpcyBpcyBhIHByZS1leGlzdGluZyBpc3N1ZSwgYnV0IGNh
biBicl9kb19wcm94eV9zdXBwcmVzc19hcnAoKSBhbHNvIHN1ZmZlcg0KZnJvbSBhbiBvdXQtb2Yt
Ym91bmRzIHJlYWQgd2hlbiBza2JfbmV0d29ya19vZmZzZXQoc2tiKSA+IDA/DQpJbiBicl9kb19w
cm94eV9zdXBwcmVzc19hcnAoKSwgcHNrYl9tYXlfcHVsbCgpIGlzIHVzZWQgdG8gdmFsaWRhdGUN
CmFycF9oZHJfbGVuKGRldikgcmVsYXRpdmUgdG8gc2tiLT5kYXRhOg0KICAgICAgICBpZiAoKGRl
di0+ZmxhZ3MgJiBJRkZfTk9BUlApIHx8DQogICAgICAgICAgICAhcHNrYl9tYXlfcHVsbChza2Is
IGFycF9oZHJfbGVuKGRldikpKQ0KICAgICAgICAgICAgICAgIHJldHVybjsNCiAgICAgICAgcGFy
cCA9IGFycF9oZHIoc2tiKTsNCg0KU2luY2UgYXJwX2hkcihza2IpIHJlc29sdmVzIHRvIHNrYl9u
ZXR3b3JrX2hlYWRlcihza2IpLCBhY2Nlc3NpbmcgdGhlIGFycA0KcGF5bG9hZCByZWFkcyBiZXlv
bmQgdGhlIHZhbGlkYXRlZCBsaW5lYXIgYXJlYSBpZiB0aGUgbmV0d29yayBvZmZzZXQgaXMNCmdy
ZWF0ZXIgdGhhbiAwLiBUaGlzIGNvdWxkIGhhcHBlbiBpZiBhIGJwZiBwcm9ncmFtIGF0IHRyYWZm
aWMgY29udHJvbCBlZ3Jlc3MNCnVzZXMgYnBmX3NrYl9hZGp1c3Rfcm9vbSB0byBzaGlmdCB0aGUg
bmV0d29yayBoZWFkZXIgcmVsYXRpdmUgdG8gc2tiLT5kYXRhDQpiZWZvcmUgYnJpZGdlIHByb2Nl
c3NpbmcuDQoiDQoNClByZS1leGlzdGluZyBpc3N1ZSwgbm90IGluIHRoZSBzY29wZS4NCg0KIg0K
PiBAQCAtMjM0LDE0ICsyMzQsOSBAQCB2b2lkIGJyX2RvX3Byb3h5X3N1cHByZXNzX2FycChzdHJ1
Y3Qgc2tfYnVmZiAqc2tiLCBzdHJ1Y3QgbmV0X2JyaWRnZSAqYnIsDQo+ICAjZW5kaWYNCj4gIA0K
PiAgI2lmIElTX0VOQUJMRUQoQ09ORklHX0lQVjYpDQo+IC1zdHJ1Y3QgbmRfbXNnICpicl9pc19u
ZF9uZWlnaF9tc2coY29uc3Qgc3RydWN0IHNrX2J1ZmYgKnNrYiwgc3RydWN0IG5kX21zZyAqbXNn
KQ0KPiArc3RydWN0IG5kX21zZyAqYnJfaXNfbmRfbmVpZ2hfbXNnKGNvbnN0IHN0cnVjdCBza19i
dWZmICpza2IpDQo+ICB7DQo+IC0Jc3RydWN0IG5kX21zZyAqbTsNCj4gLQ0KPiAtCW0gPSBza2Jf
aGVhZGVyX3BvaW50ZXIoc2tiLCBza2JfbmV0d29ya19vZmZzZXQoc2tiKSArDQo+IC0JCQkgICAg
ICAgc2l6ZW9mKHN0cnVjdCBpcHY2aGRyKSwgc2l6ZW9mKCptc2cpLCBtc2cpOw0KPiAtCWlmICgh
bSkNCj4gLQkJcmV0dXJuIE5VTEw7DQo+ICsJc3RydWN0IG5kX21zZyAqbSA9IChzdHJ1Y3QgbmRf
bXNnICopKGlwdjZfaGRyKHNrYikgKyAxKTsNCg0KRG9lcyB0aGlzIGNhc3QgaW50cm9kdWNlIGFu
IG91dC1vZi1ib3VuZHMgcmVhZCBpZiBza2JfbmV0d29ya19vZmZzZXQoc2tiKSA+IDA/DQpUaGUg
Y2FsbGVycyB1c2UgcHNrYl9tYXlfcHVsbCgpIHRvIHZhbGlkYXRlIHRoZSBsZW5ndGggcmVsYXRp
dmUgdG8gc2tiLT5kYXRhLg0KSG93ZXZlciwgaXB2Nl9oZHIoc2tiKSByZXNvbHZlcyB0byBza2Jf
bmV0d29ya19oZWFkZXIoc2tiKSwgd2hpY2ggaXMNCnNrYi0+ZGF0YSArIHNrYl9uZXR3b3JrX29m
ZnNldChza2IpLg0KSWYgYSBwYWNrZXQgaXMgc2VudCB0aHJvdWdoIHRoZSBicmlkZ2UgZGV2aWNl
IHdoZXJlIHNrYl9uZXR3b3JrX29mZnNldChza2IpDQppcyBncmVhdGVyIHRoYW4gMCAoc3VjaCBh
cyB3aGVuIGEgYnBmIHByb2dyYW0gYXQgdHJhZmZpYyBjb250cm9sIGVncmVzcw0KZXhwYW5kcyB0
aGUgbWFjIGhlYWRlciksIHRoZSBicmlkZ2UncyB1bmNvbmRpdGlvbmFsIHB1bGwgb2YgdGhlIGV0
aGVybmV0DQpoZWFkZXIgbGVhdmVzIHNrYi0+ZGF0YSBiZWZvcmUgdGhlIG5ldHdvcmsgaGVhZGVy
Lg0KSW4gdGhpcyBzaXR1YXRpb24sIHRoZSBkaXJlY3QgcG9pbnRlciBjYXN0IGV2YWx1YXRlcyB0
byBhIG1lbW9yeSBhZGRyZXNzIHRoYXQNCnJlcXVpcmVzOg0Kc2tiX25ldHdvcmtfb2Zmc2V0KHNr
YikgKyBzaXplb2Yoc3RydWN0IGlwdjZoZHIpICsgc2l6ZW9mKHN0cnVjdCBuZF9tc2cpDQpsaW5l
YXIgYnl0ZXMsIGJ1dCBwc2tiX21heV9wdWxsKCkgb25seSB2YWxpZGF0ZWQgc2l6ZW9mKHN0cnVj
dCBpcHY2aGRyKSArDQpzaXplb2Yoc3RydWN0IG5kX21zZykgcmVsYXRpdmUgdG8gc2tiLT5kYXRh
Lg0K4oCdDQoNClBhdGNoICMzIHN1cGVyc2VkZXMgdGhlIGNhc3QsIG5vIGJ1ZyBpbiB0aGUgYXNz
ZW1ibGVkIHNlcmllcy4NCg0K
