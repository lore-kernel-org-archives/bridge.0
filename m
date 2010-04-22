MIME-Version: 1.0
Date: Thu, 22 Apr 2010 10:48:09 +1000
Message-ID: <m2nbc9320b91004211748o5548f351z646076fab6744cca@mail.gmail.com>
From: benno joy <bennojoy@gmail.com>
Content-Type: multipart/alternative; boundary=0016363b88ae2864640484c8aa5f
Subject: [Bridge] Bridge blocking network traffic
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

--0016363b88ae2864640484c8aa5f
Content-Type: text/plain; charset=ISO-8859-1

Dear Team,

I have a strange problem...... This is my problem i have a linux box running
Xen kernel (2.2). and i have the a bonding interface called bond0.497(eth0
and eth1 and also des Vlan tagging).
the bond0.497 is part of the bridge "xenbrv497", the issue is as soon as i
make the bond a part of the bridge my network traffic stops to work.
I did some prelimanary tests and found the following:
1) if i assighn an ip to the bond and do a ping to the gateway it works
(provided it is not part of bridge xenbrv497)
2) if i add the bondig interface to the brodge xenbrv497 (brclt addif
xenbrv497 bond0.497) the ping tests fails.
3) i did a tcpdump and found that arp requests are going out of the
interface and we are getting response also. but soemhow
the arp entries are not gettign registered. i did some googling and found it
may be because of filtering so i disabled it by
echo 0 > in /proc/sys/net/bridge/bridge-nf-*.
But even this did not help still the arp entries are not getting registered
due to which my network traffic is gettign dropped.
This problem can be resolved by a reboot. but i would like to troubleshoot
it.
Could you please let me know how i can get more debugging message from the
bridge calls so i can figure out what exactly is happening.

# uname -a
Linux vmclkxstgh04.espdev.aurdev.national.com.au 2.6.18-128.2.1.4.13.el5xen
#1 SMP Mon Dec 7 14:34:40 EST 2009 i686 i686 i386 GNU/Linux

[root@vmclkxstgh04 ~]# brctl show
bridge name     bridge id               STP enabled     interfaces
vlan441         8000.0017a4770470       no              bond0.441
xenbrv205               8000.0017a477046c       no              bond1.205
xenbrv208               8000.0017a477046c       no              bond1.208
xenbrv220               8000.000000000000       no
xenbrv221               8000.000000000000       no
xenbrv226               8000.0017a477046c       no              vif40.1
                                                        vif39.1
                                                        vif37.1
                                                        vif26.1
                                                        vif25.1
                                                        vif24.1
                                                        vif13.1
                                                        bond1.226
xenbrv227               8000.0017a4770470       no              vif40.0
                                                        vif39.0
                                                        vif37.0
                                                        vif26.0
                                                        vif25.0
                                                        vif24.0
                                                        vif13.0
                                                        bond0.227
xenbrv420               8000.0017a4770470       no              bond0.420
xenbrv422               8000.0017a4770470       no              vif35.0
                                                        vif7.0
                                                        vif6.0
                                                        vif4.0
                                                        vif3.0
                                                        vif2.0
                                                        tap2.0
                                                        bond0.422
xenbrv425               8000.0017a4770470       no              bond0.425
xenbrv450               8000.0017a4770470       no              bond0.450
xenbrv492               8000.0017a4770470       no              bond0.492
xenbrv493               8000.0017a4770470       no              bond0.493
xenbrv494               8000.0017a4770470       no              bond0.494
xenbrv495               8000.0017a4770470       no              bond0.495
xenbrv496               8000.0017a4770470       no              bond0.496
xenbrv497               8000.0017a4770470       no              bond0.497
xenbrv701               8000.0017a477046c       no              vif44.1
                                                        bond1.701

bond0.497 Link encap:Ethernet  HWaddr 00:17:A4:77:04:70
          inet addr:10.12.166.231  Bcast:10.12.166.255  Mask:255.255.255.224
          UP BROADCAST RUNNING MASTER MULTICAST  MTU:1500  Metric:1
          RX packets:3807595 errors:0 dropped:0 overruns:0 frame:0
          TX packets:3304 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:188847200 (180.0 MiB)  TX bytes:138768 (135.5 KiB)
[root@vmclkxstgh04 ~]# tcpdump -i xenbrv497

Thanks,
Benno Joy

--0016363b88ae2864640484c8aa5f
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: base64

