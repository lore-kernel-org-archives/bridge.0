Return-Path: <kernelluck@163.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=4Ozb1
	NS2iGaBYg/hG5RA1onTyPMdUYAZRoA9kdSCK/s=; b=GgbzcloQgJJgY7aVvoCLa
	HDjFX4Kd4JCMl+EaB91c9FVx1nsy36gvTA1qNmO9WiuvQ17xs4lYARwvi+6Hxm+k
	mAQCKGom/A/RsbWeJ36TZF2+reIUuQaXHP4fZFluqCTwZdOTxKqps7IOEiQ7mu/f
	MUFghEp2kgXkTSpscfQqQI=
Date: Sun, 30 Mar 2014 10:10:05 +0800 (CST)
From: "longguang.yue" <kernelluck@163.com>
Content-Type: multipart/alternative; 
	boundary="----=_Part_165967_552514930.1396145405541"
MIME-Version: 1.0
Message-ID: <67759941.af95.14510c03e65.Coremail.kernelluck@163.com>
Subject: [Bridge] what is the driver of vm's virtual ethernet?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge <bridge@lists.linux-foundation.org>, virtualization <virtualization@lists.linux-foundation.org>

------=_Part_165967_552514930.1396145405541
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: base64

aGksYWxsCmVhY2ggcG9ydCBvZiBicmlkZ2UsIGhhcyBpdHMgcGFja2V0cyBwcm9jZXNzIGZ1bmN0
aW9uIGNhbGxlZCBicl9oYW5kbGVfZnJhbWUuCmkgd2FudCB0byBrbm93IGJlZm9yZSB0aGlzIGZ1
bmN0aW9uIGNhbGxlZCAgIHdobyBhbmQgaG93IGl0IGdldCB0aGUgcGFja2V0cz8KaWYgaXQgaXMg
YSByZWFsIHBoeXNpY2FsIGV0aGVybmV0LCBpdCAgbXVzdCBiZSBpdHMgZHJpdmVyLCBidXQgZm9y
IHZpcnR1YWwgZXRoZXJuZXQgLCB3aGF0IGlzIHRoZSBkcml2ZXI/CiAKIAp0aGFua3M=
------=_Part_165967_552514930.1396145405541
Content-Type: text/html; charset=GBK
Content-Transfer-Encoding: base64

PGRpdiBzdHlsZT0ibGluZS1oZWlnaHQ6MS43O2NvbG9yOiMwMDAwMDA7Zm9udC1zaXplOjE0cHg7
Zm9udC1mYW1pbHk6YXJpYWwiPjxkaXY+aGksYWxsPC9kaXY+PGRpdj5lYWNoIHBvcnQgb2YgYnJp
ZGdlLCBoYXMgaXRzIHBhY2tldHMgcHJvY2VzcyBmdW5jdGlvbiBjYWxsZWQgYnJfaGFuZGxlX2Zy
YW1lLjwvZGl2PjxkaXY+aSB3YW50IHRvIGtub3cgYmVmb3JlIHRoaXMgZnVuY3Rpb24gY2FsbGVk
Jm5ic3A7Jm5ic3A7IHdobyBhbmQgaG93IGl0IGdldCB0aGUgcGFja2V0cz88L2Rpdj48ZGl2Pmlm
IGl0IGlzIGEgcmVhbCBwaHlzaWNhbCBldGhlcm5ldCwgaXQmbmJzcDsgbXVzdCBiZSBpdHMgZHJp
dmVyLCBidXQgZm9yIHZpcnR1YWwgZXRoZXJuZXQgLCB3aGF0IGlzIHRoZSBkcml2ZXI/PC9kaXY+
PGRpdj4mbmJzcDs8L2Rpdj48ZGl2PiZuYnNwOzwvZGl2PjxkaXY+dGhhbmtzPC9kaXY+PC9kaXY+
PGJyPjxicj48c3BhbiB0aXRsZT0ibmV0ZWFzZWZvb3RlciI+PHNwYW4gaWQ9Im5ldGVhc2VfbWFp
bF9mb290ZXIiPjwvc3Bhbj48L3NwYW4+
------=_Part_165967_552514930.1396145405541--

