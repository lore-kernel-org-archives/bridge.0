Return-Path: <makita.toshiaki@lab.ntt.co.jp>
Message-ID: <545B3148.8000704@lab.ntt.co.jp>
Date: Thu, 06 Nov 2014 17:28:56 +0900
From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
MIME-Version: 1.0
References: <1415255192-13584-1-git-send-email-suhyun.park@ahnlab.com>
	<545B1E27.3080302@lab.ntt.co.jp>
	<8D1F1238A24CE743B8F3CED0F137C69E408AA087@EXMB02.ahnbang.ahnlab.com>
In-Reply-To: <8D1F1238A24CE743B8F3CED0F137C69E408AA087@EXMB02.ahnbang.ahnlab.com>
Content-Type: text/plain; charset="euc-kr"
Content-Transfer-Encoding: base64
Subject: Re: [Bridge] [PATCH] bridge: missing null bridge device check
 causing null pointer dereference (bugfix)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?EUC-KR?B?udq89sf2?= <suhyun.park@ahnlab.com>, Stephen Hemminger <stephen@networkplumber.org>, "David S. Miller" <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

T24gMjAxNC8xMS8wNiAxNjo1OCwgudq89sf2IHdyb3RlOgo+PiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQo+PiBGcm9tOiBUb3NoaWFraSBNYWtpdGEgW21haWx0bzptYWtpdGEudG9zaGlha2lA
bGFiLm50dC5jby5qcF0KPj4gU2VudDogVGh1cnNkYXksIE5vdmVtYmVyIDA2LCAyMDE0IDQ6MDcg
UE0KPj4gVG86ILnavPbH9jsgU3RlcGhlbiBIZW1taW5nZXI7IERhdmlkIFMuIE1pbGxlcgo+PiBD
YzogYnJpZGdlQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnOyBuZXRkZXZAdmdlci5rZXJuZWwu
b3JnOyBsaW51eC0KPj4ga2VybmVsQHZnZXIua2VybmVsLm9yZwo+PiBTdWJqZWN0OiBSZTogW1BB
VENIXSBicmlkZ2U6IG1pc3NpbmcgbnVsbCBicmlkZ2UgZGV2aWNlIGNoZWNrIGNhdXNpbmcgbnVs
bAo+PiBwb2ludGVyIGRlcmVmZXJlbmNlIChidWdmaXgpCj4+Cj4+IE9uIDIwMTQvMTEvMDYgMTU6
MjYsIFN1LUh5dW4gUGFyayB3cm90ZToKPj4+IHRoZSBicmlkZ2UgZGV2aWNlIGNhbiBiZSBudWxs
IGlmIHRoZSBicmlkZ2UgaXMgYmVpbmcgZGVsZXRlZCB3aGlsZQo+Pj4gcHJvY2Vzc2luZyB0aGUg
cGFja2V0LCB3aGljaCBjYXVzZXMgdGhlIG51bGwgcG9pbnRlciBkZXJlZmVyZW5jZSBpbgo+PiBz
d2l0Y2ggc3RhdGVtZW50Lgo+Pgo+PiBIb3cgY2FuIHRoaXMgaGFwcGVuPz8KPj4gSXQgaXMgZ3Vh
cmRlZCBieSByY3UuCj4+IG5ldGRldl9yeF9oYW5kbGVyX3VucmVnaXN0ZXIoKSBlbnN1cmVzIHJ4
X2hhbmRsZXJfZGF0YSBpcyBub24gTlVMTC4KPj4KPiAKPiBUaGUgUkNVIHByb3RlY3QgcnhfaGFu
ZGxlcl9kYXRhLCBub3QgdGhlIGJyaWRnZSBtZW1iZXIgcG9ydC4gSXQgY2FuIGJlIE5VTEwgYWNj
b3JkaW5nIHRvIGJlbG93IGNvZGUuCj4gCj4gc3RhdGljIGlubGluZSBzdHJ1Y3QgbmV0X2JyaWRn
ZV9wb3J0ICpicl9wb3J0X2dldF9yY3UoY29uc3Qgc3RydWN0IG5ldF9kZXZpY2UgKmRldikgewo+
IAlzdHJ1Y3QgbmV0X2JyaWRnZV9wb3J0ICpwb3J0ID0gcmN1X2RlcmVmZXJlbmNlKGRldi0+cnhf
aGFuZGxlcl9kYXRhKTsKPiAJcmV0dXJuIGJyX3BvcnRfZXhpc3RzKGRldikgPyBwb3J0IDogTlVM
TDsgCj4gfQoKU2VlbXMgdG8gaGF2ZSBiZWVuIGZpeGVkIGZvciBhIHllYXIuCjcxNmVjMDUyZDIy
OCAoImJyaWRnZTogZml4IE5VTEwgcG9pbnRlciBkZXJlZiBvZiBicl9wb3J0X2dldF9yY3UiKQoK
VGhhbmtzLApUb3NoaWFraSBNYWtpdGEKCg==
