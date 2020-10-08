Return-Path: <nikolay@nvidia.com>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Date: Thu, 8 Oct 2020 17:54:40 +0000
Message-ID: <a7a0f63afdcd30ec89692781b5804d0cb28e7ee8.camel@nvidia.com>
References: <20201007120700.2152699-1-henrik.bjoernlund@microchip.com>
 <32183f25a3d7ee8c148db42fbed9dd2a6e0a1f92.camel@nvidia.com>
 <585c251204d3c09150e9fcb60f560c599567688a.camel@nvidia.com>
 <20201008100930.1e5fca41@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20201008100930.1e5fca41@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Reply-To: Nikolay Aleksandrov <nikolay@nvidia.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <7E2017FD1D522346A6A26A05E87301B3@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1602179710; bh=mbd8mTHSWEsXWlezFORpjy2Fdh3v90dlI9gbl+Trhxs=;
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
 b=Fp7qktllAmY8p3heE1yWQgkFsneOoWNTcwpOIUnmWWTMPAxNGcYecj+RFK7mDmW0E
 aAk3c28/MBL4h+OqoTsDtUOqKvtmCJ+J4GeQaIphg4T1FJ2w41bEjneECty3vpuq68
 HYJ7KRrBAlNF/WKL/2pa5KUKkZmOznKE7eQ7/dbKPcbq+u3OCjd+jCP7rtxWgpzzQz
 Bm/diEmw5ZIZ0n79fE3+/ud47r6jymuR91e0n+ihbxj9QXVYeFSK8F5BVVH+scsC7F
 sxRb89olr5dBwrKMvsDrcPxZbYAN24LVKgUKpv0j7ZwUzzOFCRvF0e7MQkU0htrwtQ
 RoYMFjNIw7ajQ==
Subject: Re: [Bridge] [PATCH net] bridge: Netlink interface fix.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "kuba@kernel.org" <kuba@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, "henrik.bjoernlund@microchip.com" <henrik.bjoernlund@microchip.com>, Roopa Prabhu <roopa@nvidia.com>, "UNGLinuxDriver@microchip.com" <UNGLinuxDriver@microchip.com>, "horatiu.vultur@microchip.com" <horatiu.vultur@microchip.com>

T24gVGh1LCAyMDIwLTEwLTA4IGF0IDEwOjA5IC0wNzAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToN
Cj4gT24gVGh1LCA4IE9jdCAyMDIwIDEwOjE4OjA5ICswMDAwIE5pa29sYXkgQWxla3NhbmRyb3Yg
d3JvdGU6DQo+ID4gT24gV2VkLCAyMDIwLTEwLTA3IGF0IDE0OjQ5ICswMDAwLCBOaWtvbGF5IEFs
ZWtzYW5kcm92IHdyb3RlOg0KPiA+ID4gT24gV2VkLCAyMDIwLTEwLTA3IGF0IDEyOjA3ICswMDAw
LCBIZW5yaWsgQmpvZXJubHVuZCB3cm90ZTogIA0KPiA+ID4gPiBUaGlzIGNvbW1pdCBpcyBjb3Jy
ZWN0aW5nIE5FVExJTksgYnJfZmlsbF9pZmluZm8oKSB0byBiZSBhYmxlIHRvDQo+ID4gPiA+IGhh
bmRsZSAnZmlsdGVyX21hc2snIHdpdGggbXVsdGlwbGUgZmxhZ3MgYXNzZXJ0ZWQuDQo+ID4gPiA+
IA0KPiA+ID4gPiBGaXhlczogMzZhOGU4ZTI2NTQyMCAoImJyaWRnZTogRXh0ZW5kIGJyX2ZpbGxf
aWZpbmZvIHRvIHJldHVybiBNUFIgc3RhdHVzIikNCj4gPiA+ID4gDQo+ID4gPiA+IFNpZ25lZC1v
ZmYtYnk6IEhlbnJpayBCam9lcm5sdW5kIDxoZW5yaWsuYmpvZXJubHVuZEBtaWNyb2NoaXAuY29t
Pg0KPiA+ID4gPiBSZXZpZXdlZC1ieTogSG9yYXRpdSBWdWx0dXIgPGhvcmF0aXUudnVsdHVyQG1p
Y3JvY2hpcC5jb20+DQo+ID4gPiA+IFN1Z2dlc3RlZC1ieTogTmlrb2xheSBBbGVrc2FuZHJvdiA8
bmlrb2xheUBudmlkaWEuY29tPg0KPiA+ID4gPiBUZXN0ZWQtYnk6IEhvcmF0aXUgVnVsdHVyIDxo
b3JhdGl1LnZ1bHR1ckBtaWNyb2NoaXAuY29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gIG5ldC9i
cmlkZ2UvYnJfbmV0bGluay5jIHwgMjYgKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0NCj4gPiA+
ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCAxNSBkZWxldGlvbnMoLSkNCj4g
PiA+ID4gICANCj4gPiA+IA0KPiA+ID4gVGhlIHBhdGNoIGxvb2tzIGdvb2QsIHBsZWFzZSBkb24n
dCBzZXBhcmF0ZSB0aGUgRml4ZXMgdGFnIGZyb20gdGhlIG90aGVycy4NCj4gPiA+IEFja2VkLWJ5
OiBOaWtvbGF5IEFsZWtzYW5kcm92IDxuaWtvbGF5QG52aWRpYS5jb20+DQo+ID4gPiAgIA0KPiA+
IA0KPiA+IFRCSCwgdGhpcyBkb2VzIGNoYW5nZSBhIHVzZXIgZmFjaW5nIGFwaSAodGhlIGF0dHJp
YnV0ZSBuZXN0aW5nKSwgYnV0IEkgdGhpbmsNCj4gPiBpbiB0aGlzIGNhc2UgaXQncyBhY2NlcHRh
YmxlIGR1ZSB0byB0aGUgZm9ybWF0IGJlaW5nIHdyb25nIGFuZCBNUlAgYmVpbmcgbmV3LCBzbw0K
PiA+IEkgZG91YnQgYW55b25lIGlzIHlldCBkdW1waW5nIGl0IG1peGVkIHdpdGggdmxhbiBmaWx0
ZXJfbWFzayBhbmQgY2hlY2tpbmcgZm9yDQo+ID4gdHdvIGlkZW50aWNhbCBhdHRyaWJ1dGVzLCBp
LmUuIGluIHRoZSBvbGQvYnJva2VuIGNhc2UgcGFyc2luZyB0aGUgYXR0cmlidXRlcw0KPiA+IGlu
dG8gYSB0YWJsZSB3b3VsZCBoaWRlIG9uZSBvZiB0aGVtIGFuZCB5b3UnZCBoYXZlIHRvIHdhbGsg
b3ZlciBhbGwgYXR0cmlidXRlcw0KPiA+IHRvIGNhdGNoIHRoYXQuDQo+IA0KPiBUbyBiZSBjbGVh
ciAtIHRoaXMgY2hhbmdlcyB0aGUgdUFQSSBhcyBmYXIgYXMgNS45LXJjcyBhcmUgY29uY2VybmVk
LiANCj4gU28gaWYgdGhpcyBjaGFuZ2Ugd2FzIHRvIGhpdCA1LjkgZmluYWwgdGhlcmUgd291bGQg
YmUgbm8gdUFQSSBicmVha2FnZSwNCj4gcmlnaHQ/DQoNClllcywgY29ycmVjdC4NCg==
