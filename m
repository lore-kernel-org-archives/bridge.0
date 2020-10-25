Return-Path: <nikolay@nvidia.com>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Date: Sun, 25 Oct 2020 10:49:46 +0000
Message-ID: <c6b2a63f635d57bd34bb96bbc4deecb506968314.camel@nvidia.com>
References: <20201017184139.2331792-1-vladimir.oltean@nxp.com>
 <98ac64d9b048278d2296f5b0ff3320c70ea13c72.camel@nvidia.com>
 <20201025065957.5736elloorffcdif@skbuf>
In-Reply-To: <20201025065957.5736elloorffcdif@skbuf>
Reply-To: Nikolay Aleksandrov <nikolay@nvidia.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <3842ED0F0918F8418D174BD6D6A39FCB@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1603622968; bh=rZJjK8MwFPJiAB6ZSfg+XPhCPuSLLZ1IEagXtnufFk8=;
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
 b=R0uAYFpEE6cNBzlWXI4Fx3PbcKM7C1Pe+mJYOE6Ff1FwMvQxeSeaR+19arpuGa7dM
 KB7RRpce651K6SKLEajQewdMugg9/cc8/EJBYzNizFvQtm6DxejwEfDBlLP0pkpBOt
 QLJhlun0V4TharZoD/87T7pFMC6bk9UE4RISASY337/S9Pc9DO0ix36SY0RDhGmaU8
 vc/8x405XOF1aURWBXkjqRxuYnqqtAE1AXCD0e/QNAj87Sm69SKYG9tX6Ez6ClaI+Z
 p0YXl9pT2xKKUKishw/YYJ/A4ihYMOoMLtL9HeHrW4c5dY7uWVdSOWHCLIijvN2c+0
 hZZ+QgpN6Nkfg==
Subject: Re: [Bridge] [RFC PATCH] net: bridge: multicast: add support for L2
	entries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>
Cc: "andrew@lunn.ch" <andrew@lunn.ch>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "vivien.didelot@gmail.com" <vivien.didelot@gmail.com>, "idosch@idosch.org" <idosch@idosch.org>, "jiri@mellanox.com" <jiri@mellanox.com>, Roopa Prabhu <roopa@nvidia.com>, "kuba@kernel.org" <kuba@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>

T24gU3VuLCAyMDIwLTEwLTI1IGF0IDA2OjU5ICswMDAwLCBWbGFkaW1pciBPbHRlYW4gd3JvdGU6
DQo+IE9uIFdlZCwgT2N0IDIxLCAyMDIwIGF0IDA5OjE3OjA3QU0gKzAwMDAsIE5pa29sYXkgQWxl
a3NhbmRyb3Ygd3JvdGU6DQo+ID4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS91YXBpL2xpbnV4L2lm
X2JyaWRnZS5oIGIvaW5jbHVkZS91YXBpL2xpbnV4L2lmX2JyaWRnZS5oDQo+ID4gPiBpbmRleCA0
YzY4NzY4NmFhOGYuLmEyNWY2ZjlhYThjMyAxMDA2NDQNCj4gPiA+IC0tLSBhL2luY2x1ZGUvdWFw
aS9saW51eC9pZl9icmlkZ2UuaA0KPiA+ID4gKysrIGIvaW5jbHVkZS91YXBpL2xpbnV4L2lmX2Jy
aWRnZS5oDQo+ID4gPiBAQCAtNTIwLDEyICs1MjAsMTQgQEAgc3RydWN0IGJyX21kYl9lbnRyeSB7
DQo+ID4gPiAgI2RlZmluZSBNREJfRkxBR1NfRkFTVF9MRUFWRQkoMSA8PCAxKQ0KPiA+ID4gICNk
ZWZpbmUgTURCX0ZMQUdTX1NUQVJfRVhDTAkoMSA8PCAyKQ0KPiA+ID4gICNkZWZpbmUgTURCX0ZM
QUdTX0JMT0NLRUQJKDEgPDwgMykNCj4gPiA+ICsjZGVmaW5lIE1EQl9GTEFHU19MMgkJKDEgPDwg
NSkNCj4gPiANCj4gPiBJIHRoaW5rIHRoaXMgc2hvdWxkIGJlIDQuDQo+ID4gDQo+IA0KPiBTaG91
bGRuJ3QgdGhpcyBiZSBpbiBzeW5jIHdpdGggTURCX1BHX0ZMQUdTX0wyIHRob3VnaD8gV2UgYWxz
byBoYXZlDQo+IE1EQl9QR19GTEFHU19CTE9DS0VEIHdoaWNoIGlzIEJJVCg0KS4NCg0KVW5mb3J0
dW5hdGVseSB0aGV5IGhhdmVuJ3QgYmVlbiBpbiBzeW5jIGZyb20gdGhlIHN0YXJ0LiBNREJfRkxB
R1MgYml0DQowIGlzIG9mZmxvYWQsIHdoaWxlIE1EQl9QR19GTEFHUyBiaXQgMCBpcyBwZXJtYW5l
bnQuIEFzIHlvdSBjYW4gc2VlDQpoZXJlIGJsb2NrZWQgaXMgYml0IDMsIHdoaWxlIGludGVybmFs
bHkgaXQncyA0IGR1ZSB0byB0aGUgc2FtZSByZWFzb24uDQpXZSBjYW4ndCBhZmZvcmQgdG8gc2tp
cCAxIGJpdCBzaW5jZSB0aGlzIGlzIHVBUEkgYW5kIHdlIG9ubHkgZ290IDggDQphdmFpbGFibGUg
Yml0cy4gSSB3b25kZXIgaWYgd2UgbmVlZCB0aGVzZSBMMiBiaXRzIGF0IGFsbCwgd2h5IG5vdCB1
c2UNCm9ubHkgcHJvdG8gPT0gMCB0byBkZW5vdGUgaXQncyBhIEwyIGVudHJ5PyBJIGNhbid0IHJl
bWVtYmVyIHdoeSBJIGFkZGVkDQp0aGUgYml0cyBiYWNrIHRoZW4sIGJ1dCB1bnRpbCBub3cgcHJv
dG8gPT0gMCB3YXNuJ3QgYWxsb3dlZCBhbmQgdGhlDQprZXJuZWwgY291bGRuJ3QgZXhwb3J0IGl0
IGFzIHN1Y2gsIHNvIGl0IHNlZW1zIHBvc3NpYmxlIHRvIHVzZSBpdC4NCg0KDQoNCg0K
