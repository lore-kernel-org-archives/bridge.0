Return-Path: <nikolay@nvidia.com>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Date: Fri, 9 Oct 2020 21:49:51 +0000
Message-ID: <a091e766d38c00ef4d70b3bc003e16dc3747789b.camel@nvidia.com>
References: <20201009143530.2438738-1-henrik.bjoernlund@microchip.com>
 <20201009143530.2438738-6-henrik.bjoernlund@microchip.com>
In-Reply-To: <20201009143530.2438738-6-henrik.bjoernlund@microchip.com>
Reply-To: Nikolay Aleksandrov <nikolay@nvidia.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <FD7F611A7F75EC4E95D32E5F0D2A9E96@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1602280198; bh=jE3mpOQs7xCk0hccpDGeWls6q+9ixAr7njjTGhz+ZnM=;
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
 b=XobY/NaflLq0OLBq1GUooNgR6KkrunQ5OHiUTdpsXJ/rQhs1EcS9igyHdS8Hx+4RW
 ZHzCAEtuu0wchQ0AOkBtAHzCyfN3aBc/LjeUvkxtqgrmnA7LLMkgrtW3+HF4CzOq7s
 ij+4e9lTzKKBe+MD01QHAkqwMTOnXAfUzI2iIpbI/DEufQoTxjGZCFKY2hGB9r3XhH
 9Nq2hndeDOxEPOtnV0R/nQSJ0jtvqk1GWLdP33/g6K80a9tAinZ2vHz1akRO/OTFjJ
 FcvroYKVhHa5pvIXkl17DYye5fx10K3s2WiU1ttNM/p1A6mD23hsj0LwC2rtZjikwf
 c3oYF7jLeAmFw==
Subject: Re: [Bridge] [PATCH net-next v4 05/10] bridge: cfm: Kernel space
 implementation of CFM. CCM frame TX added.
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
ZToNCj4gVGhpcyBpcyB0aGUgc2Vjb25kIGNvbW1pdCBvZiB0aGUgaW1wbGVtZW50YXRpb24gb2Yg
dGhlIENGTSBwcm90b2NvbA0KPiBhY2NvcmRpbmcgdG8gODAyLjFRIHNlY3Rpb24gMTIuMTQuDQo+
IA0KPiBGdW5jdGlvbmFsaXR5IGlzIGV4dGVuZGVkIHdpdGggQ0NNIGZyYW1lIHRyYW5zbWlzc2lv
bi4NCj4gDQo+IEludGVyZmFjZSBpcyBleHRlbmRlZCB3aXRoIHRoZXNlIGZ1bmN0aW9uczoNCj4g
YnJfY2ZtX2NjX3JkaV9zZXQoKQ0KPiBicl9jZm1fY2NfY2NtX3R4KCkNCj4gYnJfY2ZtX2NjX2Nv
bmZpZ19zZXQoKQ0KPiANCj4gQSBNRVAgQ29udGludWl0eSBDaGVjayBmZWF0dXJlIGNhbiBiZSBj
b25maWd1cmVkIGJ5DQo+IGJyX2NmbV9jY19jb25maWdfc2V0KCkNCj4gICAgIFRoZSBDb250aW51
aXR5IENoZWNrIHBhcmFtZXRlcnMgY2FuIGJlIGNvbmZpZ3VyZWQgdG8gYmUgdXNlZCB3aGVuDQo+
ICAgICB0cmFuc21pdHRpbmcgQ0NNLg0KPiANCj4gQSBNRVAgY2FuIGJlIGNvbmZpZ3VyZWQgdG8g
c3RhcnQgb3Igc3RvcCB0cmFuc21pc3Npb24gb2YgQ0NNIGZyYW1lcyBieQ0KPiBicl9jZm1fY2Nf
Y2NtX3R4KCkNCj4gICAgIFRoZSBDQ00gd2lsbCBiZSB0cmFuc21pdHRlZCBmb3IgYSBzZWxlY3Rl
ZCBwZXJpb2QgaW4gc2Vjb25kcy4NCj4gICAgIE11c3QgY2FsbCB0aGlzIGZ1bmN0aW9uIGJlZm9y
ZSB0aW1lb3V0IHRvIGtlZXAgdHJhbnNtaXNzaW9uIGFsaXZlLg0KPiANCj4gQSBNRVAgdHJhbnNt
aXR0aW5nIENDTSBjYW4gYmUgY29uZmlndXJlZCB3aXRoIGluc2VydGVkIFJESSBpbiBQRFUgYnkN
Cj4gYnJfY2ZtX2NjX3JkaV9zZXQoKQ0KPiANCj4gU2lnbmVkLW9mZi1ieTogSGVucmlrIEJqb2Vy
bmx1bmQgIDxoZW5yaWsuYmpvZXJubHVuZEBtaWNyb2NoaXAuY29tPg0KPiBSZXZpZXdlZC1ieTog
SG9yYXRpdSBWdWx0dXIgIDxob3JhdGl1LnZ1bHR1ckBtaWNyb2NoaXAuY29tPg0KPiAtLS0NCj4g
IGluY2x1ZGUvdWFwaS9saW51eC9jZm1fYnJpZGdlLmggfCAgMzkgKysrKy0NCj4gIG5ldC9icmlk
Z2UvYnJfY2ZtLmMgICAgICAgICAgICAgfCAyODQgKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysNCj4gIG5ldC9icmlkZ2UvYnJfcHJpdmF0ZV9jZm0uaCAgICAgfCAgNTQgKysrKysrDQo+
ICAzIGZpbGVzIGNoYW5nZWQsIDM3NiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0K
DQpBY2tlZC1ieTogTmlrb2xheSBBbGVrc2FuZHJvdiA8bmlrb2xheUBudmlkaWEuY29tPg0KDQo=
