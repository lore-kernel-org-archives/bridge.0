From: "Zou, Yi" <yi.zou@intel.com>
Date: Mon, 5 Sep 2011 20:25:39 -0700
Message-ID: <5A9BD224CEA58D4CB62235967D650C160A1B7D1C@orsmsx509.amr.corp.intel.com>
References: <1314905304-16485-1-git-send-email-jpirko@redhat.com>
	<20110902122630.GC1991@minipsycho>
	<1314989161.3419.5.camel@bwh-desktop>
	<20110903133428.GA2821@minipsycho> <1315057614.3092.160.camel@deadeye>
In-Reply-To: <1315057614.3092.160.camel@deadeye>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Bridge] [patch net-next-2.6 v3] net: consolidate and fix
 ethtool_ops->get_settings calling
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ben Hutchings <bhutchings@solarflare.com>, Jiri Pirko <jpirko@redhat.com>
Cc: "amit.salecha@qlogic.com" <amit.salecha@qlogic.com>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>, "devel@open-fcoe.org" <devel@open-fcoe.org>, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, "decot@google.com" <decot@google.com>, "therbert@google.com" <therbert@google.com>, "Love,
	Robert W" <robert.w.love@intel.com>, "eric.dumazet@gmail.com" <eric.dumazet@gmail.com>, "fubar@us.ibm.com" <fubar@us.ibm.com>, "JBottomley@parallels.com" <JBottomley@parallels.com>, "xiaosuo@gmail.com" <xiaosuo@gmail.com>, "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>, "Duyck, Alexander H" <alexander.h.duyck@intel.com>, "mirq-linux@rere.qmqm.pl" <mirq-linux@rere.qmqm.pl>, "greearb@candelatech.com" <greearb@candelatech.com>, "bprakash@broadcom.com" <bprakash@broadcom.com>, "laijs@cn.fujitsu.com" <laijs@cn.fujitsu.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "ralf@linux-mips.org" <ralf@linux-mips.org>, "davem@davemloft.net" <davem@davemloft.net>, "loke.chetan@gmail.com" <loke.chetan@gmail.com>

PiANCj4gT24gU2F0LCAyMDExLTA5LTAzIGF0IDE1OjM0ICswMjAwLCBKaXJpIFBpcmtvIHdyb3Rl
Og0KPiA+IFRoaXMgcGF0Y2ggZG9lcyBzZXZlcmFsIHRoaW5nczoNCj4gPiAtIGludHJvZHVjZXMg
X19ldGh0b29sX2dldF9zZXR0aW5ncyB3aGljaCBpcyBjYWxsZWQgZnJvbSBldGh0b29sIGNvZGUN
Cj4gYW5kDQo+ID4gICBmcm9tIGRyaXZlcnMgYXMgd2VsbC4gUHV0IEFTU0VSVF9SVE5MIHRoZXJl
Lg0KPiA+IC0gZGV2X2V0aHRvb2xfZ2V0X3NldHRpbmdzKCkgaXMgcmVwbGFjZWQgYnkgX19ldGh0
b29sX2dldF9zZXR0aW5ncygpDQo+ID4gLSBjaGFuZ2VzIGNhbGxpbmcgaW4gZHJpdmVycyBzbyBy
dG5sIGxvY2tpbmcgaXMgcmVzcGVjdGVkLiBJbg0KPiA+ICAgaWJvZV9nZXRfcmF0ZSB3YXMgcHJl
dmlvdXNseSAtPmdldF9zZXR0aW5ncygpIGNhbGxlZCB1bmxvY2tlZC4gVGhpcw0KPiA+ICAgZml4
ZXMgaXQuIEFsc28gcHJiX2NhbGNfcmV0aXJlX2Jsa190bW8oKSBpbiBhZl9wYWNrZXQuYyBoYWQg
dGhlIHNhbWUNCj4gPiAgIHByb2JsZW0uIEFsc28gZml4ZWQgYnkgY2FsbGluZyBfX2Rldl9nZXRf
YnlfaW5kZXgoKSBpbnN0ZWFkIG9mDQo+ID4gICBkZXZfZ2V0X2J5X2luZGV4KCkgYW5kIGhvbGRp
bmcgcnRubF9sb2NrIGZvciBib3RoIGNhbGxzLg0KPiA+IC0gaW50cm9kdWNlcyBydG5sX2xvY2sg
aW4gYm54MmZjX3Zwb3J0X2NyZWF0ZSgpIGFuZCBmY29lX3Zwb3J0X2NyZWF0ZSgpDQo+ID4gICBz
byBibngyZmNfaWZfY3JlYXRlKCkgYW5kIGZjb2VfaWZfY3JlYXRlKCkgYXJlIGNhbGxlZCBsb2Nr
ZWQgYXMgdGhleQ0KPiA+ICAgYXJlIGZyb20gb3RoZXIgcGxhY2VzLg0KPiA+IC0gdXNlIF9fZXRo
dG9vbF9nZXRfc2V0dGluZ3MoKSBpbiBib25kaW5nIGNvZGUNCj4gPg0KPiA+IFNpZ25lZC1vZmYt
Ynk6IEppcmkgUGlya28gPGpwaXJrb0ByZWRoYXQuY29tPg0KPiBSZXZpZXdlZC1ieTogQmVuIEh1
dGNoaW5ncyA8Ymh1dGNoaW5nc0Bzb2xhcmZsYXJlLmNvbT4gW2V4Y2VwdCBGQ29FIGJpdHNdDQo+
IA0KPiBCZW4uDQpGQ29FIGJpdHMgbG9vayBvayB0byBtZS4gVGhhbmtzLA0KDQpSZXZpZXdlZC1i
eTogWWkgWm91IDx5aS56b3VAaW50ZWwuY29tPg0KDQo+IA0KPiAtLQ0KPiBCZW4gSHV0Y2hpbmdz
LCBTdGFmZiBFbmdpbmVlciwgU29sYXJmbGFyZQ0KPiBOb3Qgc3BlYWtpbmcgZm9yIG15IGVtcGxv
eWVyOyB0aGF0J3MgdGhlIG1hcmtldGluZyBkZXBhcnRtZW50J3Mgam9iLg0KPiBUaGV5IGFza2Vk
IHVzIHRvIG5vdGUgdGhhdCBTb2xhcmZsYXJlIHByb2R1Y3QgbmFtZXMgYXJlIHRyYWRlbWFya2Vk
Lg0KPiANCj4gLS0NCj4gVG8gdW5zdWJzY3JpYmUgZnJvbSB0aGlzIGxpc3Q6IHNlbmQgdGhlIGxp
bmUgInVuc3Vic2NyaWJlIGxpbnV4LXNjc2kiIGluDQo+IHRoZSBib2R5IG9mIGEgbWVzc2FnZSB0
byBtYWpvcmRvbW9Admdlci5rZXJuZWwub3JnDQo+IE1vcmUgbWFqb3Jkb21vIGluZm8gYXQgIGh0
dHA6Ly92Z2VyLmtlcm5lbC5vcmcvbWFqb3Jkb21vLWluZm8uaHRtbA0K
