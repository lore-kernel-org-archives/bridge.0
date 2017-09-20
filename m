Return-Path: <davem@davemloft.net>
Date: Wed, 20 Sep 2017 15:41:17 -0700 (PDT)
Message-Id: <20170920.154117.1811118515077748495.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <87bmm56mu2.fsf@luffy.cx>
References: <20170920.140956.781667692297467325.davem@davemloft.net>
	<16e5566a-909d-ba83-7637-1fb6c93126bc@gmail.com>
	<87bmm56mu2.fsf@luffy.cx>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: base64
Subject: Re: [Bridge] [PATCH net-next v2] bridge: also trigger RTM_NEWLINK
 when interface is released from bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: vincent@bernat.im
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, dsahern@gmail.com

RnJvbTogVmluY2VudCBCZXJuYXQgPHZpbmNlbnRAYmVybmF0LmltPg0KRGF0ZTogVGh1LCAyMSBT
ZXAgMjAxNyAwMDoxMjo1MyArMDIwMA0KDQo+ICDinaYgMjAgc2VwdGVtYnJlIDIwMTcgMTU6NTcg
LTA2MDAsIERhdmlkIEFoZXJuIDxkc2FoZXJuQGdtYWlsLmNvbT7CoDoNCj4gDQo+PiBUaGUgREVM
TElOSyBpcyBmb3IgQUZfQlJJREdFIGZhbWlseSAoaWZpX2ZhbWlseSkuIEFkZGluZyBmYW1pbHkg
dG8NCj4+IHByaW50X2xpbmtpbmZvIGFuZCBydW5uaW5nIHRoZSBtb25pdG9yIEkgZ2V0Og0KPj4N
Cj4+DQo+PiBbTElOS11mYW1pbHkgMDogMzU6IGR1bW15MTogPEJST0FEQ0FTVCxOT0FSUCxVUCxM
T1dFUl9VUD4gbXR1IDE1MDAgcWRpc2MNCj4+IG5vcXVldWUgbWFzdGVyIGJyMCBzdGF0ZSBVTktO
T1dOIGdyb3VwIGRlZmF1bHQNCj4+ICAgICBsaW5rL2V0aGVyIGQ2OmMzOjczOjg2OjNjOjczIGJy
ZCBmZjpmZjpmZjpmZjpmZjpmZg0KPj4NCj4+IFtMSU5LXWZhbWlseSA3OiAzNTogZHVtbXkxOiA8
QlJPQURDQVNULE5PQVJQLFVQLExPV0VSX1VQPiBtdHUgMTUwMA0KPj4gbWFzdGVyIGJyMCBzdGF0
ZSBVTktOT1dODQo+PiAgICAgbGluay9ldGhlciBkNjpjMzo3Mzo4NjozYzo3Mw0KPj4NCj4+IFtM
SU5LXURlbGV0ZWQgZmFtaWx5IDc6IDM1OiBkdW1teTE6IDxCUk9BRENBU1QsTk9BUlAsVVAsTE9X
RVJfVVA+IG10dQ0KPj4gMTUwMCBtYXN0ZXIgYnIwIHN0YXRlIFVOS05PV04NCj4+ICAgICBsaW5r
L2V0aGVyIGQ2OmMzOjczOjg2OjNjOjczDQo+IA0KPiBJIGRpZG4ndCBrbm93IGFib3V0IHRoZSBm
YW1pbHkuIFdlIGNhbiBkcm9wIHRoZSBwYXRjaC4NCg0KT2ssIEkndmUgcmV2ZXJ0ZWQuDQoNClRo
YW5rcy4NCg==
