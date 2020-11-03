Return-Path: <nikolay@nvidia.com>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Date: Tue, 3 Nov 2020 16:26:25 +0000
Message-ID: <067c94269abed15f777ac078a216be314c935fd5.camel@nvidia.com>
References: <20201102143828.5286-1-menglong8.dong@gmail.com>
In-Reply-To: <20201102143828.5286-1-menglong8.dong@gmail.com>
Reply-To: Nikolay Aleksandrov <nikolay@nvidia.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <680D0BE04AACBD4292520B4598C416B7@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1604420789; bh=e1tATsxgREHFZSoWYxz7YKJIHFSOswzbNqM3WpL7Fok=;
 h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:From:To:
 CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
 In-Reply-To:Reply-To:Accept-Language:Content-Language:
 X-MS-Has-Attach:X-MS-TNEF-Correlator:user-agent:
 authentication-results:x-originating-ip:x-ms-publictraffictype:
 x-ms-office365-filtering-correlation-id:x-ms-traffictypediagnostic:
 x-ms-exchange-transport-forked:x-microsoft-antispam-prvs:
 x-ms-oob-tlc-oobclassifiers:x-ms-exchange-senderadcheck:
 x-microsoft-antispam:x-microsoft-antispam-message-info:
 x-forefront-antispam-report:x-ms-exchange-antispam-messagedata:
 Content-Type:Content-ID:Content-Transfer-Encoding:MIME-Version:
 X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-AuthSource:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-originalarrivaltime:
 X-MS-Exchange-CrossTenant-fromentityheader:
 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
 X-MS-Exchange-CrossTenant-userprincipalname:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 b=T9fiDLVXHn+bSQ3JVHTmryS/wfQgRS0ZUDK94dzm46ygJIRNqh7l/FcOLuCQYtTq2
 PEuPkXTA4nucld7raOuMzpLS/afdanfTcgPSKwjm1OhdhptAONYlFWbnIGMILrvCZP
 EgpWD1wbLT754vuZd6iasLFx0xZhzaIJdTGUHhQ0JfqP64RL19a+SV16F6UVazzvyr
 EWcF4+VZuwVNLZ59U9FZtsxC9Wn0gKKILpzw+0VZ/LJio1FokANeUHOSV39/VDojj4
 MOII4K9/zOjX+VQWVwNlYYKKmqsSXojPqo7cn+0u4ZbV/3AQWMb8pyCbcgS7rc15Sj
 MCGP6mzSZg0Yw==
Subject: Re: [Bridge] [PATCH] net: bridge: disable multicast while delete
	bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "menglong8.dong@gmail.com" <menglong8.dong@gmail.com>, Roopa Prabhu <roopa@nvidia.com>
Cc: "dong.menglong@zte.com.cn" <dong.menglong@zte.com.cn>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kuba@kernel.org" <kuba@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>

