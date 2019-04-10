Return-Path: <petrm@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=ThJ01jct1k9iNxpf6TgizWCfHx7DsY3NoNQvIxw8a40=;
	b=mmEcHVE3ur+cDxDPjtIvrUUVDek1cc+YhyiMHR6Y4IMGjhSTQ9G1PmniSw3ZBVBffENeU5JQXeA9NTxRURPUYiwwrHiPBdFwi6cil7vP0x126cmyCo83+0IR2YespKOjybkXAnzUxPYey28Y/DQMjELYcdWA41mqhYHQETl2sQE=
From: Petr Machata <petrm@mellanox.com>
Date: Wed, 10 Apr 2019 10:34:17 +0000
Message-ID: <87y34ijgil.fsf@mellanox.com>
References: <20190410023208.25435-1-huangruiPPP@gmail.com>
	<20190409193911.2d68a64d@shemminger-XPS-13-9360>
In-Reply-To: <20190409193911.2d68a64d@shemminger-XPS-13-9360>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH] net:bridge:always disable auto-tuning when the
 user specified MTU
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: "songliubraving@fb.com" <songliubraving@fb.com>, "jakub.kicinski@netronome.com" <jakub.kicinski@netronome.com>, "ast@kernel.org" <ast@kernel.org>, "ecree@solarflare.com" <ecree@solarflare.com>, "xdp-newbies@vger.kernel.org" <xdp-newbies@vger.kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "john.fastabend@gmail.com" <john.fastabend@gmail.com>, Li Rongqing <lirongqing@baidu.com>, Huang Rui <huangruippp@gmail.com>, "yhs@fb.com" <yhs@fb.com>, "alexander.h.duyck@intel.com" <alexander.h.duyck@intel.com>, "hawk@kernel.org" <hawk@kernel.org>, "nikolay@cumulusnetworks.com" <nikolay@cumulusnetworks.com>, "roopa@cumulusnetworks.com" <roopa@cumulusnetworks.com>, Ido Schimmel <idosch@mellanox.com>, Jiri Pirko <jiri@mellanox.com>, "amritha.nambiar@intel.com" <amritha.nambiar@intel.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "kafai@fb.com" <kafai@fb.com>

DQpTdGVwaGVuIEhlbW1pbmdlciA8c3RlcGhlbkBuZXR3b3JrcGx1bWJlci5vcmc+IHdyaXRlczoN
Cg0KPiBPbiBXZWQsIDEwIEFwciAyMDE5IDAyOjMyOjA4ICswMDAwDQo+IEh1YW5nIFJ1aSA8aHVh
bmdydWlwcHBAZ21haWwuY29tPiB3cm90ZToNCj4NCj4+IEZvciBleGFtcGxlLg0KPj4gTXkgcHVy
cG9zZSBpcyB0byBjcmVhdGUgYSBicmlkZ2UgYnIwIGFuZCBqb2luIGV0aDAgaW50byBicjAuDQo+
PiBpZiB3ZSB1c2UgdGhpcyBmb2xsb3dpbmcgd2F5LCB0aGUgYXV0by10dW5pbmcgZmxhZyB3aWxs
IG5vdCBiZSBkaXNhYmxlZC4NCj4+DQo+PiBJZiBldGgwJ3MgbXR1IGlzIDEyMDANCj4+IHN0ZXAg
MS5icmN0bCBhZGRiciBicjANCj4+IHN0ZXAgMi5icmN0bCBhZGRpZiBicjAgZXRoMA0KPj4gc3Rl
cCAzLmlmY29uZmlnIGJyMCBtdHUgMTIwMA0KPj4gc3RlcCA0LmlmY29uZmlnIGV0aDAgbXR1IDE1
MDANCj4+DQo+PiBSZXN1bHQ6DQo+PiBicjAncyBNVFU6IDE1MDAsIGV0aDAncyBNVFU6IDE1MDAN
Cj4+DQo+PiBFeHBlY3RlZDoNCj4+IGJyMCdzIE1UVTogMTIwMCwgZXRoMCdzIE1UVTogMTUwMA0K
Pj4NCj4+IEkgaGF2ZSBzcGVjaWZpZWQgYnIwJ3MgTVRVLCAgYnV0IGF1dG8tbWluIHBvbGljeSB3
b3Jrcy4gU28gdGhlIE1UVSBpcw0KPj4gbm90IHRoZSByZXN1bHQgd2hhdCB3ZSBleHBlY3RlZC4N
Cj4+IEFzIGV4cGVjdGVkLCBpZiBpIGhhdmUgc3BlY2lmaWVkIGJyaWRnZSdzIE1UVSwgaXQgd2ls
bCBzZXQgdGhlIGZsYWc6DQo+PiBCUk9QVF9NVFVfU0VUX0JZX1VTRVIgaW4gbmV0X2JyaWRnZV9v
cHRzIGRpc2FibGVkIGFuZCBhdXRvLW1pbi9tYXgNCj4+IHBvbGljeSB3aWxsIG5vdCB3b3JrLkJ1
dCBpbiB0aGlzIGNhc2UsIGJlY2F1c2UgdGhlIGRldl9zZXRfbXR1IHJldHVybg0KPj4gZWFybHks
IHRoZSBCUk9QVF9NVFVfU0VUX0JZX1VTRVIgZmxhZyB3aWxsIG5vdCBiZSBkaXNhYmxlZCBhbmQN
Cj4+IGF1dG8tbWluL21heCBwb2xpY3kgd2lsbCBzdGlsbCB3b3JrLg0KPj4NCj4+IFNpZ25lZC1v
ZmYtYnk6IEh1YW5nIFJ1aSA8aHVhbmdydWlQUFBAZ21haWwuY29tPg0KPg0KPiBBIGJyaWRnZSBs
aWtlIHRoaXMgZ29pbmcgdG8gZHJvcCBmcmFtZXMuDQo+IEEgZnJhbWUgcmVjZWl2ZWQgd2l0aCBN
VFUgb2YgMTIwMCB3aWxsIGdldCBkcm9wcGVkLg0KDQpUaGF0J3MgdHJ1ZSBldmVuIGlmIGFib3Zl
IHlvdSBzZXQgYnIwJ3MgTVRVIHRvIDEyMDEsIGJ1dCB0aGVuIHRoZQ0KYXV0by10dW5pbmcgaXMg
ZGlzYWJsZWQgYXMgZXhwZWN0ZWQuIFRoZSBwcm9ibGVtIGlzIHRoYXQgc2V0dGluZyBNVFUgdG8N
CjEyMDAgaXMgcGVyY2VpdmVkIGFzIGEgbm9uLWNoYW5nZSwgd2hlcmVhcyBpdCBzaG91bGQgaW5z
dGVhZCBiZQ0KcGVyY2VpdmVkIGFzIGEgc2lnbmFsIHRoYXQgdGhlIHVzZXIgdGFrZXMgb3ZlciB0
aGUgTVRVIG1hbmFnZW1lbnQuDQoNCj4gVGhlIHByb3BlciB3YXkgdG8gZG8gdGhpcyBpcyB0byBj
aGFuZ2UgTVRVIG9mIGJvdGggaW50ZXJmYWNlcyB0byBtYXRjaC4NCg==
