Return-Path: <nikolay@nvidia.com>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Date: Tue, 27 Oct 2020 15:09:27 +0000
Message-ID: <0dd2e57a61d618984648a3bf6373728f61a8fecf.camel@nvidia.com>
References: <20201027100251.3241719-1-henrik.bjoernlund@microchip.com>
 <20201027100251.3241719-2-henrik.bjoernlund@microchip.com>
 <20201027075921.69976131@hermes.local>
In-Reply-To: <20201027075921.69976131@hermes.local>
Reply-To: Nikolay Aleksandrov <nikolay@nvidia.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <A2187ED1B5E62F40AD7D297CDD0A739F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1603811370; bh=lIn8VrD8UlH+41e59jfyfdchwtN6vO0NxG3TV3AXGr0=;
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
 b=j/u/YQq7N9OFY1Hi4vw1Iwpk6Q9kn67s5uU/j/dRQU3jIhbOE55akcKgUz+MN0ifV
 pwtsm1joq6kzk/5mnzPttBTIdnFR24FKLFMSANQhziJ8WpmvFEfkcR4YV79zsg89hZ
 DDG7Jn1RPPG38nXH0WGwM+tpMR1p2WqYbX/i1WmFPxPPSxU70wdf6FY5YHOvizMFOP
 qfxbXSxldr/sJzV64WhOudq5BUXajGpkPRasmsoXG/jZhUPsUx7sW/e6K0nBsqKI8o
 NA5/nIJSSRPW1Ic8Za5RPUKgr1mgRlTfhvYJRtPEvUrP0xUVDz8/k0tPIhmPuz30GH
 oy8nrBRsIhprQ==
Subject: Re: [Bridge] [PATCH net-next v7 01/10] net: bridge: extend the
 process of special frames
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "stephen@networkplumber.org" <stephen@networkplumber.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "jiri@mellanox.com" <jiri@mellanox.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "idosch@mellanox.com" <idosch@mellanox.com>, "henrik.bjoernlund@microchip.com" <henrik.bjoernlund@microchip.com>, Roopa Prabhu <roopa@nvidia.com>, "kuba@kernel.org" <kuba@kernel.org>, "UNGLinuxDriver@microchip.com" <UNGLinuxDriver@microchip.com>, "horatiu.vultur@microchip.com" <horatiu.vultur@microchip.com>, "davem@davemloft.net" <davem@davemloft.net>

T24gVHVlLCAyMDIwLTEwLTI3IGF0IDA3OjU5IC0wNzAwLCBTdGVwaGVuIEhlbW1pbmdlciB3cm90
ZToNCj4gT24gVHVlLCAyNyBPY3QgMjAyMCAxMDowMjo0MiArMDAwMA0KPiBIZW5yaWsgQmpvZXJu
bHVuZCB2aWEgQnJpZGdlIDxicmlkZ2VAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmc+IHdyb3Rl
Og0KPiANCj4gPiArLyogUmV0dXJuIDAgaWYgdGhlIGZyYW1lIHdhcyBub3QgcHJvY2Vzc2VkIG90
aGVyd2lzZSAxDQo+ID4gKyAqIG5vdGU6IGFscmVhZHkgY2FsbGVkIHdpdGggcmN1X3JlYWRfbG9j
aw0KPiA+ICsgKi8NCj4gPiArc3RhdGljIGludCBicl9wcm9jZXNzX2ZyYW1lX3R5cGUoc3RydWN0
IG5ldF9icmlkZ2VfcG9ydCAqcCwNCj4gPiArCQkJCSBzdHJ1Y3Qgc2tfYnVmZiAqc2tiKQ0KPiA+
ICt7DQo+ID4gKwlzdHJ1Y3QgYnJfZnJhbWVfdHlwZSAqdG1wOw0KPiA+ICsNCj4gPiArCWhsaXN0
X2Zvcl9lYWNoX2VudHJ5X3JjdSh0bXAsICZwLT5ici0+ZnJhbWVfdHlwZV9saXN0LCBsaXN0KQ0K
PiA+ICsJCWlmICh1bmxpa2VseSh0bXAtPnR5cGUgPT0gc2tiLT5wcm90b2NvbCkpDQo+ID4gKwkJ
CXJldHVybiB0bXAtPmZyYW1lX2hhbmRsZXIocCwgc2tiKTsNCj4gPiArDQo+ID4gKwlyZXR1cm4g
MDsNCj4gPiArfQ0KPiANCj4gRG9lcyB0aGUgbGluZWFyIHNlYXJjaCBvZiBmcmFtZSB0eXBlcyBo
YXZlIG5vdGljYWJsZSBpbXBhY3Qgb24gcGVyZm9ybWFuY2U/DQo+IEhpbnQ6IG1heWJlIGEgYml0
bWFwIG9yIHNvbWV0aGluZyB3b3VsZCBiZSBmYXN0ZXIuDQoNCkkgZG9uJ3QgdGhpbmsgaXQncyBu
ZWNlc3NhcnkgdG8gb3B0aW1pemUgaXQgc28gZWFybHkuIFRoZXJlIGFyZSBvbmx5IDIgcG9zc2li
bGUNCnR5cGVzIHNvIGZhciAod2l0aCB0aGlzIHNldCBpbmNsdWRlZCkgaWYgQ2ZNIGFuZCBNUlAg
Ym90aCBhcmUgaW4gdXNlLCBpZiBhdCBzb21lDQpwb2ludCBpdCBncm93cyB3ZSBjYW4gdHVybiBp
dCBpbnRvIGEgaGFzaCBvciBiaXRtYXAsIGF0IHRoZSBtb21lbnQgYSBzaW1wbGUgYW5kDQplYXNp
ZXIgdG8gbWFpbnRhaW4gc29sdXRpb24gc2VlbXMgYmV0dGVyIHRvIG1lLiBXZSBjb3VsZCBtYXNr
IHRoZSBzZWFyY2ggaXRzZWxmDQpiZWhpbmQgYSBzdGF0aWMga2V5IGFuZCBkbyBpdCBvbmx5IGlm
IGEgcHJvdG9jb2wgaXMgcmVnaXN0ZXJlZCB0byBtaW5pbWl6ZSB0aGUNCmltcGFjdCBmdXJ0aGVy
Lg0KDQpDaGVlcnMsDQogTmlrDQoNCg0K
