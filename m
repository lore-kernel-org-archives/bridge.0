Return-Path: <nikolay@nvidia.com>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Date: Tue, 6 Oct 2020 14:13:15 +0000
Message-ID: <9149db9d070102e20208d962aeb9101fd5fe2c4c.camel@nvidia.com>
References: <20201001103019.1342470-1-henrik.bjoernlund@microchip.com>
 <20201001103019.1342470-2-henrik.bjoernlund@microchip.com>
In-Reply-To: <20201001103019.1342470-2-henrik.bjoernlund@microchip.com>
Reply-To: Nikolay Aleksandrov <nikolay@nvidia.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <30E27537C8946C4A8C2D5B6D555CCC6F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1601993598; bh=EmPRsyn1oG4SMYPUOGekrUlH3mnqVSA9dJsolaGVHak=;
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
 b=EzQwksvAyEhc86ZGUEO0DuZk5Tfq7QhL+oC6PPsiP5aQ9Q9rzRO7+fFSVx5jTArZj
 cKBEcs6y4PdPFiD80Iz96L2bL+a1GsWramsdoAWuKDTfTpUEyU1QoCrQlhHXKszJDh
 VO0KOS4fnWEFEPHEfqN5fGcP/iWqtjNLPuX7wxWSXZbTJdwEfiqBS3+/r72tafYJtI
 bl36DDzGr1/SdAABZv5zIngqR+Dxp1TRwVbHoT+DU2oJPcHfHfm3Zze1Kx9jhYKgFV
 OOgADuaFAfYAJOptNrFPq2jnTaQNr06nIBi2+1f4SlVycmi55LL2eq4MQoki1Zp+0C
 w4fhnlk2XJnuA==
Subject: Re: [Bridge] [net-next v2 01/11] net: bridge: extend the process of
 special frames
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "henrik.bjoernlund@microchip.com" <henrik.bjoernlund@microchip.com>, "davem@davemloft.net" <davem@davemloft.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jiri@mellanox.com" <jiri@mellanox.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Roopa Prabhu <roopa@nvidia.com>, "idosch@mellanox.com" <idosch@mellanox.com>, "kuba@kernel.org" <kuba@kernel.org>, "UNGLinuxDriver@microchip.com" <UNGLinuxDriver@microchip.com>
Cc: "horatiu.vultur@microchip.com" <horatiu.vultur@microchip.com>

