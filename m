Return-Path: <nikolay@nvidia.com>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Date: Wed, 14 Oct 2020 10:50:38 +0000
Message-ID: <8804be4ea95ea61eabd030eff51ca5116512d184.camel@nvidia.com>
References: <20201012140428.2549163-1-henrik.bjoernlund@microchip.com>
 <20201012140428.2549163-2-henrik.bjoernlund@microchip.com>
In-Reply-To: <20201012140428.2549163-2-henrik.bjoernlund@microchip.com>
Reply-To: Nikolay Aleksandrov <nikolay@nvidia.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <B07A3D8BE4C5B045A829AD4B030DAFA0@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1602672598; bh=x2F0/9+JMJi2vJGCxiqHYsecFSaVZTKkAHAZW5Ygc24=;
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
 b=baJO6lryBoVUXdIURSUox162ScQz0ltOLKqC0koB2+vvXybJ/VLcGqlbnHneqpbEi
 sPr5i13WNgNC8otZZAZEpp9gQSgBAWPJje2wqIxW5HYr9MGUlG1G7MNE/XUDOdOOOz
 IxqVp6xl7aG3K6GjH2asGShnqBzdblw3CsYOX5x3L98R8IP+jHmpLHrjXgf12zb8MZ
 GBdJP1bFUBTH3oGiX6H0akyGuxpcDB6eDUiKBo1bogG4BUJO86cBnevLl2aWnIKZ6x
 W8oTZkJcLjcKfacpv/sddHEA+0/6q4jBP/wLCYwHUKxzkHw6FcLwWwSHHOwrO6nUun
 5N/4kkGTnbmGA==
Subject: Re: [Bridge] [PATCH net-next v5 01/10] net: bridge: extend the
 process of special frames
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

T24gTW9uLCAyMDIwLTEwLTEyIGF0IDE0OjA0ICswMDAwLCBIZW5yaWsgQmpvZXJubHVuZCB3cm90
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
IFNpZ25lZC1vZmYtYnk6IEhlbnJpayBCam9lcm5sdW5kICA8aGVucmlrLmJqb2Vybmx1bmRAbWlj
cm9jaGlwLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IEhvcmF0aXUgVnVsdHVyICA8aG9yYXRpdS52dWx0
dXJAbWljcm9jaGlwLmNvbT4NCj4gLS0tDQo+ICBuZXQvYnJpZGdlL2JyX2RldmljZS5jICB8ICAx
ICsNCj4gIG5ldC9icmlkZ2UvYnJfaW5wdXQuYyAgIHwgMzMgKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKystDQo+ICBuZXQvYnJpZGdlL2JyX21ycC5jICAgICB8IDE5ICsrKysrKysrKysr
KysrKy0tLS0NCj4gIG5ldC9icmlkZ2UvYnJfcHJpdmF0ZS5oIHwgMTkgKysrKysrKysrKysrLS0t
LS0tLQ0KPiAgNCBmaWxlcyBjaGFuZ2VkLCA2MCBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMo
LSkNCj4gDQoNCkxvb2tzIGdvb2QuDQpBY2tlZC1ieTogTmlrb2xheSBBbGVrc2FuZHJvdiA8bmlr
b2xheUBudmlkaWEuY29tPg0KDQo=
