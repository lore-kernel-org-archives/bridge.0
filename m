Return-Path: <nikolay@nvidia.com>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Date: Wed, 7 Oct 2020 14:49:17 +0000
Message-ID: <32183f25a3d7ee8c148db42fbed9dd2a6e0a1f92.camel@nvidia.com>
References: <20201007120700.2152699-1-henrik.bjoernlund@microchip.com>
In-Reply-To: <20201007120700.2152699-1-henrik.bjoernlund@microchip.com>
Reply-To: Nikolay Aleksandrov <nikolay@nvidia.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <54A55BAAEF11184F834429296B94FC63@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1602082147; bh=3Jc9d6oKhSlWFgXQPSyR4MIJKx1eafTynQ0vc7DYmec=;
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
 b=LKdt3A/8P3dWCjD7skfoQ+HQ+cODP6DrpLiu+7pAg2yTupN/8DcmJHGuQzgoHyWZB
 wpwjDqKc+vASc802588Zo8s1FC08K4+ytCpAQXeuA/J3L5xzWenzKgbAU/DVXl9PUA
 Kgt2B05cCVKFI5WtHRcgeVFTEuhFYCNIlsBJtB+4wANrUPC3Tp69om5+mIhZ1muU9Y
 iyEFUE8wgn8vG1unamhmr+u5f+NkkBMfOuNy0gcVNZN8htBAgbelivavRHXTKiQfMQ
 m/DqBk85Axm/vu/Rtg28JRNVphtSB2RM+Bi3y8uqXl+LI6hZxDPxydscGEjtdRhsA4
 dxSDYwLCpCcTg==
Subject: Re: [Bridge] [PATCH net] bridge: Netlink interface fix.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "henrik.bjoernlund@microchip.com" <henrik.bjoernlund@microchip.com>, "davem@davemloft.net" <davem@davemloft.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kuba@kernel.org" <kuba@kernel.org>, Roopa
 Prabhu <roopa@nvidia.com>, "UNGLinuxDriver@microchip.com" <UNGLinuxDriver@microchip.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "horatiu.vultur@microchip.com" <horatiu.vultur@microchip.com>

T24gV2VkLCAyMDIwLTEwLTA3IGF0IDEyOjA3ICswMDAwLCBIZW5yaWsgQmpvZXJubHVuZCB3cm90
ZToNCj4gVGhpcyBjb21taXQgaXMgY29ycmVjdGluZyBORVRMSU5LIGJyX2ZpbGxfaWZpbmZvKCkg
dG8gYmUgYWJsZSB0bw0KPiBoYW5kbGUgJ2ZpbHRlcl9tYXNrJyB3aXRoIG11bHRpcGxlIGZsYWdz
IGFzc2VydGVkLg0KPiANCj4gRml4ZXM6IDM2YThlOGUyNjU0MjAgKCJicmlkZ2U6IEV4dGVuZCBi
cl9maWxsX2lmaW5mbyB0byByZXR1cm4gTVBSIHN0YXR1cyIpDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBIZW5yaWsgQmpvZXJubHVuZCA8aGVucmlrLmJqb2Vybmx1bmRAbWljcm9jaGlwLmNvbT4NCj4g
UmV2aWV3ZWQtYnk6IEhvcmF0aXUgVnVsdHVyIDxob3JhdGl1LnZ1bHR1ckBtaWNyb2NoaXAuY29t
Pg0KPiBTdWdnZXN0ZWQtYnk6IE5pa29sYXkgQWxla3NhbmRyb3YgPG5pa29sYXlAbnZpZGlhLmNv
bT4NCj4gVGVzdGVkLWJ5OiBIb3JhdGl1IFZ1bHR1ciA8aG9yYXRpdS52dWx0dXJAbWljcm9jaGlw
LmNvbT4NCj4gLS0tDQo+ICBuZXQvYnJpZGdlL2JyX25ldGxpbmsuYyB8IDI2ICsrKysrKysrKysr
LS0tLS0tLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgMTUg
ZGVsZXRpb25zKC0pDQo+IA0KDQpUaGUgcGF0Y2ggbG9va3MgZ29vZCwgcGxlYXNlIGRvbid0IHNl
cGFyYXRlIHRoZSBGaXhlcyB0YWcgZnJvbSB0aGUgb3RoZXJzLg0KQWNrZWQtYnk6IE5pa29sYXkg
QWxla3NhbmRyb3YgPG5pa29sYXlAbnZpZGlhLmNvbT4NCg0K
