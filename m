Return-Path: <drmaligno@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:date:message-id:subject:from:to:content-type;
	bh=uj8FThyQBBinz68DFOx+H4FoSVe27bK6Bj+g/f9lBs0=;
	b=a6b1iAwAh6P1VSikPqH7N8ujcCYUxLJTpkUYsgPAJI3iFJEQiELAFLwS+OEqEFp5sN
	U4wtm+JXSVd2q40FhE/HSsSRYqYn4crodjqsquYEVkX/YMq8VA3kroOTSHRZF2Txinne
	Vl/EvvURJS+/hPAIVRbYjjAPJCjOVbfXI6hS8/KsQ7QVg/52YgVZxn1OtIkYbv6irXze
	rL79CduNbMAkdNyxBxXVr9XIOc7RA7UY0/JekZcBHz+CbqJxIyqN2GANRWFWpAZMZtKq
	MoZ24EjUN7gaRhRvPyb9mdajYUov7TqBf78EsSznoMMFitadrQsVbTRSWy8xDAm5fFiD
	Bn6A==
MIME-Version: 1.0
Message-ID: <CAL4ZbrRSLC4hoeTWbp1s82Vzo2NqO5GDpkfAh0nndBa9CF6sag@mail.gmail.com>
From: Alex Font <drmaligno@gmail.com>
Content-Type: multipart/alternative; boundary=089e0160c77ab9ee4704e125c056
Subject: [Bridge] Bridging Vlan traffic on routed network
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Wed, 10 Jul 2013 10:29:33 -0000
To: bridge@lists.linux-foundation.org

--089e0160c77ab9ee4704e125c056
Content-Type: text/plain; charset=ISO-8859-1

Hi everybody!

As a part of a NAC implementation, I've created a new VLAN for the
"isolated" devices, from this VLAN, the computers in it, are not able to
communicate with nothing, except what I want (via iptables).
So, the thing is that I'm trying to bridge some traffic from one
"isolation" VLAN (VLAN 3) to the "production" VLAN (VLAN 800).
I'm working on a routed network (Enterasys routing) that take care of
routing and VLAN tagging stuff of course...

