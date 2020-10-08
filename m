Return-Path: <nikolay@nvidia.com>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Date: Thu, 8 Oct 2020 10:18:09 +0000
Message-ID: <585c251204d3c09150e9fcb60f560c599567688a.camel@nvidia.com>
References: <20201007120700.2152699-1-henrik.bjoernlund@microchip.com>
 <32183f25a3d7ee8c148db42fbed9dd2a6e0a1f92.camel@nvidia.com>
In-Reply-To: <32183f25a3d7ee8c148db42fbed9dd2a6e0a1f92.camel@nvidia.com>
Reply-To: Nikolay Aleksandrov <nikolay@nvidia.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <A6370466707DB64D8F28135E50738949@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1602152234; bh=v7QK+x48Nahz9E245zPp0yBfsIPiIH5jtK/dW+p4mzo=;
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
 b=A4VKAk8H+SgDUJT0Ag1lSF++LbohS7xZBjsBpalvPjJ6Bg0yUOn+fD8Pm/YvC0sO0
 7UcXsT7SEaf6xN3c/M3sYLJJQwOJEB/wo/ztmBDX2CTG9ouvm4hDzwDsLwuTZZGqWD
 NiodIHLhsCP53+Xw+1V6m1x/IVwrcSpNt0hF7lGAlw0B0u5Eqz/5C+IxpgyungGcfm
 FEpKabBuDCAgnAwsEqFlMm+hfCdzm4UnAcCi88hSfgZYsDIyIA7tA4WlinWdd2MUaQ
 ZqZg55VoEzzouZO2yPxr4i1evw0IzEiiaJChD/UJTMg+46u9k3RyfHJIcqP5G30OR+
 dOEetmiUAIbSg==
Subject: Re: [Bridge] [PATCH net] bridge: Netlink interface fix.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "henrik.bjoernlund@microchip.com" <henrik.bjoernlund@microchip.com>, "davem@davemloft.net" <davem@davemloft.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "kuba@kernel.org" <kuba@kernel.org>, "UNGLinuxDriver@microchip.com" <UNGLinuxDriver@microchip.com>, Roopa Prabhu <roopa@nvidia.com>
Cc: "horatiu.vultur@microchip.com" <horatiu.vultur@microchip.com>

T24gV2VkLCAyMDIwLTEwLTA3IGF0IDE0OjQ5ICswMDAwLCBOaWtvbGF5IEFsZWtzYW5kcm92IHdy
b3RlOg0KPiBPbiBXZWQsIDIwMjAtMTAtMDcgYXQgMTI6MDcgKzAwMDAsIEhlbnJpayBCam9lcm5s
dW5kIHdyb3RlOg0KPiA+IFRoaXMgY29tbWl0IGlzIGNvcnJlY3RpbmcgTkVUTElOSyBicl9maWxs
X2lmaW5mbygpIHRvIGJlIGFibGUgdG8NCj4gPiBoYW5kbGUgJ2ZpbHRlcl9tYXNrJyB3aXRoIG11
bHRpcGxlIGZsYWdzIGFzc2VydGVkLg0KPiA+IA0KPiA+IEZpeGVzOiAzNmE4ZThlMjY1NDIwICgi
YnJpZGdlOiBFeHRlbmQgYnJfZmlsbF9pZmluZm8gdG8gcmV0dXJuIE1QUiBzdGF0dXMiKQ0KPiA+
IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEhlbnJpayBCam9lcm5sdW5kIDxoZW5yaWsuYmpvZXJubHVu
ZEBtaWNyb2NoaXAuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBIb3JhdGl1IFZ1bHR1ciA8aG9yYXRp
dS52dWx0dXJAbWljcm9jaGlwLmNvbT4NCj4gPiBTdWdnZXN0ZWQtYnk6IE5pa29sYXkgQWxla3Nh
bmRyb3YgPG5pa29sYXlAbnZpZGlhLmNvbT4NCj4gPiBUZXN0ZWQtYnk6IEhvcmF0aXUgVnVsdHVy
IDxob3JhdGl1LnZ1bHR1ckBtaWNyb2NoaXAuY29tPg0KPiA+IC0tLQ0KPiA+ICBuZXQvYnJpZGdl
L2JyX25ldGxpbmsuYyB8IDI2ICsrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tDQo+ID4gIDEgZmls
ZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCAxNSBkZWxldGlvbnMoLSkNCj4gPiANCj4gDQo+
IFRoZSBwYXRjaCBsb29rcyBnb29kLCBwbGVhc2UgZG9uJ3Qgc2VwYXJhdGUgdGhlIEZpeGVzIHRh
ZyBmcm9tIHRoZSBvdGhlcnMuDQo+IEFja2VkLWJ5OiBOaWtvbGF5IEFsZWtzYW5kcm92IDxuaWtv
bGF5QG52aWRpYS5jb20+DQo+IA0KDQpUQkgsIHRoaXMgZG9lcyBjaGFuZ2UgYSB1c2VyIGZhY2lu
ZyBhcGkgKHRoZSBhdHRyaWJ1dGUgbmVzdGluZyksIGJ1dCBJIHRoaW5rDQppbiB0aGlzIGNhc2Ug
aXQncyBhY2NlcHRhYmxlIGR1ZSB0byB0aGUgZm9ybWF0IGJlaW5nIHdyb25nIGFuZCBNUlAgYmVp
bmcgbmV3LCBzbw0KSSBkb3VidCBhbnlvbmUgaXMgeWV0IGR1bXBpbmcgaXQgbWl4ZWQgd2l0aCB2
bGFuIGZpbHRlcl9tYXNrIGFuZCBjaGVja2luZyBmb3INCnR3byBpZGVudGljYWwgYXR0cmlidXRl
cywgaS5lLiBpbiB0aGUgb2xkL2Jyb2tlbiBjYXNlIHBhcnNpbmcgdGhlIGF0dHJpYnV0ZXMNCmlu
dG8gYSB0YWJsZSB3b3VsZCBoaWRlIG9uZSBvZiB0aGVtIGFuZCB5b3UnZCBoYXZlIHRvIHdhbGsg
b3ZlciBhbGwgYXR0cmlidXRlcw0KdG8gY2F0Y2ggdGhhdC4NCg0KDQo=
