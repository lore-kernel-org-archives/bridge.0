Return-Path: <nikolay@nvidia.com>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Date: Fri, 9 Oct 2020 21:52:32 +0000
Message-ID: <2ec76c98813c8190ced9e34b70b46d2dad94d714.camel@nvidia.com>
References: <20201009143530.2438738-1-henrik.bjoernlund@microchip.com>
 <20201009143530.2438738-7-henrik.bjoernlund@microchip.com>
In-Reply-To: <20201009143530.2438738-7-henrik.bjoernlund@microchip.com>
Reply-To: Nikolay Aleksandrov <nikolay@nvidia.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <4868D7FDBE19674CA5711868EF963C64@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1602280341; bh=I09VDzVoZh5+iTBqSAwOOIkD+EDlxCvrdK8PCBQVTjc=;
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
 b=BwzKBPedMbEJ1XP7QvpYfw4WfW9Nptve7Ymd0rpwrI5LqCFBwGqrsDZkvWb9YAB+k
 8NmQSyygvLRXZxPIKviL2MkIXGpJsvvzh9CmfILr1EBvKN3wWZQZqcq1po+cYo4sIp
 sczXHrkxXE6MUViJ5CyQuNhargi4nFLU+U8vJ/+xcbbGmd3j5L81A0jjYS/Hm9vwp6
 muOHTENORlyp/ApIggL+D+Rt2xXUZr5eG1deMEWHbXWBX12I2D+t8xkQRAUJr4K44I
 pNc4p4mFh8lq4pL0QZwGF/Szr0/yUDY+7DpgNv9Vu0pdOupMY6ODs4aD12fiOg7XEd
 dZdURKnJ0CtVQ==
Subject: Re: [Bridge] [PATCH net-next v4 06/10] bridge: cfm: Kernel space
 implementation of CFM. CCM frame RX added.
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

T24gRnJpLCAyMDIwLTEwLTA5IGF0IDE0OjM1ICswMDAwLCBIZW5yaWsgQmpvZXJubHVuZCB3cm90
ZToNCj4gVGhpcyBpcyB0aGUgdGhpcmQgY29tbWl0IG9mIHRoZSBpbXBsZW1lbnRhdGlvbiBvZiB0
aGUgQ0ZNIHByb3RvY29sDQo+IGFjY29yZGluZyB0byA4MDIuMVEgc2VjdGlvbiAxMi4xNC4NCj4g
DQo+IEZ1bmN0aW9uYWxpdHkgaXMgZXh0ZW5kZWQgd2l0aCBDQ00gZnJhbWUgcmVjZXB0aW9uLg0K
PiBUaGUgTUVQIGluc3RhbmNlIG5vdyBjb250YWlucyBDQ00gYmFzZWQgc3RhdHVzIGluZm9ybWF0
aW9uLg0KPiBNb3N0IGltcG9ydGFudCBpcyB0aGUgQ0NNIGRlZmVjdCBzdGF0dXMgaW5kaWNhdGlu
ZyBpZiBjb3JyZWN0DQo+IENDTSBmcmFtZXMgYXJlIHJlY2VpdmVkIHdpdGggdGhlIGV4cGVjdGVk
IGludGVydmFsLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSGVucmlrIEJqb2Vybmx1bmQgIDxoZW5y
aWsuYmpvZXJubHVuZEBtaWNyb2NoaXAuY29tPg0KPiBSZXZpZXdlZC1ieTogSG9yYXRpdSBWdWx0
dXIgIDxob3JhdGl1LnZ1bHR1ckBtaWNyb2NoaXAuY29tPg0KPiAtLS0NCj4gIGluY2x1ZGUvdWFw
aS9saW51eC9jZm1fYnJpZGdlLmggfCAgMTAgKysNCj4gIG5ldC9icmlkZ2UvYnJfY2ZtLmMgICAg
ICAgICAgICAgfCAyNjkgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gIG5ldC9i
cmlkZ2UvYnJfcHJpdmF0ZV9jZm0uaCAgICAgfCAgMzIgKysrKw0KPiAgMyBmaWxlcyBjaGFuZ2Vk
LCAzMTEgaW5zZXJ0aW9ucygrKQ0KPiANCg0KQWNrZWQtYnk6IE5pa29sYXkgQWxla3NhbmRyb3Yg
PG5pa29sYXlAbnZpZGlhLmNvbT4NCg0KDQo=
