Return-Path: <nikolay@nvidia.com>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Date: Tue, 6 Oct 2020 10:50:33 +0000
Message-ID: <fb313c83e6ac750d4bcdf96d2b2d7ebe4ae98dd6.camel@nvidia.com>
References: <20201001103019.1342470-1-henrik.bjoernlund@microchip.com>
 <20201001103019.1342470-11-henrik.bjoernlund@microchip.com>
 <20201001124929.GM8264@nanopsycho>
 <20201005130712.ybbgiddb7bnbkz6h@ws.localdomain>
In-Reply-To: <20201005130712.ybbgiddb7bnbkz6h@ws.localdomain>
Reply-To: Nikolay Aleksandrov <nikolay@nvidia.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <11B75A87304983429E8F4FD190217A53@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1601981435; bh=I7s6z5gy1pZhuAIIVBcJ6Jtlz2QAR95SIenqWufVAEc=;
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
 b=PegHcIiEFm1q1KDR2w4XWOqCRAz3HdfU8Rv4JQQwV9akzoinHiF5zHGEnkgYEVl6H
 Gx1GWa6Gl0NDmO9XEwHmjBCYXEhUNbtCbsEPyWbHtMVd7EWeaoTGTakpTuaRe2KZya
 fm2XO518eBzmeSU3eBdJbfXIWtFhveZ1FQ0SuP1DiEQKYa5OoO7mXS6+b++mKMl+X9
 IUFGVmixHwIIMjWKRC17dnxSWc70dCM8iig1NUM3Io2dukvD6hTRqXncb3FguMOONS
 zBkXPu2Po0p819JvVVQ6WmfMVl6WnZyOzN9f5oZsZ43+wnPI6pdI//M6vOsBNbijIl
 TAX9D/TYAg6JQ==
Subject: Re: [Bridge] [net-next v2 10/11] bridge: switchdev: cfm: switchdev
 interface implementation
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "jiri@resnulli.us" <jiri@resnulli.us>, "allan.nielsen@microchip.com" <allan.nielsen@microchip.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "jiri@mellanox.com" <jiri@mellanox.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "idosch@mellanox.com" <idosch@mellanox.com>, "henrik.bjoernlund@microchip.com" <henrik.bjoernlund@microchip.com>, Roopa Prabhu <roopa@nvidia.com>, "kuba@kernel.org" <kuba@kernel.org>, "UNGLinuxDriver@microchip.com" <UNGLinuxDriver@microchip.com>, "horatiu.vultur@microchip.com" <horatiu.vultur@microchip.com>, "davem@davemloft.net" <davem@davemloft.net>

