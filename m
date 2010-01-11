MIME-Version: 1.0
In-Reply-To: <0B4BAD7651DDBF4CB463FDBCA36C673F108C64BE@EXCHANGE.claremont.globaldial.com>
References: <0B4BAD7651DDBF4CB463FDBCA36C673F108C64BE@EXCHANGE.claremont.globaldial.com>
Date: Mon, 11 Jan 2010 10:16:15 -0700
Message-ID: <c5b98f841001110916p2e12a65k1586ba76871adc8a@mail.gmail.com>
From: Robert LeBlanc <robert@leblancnet.us>
Content-Type: multipart/alternative; boundary=0016367b6b06eaeb29047ce6b194
Subject: Re: [Bridge] MAC intermittently being learnt on wrong port
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ryan King <ryank@staff.globaldial.com>
Cc: "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>

--0016367b6b06eaeb29047ce6b194
Content-Type: text/plain; charset=ISO-8859-1

On Thu, Jan 7, 2010 at 8:25 PM, Ryan King <ryank@staff.globaldial.com>wrote:

>  Hi,
>
>
>
> I am seeing a strange issue with a fairly simple bridge I have setup (for
> openvpn in bridge mode).
>
>
>
> eth0 ---  [ openvpn machine  (tap0) ] --- eth1
>
>
>
> The bridge is between tap0 and eth1 on a debian machine running on ESX 4.
> (tap0 being the openvpn tunnel interface).  Intermittently, I see openvpn
> client MAC addresses on port 2 (eth1).  When this happens, their vpn link
> stops working, since arp replies are being sent back via the wrong
> interface.  But after a random amount of time, it will change back to port 1
> (tap0) and start working again.  Sometimes this is quick, sometimes it
> doesn't happen for hours.
>
>
>
> Anyone else had these issues?  I've searched the archives, and come across
> several people who seem to have had similar problems - but haven't found one
> that has a solution yet.
>
>
>
> I'd appreciate any suggestions on where I should start looking to find out
> why/how these MAC's are being learnt on the wrong interface...
>
>
>
>
>
> brctl show br0:
>
>
>
> bridge name      bridge id                              STP enabled
> interfaces
>
> br0                         8000.005056b804c2
> no                           eth1
>
>
> tap0
>
>
>
>
>
> brctl showstp br0:
>
>
>
> br0
>
>  bridge id                             8000.005056b804c2
>
>  designated root              8000.005056b804c2
>
>  root port
> 0                                           path
> cost                                0
>
>  max age
> 20.00                                   bridge max age
> 20.00
>
>  hello time
> 2.00                                     bridge hello time
> 2.00
>
>  forward delay                     5.00
> bridge forward delay        5.00
>
>  ageing time                       300.01
>
>  hello timer
> 1.19                                     tcn
> timer                                0.00
>
>  topology change timer    0.00                                     gc
> timer                                  2.19
>
>  flags
>
>
>
>
>
> eth1 (2)
>
>  port id                 8002
> state                           forwarding
>
>  designated root              8000.005056b804c2         path
> cost                             100
>
>  designated bridge          8000.005056b804c2         message age
> timer            0.00
>
>  designated port              8002
> forward delay timer          0.00
>
>  designated cost
> 0                                           hold
> timer                             0.19
>
>  flags
>
>
>
> tap0 (1)
>
>  port id                 8001
> state                           forwarding
>
>  designated root              8000.005056b804c2         path
> cost                             100
>
>  designated bridge          8000.005056b804c2         message age
> timer            0.00
>
>  designated port              8001
> forward delay timer          0.00
>
>  designated cost
> 0                                           hold
> timer                             0.19
>
>  flags
>
>
>
>
>
> eg:
>
> brctl showmacs br0:
>
>
>
> port no mac addr                             is local?
> ageing timer
>
>   2            00:50:56:b8:04:c2             yes
> 0.00
>
>   1            00:ff:46:97:7f:d5               yes
>    0.00
>
>   2            7a:6e:9f:28:12:79              no
>    0.56
>
>
>
> 7a:6e:9f:28:12:79 -- the openvpn client
>
> 00:ff:....   -- tap0
>
> 00:50:56...   -- eth1
>
>
>
>
>
>
>
>
>
>
>
> Thanks,
>
>
>
> Ryan
>
I too am seeing this problem, I've tested with Lenny and Squeeze on ESX 4
and still see the same problem. I am anxiously awaiting some help on how to
troubleshoot the problem. This is a big hang up for me. I don't know if the
virtual switch is sending out multiple replies or what, I'm going to set
this up on some physical hardware and compare. I don't know what else to do.