PHA+RGVhcqBUZWFtLDwvcD4KPHA+SSBoYXZlIGEgc3RyYW5nZSBwcm9ibGVtLi4uLi4uIFRoaXMg
aXMgbXkgcHJvYmxlbSBpIGhhdmUgYSBsaW51eCBib3ggcnVubmluZyBYZW4ga2VybmVsICgyLjIp
LiBhbmQgaSBoYXZlIHRoZSBhIGJvbmRpbmcgaW50ZXJmYWNlIGNhbGxlZCBib25kMC40OTcoZXRo
MCBhbmQgZXRoMSBhbmQgYWxzbyBkZXMgVmxhbiB0YWdnaW5nKS48YnI+dGhlIGJvbmQwLjQ5NyBp
cyBwYXJ0IG9mIHRoZSBicmlkZ2UgJnF1b3Q7eGVuYnJ2NDk3JnF1b3Q7LCB0aGUgaXNzdWUgaXMg
YXMgc29vbiBhcyBpIG1ha2UgdGhlIGJvbmQgYSBwYXJ0IG9mIHRoZSBicmlkZ2UgbXkgbmV0d29y
ayB0cmFmZmljIHN0b3BzIHRvIHdvcmsuPGJyPgpJIGRpZCBzb21lIHByZWxpbWFuYXJ5IHRlc3Rz
IGFuZCBmb3VuZCB0aGUgZm9sbG93aW5nOjxicj4xKSBpZiBpIGFzc2lnaG4gYW4gaXAgdG8gdGhl
IGJvbmQgYW5kIGRvIGEgcGluZyB0byB0aGUgZ2F0ZXdheSBpdCB3b3JrcyAocHJvdmlkZWQgaXQg
aXMgbm90IHBhcnQgb2YgYnJpZGdlIHhlbmJydjQ5Nyk8YnI+MikgaWYgaSBhZGQgdGhlIGJvbmRp
ZyBpbnRlcmZhY2UgdG8gdGhlIGJyb2RnZSB4ZW5icnY0OTcgKGJyY2x0IGFkZGlmIHhlbmJydjQ5
NyBib25kMC40OTcpIHRoZSBwaW5nIHRlc3RzIGZhaWxzLjxicj4KMykgaSBkaWQgYSB0Y3BkdW1w
IGFuZCBmb3VuZCB0aGF0IGFycCByZXF1ZXN0cyBhcmUgZ29pbmcgb3V0IG9mIHRoZSBpbnRlcmZh
Y2UgYW5kIHdlIGFyZSBnZXR0aW5nIHJlc3BvbnNlIGFsc28uIGJ1dCBzb2VtaG93PGJyPnRoZSBh
cnAgZW50cmllcyBhcmUgbm90IGdldHRpZ24gcmVnaXN0ZXJlZC4gaSBkaWQgc29tZSBnb29nbGlu
ZyBhbmQgZm91bmQgaXQgbWF5IGJlIGJlY2F1c2Ugb2YgZmlsdGVyaW5nIHNvIGkgZGlzYWJsZWQg
aXQgYnk8YnI+CmVjaG8gMCAmZ3Q7IGluIC9wcm9jL3N5cy9uZXQvYnJpZGdlL2JyaWRnZS1uZi0q
Ljxicj5CdXQgZXZlbiB0aGlzIGRpZCBub3QgaGVscCBzdGlsbCB0aGUgYXJwIGVudHJpZXMgYXJl
IG5vdCBnZXR0aW5nIHJlZ2lzdGVyZWQgZHVlIHRvIHdoaWNoIG15IG5ldHdvcmsgdHJhZmZpYyBp
cyBnZXR0aWduIGRyb3BwZWQuPGJyPlRoaXMgcHJvYmxlbSBjYW4gYmUgcmVzb2x2ZWQgYnkgYSBy
ZWJvb3QuIGJ1dCBpIHdvdWxkIGxpa2UgdG8gdHJvdWJsZXNob290IGl0LiA8YnI+CkNvdWxkIHlv
dSBwbGVhc2UgbGV0IG1lIGtub3cgaG93IGkgY2FuIGdldCBtb3JlIGRlYnVnZ2luZyBtZXNzYWdl
IGZyb20gdGhlIGJyaWRnZSBjYWxscyBzbyBpIGNhbiBmaWd1cmUgb3V0IHdoYXQgZXhhY3RseSBp
cyBoYXBwZW5pbmcuPC9wPgo8cD4jIHVuYW1lIC1hPGJyPkxpbnV4IDxhIGhyZWY9Imh0dHA6Ly92
bWNsa3hzdGdoMDQuZXNwZGV2LmF1cmRldi5uYXRpb25hbC5jb20uYXUiPnZtY2xreHN0Z2gwNC5l
c3BkZXYuYXVyZGV2Lm5hdGlvbmFsLmNvbS5hdTwvYT4gMi42LjE4LTEyOC4yLjEuNC4xMy5lbDV4
ZW4gIzEgU01QIE1vbiBEZWMgNyAxNDozNDo0MCBFU1QgMjAwOSBpNjg2IGk2ODYgaTM4NiBHTlUv
TGludXg8L3A+Cgo8cD5bcm9vdEB2bWNsa3hzdGdoMDQgfl0jIGJyY3RsIHNob3c8YnI+YnJpZGdl
IG5hbWWgoKCgIGJyaWRnZSBpZKCgoKCgoKCgoKCgoKCgIFNUUCBlbmFibGVkoKCgoCBpbnRlcmZh
Y2VzPGJyPnZsYW40NDGgoKCgoKCgoCA4MDAwLjAwMTdhNDc3MDQ3MKCgoKCgoCBub6CgoKCgoKCg
oKCgoKAgYm9uZDAuNDQxPGJyPnhlbmJydjIwNaCgoKCgoKCgoKCgoKCgIDgwMDAuMDAxN2E0Nzcw
NDZjoKCgoKCgIG5voKCgoKCgoKCgoKCgoCBib25kMS4yMDU8YnI+CnhlbmJydjIwOKCgoKCgoKCg
oKCgoKCgIDgwMDAuMDAxN2E0NzcwNDZjoKCgoKCgIG5voKCgoKCgoKCgoKCgoCBib25kMS4yMDg8
YnI+eGVuYnJ2MjIwoKCgoKCgoKCgoKCgoKAgODAwMC4wMDAwMDAwMDAwMDCgoKCgoKAgbm88YnI+
eGVuYnJ2MjIxoKCgoKCgoKCgoKCgoKAgODAwMC4wMDAwMDAwMDAwMDCgoKCgoKAgbm88YnI+eGVu
YnJ2MjI2oKCgoKCgoKCgoKCgoKAgODAwMC4wMDE3YTQ3NzA0NmOgoKCgoKAgbm+goKCgoKCgoKCg
oKCgIHZpZjQwLjE8YnI+CqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKAgdmlmMzkuMTxicj6goKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgIHZpZjM3LjE8YnI+oKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoCB2aWYyNi4xPGJyPqCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAgdmlmMjUuMTxicj4K
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoCB2
aWYyNC4xPGJyPqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKAgdmlmMTMuMTxicj6goKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgIGJvbmQxLjIyNjxicj54ZW5icnYyMjegoKCgoKCgoKCgoKCgoCA4
MDAwLjAwMTdhNDc3MDQ3MKCgoKCgoCBub6CgoKCgoKCgoKCgoKAgdmlmNDAuMDxicj4KoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoCB2aWYzOS4w
PGJyPqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKAgdmlmMzcuMDxicj6goKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgIHZpZjI2LjA8YnI+oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoCB2aWYyNS4wPGJyPgqgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgIHZpZjI0LjA8YnI+oKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoCB2aWYxMy4wPGJyPqCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAgYm9u
ZDAuMjI3PGJyPnhlbmJydjQyMKCgoKCgoKCgoKCgoKCgIDgwMDAuMDAxN2E0NzcwNDcwoKCgoKCg
IG5voKCgoKCgoKCgoKCgoCBib25kMC40MjA8YnI+CnhlbmJydjQyMqCgoKCgoKCgoKCgoKCgIDgw
MDAuMDAxN2E0NzcwNDcwoKCgoKCgIG5voKCgoKCgoKCgoKCgoCB2aWYzNS4wPGJyPqCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAgdmlmNy4wPGJy
PqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAg
dmlmNi4wPGJyPqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKAgdmlmNC4wPGJyPgqgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgIHZpZjMuMDxicj6goKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgIHZpZjIuMDxicj6goKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgIHRhcDIuMDxicj6goKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgIGJvbmQwLjQyMjxi
cj4KeGVuYnJ2NDI1oKCgoKCgoKCgoKCgoKAgODAwMC4wMDE3YTQ3NzA0NzCgoKCgoKAgbm+goKCg
oKCgoKCgoKCgIGJvbmQwLjQyNTxicj54ZW5icnY0NTCgoKCgoKCgoKCgoKCgoCA4MDAwLjAwMTdh
NDc3MDQ3MKCgoKCgoCBub6CgoKCgoKCgoKCgoKAgYm9uZDAuNDUwPGJyPnhlbmJydjQ5MqCgoKCg
oKCgoKCgoKCgIDgwMDAuMDAxN2E0NzcwNDcwoKCgoKCgIG5voKCgoKCgoKCgoKCgoCBib25kMC40
OTI8YnI+CnhlbmJydjQ5M6CgoKCgoKCgoKCgoKCgIDgwMDAuMDAxN2E0NzcwNDcwoKCgoKCgIG5v
oKCgoKCgoKCgoKCgoCBib25kMC40OTM8YnI+eGVuYnJ2NDk0oKCgoKCgoKCgoKCgoKAgODAwMC4w
MDE3YTQ3NzA0NzCgoKCgoKAgbm+goKCgoKCgoKCgoKCgIGJvbmQwLjQ5NDxicj54ZW5icnY0OTWg
oKCgoKCgoKCgoKCgoCA4MDAwLjAwMTdhNDc3MDQ3MKCgoKCgoCBub6CgoKCgoKCgoKCgoKAgYm9u
ZDAuNDk1PGJyPgp4ZW5icnY0OTagoKCgoKCgoKCgoKCgoCA4MDAwLjAwMTdhNDc3MDQ3MKCgoKCg
oCBub6CgoKCgoKCgoKCgoKAgYm9uZDAuNDk2PGJyPnhlbmJydjQ5N6CgoKCgoKCgoKCgoKCgIDgw
MDAuMDAxN2E0NzcwNDcwoKCgoKCgIG5voKCgoKCgoKCgoKCgoCBib25kMC40OTc8YnI+eGVuYnJ2
NzAxoKCgoKCgoKCgoKCgoKAgODAwMC4wMDE3YTQ3NzA0NmOgoKCgoKAgbm+goKCgoKCgoKCgoKCg
IHZpZjQ0LjE8YnI+CqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKAgYm9uZDEuNzAxPC9wPgo8cD5ib25kMC40OTcgTGluayBlbmNhcDpFdGhlcm5l
dKAgSFdhZGRyIDAwOjE3OkE0Ojc3OjA0OjcwPGJyPqCgoKCgoKCgoCBpbmV0IGFkZHI6MTAuMTIu
MTY2LjIzMaAgQmNhc3Q6MTAuMTIuMTY2LjI1NaAgTWFzazoyNTUuMjU1LjI1NS4yMjQ8YnI+oKCg
oKCgoKCgIFVQIEJST0FEQ0FTVCBSVU5OSU5HIE1BU1RFUiBNVUxUSUNBU1SgIE1UVToxNTAwoCBN
ZXRyaWM6MTxicj6goKCgoKCgoKAgUlggcGFja2V0czozODA3NTk1IGVycm9yczowIGRyb3BwZWQ6
MCBvdmVycnVuczowIGZyYW1lOjA8YnI+CqCgoKCgoKCgoCBUWCBwYWNrZXRzOjMzMDQgZXJyb3Jz
OjAgZHJvcHBlZDowIG92ZXJydW5zOjAgY2FycmllcjowPGJyPqCgoKCgoKCgoCBjb2xsaXNpb25z
OjAgdHhxdWV1ZWxlbjowPGJyPqCgoKCgoKCgoCBSWCBieXRlczoxODg4NDcyMDAgKDE4MC4wIE1p
QimgIFRYIGJ5dGVzOjEzODc2OCAoMTM1LjUgS2lCKTwvcD4KPGRpdj5bcm9vdEB2bWNsa3hzdGdo
MDQgfl0jIHRjcGR1bXAgLWkgeGVuYnJ2NDk3PGJyPjwvZGl2Pgo8ZGl2PqA8L2Rpdj4KPGRpdj5U
aGFua3MsPC9kaXY+CjxkaXY+QmVubm8gSm95PC9kaXY+CjxkaXY+oDwvZGl2Pgo=
--0016363b88ae2864640484c8aa5f--
