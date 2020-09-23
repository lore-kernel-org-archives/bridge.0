Return-Path: <nikolay@nvidia.com>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Date: Wed, 23 Sep 2020 08:20:52 +0000
Message-ID: <e3e9fec1ac857512ee37c6bbc8f67fa047778484.camel@nvidia.com>
References: <20200922073027.1196992-13-razor@blackwall.org>
 <202009231635.WjfHleMK%lkp@intel.com>
In-Reply-To: <202009231635.WjfHleMK%lkp@intel.com>
Reply-To: Nikolay Aleksandrov <nikolay@nvidia.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <332771DE6537A64D8F3A0CECE32C4953@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1600849212; bh=4KUuACMDD6PBH+dEKYhQbAwOejlM0Ktxx6YNK/MWDbo=;
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
 b=mwx3Qmeg9Pq/UONgjxlfF1YFpiv0QOz2OmMPXwwGoaSRIHRnNk9s8YxnWHB3XhbD4
 E1i+pyGIf0N/paeKw3O7GO5tZprBBzwguP2oEV4j9jkOFDrpQFpxmMXdIkkmZwJxvv
 v9yLimDOLiGMQ1L+eb+vWrk8D9ZN95M2lsTsuoMqoSXmsznew/IiLo8+ZR8GwAVyXZ
 yHc2ERN1FAsh7M/Uk4mU23qLOQ74uPLpMRtDAIZIKM2JD0HPlnejCJzcEE2v7O9rck
 UiwbX+fczQXoqyAH/cZ5Lcm9Wt73hCyJgSD9fIRn8KLrbs21+v4CpDUV82jr2J3g2C
 wnSel6YKGwokQ==
Subject: Re: [Bridge] [PATCH net-next v2 12/16] net: bridge: mcast: install
 S, G entries automatically based on reports
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "lkp@intel.com" <lkp@intel.com>
Cc: "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>, "davem@davemloft.net" <davem@davemloft.net>, Roopa Prabhu <roopa@nvidia.com>

T24gV2VkLCAyMDIwLTA5LTIzIGF0IDE2OjEzICswODAwLCBrZXJuZWwgdGVzdCByb2JvdCB3cm90
ZToNCj4gSGkgTmlrb2xheSwNCj4gDQo+IEkgbG92ZSB5b3VyIHBhdGNoISBQZXJoYXBzIHNvbWV0
aGluZyB0byBpbXByb3ZlOg0KPiANCj4gW2F1dG8gYnVpbGQgdGVzdCBXQVJOSU5HIG9uIG5ldC1u
ZXh0L21hc3Rlcl0NCj4gDQo+IHVybDogICAgaHR0cHM6Ly9naXRodWIuY29tLzBkYXktY2kvbGlu
dXgvY29tbWl0cy9OaWtvbGF5LUFsZWtzYW5kcm92L25ldC1icmlkZ2UtbWNhc3QtSUdNUHYzLU1M
RHYyLWZhc3QtcGF0aC1wYXJ0LTIvMjAyMDA5MjItMTUzMzIxDQo+IGJhc2U6ICAgaHR0cHM6Ly9n
aXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvZGF2ZW0vbmV0LW5leHQuZ2l0
IDkyZWM4MDRmM2RiZjBkOTg2ZjhlMTA4NTBiZmZmMTRmMzE2ZDdhYWYNCj4gY29uZmlnOiBpMzg2
LXJhbmRjb25maWctbTAyMS0yMDIwMDkyMyAoYXR0YWNoZWQgYXMgLmNvbmZpZykNCj4gY29tcGls
ZXI6IGdjYy05IChEZWJpYW4gOS4zLjAtMTUpIDkuMy4wDQo+IA0KPiBJZiB5b3UgZml4IHRoZSBp
c3N1ZSwga2luZGx5IGFkZCBmb2xsb3dpbmcgdGFnIGFzIGFwcHJvcHJpYXRlDQo+IFJlcG9ydGVk
LWJ5OiBrZXJuZWwgdGVzdCByb2JvdCA8bGtwQGludGVsLmNvbT4NCj4gDQo+IE5ldyBzbWF0Y2gg
d2FybmluZ3M6DQo+IG5ldC9icmlkZ2UvYnJfbXVsdGljYXN0LmM6OTgwIF9fYnJfbXVsdGljYXN0
X2FkZF9ncm91cCgpIGVycm9yOiBwb3RlbnRpYWwgbnVsbCBkZXJlZmVyZW5jZSAnbXAnLiAgKGJy
X211bHRpY2FzdF9uZXdfZ3JvdXAgcmV0dXJucyBudWxsKQ0KPiANCj4gT2xkIHNtYXRjaCB3YXJu
aW5nczoNCj4gaW5jbHVkZS9saW51eC91NjRfc3RhdHNfc3luYy5oOjEyOCB1NjRfc3RhdHNfdXBk
YXRlX2JlZ2luKCkgd2Fybjogc3RhdGVtZW50IGhhcyBubyBlZmZlY3QgMzENCj4gDQoNClRoaXMg
cmVwb3J0IGlzIHdyb25nLCBicl9tdWx0aWNhc3RfbmV3X2dyb3VwKCkgY2Fubm90IHJldHVybiBO
VUxMLg0KSXQgYWx3YXlzIHJldHVybnMgRVJSX1BUUigpIG9mIHdoYXRldmVyIGVycm9yIGhhcHBl
bmVkIGFuZCB0aGVyZQ0KaXMgYW4gSVNfRVJSKCkgY2hlY2sgYWZ0ZXJ3YXJkcy4NCg0KVGhhbmtz
Lg0KDQo=