Thanks,

Robert LeBlanc
Life Sciences & Undergraduate Education Computer Support
Brigham Young University

--0016367b6b06eaeb29047ce6b194
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: base64

T24gVGh1LCBKYW4gNywgMjAxMCBhdCA4OjI1IFBNLCBSeWFuIEtpbmcgPHNwYW4gZGlyPSJsdHIi
PiZsdDs8YSBocmVmPSJtYWlsdG86cnlhbmtAc3RhZmYuZ2xvYmFsZGlhbC5jb20iPnJ5YW5rQHN0
YWZmLmdsb2JhbGRpYWwuY29tPC9hPiZndDs8L3NwYW4+IHdyb3RlOjxicj48ZGl2IGNsYXNzPSJn
bWFpbF9xdW90ZSI+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0iYm9yZGVy
LWxlZnQ6IDFweCBzb2xpZCByZ2IoMjA0LCAyMDQsIDIwNCk7IG1hcmdpbjogMHB0IDBwdCAwcHQg
MC44ZXg7IHBhZGRpbmctbGVmdDogMWV4OyI+CgoKCgoKCgoKCjxkaXYgbGluaz0iYmx1ZSIgdmxp
bms9InB1cnBsZSIgbGFuZz0iRU4tQVUiPgoKPGRpdj4KCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxz
cGFuIGxhbmc9IkVOLVVTIj5IaSw8L3NwYW4+PC9wPgoKPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNw
YW4gbGFuZz0iRU4tVVMiPqA8L3NwYW4+PC9wPgoKPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4g
bGFuZz0iRU4tVVMiPkkgYW0gc2VlaW5nIGEgc3RyYW5nZSBpc3N1ZSB3aXRoIGEgZmFpcmx5CnNp
bXBsZSBicmlkZ2UgSSBoYXZlIHNldHVwIChmb3Igb3BlbnZwbiBpbiBicmlkZ2UgbW9kZSkuPC9z
cGFuPjwvcD4KCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIGxhbmc9IkVOLVVTIj6gPC9zcGFu
PjwvcD4KCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIGxhbmc9IkVOLVVTIj5ldGgwIC0tLaAg
WyBvcGVudnBuIG1hY2hpbmWgICh0YXAwKSBdIC0tLQpldGgxPC9zcGFuPjwvcD4KCjxwIGNsYXNz
PSJNc29Ob3JtYWwiPjxzcGFuIGxhbmc9IkVOLVVTIj6gPC9zcGFuPjwvcD4KCjxwIGNsYXNzPSJN
c29Ob3JtYWwiPjxzcGFuIGxhbmc9IkVOLVVTIj5UaGUgYnJpZGdlIGlzIGJldHdlZW4gdGFwMCBh
bmQgZXRoMSBvbiBhCmRlYmlhbiBtYWNoaW5lIHJ1bm5pbmcgb24gRVNYIDQuoCAodGFwMCBiZWlu
ZyB0aGUgb3BlbnZwbiB0dW5uZWwgaW50ZXJmYWNlKS6gIEludGVybWl0dGVudGx5LApJIHNlZSBv
cGVudnBuIGNsaWVudCBNQUMgYWRkcmVzc2VzIG9uIHBvcnQgMiAoZXRoMSkuoCBXaGVuIHRoaXMg
aGFwcGVucywgdGhlaXIKdnBuIGxpbmsgc3RvcHMgd29ya2luZywgc2luY2UgYXJwIHJlcGxpZXMg
YXJlIGJlaW5nIHNlbnQgYmFjayB2aWEgdGhlIHdyb25nCmludGVyZmFjZS6gIEJ1dCBhZnRlciBh
IHJhbmRvbSBhbW91bnQgb2YgdGltZSwgaXQgd2lsbCBjaGFuZ2UgYmFjayB0byBwb3J0IDEKKHRh
cDApIGFuZCBzdGFydCB3b3JraW5nIGFnYWluLqAgU29tZXRpbWVzIHRoaXMgaXMgcXVpY2ssIHNv
bWV0aW1lcyBpdCBkb2VzbiYjMzk7dApoYXBwZW4gZm9yIGhvdXJzLjwvc3Bhbj48L3A+Cgo8cCBj
bGFzcz0iTXNvTm9ybWFsIj48c3BhbiBsYW5nPSJFTi1VUyI+oDwvc3Bhbj48L3A+Cgo8cCBjbGFz
cz0iTXNvTm9ybWFsIj48c3BhbiBsYW5nPSJFTi1VUyI+QW55b25lIGVsc2UgaGFkIHRoZXNlIGlz
c3Vlcz+gIEkmIzM5O3ZlCnNlYXJjaGVkIHRoZSBhcmNoaXZlcywgYW5kIGNvbWUgYWNyb3NzIHNl
dmVyYWwgcGVvcGxlIHdobyBzZWVtIHRvIGhhdmUgaGFkCnNpbWlsYXIgcHJvYmxlbXMgLSBidXQg
aGF2ZW4mIzM5O3QgZm91bmQgb25lIHRoYXQgaGFzIGEgc29sdXRpb24geWV0Ljwvc3Bhbj48L3A+
Cgo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBsYW5nPSJFTi1VUyI+oDwvc3Bhbj48L3A+Cgo8
cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBsYW5nPSJFTi1VUyI+SSYjMzk7ZCBhcHByZWNpYXRl
IGFueSBzdWdnZXN0aW9ucyBvbiB3aGVyZSBJCnNob3VsZCBzdGFydCBsb29raW5nIHRvIGZpbmQg
b3V0IHdoeS9ob3cgdGhlc2UgTUFDJiMzOTtzIGFyZSBiZWluZyBsZWFybnQgb24gdGhlCndyb25n
IGludGVyZmFjZS4uLjwvc3Bhbj48L3A+Cgo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBsYW5n
PSJFTi1VUyI+oDwvc3Bhbj48L3A+Cgo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBsYW5nPSJF
Ti1VUyI+oDwvc3Bhbj48L3A+Cgo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBsYW5nPSJFTi1V
UyI+YnJjdGwgc2hvdyBicjA6PC9zcGFuPjwvcD4KCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFu
IGxhbmc9IkVOLVVTIj6gPC9zcGFuPjwvcD4KCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIGxh
bmc9IkVOLVVTIj5icmlkZ2UgbmFtZaCgoKCgIGJyaWRnZSBpZKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgIFNUUAplbmFibGVkoKCgoKCgIGludGVyZmFjZXM8L3NwYW4+PC9wPgoKPHAgY2xh
c3M9Ik1zb05vcm1hbCI+PHNwYW4gbGFuZz0iRU4tVVMiPmJyMKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoCA4MDAwLjAwNTA1NmI4MDRjMqCgoKCgoKCgIG5voKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKAgZXRoMTwvc3Bhbj48L3A+Cgo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBsYW5nPSJFTi1V
UyI+oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
IHRhcDA8L3NwYW4+PC9wPgoKPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gbGFuZz0iRU4tVVMi
PqA8L3NwYW4+PC9wPgoKPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gbGFuZz0iRU4tVVMiPqA8
L3NwYW4+PC9wPgoKPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gbGFuZz0iRU4tVVMiPmJyY3Rs
IHNob3dzdHAgYnIwOjwvc3Bhbj48L3A+Cgo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBsYW5n
PSJFTi1VUyI+oDwvc3Bhbj48L3A+Cgo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBsYW5nPSJF
Ti1VUyI+YnIwPC9zcGFuPjwvcD4KCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIGxhbmc9IkVO
LVVTIj6gYnJpZGdlIGlkoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoCA4MDAwLjAwNTA1NmI4
MDRjMjwvc3Bhbj48L3A+Cgo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBsYW5nPSJFTi1VUyI+
oGRlc2lnbmF0ZWQgcm9vdKCgoKCgoKCgoKCgoKAgODAwMC4wMDUwNTZiODA0YzI8L3NwYW4+PC9w
PgoKPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gbGFuZz0iRU4tVVMiPqByb290IHBvcnSgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgIKCgIDCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKAgcGF0aApjb3N0oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoCCgoCAw
PC9zcGFuPjwvcD4KCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIGxhbmc9IkVOLVVTIj6gbWF4
IGFnZaCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgIKAKMjAuMDCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgIGJyaWRnZSBtYXggYWdloKCgoKCgoKCgoKCgoKCgoCCgIDIwLjAw
PC9zcGFuPjwvcD4KCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIGxhbmc9IkVOLVVTIj6gaGVs
bG8gdGltZaCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAgoKAKMi4wMKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoCBicmlkZ2UgaGVsbG8gdGltZaCgoKCgoKCgoKCgIKCgIDIuMDA8
L3NwYW4+PC9wPgoKPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gbGFuZz0iRU4tVVMiPqBmb3J3
YXJkIGRlbGF5oKCgoKCgoKCgoKCgoKCgoKAgoKAgNS4wMKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoCBicmlkZ2UKZm9yd2FyZCBkZWxheaCgoKAgoKAgNS4wMDwvc3Bhbj48L3A+
Cgo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBsYW5nPSJFTi1VUyI+oGFnZWluZyB0aW1loKCg
oKCgoKCgoKCgoKCgoKCgoKCgoCAgMzAwLjAxPC9zcGFuPjwvcD4KCjxwIGNsYXNzPSJNc29Ob3Jt
YWwiPjxzcGFuIGxhbmc9IkVOLVVTIj6gaGVsbG8gdGltZXKgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oCCgoCAxLjE5oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgIHRjbgp0aW1lcqCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAgoKAgMC4wMDwvc3Bhbj48L3A+Cgo8cCBjbGFzcz0i
TXNvTm9ybWFsIj48c3BhbiBsYW5nPSJFTi1VUyI+oHRvcG9sb2d5IGNoYW5nZSB0aW1lciCgoCAw
LjAwoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgIGdjCnRpbWVyoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgIKCgIDIuMTk8L3NwYW4+PC9wPgoKPHAgY2xhc3M9Ik1zb05v
cm1hbCI+PHNwYW4gbGFuZz0iRU4tVVMiPqBmbGFnc6CgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoCA8L3NwYW4+PC9wPgoKPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gbGFuZz0i
RU4tVVMiPqA8L3NwYW4+PC9wPgoKPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gbGFuZz0iRU4t
VVMiPqA8L3NwYW4+PC9wPgoKPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gbGFuZz0iRU4tVVMi
PmV0aDEgKDIpPC9zcGFuPjwvcD4KCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIGxhbmc9IkVO
LVVTIj6gcG9ydCBpZKCgoKCgoKCgoKCgoKCgoKAgODAwMqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgIHN0YXRloKCgoKCgoKCgoKCgoKCgoKCgoKCgIKCgoKAKZm9yd2FyZGlu
Zzwvc3Bhbj48L3A+Cgo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBsYW5nPSJFTi1VUyI+oGRl
c2lnbmF0ZWQgcm9vdKCgoKCgoKCgoKCgoKAgODAwMC4wMDUwNTZiODA0YzKgoKCgoKCgoCBwYXRo
CmNvc3SgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgICAxMDA8L3NwYW4+PC9wPgoKPHAgY2xh
c3M9Ik1zb05vcm1hbCI+PHNwYW4gbGFuZz0iRU4tVVMiPqBkZXNpZ25hdGVkIGJyaWRnZaCgoKCg
oKCgoCA4MDAwLjAwNTA1NmI4MDRjMqCgoKCgoKCgIG1lc3NhZ2UKYWdlIHRpbWVyoKCgoKCgoKAg
oKAgMC4wMDwvc3Bhbj48L3A+Cgo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBsYW5nPSJFTi1V
UyI+oGRlc2lnbmF0ZWQgcG9ydKCgoKCgoKCgoKCgoKAgODAwMqCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgIGZvcndhcmQKZGVsYXkgdGltZXKgoKCgoKAgoKAgMC4wMDwvc3Bh
bj48L3A+Cgo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBsYW5nPSJFTi1VUyI+oGRlc2lnbmF0
ZWQgY29zdKCgoKCgoKCgoKCgoKCgIKCgIDCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKAgaG9sZAp0aW1lcqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAgoKAgMC4xOTwv
c3Bhbj48L3A+Cgo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBsYW5nPSJFTi1VUyI+oGZsYWdz
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgIDwvc3Bhbj48L3A+Cgo8cCBjbGFz
cz0iTXNvTm9ybWFsIj48c3BhbiBsYW5nPSJFTi1VUyI+oDwvc3Bhbj48L3A+Cgo8cCBjbGFzcz0i
TXNvTm9ybWFsIj48c3BhbiBsYW5nPSJFTi1VUyI+dGFwMCAoMSk8L3NwYW4+PC9wPgoKPHAgY2xh
c3M9Ik1zb05vcm1hbCI+PHNwYW4gbGFuZz0iRU4tVVMiPqBwb3J0IGlkoKCgoKCgoKCgoKCgoKCg
oCA4MDAxoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAgc3RhdGWgoKCgoKCg
oKCgoKCgoKCgoKCgoKAgoKCgoApmb3J3YXJkaW5nPC9zcGFuPjwvcD4KCjxwIGNsYXNzPSJNc29O
b3JtYWwiPjxzcGFuIGxhbmc9IkVOLVVTIj6gZGVzaWduYXRlZCByb290oKCgoKCgoKCgoKCgoCA4
MDAwLjAwNTA1NmI4MDRjMqCgoKCgoKCgIHBhdGgKY29zdKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKAgIDEwMDwvc3Bhbj48L3A+Cgo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBsYW5nPSJF
Ti1VUyI+oGRlc2lnbmF0ZWQgYnJpZGdloKCgoKCgoKCgIDgwMDAuMDA1MDU2YjgwNGMyoKCgoKCg
oKAgbWVzc2FnZQphZ2UgdGltZXKgoKCgoKCgoCCgoCAwLjAwPC9zcGFuPjwvcD4KCjxwIGNsYXNz
PSJNc29Ob3JtYWwiPjxzcGFuIGxhbmc9IkVOLVVTIj6gZGVzaWduYXRlZCBwb3J0oKCgoKCgoKCg
oKCgoCA4MDAxoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAgZm9yd2FyZApk
ZWxheSB0aW1lcqCgoKCgoCCgoCAwLjAwPC9zcGFuPjwvcD4KCjxwIGNsYXNzPSJNc29Ob3JtYWwi
PjxzcGFuIGxhbmc9IkVOLVVTIj6gZGVzaWduYXRlZCBjb3N0oKCgoKCgoKCgoKCgoKAgoKAgMKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoCBob2xkCnRpbWVyoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoCCgoCAwLjE5PC9zcGFuPjwvcD4KCjxwIGNsYXNzPSJNc29Ob3Jt
YWwiPjxzcGFuIGxhbmc9IkVOLVVTIj6gZmxhZ3M8L3NwYW4+PC9wPgoKPHAgY2xhc3M9Ik1zb05v
cm1hbCI+PHNwYW4gbGFuZz0iRU4tVVMiPqA8L3NwYW4+PC9wPgoKPHAgY2xhc3M9Ik1zb05vcm1h
bCI+PHNwYW4gbGFuZz0iRU4tVVMiPqA8L3NwYW4+PC9wPgoKPHAgY2xhc3M9Ik1zb05vcm1hbCI+
PHNwYW4gbGFuZz0iRU4tVVMiPmVnOjwvc3Bhbj48L3A+Cgo8cCBjbGFzcz0iTXNvTm9ybWFsIj48
c3BhbiBsYW5nPSJFTi1VUyI+YnJjdGwgc2hvd21hY3MgYnIwOjwvc3Bhbj48L3A+Cgo8cCBjbGFz
cz0iTXNvTm9ybWFsIj48c3BhbiBsYW5nPSJFTi1VUyI+oDwvc3Bhbj48L3A+Cgo8cCBjbGFzcz0i
TXNvTm9ybWFsIj48c3BhbiBsYW5nPSJFTi1VUyI+cG9ydCBubyBtYWMgYWRkcqCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKAgaXMKbG9jYWw/oKCgoKCgoKCgoKCgoKCgIGFnZWluZyB0aW1lcjwv
c3Bhbj48L3A+Cgo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBsYW5nPSJFTi1VUyI+oCAyoKCg
oKCgoKCgoKAgMDA6NTA6NTY6Yjg6MDQ6YzKgoKCgoKCgoKCgoKAgeWVzoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgIKCgCjAuMDA8L3NwYW4+PC9wPgoKPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4g
bGFuZz0iRU4tVVMiPqAgMaCgoKCgoKCgoKCgIDAwOmZmOjQ2Ojk3OjdmOmQ1oKCgoKCgoKCgoKCg
oKAgeWVzoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgIKCgCjAuMDA8L3NwYW4+PC9wPgoKPHAgY2xh
c3M9Ik1zb05vcm1hbCI+PHNwYW4gbGFuZz0iRU4tVVMiPqAgMqCgoKCgoKCgoKCgIDdhOjZlOjlm
OjI4OjEyOjc5oKCgoKCgoKCgoKCgoCBub6CgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgIKCgCjAu
NTY8L3NwYW4+PC9wPgoKPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gbGFuZz0iRU4tVVMiPqA8
L3NwYW4+PC9wPgoKPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gbGFuZz0iRU4tVVMiPjdhOjZl
OjlmOjI4OjEyOjc5IC0tIHRoZSBvcGVudnBuIGNsaWVudDwvc3Bhbj48L3A+Cgo8cCBjbGFzcz0i
TXNvTm9ybWFsIj48c3BhbiBsYW5nPSJFTi1VUyI+MDA6ZmY6Li4uLqCgIC0tIHRhcDA8L3NwYW4+
PC9wPgoKPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gbGFuZz0iRU4tVVMiPjAwOjUwOjU2Li4u
oKAgLS0gZXRoMTwvc3Bhbj48L3A+Cgo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBsYW5nPSJF
Ti1VUyI+oDwvc3Bhbj48L3A+Cgo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBsYW5nPSJFTi1V
UyI+oDwvc3Bhbj48L3A+Cgo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBsYW5nPSJFTi1VUyI+
oDwvc3Bhbj48L3A+Cgo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBsYW5nPSJFTi1VUyI+oDwv
c3Bhbj48L3A+Cgo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBsYW5nPSJFTi1VUyI+oDwvc3Bh
bj48L3A+Cgo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBsYW5nPSJFTi1VUyI+VGhhbmtzLDwv
c3Bhbj48L3A+Cgo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBsYW5nPSJFTi1VUyI+oDwvc3Bh
bj48L3A+Cgo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBsYW5nPSJFTi1VUyI+Unlhbjwvc3Bh
bj48L3A+PC9kaXY+PC9kaXY+PC9ibG9ja3F1b3RlPjxkaXY+SSB0b28gYW0gc2VlaW5nIHRoaXMg
cHJvYmxlbSwgSSYjMzk7dmUgdGVzdGVkIHdpdGggTGVubnkgYW5kIFNxdWVlemUgb24gRVNYIDQg
YW5kIHN0aWxsIHNlZSB0aGUgc2FtZSBwcm9ibGVtLiBJIGFtIGFueGlvdXNseSBhd2FpdGluZyBz
b21lIGhlbHAgb24gaG93IHRvIHRyb3VibGVzaG9vdCB0aGUgcHJvYmxlbS4gVGhpcyBpcyBhIGJp
ZyBoYW5nIHVwIGZvciBtZS4gSSBkb24mIzM5O3Qga25vdyBpZiB0aGUgdmlydHVhbCBzd2l0Y2gg
aXMgc2VuZGluZyBvdXQgbXVsdGlwbGUgcmVwbGllcyBvciB3aGF0LCBJJiMzOTttIGdvaW5nIHRv
IHNldCB0aGlzIHVwIG9uIHNvbWUgcGh5c2ljYWwgaGFyZHdhcmUgYW5kIGNvbXBhcmUuIEkgZG9u
JiMzOTt0IGtub3cgd2hhdCBlbHNlIHRvIGRvLjxicj4KPGJyPlRoYW5rcyw8YnIgY2xlYXI9ImFs
bCI+PGJyPlJvYmVydCBMZUJsYW5jPGJyPkxpZmUgU2NpZW5jZXMgJmFtcDsgVW5kZXJncmFkdWF0
ZSBFZHVjYXRpb24gQ29tcHV0ZXIgU3VwcG9ydDxicj5CcmlnaGFtIFlvdW5nIFVuaXZlcnNpdHk8
YnI+Cjxicj6gPC9kaXY+PC9kaXY+PGJyPgo=
--0016367b6b06eaeb29047ce6b194--
