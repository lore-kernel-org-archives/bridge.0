Return-Path: <nikolay@nvidia.com>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Date: Fri, 18 Sep 2020 12:35:02 +0000
Message-ID: <9ab2973de2c0fb32de7fbc4ae823a820cd48a769.camel@nvidia.com>
References: <CAMuHMdUd4VtpOGr26KAmF22N32obNqQzq3tbcPxLJ7mxUtSyrg@mail.gmail.com>
 <20200911.174400.306709791543819081.davem@davemloft.net>
 <CAMuHMdW0agywTHr4bDO9f_xbQibCxDykdkcAmuRJQO90=E6-Zw@mail.gmail.com>
 <20200912.183437.1205152743307947529.davem@davemloft.net>
 <CAMuHMdXGmKYKWtkFCV0WmYnY4Gn--Bbz-iSX76oc-UNNrzCMuw@mail.gmail.com>
In-Reply-To: <CAMuHMdXGmKYKWtkFCV0WmYnY4Gn--Bbz-iSX76oc-UNNrzCMuw@mail.gmail.com>
Reply-To: Nikolay Aleksandrov <nikolay@nvidia.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <CDB2C3060B5F194BAC4EBCCF6887BA0B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1600432460; bh=h/jBSanyBxK7bWX+OVxK3fSFXORvSxaNGGv7E5spujQ=;
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
 b=hVMFh6DHP3wQLOMdt+RxyWfUrzhB8uVhYJcUa/wb1Hp6vX+38mVLJhm7jFo2Utlo+
 pEebdoEv/YhiRfdrtM27eTkiiMO7C2KdjWFN6wHZN+tZTn0lv30Q8WxmyLW84CDevA
 ad7dnAynbxC40k2ZhXfSC4a4/xKNu5H/nemRbnRUxjC5jUc5+LL5kcF/gc2WEj9D4Z
 GjTkf2YUUl7BFFeGNtihP3ybBnIERouXBMi8jtSr+jvy7D3nc7L78BdmSMfqk+P0io
 ppReEwb/K9bRl/GXkvWCLVLQrUjRQhOinIB31SN0qOnpZ1YC5k6CDYv+JZKLVGLb1Y
 hQhdly5Z9ToGw==
Subject: Re: [Bridge] [PATCH] Revert "net: linkwatch: add check for
 netdevice being present to linkwatch_do_dev"
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "davem@davemloft.net" <davem@davemloft.net>, "geert@linux-m68k.org" <geert@linux-m68k.org>
Cc: "andrew@lunn.ch" <andrew@lunn.ch>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "yoshihiro.shimoda.uh@renesas.com" <yoshihiro.shimoda.uh@renesas.com>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Roopa Prabhu <roopa@nvidia.com>, "kuba@kernel.org" <kuba@kernel.org>, "gaku.inami.xh@renesas.com" <gaku.inami.xh@renesas.com>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>