T24gTW9uLCAyMDIwLTExLTAyIGF0IDIyOjM4ICswODAwLCBNZW5nbG9uZyBEb25nIHdyb3RlOg0K
PiBGcm9tOiBNZW5nbG9uZyBEb25nIDxkb25nLm1lbmdsb25nQHp0ZS5jb20uY24+DQo+IA0KPiBU
aGlzIGNvbW1pdCBzZWVtcyBtYWtlIG5vIHNlbnNlLCBhcyBicmlkZ2UgaXMgZGVzdHJveWVkIHdo
ZW4NCj4gYnJfbXVsdGljYXN0X2Rldl9kZWwgaXMgY2FsbGVkLg0KPiANCj4gSW4gY29tbWl0IGIx
YjlkMzY2MDI4Zg0KPiAoImJyaWRnZTogbW92ZSBicmlkZ2UgbXVsdGljYXN0IGNsZWFudXAgdG8g
bmRvX3VuaW5pdCIpLCBYaW4gTG9uZw0KPiBmaXhlZCB0aGUgdXNlLWFmdGVyLWZyZWUgcGFuaWMg
aW4gYnJfbXVsdGljYXN0X2dyb3VwX2V4cGlyZWQgYnkNCj4gbW92aW5nIGJyX211bHRpY2FzdF9k
ZXZfZGVsIHRvIG5kb191bmluaXQuIEhvd2V2ZXIsIHRoYXQgcGF0Y2ggaXMNCj4gbm90IGFwcGxp
ZWQgdG8gNC40LlgsIGFuZCB0aGUgYnVnIGV4aXN0cy4NCj4gDQo+IEZpeCB0aGF0IGJ1ZyBieSBk
aXNhYmxpbmcgbXVsdGljYXN0IGluIGJyX211bHRpY2FzdF9kZXZfZGVsIGZvcg0KPiA0LjQuWCwg
YW5kIHRoZXJlIGlzIG5vIGhhcm0gZm9yIG90aGVyIGJyYW5jaGVzLg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogTWVuZ2xvbmcgRG9uZyA8ZG9uZy5tZW5nbG9uZ0B6dGUuY29tLmNuPg0KPiAtLS0NCj4g
IG5ldC9icmlkZ2UvYnJfbXVsdGljYXN0LmMgfCAxICsNCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL25ldC9icmlkZ2UvYnJfbXVsdGljYXN0LmMg
Yi9uZXQvYnJpZGdlL2JyX211bHRpY2FzdC5jDQo+IGluZGV4IGVhZTg5OGMzY2ZmNy4uOTk5MmZk
ZmYyOTUxIDEwMDY0NA0KPiAtLS0gYS9uZXQvYnJpZGdlL2JyX211bHRpY2FzdC5jDQo+ICsrKyBi
L25ldC9icmlkZ2UvYnJfbXVsdGljYXN0LmMNCj4gQEAgLTMzNjksNiArMzM2OSw3IEBAIHZvaWQg
YnJfbXVsdGljYXN0X2Rldl9kZWwoc3RydWN0IG5ldF9icmlkZ2UgKmJyKQ0KPiAgCWhsaXN0X2Zv
cl9lYWNoX2VudHJ5X3NhZmUobXAsIHRtcCwgJmJyLT5tZGJfbGlzdCwgbWRiX25vZGUpDQo+ICAJ
CWJyX211bHRpY2FzdF9kZWxfbWRiX2VudHJ5KG1wKTsNCj4gIAlobGlzdF9tb3ZlX2xpc3QoJmJy
LT5tY2FzdF9nY19saXN0LCAmZGVsZXRlZF9oZWFkKTsNCj4gKwlicl9vcHRfdG9nZ2xlKGJyLCBC
Uk9QVF9NVUxUSUNBU1RfRU5BQkxFRCwgZmFsc2UpOw0KPiAgCXNwaW5fdW5sb2NrX2JoKCZici0+
bXVsdGljYXN0X2xvY2spOw0KPiAgDQo+ICAJYnJfbXVsdGljYXN0X2djKCZkZWxldGVkX2hlYWQp
Ow0KDQpUaGlzIGRvZXNuJ3QgbWFrZSBhbnkgc2Vuc2UuIEl0IGRvZXNuJ3QgZml4IGFueXRoaW5n
Lg0KSWYgNC40IGhhcyBhIHByb2JsZW0gdGhlbiB0aGUgcmVsZXZhbnQgcGF0Y2hlcyBzaG91bGQg
Z2V0IGJhY2twb3J0ZWQgdG8gaXQuDQpXZSBkb24ndCBhZGQgcmFuZG9tIGNoYW5nZXMgdG8gZml4
IG9sZGVyIHJlbGVhc2VzLg0KDQpDaGVlcnMsDQogTmlrDQoNCk5hY2tlZC1ieTogTmlrb2xheSBB
bGVrc2FuZHJvdiA8bmlrb2xheUBudmlkaWEuY29tPg0K