The point is that I want that the linux box filter the packets between
those VLAN's, but I've tried with brctl and ebtables, but at first, the
"isolated" computer was not able to reach the servers on the "production"
VLAN (I was seeing the ARP requests from the PC, asking for the MAC of its
gateway) and after a few tries I managed to put it working, but after a few
minutes, the entire network went down... :( So, definately, I'm doing
something wrong...

Here's an example of the scenario:

VLAN 110: 172.26.0.0/16 (gw: 172.26.135.136)
VLAN 800: 172.20.0.0/16 (gw: 172.20.135.136)
VLAN 3: (isolation, no routed by the Enterasys)

___________________
| PC isolated (VLAN 3)|
172.20.135.136                         ____________
|IP: 172.26.135.109    |
__172.26.135.136_                       |                    |
|GW: 172.26.135.136  |------->| Cisco 3560 |---(trunk)---->|Enterasys
Router|----VLAN3---------|Linux Bridge  |
---------------------------------

|--------------------------|-----VLAN800-----|     Box          |

                                                        |
                           |---------------------|

|

VLAN800

|

------------

| Server|

------------

IP:172.20.100.2

GW:172.20.135.136

As you can see, the packets from the Router to the bridge box arrive
"tagged"... I've tried also configuring the port of "VLAN800" to the Linux
Box as an "access port", but the packets never came again to the linux box
(I only see the computer ARP requests coming from the VLAN3, passing
through the bridge and leaving by the "access" interface...)

So, I configured both ports of Enterasys router as "tagged ports" and the
linux bridge box as the following:

ifconfig eth0 0.0.0.0
ifconfig eth1 0.0.0.0
vconfig add eth0 800
vconfig add eth1 3
brctl addbr br0
brctl addif br0 eth0.800
brctl addif br0 eth1.3

With this configuration, the computer can communicate with the servers, but
after a while, the entire network goes down! :-/

What would be the best way to do this kind of packet forwarding. I know
that this work can be done with the Router itself, but it's not able to
filter the packets as iptables does (fine grained)... so that's why I'm
putting the linux bridge between those VLANs.

What I'm missing?

Thanks in advance!!

PS: By the way, STP is disabled in the router and also in the Linux bridge
box.

--089e0160c77ab9ee4704e125c056
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdj48ZGl2PjxkaXY+PGRpdj48ZGl2PjxkaXY+SGkgZXZlcnlib2R5
ITxicj48YnI+PC9kaXY+QXMgYSBwYXJ0IG9mIGEgTkFDIGltcGxlbWVudGF0aW9uLCBJJiMzOTt2
ZSBjcmVhdGVkIGEgbmV3IFZMQU4gZm9yIHRoZSAmcXVvdDtpc29sYXRlZCZxdW90OyBkZXZpY2Vz
LCBmcm9tIHRoaXMgVkxBTiwgdGhlIGNvbXB1dGVycyBpbiBpdCwgYXJlIG5vdCBhYmxlIHRvIGNv
bW11bmljYXRlIHdpdGggbm90aGluZywgZXhjZXB0IHdoYXQgSSB3YW50ICh2aWEgaXB0YWJsZXMp
LiA8YnI+DQpTbywgdGhlIHRoaW5nIGlzIHRoYXQgSSYjMzk7bSB0cnlpbmcgdG8gYnJpZGdlIHNv
bWUgdHJhZmZpYyBmcm9tIG9uZSAmcXVvdDtpc29sYXRpb24mcXVvdDsgVkxBTiAoVkxBTiAzKSB0
byB0aGUgJnF1b3Q7cHJvZHVjdGlvbiZxdW90OyBWTEFOIChWTEFOIDgwMCkuIDxicj5JJiMzOTtt
IHdvcmtpbmcgb24gYSByb3V0ZWQgbmV0d29yayAoRW50ZXJhc3lzIHJvdXRpbmcpIHRoYXQgdGFr
ZSBjYXJlIG9mIHJvdXRpbmcgYW5kIFZMQU4gdGFnZ2luZyBzdHVmZiBvZiBjb3Vyc2UuLi48YnI+
DQo8YnI+VGhlIHBvaW50IGlzIHRoYXQgSSB3YW50IHRoYXQgdGhlIGxpbnV4IGJveCBmaWx0ZXIg
dGhlIHBhY2tldHMgYmV0d2VlbiB0aG9zZSBWTEFOJiMzOTtzLCBidXQgSSYjMzk7dmUgdHJpZWQg
d2l0aCBicmN0bCBhbmQgZWJ0YWJsZXMsIGJ1dCBhdCBmaXJzdCwgdGhlICZxdW90O2lzb2xhdGVk
JnF1b3Q7IGNvbXB1dGVyIHdhcyBub3QgYWJsZSB0byByZWFjaCB0aGUgc2VydmVycyBvbiB0aGUg
JnF1b3Q7cHJvZHVjdGlvbiZxdW90OyBWTEFOIChJIHdhcyBzZWVpbmcgdGhlIEFSUCByZXF1ZXN0
cyBmcm9tIHRoZSBQQywgYXNraW5nIGZvciB0aGUgTUFDIG9mIGl0cyBnYXRld2F5KSBhbmQgYWZ0
ZXIgYSBmZXcgdHJpZXMgSSBtYW5hZ2VkIHRvIHB1dCBpdCB3b3JraW5nLCBidXQgYWZ0ZXIgYSBm
ZXcgbWludXRlcywgdGhlIGVudGlyZSBuZXR3b3JrIHdlbnQgZG93bi4uLiA6KCBTbywgZGVmaW5h
dGVseSwgSSYjMzk7bSBkb2luZyBzb21ldGhpbmcgd3JvbmcuLi48YnI+DQo8YnI+PC9kaXY+SGVy
ZSYjMzk7cyBhbiBleGFtcGxlIG9mIHRoZSBzY2VuYXJpbzo8YnI+PGJyPjwvZGl2PjxkaXY+VkxB
TiAxMTA6IDxhIGhyZWY9Imh0dHA6Ly8xNzIuMjYuMC4wLzE2Ij4xNzIuMjYuMC4wLzE2PC9hPiAo
Z3c6IDE3Mi4yNi4xMzUuMTM2KTxicj48L2Rpdj48ZGl2PlZMQU4gODAwOiA8YSBocmVmPSJodHRw
Oi8vMTcyLjIwLjAuMC8xNiI+MTcyLjIwLjAuMC8xNjwvYT4gKGd3OiAxNzIuMjAuMTM1LjEzNik8
YnI+DQo8L2Rpdj48ZGl2PlZMQU4gMzogKGlzb2xhdGlvbiwgbm8gcm91dGVkIGJ5IHRoZSBFbnRl
cmFzeXMpPGJyPjxicj48L2Rpdj5fX19fX19fX19fX19fX19fX19fPGJyPjwvZGl2PnwgUEMgaXNv
bGF0ZWQgKFZMQU4gMyl8oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoCAxNzIuMjAuMTM1LjEzNiCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoCBfX19fX19fX19f
X188YnI+DQo8L2Rpdj48ZGl2PnxJUDogMTcyLjI2LjEzNS4xMDmgoKAgfKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAgX18xNzIuMjYuMTM1LjEzNl+goKCgoKCg
oKCgoKCgoKCgoKCgoKCgIHygoKCgoKCgoKCgoKCgoKCgoKCgIHw8YnI+PC9kaXY+fEdXOiAxNzIu
MjYuMTM1LjEzNqAgfC0tLS0tLS0mZ3Q7fCBDaXNjbyAzNTYwIHwtLS0odHJ1bmspLS0tLSZndDt8
RW50ZXJhc3lzIFJvdXRlcnwtLS0tVkxBTjMtLS0tLS0tLS18TGludXggQnJpZGdloCB8PGJyPg0K
PC9kaXY+LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tIKCgIKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoCB8LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS18
LS0tLS1WTEFOODAwLS0tLS18oKCgoCBCb3igoKCgoKCgoKAgfDxicj48ZGl2PjxkaXY+PGRpdj48
ZGl2PjxkaXY+oCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAgfKCgoKCgoKCgoCCgoCCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoCB8LS0tLS0tLS0tLS0tLS0tLS0tLS0tfDxicj4NCqCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgIHw8YnI+PC9kaXY+PGRpdj6goKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKAgVkxBTjgwMDxicj6goKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoCB8PGJyPg0KoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoCAtLS0tLS0tLS0tLS0g
PGJyPjwvZGl2PjxkaXY+oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoCB8IFNlcnZlcnwgPGJy
PqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAgLS0tLS0tLS0tLS0tIDxicj4NCjwvZGl2Pjxk
aXY+oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoCBJUDoxNzIuMjAuMTAwLjI8YnI+PC9kaXY+PGRp
dj6goKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgIEdXOjE3Mi4yMC4xMzUuMTM2PGJyPg0KPC9kaXY+
PGRpdj48YnI+PC9kaXY+PGRpdj5BcyB5b3UgY2FuIHNlZSwgdGhlIHBhY2tldHMgZnJvbSB0aGUg
Um91dGVyIHRvIHRoZSBicmlkZ2UgYm94IGFycml2ZSAmcXVvdDt0YWdnZWQmcXVvdDsuLi4gSSYj
Mzk7dmUgdHJpZWQgYWxzbyBjb25maWd1cmluZyB0aGUgcG9ydCBvZiAmcXVvdDtWTEFOODAwJnF1
b3Q7IHRvIHRoZSBMaW51eCBCb3ggYXMgYW4gJnF1b3Q7YWNjZXNzIHBvcnQmcXVvdDssIGJ1dCB0
aGUgcGFja2V0cyBuZXZlciBjYW1lIGFnYWluIHRvIHRoZSBsaW51eCBib3ggKEkgb25seSBzZWUg
dGhlIGNvbXB1dGVyIEFSUCByZXF1ZXN0cyBjb21pbmcgZnJvbSB0aGUgVkxBTjMsIHBhc3Npbmcg
dGhyb3VnaCB0aGUgYnJpZGdlIGFuZCBsZWF2aW5nIGJ5IHRoZSAmcXVvdDthY2Nlc3MmcXVvdDsg
aW50ZXJmYWNlLi4uKTxicj4NCjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+U28sIEkgY29uZmln
dXJlZCBib3RoIHBvcnRzIG9mIEVudGVyYXN5cyByb3V0ZXIgYXMgJnF1b3Q7dGFnZ2VkIHBvcnRz
JnF1b3Q7IGFuZCB0aGUgbGludXggYnJpZGdlIGJveCBhcyB0aGUgZm9sbG93aW5nOjxicj48YnI+
PC9kaXY+PGRpdj48L2Rpdj48ZGl2PmlmY29uZmlnIGV0aDAgMC4wLjAuMDxicj48L2Rpdj48ZGl2
PmlmY29uZmlnIGV0aDEgMC4wLjAuMDxicj4NCjwvZGl2PjxkaXY+dmNvbmZpZyBhZGQgZXRoMCA4
MDA8YnI+PC9kaXY+PGRpdj52Y29uZmlnIGFkZCBldGgxIDM8YnI+PC9kaXY+PGRpdj5icmN0bCBh
ZGRiciBicjA8YnI+PC9kaXY+PGRpdj5icmN0bCBhZGRpZiBicjAgZXRoMC44MDA8YnI+PC9kaXY+
PGRpdj5icmN0bCBhZGRpZiBicjAgZXRoMS4zPGJyPjxicj48L2Rpdj48ZGl2PldpdGggdGhpcyBj
b25maWd1cmF0aW9uLCB0aGUgY29tcHV0ZXIgY2FuIGNvbW11bmljYXRlIHdpdGggdGhlIHNlcnZl
cnMsIGJ1dCBhZnRlciBhIHdoaWxlLCB0aGUgZW50aXJlIG5ldHdvcmsgZ29lcyBkb3duISA6LS88
YnI+DQo8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PldoYXQgd291bGQgYmUgdGhlIGJlc3Qgd2F5
IHRvIGRvIHRoaXMga2luZCBvZiBwYWNrZXQgZm9yd2FyZGluZy4gSSBrbm93IHRoYXQgdGhpcyB3
b3JrIGNhbiBiZSBkb25lIHdpdGggdGhlIFJvdXRlciBpdHNlbGYsIGJ1dCBpdCYjMzk7cyBub3Qg
YWJsZSB0byBmaWx0ZXIgdGhlIHBhY2tldHMgYXMgaXB0YWJsZXMgZG9lcyAoZmluZSBncmFpbmVk
KS4uLiBzbyB0aGF0JiMzOTtzIHdoeSBJJiMzOTttIHB1dHRpbmcgdGhlIGxpbnV4IGJyaWRnZSBi
ZXR3ZWVuIHRob3NlIFZMQU5zLjxicj4NCjxicj48L2Rpdj48ZGl2PldoYXQgSSYjMzk7bSBtaXNz
aW5nPzxicj48YnI+PC9kaXY+PGRpdj5UaGFua3MgaW4gYWR2YW5jZSEhPGJyPjxicj48L2Rpdj48
ZGl2PlBTOiBCeSB0aGUgd2F5LCBTVFAgaXMgZGlzYWJsZWQgaW4gdGhlIHJvdXRlciBhbmQgYWxz
byBpbiB0aGUgTGludXggYnJpZGdlIGJveC48YnI+PC9kaXY+PGRpdj48YnI+PGJyPjxicj48YnI+
PGJyPjxicj48YnI+PGJyPjwvZGl2Pg0KPC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+DQo=
--089e0160c77ab9ee4704e125c056--
