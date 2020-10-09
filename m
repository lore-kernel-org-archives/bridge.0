Return-Path: <nikolay@nvidia.com>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Date: Fri, 9 Oct 2020 21:41:12 +0000
Message-ID: <eda6fb9c0535077be89d2ee7dd9f7e12f730ef68.camel@nvidia.com>
References: <20201009143530.2438738-1-henrik.bjoernlund@microchip.com>
 <20201009143530.2438738-4-henrik.bjoernlund@microchip.com>
In-Reply-To: <20201009143530.2438738-4-henrik.bjoernlund@microchip.com>
Reply-To: Nikolay Aleksandrov <nikolay@nvidia.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <CFFF9698345104489C95AC5C8AE91CE0@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1602279617; bh=ynn4ygqhnj3RM4OdfcN8TkkP5pcf3H96UUTDqOs3FHE=;
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
 b=Xk2hsGucu9i6QRS6V3MZ3mTJX/sUu0bFpiOnh72yQHFhuCDnG8h7rOlBzntwUl7rm
 PT7ex9AgJU4Q1YN9HEa3AIiHTY9x9RApsMRdr4x/3fihXKAec/gVJbfBld4YKdfsMR
 /zToWNy3rXTGVHAW6x0WC1Tb6aHpZ0BfnIDKRAiXN+EYONed59AkJAUcNh5pGk48Qf
 fYtRY/U2o5SPAH+0fyYeN0DFRAIIfvTeXhQq32OyoY4BZrNFcxAO2Q06OxZfzjxxUc
 NcJNaWm7jjs9aJjShniukzh5Lv8D6AcB+Q4DqoQHmhCCfQf7znTNKrmfF8ZfReIQTe
 ETD6FeYso5ysw==
Subject: Re: [Bridge] [PATCH net-next v4 03/10] bridge: uapi: cfm: Added
 EtherType used by the CFM protocol.
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
ZToNCj4gVGhpcyBFdGhlclR5cGUgaXMgdXNlZCBieSBhbGwgQ0ZNIHByb3RvY2FsIGZyYW1lcyB0
cmFuc21pdHRlZA0KPiBhY2NvcmRpbmcgdG8gODAyLjFRIHNlY3Rpb24gMTIuMTQuDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBIZW5yaWsgQmpvZXJubHVuZCAgPGhlbnJpay5iam9lcm5sdW5kQG1pY3Jv
Y2hpcC5jb20+DQo+IFJldmlld2VkLWJ5OiBIb3JhdGl1IFZ1bHR1ciAgPGhvcmF0aXUudnVsdHVy
QG1pY3JvY2hpcC5jb20+DQo+IEFja2VkLWJ5OiBOaWtvbGF5IEFsZWtzYW5kcm92IDxuaWtvbGF5
QG52aWRpYS5jb20+DQo+IC0tLQ0KPiAgaW5jbHVkZS91YXBpL2xpbnV4L2lmX2V0aGVyLmggfCAx
ICsNCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiANCg0KQWNrZWQtYnk6IE5p
a29sYXkgQWxla3NhbmRyb3YgPG5pa29sYXlAbnZpZGlhLmNvbT4NCg==
