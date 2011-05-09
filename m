Date: Mon, 09 May 2011 12:08:11 -0700 (PDT)
Message-Id: <20110509.120811.246541047.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20110507114803.0D80A13A6B@rere.qmqm.pl>
References: <20110507114803.0D80A13A6B@rere.qmqm.pl>
Mime-Version: 1.0
Content-Type: Text/Plain; charset="euc-kr"
Content-Transfer-Encoding: base64
Subject: Re: [Bridge] [RFC PATCH] net: fold dev_disable_lro() into
 netdev_fix_features()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: mirq-linux@rere.qmqm.pl
Cc: pekkas@netcore.fi, eric.dumazet@gmail.com, yoshfuji@linux-ipv6.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, jmorris@namei.org, bhutchings@solarflare.com, kuznet@ms2.inr.ac.ru, therbert@google.com

RnJvbTogTWljaGGpqSBNaXJvc6mpYXcgPG1pcnEtbGludXhAcmVyZS5xbXFtLnBsPgpEYXRlOiBT
YXQsICA3IE1heSAyMDExIDEzOjQ4OjAyICswMjAwIChDRVNUKQoKPiBUaGlzIG1vdmVzIGNoZWNr
cyB0aGF0IGRldmljZSBpcyBmb3J3YXJkaW5nIGZyb20gYnJpZGdlLCBJUHY0IGFuZCBJUHY2Cj4g
Y29kZSBpbnRvIG5ldGRldl9maXhfZmVhdHVyZXMoKS4gQXMgYSBzaWRlIGVmZmVjdCwgYWZ0ZXIg
ZGV2aWNlIGlzIG5vIGxvbmdlcgo+IGZvcndhcmRpbmcgaXQgZ2V0cyBMUk8gYmFjay4gVGhpcyBh
bHNvIG1lYW5zIHRoYXQgdXNlciBpcyBub3QgYWxsb3dlZCB0bwo+IGVuYWJsZSBMUk8gYWZ0ZXIg
ZGV2aWNlIGlzIHB1dCB0byBmb3J3YXJkaW5nIG1vZGUuCj4gCj4gVGhpcyBwYXRjaCBkZXBlbmRz
IG9uIHJlbW92YWwgb2YgZGlzY3JldGUgb2ZmbG9hZCBzZXR0aW5nIGV0aHRvb2wgb3BzLgo+IAo+
IFNpZ25lZC1vZmYtYnk6IE1pY2hhqakgTWlyb3OpqWF3IDxtaXJxLWxpbnV4QHJlcmUucW1xbS5w
bD4KCldlIG5lZWQgdG8ga2VlcCB0aGUgY2hlY2sgaW4gdGhlIHByb3RvY29scyBiZWNhdXNlIHdl
IGRvbid0IHdhbnQgdG8KYmUgdGVzdGluZyBwcm90b2NvbCBzcGVjaWZpYyBkZXZpY2Ugc3RhdGUg
aW4gZ2VuZXJpYyBjb2RlIGxpa2UKbmV0L2NvcmUvZGV2LmMK