T24gTW9uLCAyMDIwLTEwLTA1IGF0IDE1OjA3ICswMjAwLCBBbGxhbiBXLiBOaWVsc2VuIHdyb3Rl
Og0KPiBIaSBKaXJpDQo+IA0KPiBPbiAwMS4xMC4yMDIwIDE0OjQ5LCBKaXJpIFBpcmtvIHdyb3Rl
Og0KPiA+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2ht
ZW50cyB1bmxlc3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiA+IA0KPiA+IFRodSwg
T2N0IDAxLCAyMDIwIGF0IDEyOjMwOjE4UE0gQ0VTVCwgaGVucmlrLmJqb2Vybmx1bmRAbWljcm9j
aGlwLmNvbSB3cm90ZToNCj4gPiA+IFRoaXMgaXMgdGhlIGRlZmluaXRpb24gb2YgdGhlIENGTSBz
d2l0Y2hkZXYgaW50ZXJmYWNlLg0KPiA+ID4gDQo+ID4gPiBUaGUgaW50ZXJmYWNlIGNvbnNpc3Qg
b2YgdGhlc2Ugb2JqZWN0czoNCj4gPiA+ICAgIFNXSVRDSERFVl9PQkpfSURfTUVQX0NGTSwNCj4g
PiA+ICAgIFNXSVRDSERFVl9PQkpfSURfTUVQX0NPTkZJR19DRk0sDQo+ID4gPiAgICBTV0lUQ0hE
RVZfT0JKX0lEX0NDX0NPTkZJR19DRk0sDQo+ID4gPiAgICBTV0lUQ0hERVZfT0JKX0lEX0NDX1BF
RVJfTUVQX0NGTSwNCj4gPiA+ICAgIFNXSVRDSERFVl9PQkpfSURfQ0NfQ0NNX1RYX0NGTSwNCj4g
PiA+ICAgIFNXSVRDSERFVl9PQkpfSURfTUVQX1NUQVRVU19DRk0sDQo+ID4gPiAgICBTV0lUQ0hE
RVZfT0JKX0lEX1BFRVJfTUVQX1NUQVRVU19DRk0NCj4gPiA+IA0KPiA+ID4gTUVQIGluc3RhbmNl
IGFkZC9kZWwNCj4gPiA+ICAgIHN3aXRjaGRldl9wb3J0X29ial9hZGQoU1dJVENIREVWX09CSl9J
RF9NRVBfQ0ZNKQ0KPiA+ID4gICAgc3dpdGNoZGV2X3BvcnRfb2JqX2RlbChTV0lUQ0hERVZfT0JK
X0lEX01FUF9DRk0pDQo+ID4gPiANCj4gPiA+IE1FUCBjb2ZpZ3VyZQ0KPiA+ID4gICAgc3dpdGNo
ZGV2X3BvcnRfb2JqX2FkZChTV0lUQ0hERVZfT0JKX0lEX01FUF9DT05GSUdfQ0ZNKQ0KPiA+ID4g
DQo+ID4gPiBNRVAgQ0MgY29maWd1cmUNCj4gPiA+ICAgIHN3aXRjaGRldl9wb3J0X29ial9hZGQo
U1dJVENIREVWX09CSl9JRF9DQ19DT05GSUdfQ0ZNKQ0KPiA+ID4gDQo+ID4gPiBQZWVyIE1FUCBh
ZGQvZGVsDQo+ID4gPiAgICBzd2l0Y2hkZXZfcG9ydF9vYmpfYWRkKFNXSVRDSERFVl9PQkpfSURf
Q0NfUEVFUl9NRVBfQ0ZNKQ0KPiA+ID4gICAgc3dpdGNoZGV2X3BvcnRfb2JqX2RlbChTV0lUQ0hE
RVZfT0JKX0lEX0NDX1BFRVJfTUVQX0NGTSkNCj4gPiA+IA0KPiA+ID4gU3RhcnQvc3RvcCBDQ00g
dHJhbnNtaXNzaW9uDQo+ID4gPiAgICBzd2l0Y2hkZXZfcG9ydF9vYmpfYWRkKFNXSVRDSERFVl9P
QkpfSURfQ0NfQ0NNX1RYX0NGTSkNCj4gPiA+IA0KPiA+ID4gR2V0IE1FUCBzdGF0dXMNCj4gPiA+
ICAgICAgIHN3aXRjaGRldl9wb3J0X29ial9nZXQoU1dJVENIREVWX09CSl9JRF9NRVBfU1RBVFVT
X0NGTSkNCj4gPiA+IA0KPiA+ID4gR2V0IFBlZXIgTUVQIHN0YXR1cw0KPiA+ID4gICAgICAgc3dp
dGNoZGV2X3BvcnRfb2JqX2dldChTV0lUQ0hERVZfT0JKX0lEX1BFRVJfTUVQX1NUQVRVU19DRk0p
DQo+ID4gPiANCj4gPiA+IFJldmlld2VkLWJ5OiBIb3JhdGl1IFZ1bHR1ciAgPGhvcmF0aXUudnVs
dHVyQG1pY3JvY2hpcC5jb20+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBIZW5yaWsgQmpvZXJubHVu
ZCAgPGhlbnJpay5iam9lcm5sdW5kQG1pY3JvY2hpcC5jb20+DQo+ID4gDQo+ID4gWW91IGhhdmUg
dG8gc3VibWl0IHRoZSBkcml2ZXIgcGFydHMgYXMgYSBwYXJ0IG9mIHRoaXMgcGF0Y2hzZXQuDQo+
ID4gT3RoZXJ3aXNlIGl0IGlzIG5vIGdvb2QuDQo+IEZhaXIgZW5vdWdoLg0KPiANCj4gV2l0aCBN
UlAgd2UgZGlkIGl0IGxpa2UgdGhpcywgYW5kIGFmdGVyIE5payBhc2tlZCBmb3IgZGV0YWlscyBv
biB3aGF0IGlzDQo+IGJlaW5nIG9mZmxvYWQsIHdlIHRob3VnaHQgdGhhdCBhZGRpbmcgdGhpcyB3
b3VsZCBoZWxwLg0KPiANCj4gVGhlIHJlYXNvbiB3aHkgd2UgZGlkIG5vdCBpbmNsdWRlIHRoZSBp
bXBsZW1lbnRhdGlvbiBvZiB0aGlzIGludGVyZmFjZQ0KPiBpcyB0aGF0IGl0IGlzIGZvciBhIG5l
dyBTb0Mgd2hpY2ggaXMgc3RpbGwgbm90IGZ1bGx5IGF2YWlsYWJsZSB3aGljaCBpcw0KPiB3aHkg
d2UgaGF2ZSBub3QgZG9uZSB0aGUgYmFzaWMgU3dpdGNoRGV2IGRyaXZlciBmb3IgaXQgeWV0LiBC
dXQgdGhlDQo+IGJhc2ljIGZ1bmN0aW9uYWxpdHkgY2xlYXJseSBuZWVkcyB0byBjb21lIGZpcnN0
Lg0KPiANCj4gT3VyIHByZWZlcmVuY2UgaXMgdG8gY29udGludWUgZml4aW5nIHRoZSBjb21tZW50
cyB3ZSBnb3Qgb24gdGhlIHB1cmUgU1cNCj4gaW1wbGVtZW50YXRpb24gYW5kIHRoZW4gZ2V0IGJh
Y2sgdG8gdGhlIFN3aXRjaERldiBvZmZsb2FkaW5nLg0KPiANCj4gVGhpcyB3aWxsIG1lYW4gZHJv
cHBpbmcgdGhlIGxhc3QgMiBwYXRjaGVzIGluIHRoZSBzZXJpZS4NCj4gDQo+IERvZXMgdGhhdCB3
b3JrIGZvciB5b3UgSmlyaSwgYW5kIE5paz8NCj4gDQo+IC9BbGxhbg0KPiANCg0KU291bmRzIGdv
b2QgdG8gbWUuIFNvcnJ5IEkgd2FzIHVucmVzcG9uc2l2ZSBsYXN0IHdlZWssIGJ1dCBJIHdhcyBz
aWNrIGFuZA0KY291bGRuJ3QgZ2V0IHRvIG5ldGRldkAuIEknbGwgcmV2aWV3IHRoZSBzZXQgdG9k
YXkuDQoNCkNoZWVycywNCiBOaWsNCg0K