T24gVGh1LCAyMDIwLTEwLTAxIGF0IDEwOjMwICswMDAwLCBIZW5yaWsgQmpvZXJubHVuZCB3cm90
ZToNCj4gVGhpcyBwYXRjaCBleHRlbmRzIHRoZSBwcm9jZXNzaW5nIG9mIGZyYW1lcyBpbiB0aGUg
YnJpZGdlLiBDdXJyZW50bHkgTVJQDQo+IGZyYW1lcyBuZWVkcyBzcGVjaWFsIHByb2Nlc3Npbmcg
YW5kIHRoZSBjdXJyZW50IGltcGxlbWVudGF0aW9uIGRvZXNuJ3QNCj4gYWxsb3cgYSBuaWNlIHdh
eSB0byBwcm9jZXNzIGRpZmZlcmVudCBmcmFtZSB0eXBlcy4gVGhlcmVmb3JlIHRyeSB0bw0KPiBp
bXByb3ZlIHRoaXMgYnkgYWRkaW5nIGEgbGlzdCB0aGF0IGNvbnRhaW5zIGZyYW1lIHR5cGVzIHRo
YXQgbmVlZA0KPiBzcGVjaWFsIHByb2Nlc3NpbmcuIFRoaXMgbGlzdCBpcyBpdGVyYXRlZCBmb3Ig
ZWFjaCBpbnB1dCBmcmFtZSBhbmQgaWYNCj4gdGhlcmUgaXMgYSBtYXRjaCBiYXNlZCBvbiBmcmFt
ZSB0eXBlIHRoZW4gdGhlc2UgZnVuY3Rpb25zIHdpbGwgYmUgY2FsbGVkDQo+IGFuZCBkZWNpZGUg
d2hhdCB0byBkbyB3aXRoIHRoZSBmcmFtZS4gSXQgY2FuIHByb2Nlc3MgdGhlIGZyYW1lIHRoZW4g
dGhlDQo+IGJyaWRnZSBkb2Vzbid0IG5lZWQgdG8gZG8gYW55dGhpbmcgb3IgZG9uJ3QgcHJvY2Vz
cyBzbyB0aGVuIHRoZSBicmlkZ2UNCj4gd2lsbCBkbyBub3JtYWwgZm9yd2FyZGluZy4NCj4gDQo+
IFJldmlld2VkLWJ5OiBIb3JhdGl1IFZ1bHR1ciAgPGhvcmF0aXUudnVsdHVyQG1pY3JvY2hpcC5j
b20+DQo+IFNpZ25lZC1vZmYtYnk6IEhlbnJpayBCam9lcm5sdW5kICA8aGVucmlrLmJqb2Vybmx1
bmRAbWljcm9jaGlwLmNvbT4NCj4gLS0tDQo+ICBuZXQvYnJpZGdlL2JyX2RldmljZS5jICB8ICAx
ICsNCj4gIG5ldC9icmlkZ2UvYnJfaW5wdXQuYyAgIHwgMzEgKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrLQ0KPiAgbmV0L2JyaWRnZS9icl9tcnAuYyAgICAgfCAxOSArKysrKysrKysrKysr
KystLS0tDQo+ICBuZXQvYnJpZGdlL2JyX3ByaXZhdGUuaCB8IDE4ICsrKysrKysrKysrKy0tLS0t
LQ0KPiAgNCBmaWxlcyBjaGFuZ2VkLCA1OCBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkN
Cj4gDQoNCkhpLA0KTW9zdGx5IGxvb2tzIGdvb2QsIG9uZSBjb21tZW50IGJlbG93Lg0KDQo+IGRp
ZmYgLS1naXQgYS9uZXQvYnJpZGdlL2JyX2RldmljZS5jIGIvbmV0L2JyaWRnZS9icl9kZXZpY2Uu
Yw0KPiBpbmRleCA5YTJmYjRhYTFhMTAuLjIwNmM0YmE1MWNkMiAxMDA2NDQNCj4gLS0tIGEvbmV0
L2JyaWRnZS9icl9kZXZpY2UuYw0KPiArKysgYi9uZXQvYnJpZGdlL2JyX2RldmljZS5jDQo+IFtz
bmlwXQ0KPiBAQCAtMzgwLDMgKzM5NSwxNyBAQCByeF9oYW5kbGVyX2Z1bmNfdCAqYnJfZ2V0X3J4
X2hhbmRsZXIoY29uc3Qgc3RydWN0IG5ldF9kZXZpY2UgKmRldikNCj4gIA0KPiAgCXJldHVybiBi
cl9oYW5kbGVfZnJhbWU7DQo+ICB9DQo+ICsNCj4gK3ZvaWQgYnJfYWRkX2ZyYW1lKHN0cnVjdCBu
ZXRfYnJpZGdlICpiciwgc3RydWN0IGJyX2ZyYW1lX3R5cGUgKmZ0KQ0KPiArew0KPiArCWhsaXN0
X2FkZF9oZWFkX3JjdSgmZnQtPmxpc3QsICZici0+ZnJhbWVfdHlwZV9saXN0KTsNCj4gK30NCj4g
Kw0KPiArdm9pZCBicl9kZWxfZnJhbWUoc3RydWN0IG5ldF9icmlkZ2UgKmJyLCBzdHJ1Y3QgYnJf
ZnJhbWVfdHlwZSAqZnQpDQo+ICt7DQo+ICsJc3RydWN0IGJyX2ZyYW1lX3R5cGUgKnRtcDsNCj4g
Kw0KPiArCWhsaXN0X2Zvcl9lYWNoX2VudHJ5KHRtcCwgJmJyLT5mcmFtZV90eXBlX2xpc3QsIGxp
c3QpDQo+ICsJCWlmIChmdCA9PSB0bXApDQo+ICsJCQlobGlzdF9kZWxfcmN1KCZmdC0+bGlzdCk7
DQoNClRoaXMgaGFzbid0IGNyYXNoZWQgb25seSBiZWNhdXNlIHlvdSdyZSB1c2luZyBobGlzdF9k
ZWxfcmN1KCksIG90aGVyd2lzZSBpdCdzDQp3cm9uZy4gWW91IHNob3VsZCB1c2UgaGxpc3RfZm9y
X2VhY2hfZW50cnlfc2FmZSgpIHdoZW4gZGVsZXRpbmcgZnJvbSB0aGUgbGlzdA0Kd2hpbGUgd2Fs
a2luZyBpdCBvciB5b3Ugc2hvdWxkIGVuZCB0aGUgd2FsayBhZnRlciB0aGUgZGVsZXRlIHNpbmNl
IHRoZXJlIGNhbid0DQpiZSB0d28gZWxlbWVudHMgd2l0aCB0aGUgc2FtZSBhZGRyZXNzIGFueXdh
eS4NCg0KVGhhbmtzLA0KIE5paw0KDQoNCg0K
