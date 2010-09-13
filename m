MIME-Version: 1.0
Date: Mon, 13 Sep 2010 15:11:21 +0530
Message-ID: <AANLkTi=Qi36akPjHb4UJTXhDPW0tCrS7MC4CyAXSDBO4@mail.gmail.com>
From: debasis das <fordebasis@gmail.com>
Content-Type: multipart/alternative; boundary=0016e644ce782dbf08049020e697
Subject: [Bridge] help needed regarding configuration for bridging
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

--0016e644ce782dbf08049020e697
Content-Type: text/plain; charset=ISO-8859-1

Hi all,
        I have a Linux box with 3 interfaces eth0,eth1 and eth2.
        Could anyone please let me know whether the following configuration
would be valid :

*#brctl addbr br1
#brctl addif br1 eth1
#ifconfig br1 up
# brctl show
bridge name     bridge id               STP enabled     interfaces
br1             8000.001000000007       no              eth1


# brctl addbr br0
# brctl addif br0 eth0
# ifconfig br0 up
# vconfig add br0 5
# brctl addif br1 br0.5

# brctl show
bridge name     bridge id               STP enabled     interfaces
br1             8000.001000000006       no                       br0.5

eth1
br0             8000.001000000006       no

#
# ifconfig br0.5 up*

Thanks.
Debasis

--0016e644ce782dbf08049020e697
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: base64

SGkgYWxsLDxicj6goKCgoKCgIEkgaGF2ZSBhIExpbnV4IGJveCB3aXRoIDMgaW50ZXJmYWNlcyBl
dGgwLGV0aDEgYW5kIGV0aDIuPGJyPqCgoKCgoKAgQ291bGQgYW55b25lIHBsZWFzZSBsZXQgbWUg
a25vdyB3aGV0aGVyIHRoZSBmb2xsb3dpbmcgY29uZmlndXJhdGlvbiB3b3VsZCBiZSB2YWxpZCA6
PGJyPjxicj48YiBzdHlsZT0iY29sb3I6IHJnYigwLCA1MSwgNTEpOyI+I2JyY3RsIGFkZGJyIGJy
MTxicj4KI2JyY3RsIGFkZGlmIGJyMSBldGgxPGJyPiNpZmNvbmZpZyBicjEgdXA8YnI+IyBicmN0
bCBzaG93PGJyPmJyaWRnZSBuYW1loKCgoCBicmlkZ2UgaWSgoKCgoKCgoKCgoKCgoCBTVFAgZW5h
YmxlZKCgoKAgaW50ZXJmYWNlczxicj5icjGgoKCgoKCgoKCgoKAgODAwMC4wMDEwMDAwMDAwMDeg
oKCgoKAgbm+goKCgoKCgoKCgoKCgIGV0aDE8YnI+PGJyPjxicj4jIGJyY3RsIGFkZGJyIGJyMDxi
cj4KIyBicmN0bCBhZGRpZiBicjAgZXRoMDxicj4jIGlmY29uZmlnIGJyMCB1cDxicj4jIHZjb25m
aWcgYWRkIGJyMCA1PGJyPiMgYnJjdGwgYWRkaWYgYnIxIGJyMC41PGJyPjxicj4jIGJyY3RsIHNo
b3c8YnI+YnJpZGdlIG5hbWWgoKCgIGJyaWRnZSBpZKCgoKCgoKCgoKCgoKCgIFNUUCBlbmFibGVk
oKCgoCBpbnRlcmZhY2VzPGJyPmJyMaCgoKCgoKCgoKCgoCA4MDAwLjAwMTAwMDAwMDAwNqCgoKCg
oCBub6CgoKCgoKCgoKCgoKCgoKCgoKCgoKAgYnIwLjU8YnI+CqCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgIGV0aDE8YnI+YnIwoKCgoKCgoKCgoKCgIDgwMDAuMDAxMDAwMDAwMDA2oKCgoKCgIG5voKCg
oKCgoKCgoKCgoCA8YnI+PGJyPiM8YnI+IyBpZmNvbmZpZyBicjAuNSB1cDwvYj48YnIgc3R5bGU9
ImNvbG9yOiByZ2IoMCwgMTAyLCAwKTsiPjxicj5UaGFua3MuPGJyPgpEZWJhc2lzPGJyPgo=
--0016e644ce782dbf08049020e697--