T24gTW9uLCAyMDIwLTA5LTE0IGF0IDA5OjQwICswMjAwLCBHZWVydCBVeXR0ZXJob2V2ZW4gd3Jv
dGU6DQo+IEhpIERhdmlkLA0KPiANCj4gQ0MgYnJpZGdlDQo+IA0KPiBPbiBTdW4sIFNlcCAxMywg
MjAyMCBhdCAzOjM0IEFNIERhdmlkIE1pbGxlciA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD4gd3JvdGU6
DQo+ID4gRnJvbTogR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC1tNjhrLm9yZz4NCj4g
PiBEYXRlOiBTYXQsIDEyIFNlcCAyMDIwIDE0OjMzOjU5ICswMjAwDQo+ID4gDQo+ID4gPiAiZGV2
IiBpcyBub3QgdGhlIGJyaWRnZSBkZXZpY2UsIGJ1dCB0aGUgcGh5c2ljYWwgRXRoZXJuZXQgaW50
ZXJmYWNlLCB3aGljaA0KPiA+ID4gbWF5IGFscmVhZHkgYmUgc3VzcGVuZGVkIGR1cmluZyBzMnJh
bS4NCj4gPiANCj4gPiBIbW1tLCBvay4NCj4gPiANCj4gPiBMb29raW5nIG1vcmUgZGVlcGx5IE5F
VERFVl9DSEFOR0UgY2F1c2VzIGJyX3BvcnRfY2Fycmllcl9jaGVjaygpIHRvIHJ1biB3aGljaA0K
PiA+IGV4aXRzIGVhcmx5IGlmIG5ldGlmX3J1bm5pbmcoKSBpcyBmYWxzZSwgd2hpY2ggaXMgZ29p
bmcgdG8gYmUgdHJ1ZSBpZg0KPiA+IG5ldGlmX2RldmljZV9wcmVzZW50KCkgaXMgZmFsc2U6DQo+
ID4gDQo+ID4gICAgICAgICAqbm90aWZpZWQgPSBmYWxzZTsNCj4gPiAgICAgICAgIGlmICghbmV0
aWZfcnVubmluZyhici0+ZGV2KSkNCj4gPiAgICAgICAgICAgICAgICAgcmV0dXJuOw0KPiA+IA0K
PiA+IFRoZSBvbmx5IG90aGVyIHdvcmsgdGhlIGJyaWRnZSBub3RpZmllciBkb2VzIGlzOg0KPiA+
IA0KPiA+ICAgICAgICAgaWYgKGV2ZW50ICE9IE5FVERFVl9VTlJFR0lTVEVSKQ0KPiA+ICAgICAg
ICAgICAgICAgICBicl92bGFuX3BvcnRfZXZlbnQocCwgZXZlbnQpOw0KPiA+IA0KPiA+IGFuZDoN
Cj4gPiANCj4gPiAgICAgICAgIC8qIEV2ZW50cyB0aGF0IG1heSBjYXVzZSBzcGFubmluZyB0cmVl
IHRvIHJlZnJlc2ggKi8NCj4gPiAgICAgICAgIGlmICghbm90aWZpZWQgJiYgKGV2ZW50ID09IE5F
VERFVl9DSEFOR0VBRERSIHx8IGV2ZW50ID09IE5FVERFVl9VUCB8fA0KPiA+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgZXZlbnQgPT0gTkVUREVWX0NIQU5HRSB8fCBldmVudCA9PSBORVRERVZf
RE9XTikpDQo+ID4gICAgICAgICAgICAgICAgIGJyX2lmaW5mb19ub3RpZnkoUlRNX05FV0xJTkss
IE5VTEwsIHApOw0KPiA+IA0KPiA+IFNvIHNvbWUgdmxhbiBzdHVmZiwgYW5kIGVtaXR0aW5nIGEg
bmV0bGluayBtZXNzYWdlIHRvIGFueSBhdmFpbGFibGUNCj4gPiBsaXN0ZW5lcnMuDQo+ID4gDQo+
ID4gU2hvdWxkIHdlIHJlYWxseSBkbyBhbGwgb2YgdGhpcyBmb3IgYSBkZXZpY2Ugd2hpY2ggaXMg
bm90IGV2ZW4NCj4gPiBwcmVzZW50Pw0KPiA+IA0KPiA+IFRoaXMgd2hvbGUgc2l0dWF0aW9uIHNl
ZW1zIGNvbXBsZXRlbHkgaWxsb2dpY2FsLiAgVGhlIGRldmljZSBpcw0KPiA+IHVzZWxlc3MsIGl0
IGxvZ2ljYWxseSBoYXMgbm8gbGluayBvciBvdGhlciBzdGF0ZSB0aGF0IGNhbiBiZSBtYW5hZ2Vk
DQo+ID4gb3IgdXNlZCwgd2hpbGUgaXQgaXMgbm90IHByZXNlbnQuDQo+ID4gDQo+ID4gU28gYWxs
IG9mIHRoZXNlIGJyaWRnZSBvcGVyYXRpb25zIHNob3VsZCBvbmx5IGhhcHBlbiB3aGVuIHRoZSBk
ZXZpY2UNCj4gPiB0cmFuc2l0aW9ucyBiYWNrIHRvIHByZXNlbnQgYWdhaW4uDQo+IA0KPiBUaGFu
a3MgZm9yIHlvdXIgYW5hbHlzaXMhDQo+IEknZCBsaWtlIHRvIGRlZmVyIHRoaXMgdG8gdGhlIGJy
aWRnZSBwZW9wbGUgKENDKS4NCj4gDQo+IEdye29ldGplLGVldGluZ31zLA0KPiANCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgR2VlcnQNCj4gDQoNCkhpLA0KU29ycnkgZm9yIHRoZSBkZWxheS4g
SW50ZXJlc3RpbmcgcHJvYmxlbS4gOikNClRoYW5rcyBmb3IgdGhlIGFuYWx5c2lzLCBJIGRvbid0
IHNlZSBhbnkgaXNzdWVzIHdpdGggY2hlY2tpbmcgaWYgdGhlIGRldmljZQ0KaXNuJ3QgcHJlc2Vu
dC4gSXQgd2lsbCBoYXZlIHRvIGdvIHRocm91Z2ggc29tZSB0ZXN0aW5nLCBidXQgbm8gb2J2aW91
cw0Kb2JqZWN0aW9ucy9pc3N1ZXMuIEhhdmUgeW91IHRyaWVkIGlmIGl0IGZpeGVzIHlvdXIgY2Fz
ZT8NCkkgaGF2ZSBicmllZmx5IGdvbmUgb3ZlciBkcml2ZXJzJyB1c2Ugb2YgbmV0X2RldmljZV9k
ZXRhY2goKSwgbW9zdGx5IGl0J3MgdXNlZA0KZm9yIHN1c3BlbmRzLCBidXQgdGhlcmUgYXJlIGEg
ZmV3IGNhc2VzIHdoaWNoIHVzZSBpdCBvbiBJTyBlcnJvciBvciB3aGVuIGENCmRldmljZSBpcyBh
Y3R1YWxseSBkZXRhY2hpbmcgKFZGIGRldGFjaCkuIFRoZSB2bGFuIHBvcnQgZXZlbnQgaXMgZm9y
IHZsYW4NCmRldmljZXMgb24gdG9wIG9mIHRoZSBicmlkZ2Ugd2hlbiBCUk9QVF9WTEFOX0JSSURH
RV9CSU5ESU5HIGlzIGVuYWJsZWQgYW5kIHRoZWlyDQpjYXJyaWVyIGlzIGNoYW5nZWQgYmFzZWQg
b24gdmxhbiBwYXJ0aWNpcGF0aW5nIHBvcnRzJyBzdGF0ZS4NCg0KVGhhbmtzLA0KIE5paw0KDQo=
