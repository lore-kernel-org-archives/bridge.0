Return-Path: <nikolay@nvidia.com>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Date: Fri, 9 Oct 2020 21:40:02 +0000
Message-ID: <d614886f589e753c75bfd146da7a4ada98a84566.camel@nvidia.com>
References: <20201009143530.2438738-1-henrik.bjoernlund@microchip.com>
 <20201009143530.2438738-3-henrik.bjoernlund@microchip.com>
In-Reply-To: <20201009143530.2438738-3-henrik.bjoernlund@microchip.com>
Reply-To: Nikolay Aleksandrov <nikolay@nvidia.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <1D67016BA2D74E43B79EE0EF309148FF@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1602279605; bh=MvdfHE5n57eHvHQc7EMX0wX/IA5vR/jx6PS5SxBPbcM=;
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
 b=QpeO5wUVqin9JvHvRfW6iwIlpoibaGocPCAN+AHKkZ8STIGki7LeAJM6m9TeTwTW2
 6OwYuPo3KY4IOuxtsBhJWTOuSo2r67KlljwqgjgQaaRET6MfHCi/KWLjGfardx3WYE
 H2DuR7y2zTM1fKkyNnCgFH3lhjRG5JTzOFUVFGvUtl0JTyylXINVdTGTqeZSocdJqG
 QH1XYGo4yY6+lDVfY5OE1rm+f0Q1+7n2g9+G4oqQiSqB28X5rQIuNVJKDCIpK6qftL
 AH3fraU+QBMwcieCGFOP9xxeeRyCGowDd57Psn4JbLH4njnZrUpJI2xraNz8MzagJk
 neyd/ejjj+r8w==
Subject: Re: [Bridge] [PATCH net-next v4 02/10] bridge: cfm: Add BRIDGE_CFM
	to Kconfig.
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
ZToNCj4gVGhpcyBtYWtlcyBpdCBwb3NzaWJsZSB0byBpbmNsdWRlIG9yIGV4Y2x1ZGUgdGhlIENG
TQ0KPiBwcm90b2NvbCBhY2NvcmRpbmcgdG8gODAyLjFRIHNlY3Rpb24gMTIuMTQuDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBIZW5yaWsgQmpvZXJubHVuZCAgPGhlbnJpay5iam9lcm5sdW5kQG1pY3Jv
Y2hpcC5jb20+DQo+IFJldmlld2VkLWJ5OiBIb3JhdGl1IFZ1bHR1ciAgPGhvcmF0aXUudnVsdHVy
QG1pY3JvY2hpcC5jb20+DQo+IC0tLQ0KPiAgbmV0L2JyaWRnZS9LY29uZmlnICAgICAgfCAxMSAr
KysrKysrKysrKw0KPiAgbmV0L2JyaWRnZS9icl9kZXZpY2UuYyAgfCAgMyArKysNCj4gIG5ldC9i
cmlkZ2UvYnJfcHJpdmF0ZS5oIHwgIDMgKysrDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDE3IGluc2Vy
dGlvbnMoKykNCj4gDQoNCkFja2VkLWJ5OiBOaWtvbGF5IEFsZWtzYW5kcm92IDxuaWtvbGF5QG52
aWRpYS5jb20+DQo=
