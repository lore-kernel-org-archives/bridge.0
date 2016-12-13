Return-Path: <ping2balaji@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:from:date:message-id:subject:to;
	bh=BcZAwohUKUBa/4dfx8w2FQ/cY5f2a4U78viK2L2q4iE=;
	b=e9Tb3cqUHpPGlrj8ti3YKogY9zk3wzSBiDU7ihFX6puoNu8gRZu273Qf53ltvMsGiI
	d/y6CtNzsb/Poqr16wOxEf26Kc26XLQthQK5ai0mNCg6jzfZbb+VXi4N07SAgmnUoqkq
	1XZIs4Vs4yV/uxETGapn4SO8WmGbMimIBaYGUg35uuv9tXwjtiLcHy8Ig8HVrB3uTBIU
	BI6zTtrKQhIM7MNbYm3A/6lIl1ya6D9YU07B1gU3LPDyudIBFFPCxKwun7lTVYhqFZyX
	1JLO8ZocUyZ2u1m2W6RVNgRo7Im5b+HPSljAP62LXfNJjhbAokpeMdODhB8kWE4XBAw1
	yT6A==
MIME-Version: 1.0
From: Balaji J <ping2balaji@gmail.com>
Date: Tue, 13 Dec 2016 21:13:43 +0530
Message-ID: <CAAtMjxaGCpd_3axCbinnpDpgR+H3DPn9y+cLabodGiytwckc7A@mail.gmail.com>
Content-Type: multipart/alternative; boundary=001a1141b25cca2f1a05438c151d
Subject: [Bridge] Bridge interface not forwarding DHCP-Broadcast
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

--001a1141b25cca2f1a05438c151d
Content-Type: text/plain; charset=UTF-8

Hi all,

I am trying to setup a bridge with 2 interfaces attached to it in Router-1.
Interface-1: eth1 ==> EoGRE Tunnel interface(gretap) connecting to another
Router-2 where DHCP server is running.
Interface-2: eth2 ==> Trying to use DHCP to assign IP for this eth2
interface from DHCP-Server running on Router-2.

Basically the setup i am expecting is like:
(eth2)[Router-1](eth1:100.1.1.1) <----------EoGRE
Tunnel----->(eth0:100.1.1.254)[Router-2](DHCP-Server)

Following are the setup i did to check the 1st stage to see if the
dhcp-discover broadcast is going out of Router-1 over EoGRE tunnel or not.
But i am not able to achieve the same.

Can anyone please let me know what is missing here? Thanks in advance.

Router-1:
1) ip link add eogre type gretap local 100.1.1.1 remote 100.1.1.254 ==>
created gretap with endpoints.
2) ip link set eogre up ==> brought the eogre interface up.
[root@centos]# ifconfig
eogre     Link encap:Ethernet  HWaddr 9E:25:FC:54:7F:F2
          inet6 addr: fe80::9c25:fcff:fe54:7ff2/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1462  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:6 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:0 (0.0 b)  TX bytes:492 (492.0 b)

eth1      Link encap:Ethernet  HWaddr 08:00:27:3C:FB:14
          inet addr:100.1.1.1  Bcast:0.0.0.0  Mask:255.255.255.0
          inet6 addr: fe80::a00:27ff:fe3c:fb14/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:13 errors:0 dropped:0 overruns:0 frame:0
          TX packets:40 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:1398 (1.3 KiB)  TX bytes:4103 (4.0 KiB)

eth2      Link encap:Ethernet  HWaddr 08:00:27:5E:7F:83
          BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
3) brctl addbr br0  ==> created bridge interface
4) brctl addif br0 eogre ==> attach eogre interface to bridge
5) brctl addif br0 eth2 ==> attach eth2 interface to bridge
6) sysctl -w net.ipv6.conf.eth2.disable_ipv6=1 ==> disable ipv6 in eth2
just to avoid unwanted ipv6 signalling messages from it.
7) ifconfig eth2 up ==> eth2 iface up with no IP in it yet.
8) ifconfig eogre up ==> eogre iface up
9) ifconfig br0 up ==> Bridge up.
10) brctl show ==>
bridge name     bridge id               STP enabled     interfaces
br0             8000.0800275e7f83       no              eogre

  eth2

11) brctl showstp br0

[root@centos-dev ~]# brctl showstp br0
br0
 bridge id              8000.0800275e7f83
 designated root        8000.0800275e7f83
 root port                 0                    path cost                  0
 max age                  19.99                 bridge max age
 19.99
 hello time                1.99                 bridge hello time
 1.99
 forward delay            14.99                 bridge forward delay
 14.99
 ageing time             299.95
 hello timer               0.50                 tcn timer
 0.00
 topology change timer     0.00                 gc timer
1.50
 hash elasticity           4                    hash max                 512
 mc last member count      2                    mc init query count        2
 mc router                 1                    mc snooping                1
 mc last member timer      0.99                 mc membership timer
 259.96
 mc querier timer        254.96                 mc query interval
 124.98
 mc response interval      9.99                 mc init query interval
 31.24
 flags


eogre (0)
 port id                0000                    state
 forwarding
 designated root        8000.0800275e7f83       path cost                100
 designated bridge      8000.0800275e7f83       message age timer
 0.00
 designated port        8001                    forward delay timer
 0.00
 designated cost           0                    hold timer
0.00
 mc router                 1
 flags

eth2 (0)
 port id                0000                    state
 forwarding
 designated root        8000.0800275e7f83       path cost                  4
 designated bridge      8000.0800275e7f83       message age timer
 0.00
 designated port        8002                    forward delay timer
 0.00
 designated cost           0                    hold timer
0.00
 mc router                 1
 flags

12) dhclient -i eth2 ==> This command triggers a DHCP-DISCOVER
broadcast(both l2/l3 broadcast destination addressed) from eth2 and
initiate ip allocation process.

Now if i capture packets in wireshark in eth1+br0+eogre interface of
Router-1, i don't see the dhcp-discover packet sent from eth2 interface
going over EoGRE Tunnel to Router-2.
But the same DHCP-Discover packet i can see if i capture in eth2
interface(obvious reason).

Is it not like whatever packets coming in or originating from eth2 will be
bridged to eogre interface using bridge "br0"?
I am using kernel 2.6 in CentOS

Can someone please help here?

Regards,
...Balaji

--001a1141b25cca2f1a05438c151d
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+SGkgYWxsLDxkaXY+PGJyPjwvZGl2PjxkaXY+SSBhbSB0cnlpbmcgdG8g
c2V0dXAgYSBicmlkZ2Ugd2l0aCAyIGludGVyZmFjZXMgYXR0YWNoZWQgdG8gaXQgaW4gUm91dGVy
LTEuPC9kaXY+PGRpdj5JbnRlcmZhY2UtMTogZXRoMSA9PSZndDsgRW9HUkUgVHVubmVsIGludGVy
ZmFjZShncmV0YXApIGNvbm5lY3RpbmcgdG8gYW5vdGhlciBSb3V0ZXItMiB3aGVyZSBESENQIHNl
cnZlciBpcyBydW5uaW5nLjwvZGl2PjxkaXY+SW50ZXJmYWNlLTI6IGV0aDIgPT0mZ3Q7IFRyeWlu
ZyB0byB1c2UgREhDUCB0byBhc3NpZ24gSVAgZm9yIHRoaXMgZXRoMiBpbnRlcmZhY2UgZnJvbSBE
SENQLVNlcnZlciBydW5uaW5nIG9uIFJvdXRlci0yLjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+
QmFzaWNhbGx5IHRoZSBzZXR1cCBpIGFtIGV4cGVjdGluZyBpcyBsaWtlOjwvZGl2PjxkaXY+KGV0
aDIpW1JvdXRlci0xXShldGgxOjEwMC4xLjEuMSkgJmx0Oy0tLS0tLS0tLS1Fb0dSRSBUdW5uZWwt
LS0tLSZndDsoZXRoMDoxMDAuMS4xLjI1NClbUm91dGVyLTJdKERIQ1AtU2VydmVyKTxicj48L2Rp
dj48ZGl2Pjxicj48L2Rpdj48ZGl2PkZvbGxvd2luZyBhcmUgdGhlIHNldHVwIGkgZGlkIHRvIGNo
ZWNrIHRoZSAxc3Qgc3RhZ2UgdG8gc2VlIGlmIHRoZSBkaGNwLWRpc2NvdmVyIGJyb2FkY2FzdCBp
cyBnb2luZyBvdXQgb2YgUm91dGVyLTEgb3ZlciBFb0dSRSB0dW5uZWwgb3Igbm90LiBCdXQgaSBh
bSBub3QgYWJsZSB0byBhY2hpZXZlIHRoZSBzYW1lLjxicj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48
ZGl2PkNhbiBhbnlvbmUgcGxlYXNlIGxldCBtZSBrbm93IHdoYXQgaXMgbWlzc2luZyBoZXJlPyBU
aGFua3MgaW4gYWR2YW5jZS48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PlJvdXRlci0xOjwvZGl2
PjxkaXY+MSkgaXAgbGluayBhZGQgZW9ncmUgdHlwZSBncmV0YXAgbG9jYWwgMTAwLjEuMS4xIHJl
bW90ZSAxMDAuMS4xLjI1NCA9PSZndDsgY3JlYXRlZCBncmV0YXAgd2l0aCBlbmRwb2ludHMuPGJy
PjwvZGl2PjxkaXY+MikgaXAgbGluayBzZXQgZW9ncmUgdXAgPT0mZ3Q7IGJyb3VnaHQgdGhlIGVv
Z3JlIGludGVyZmFjZSB1cC48YnI+PC9kaXY+PGRpdj5bcm9vdEBjZW50b3NdIyBpZmNvbmZpZ8Kg
PC9kaXY+PGRpdj48ZGl2PmVvZ3JlIMKgIMKgIExpbmsgZW5jYXA6RXRoZXJuZXQgwqBIV2FkZHIg
OUU6MjU6RkM6NTQ6N0Y6RjIgwqA8L2Rpdj48ZGl2PsKgIMKgIMKgIMKgIMKgIGluZXQ2IGFkZHI6
IGZlODA6OjljMjU6ZmNmZjpmZTU0OjdmZjIvNjQgU2NvcGU6TGluazwvZGl2PjxkaXY+wqAgwqAg
wqAgwqAgwqAgVVAgQlJPQURDQVNUIFJVTk5JTkcgTVVMVElDQVNUIMKgTVRVOjE0NjIgwqBNZXRy
aWM6McKgPC9kaXY+PGRpdj7CoCDCoCDCoCDCoCDCoCBSWCBwYWNrZXRzOjAgZXJyb3JzOjAgZHJv
cHBlZDowIG92ZXJydW5zOjAgZnJhbWU6MMKgPC9kaXY+PGRpdj7CoCDCoCDCoCDCoCDCoCBUWCBw
YWNrZXRzOjYgZXJyb3JzOjAgZHJvcHBlZDowIG92ZXJydW5zOjAgY2FycmllcjowPC9kaXY+PGRp
dj7CoCDCoCDCoCDCoCDCoCBjb2xsaXNpb25zOjAgdHhxdWV1ZWxlbjoxMDAwIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPC9kaXY+PGRpdj7CoCDCoCDCoCDCoCDCoCBSWCBieXRl
czowICgwLjAgYikgwqBUWCBieXRlczo0OTIgKDQ5Mi4wIGIpIMKgIMKgIMKgIMKgIMKgPC9kaXY+
PGRpdj48YnI+PC9kaXY+PGRpdj5ldGgxIMKgIMKgIMKgTGluayBlbmNhcDpFdGhlcm5ldCDCoEhX
YWRkciAwODowMDoyNzozQzpGQjoxNCDCoDwvZGl2PjxkaXY+wqAgwqAgwqAgwqAgwqAgaW5ldCBh
ZGRyOjEwMC4xLjEuMSDCoEJjYXN0OjAuMC4wLjAgwqBNYXNrOjI1NS4yNTUuMjU1LjA8L2Rpdj48
ZGl2PsKgIMKgIMKgIMKgIMKgIGluZXQ2IGFkZHI6IGZlODA6OmEwMDoyN2ZmOmZlM2M6ZmIxNC82
NCBTY29wZTpMaW5rIMKgIMKgPC9kaXY+PGRpdj7CoCDCoCDCoCDCoCDCoCBVUCBCUk9BRENBU1Qg
UlVOTklORyBNVUxUSUNBU1QgwqBNVFU6MTUwMCDCoE1ldHJpYzoxIMKgIMKgPC9kaXY+PGRpdj7C
oCDCoCDCoCDCoCDCoCBSWCBwYWNrZXRzOjEzIGVycm9yczowIGRyb3BwZWQ6MCBvdmVycnVuczow
IGZyYW1lOjAgwqDCoDwvZGl2PjxkaXY+wqAgwqAgwqAgwqAgwqAgVFggcGFja2V0czo0MCBlcnJv
cnM6MCBkcm9wcGVkOjAgb3ZlcnJ1bnM6MCBjYXJyaWVyOjDCoDwvZGl2PjxkaXY+wqAgwqAgwqAg
wqAgwqAgY29sbGlzaW9uczowIHR4cXVldWVsZW46MTAwMCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoDwvZGl2PjxkaXY+wqAgwqAgwqAgwqAgwqAgUlggYnl0ZXM6MTM5OCAo
MS4zIEtpQikgwqBUWCBieXRlczo0MTAzICg0LjAgS2lCKSDCoCDCoCDCoDwvZGl2PjxkaXY+PGJy
PjwvZGl2PjxkaXY+ZXRoMiDCoCDCoCDCoExpbmsgZW5jYXA6RXRoZXJuZXQgwqBIV2FkZHIgMDg6
MDA6Mjc6NUU6N0Y6ODMgwqA8L2Rpdj48ZGl2PsKgIMKgIMKgIMKgIMKgIEJST0FEQ0FTVCBNVUxU
SUNBU1QgwqBNVFU6MTUwMCDCoE1ldHJpYzoxIMKgIMKgIMKgIMKgPC9kaXY+PGRpdj7CoCDCoCDC
oCDCoCDCoCBSWCBwYWNrZXRzOjAgZXJyb3JzOjAgZHJvcHBlZDowIG92ZXJydW5zOjAgZnJhbWU6
MDwvZGl2PjxkaXY+wqAgwqAgwqAgwqAgwqAgVFggcGFja2V0czowIGVycm9yczowIGRyb3BwZWQ6
MCBvdmVycnVuczowIGNhcnJpZXI6MDwvZGl2PjxkaXY+wqAgwqAgwqAgwqAgwqAgY29sbGlzaW9u
czowIHR4cXVldWVsZW46MTAwMCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDwv
ZGl2PjxkaXY+wqAgwqAgwqAgwqAgwqAgUlggYnl0ZXM6MCAoMC4wIGIpIMKgVFggYnl0ZXM6MCAo
MC4wIGIpIMKgIMKgIMKgIMKgIMKgIMKgIMKgPC9kaXY+PC9kaXY+PGRpdj48ZGl2PjMpIGJyY3Rs
IGFkZGJyIGJyMCDCoD09Jmd0OyBjcmVhdGVkIGJyaWRnZSBpbnRlcmZhY2U8YnI+PC9kaXY+PGRp
dj40KSBicmN0bCBhZGRpZiBicjAgZW9ncmUgPT0mZ3Q7IGF0dGFjaCBlb2dyZSBpbnRlcmZhY2Ug
dG8gYnJpZGdlPGJyPjwvZGl2PjxkaXY+NSkgYnJjdGwgYWRkaWYgYnIwIGV0aDIgPT0mZ3Q7IGF0
dGFjaCBldGgyIGludGVyZmFjZcKgdG8gYnJpZGdlPC9kaXY+PGRpdj42KSBzeXNjdGwgLXcgbmV0
LmlwdjYuY29uZi5ldGgyLmRpc2FibGVfaXB2Nj0xID09Jmd0OyBkaXNhYmxlIGlwdjYgaW4gZXRo
MiBqdXN0IHRvIGF2b2lkIHVud2FudGVkIGlwdjYgc2lnbmFsbGluZyBtZXNzYWdlcyBmcm9tIGl0
Ljxicj48L2Rpdj48ZGl2PjcpIGlmY29uZmlnIGV0aDIgdXAgPT0mZ3Q7IGV0aDIgaWZhY2UgdXAg
d2l0aCBubyBJUCBpbiBpdCB5ZXQuPGJyPjwvZGl2PjxkaXY+OCkgaWZjb25maWcgZW9ncmUgdXAg
PT0mZ3Q7IGVvZ3JlIGlmYWNlIHVwwqA8L2Rpdj48ZGl2PjkpIGlmY29uZmlnIGJyMCB1cCA9PSZn
dDsgQnJpZGdlIHVwLjwvZGl2PjxkaXY+MTApIGJyY3RsIHNob3cgPT0mZ3Q7PGJyPjwvZGl2Pjxk
aXY+PGRpdj5icmlkZ2UgbmFtZSDCoCDCoCBicmlkZ2UgaWQgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
U1RQIGVuYWJsZWQgwqAgwqAgaW50ZXJmYWNlczwvZGl2PjxkaXY+YnIwIMKgIMKgIMKgIMKgIMKg
IMKgIDgwMDAuMDgwMDI3NWU3ZjgzIMKgIMKgIMKgIG5vIMKgIMKgIMKgIMKgIMKgIMKgIMKgZW9n
cmU8L2Rpdj48ZGl2PsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIGV0aDI8YnI+PC9kaXY+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj4x
MSkgYnJjdGwgc2hvd3N0cCBicjA8L2Rpdj48ZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+W3Jvb3RA
Y2VudG9zLWRldiB+XSMgYnJjdGwgc2hvd3N0cCBicjA8L2Rpdj48ZGl2PmJyMCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoMKgPC9kaXY+PGRpdj7CoGJy
aWRnZSBpZCDCoCDCoCDCoCDCoCDCoCDCoCDCoDgwMDAuMDgwMDI3NWU3ZjgzPC9kaXY+PGRpdj7C
oGRlc2lnbmF0ZWQgcm9vdCDCoCDCoCDCoCDCoDgwMDAuMDgwMDI3NWU3ZjgzPC9kaXY+PGRpdj7C
oHJvb3QgcG9ydCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAwIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgcGF0aCBjb3N0IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgMDwvZGl2PjxkaXY+
wqBtYXggYWdlIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgMTkuOTkgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgYnJpZGdlIG1heCBhZ2UgwqAgwqAgwqAgwqAgwqAgwqAxOS45OTwvZGl2PjxkaXY+
wqBoZWxsbyB0aW1lIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgMS45OSDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCBicmlkZ2UgaGVsbG8gdGltZSDCoCDCoCDCoCDCoCDCoDEuOTk8L2Rpdj48ZGl2PsKg
Zm9yd2FyZCBkZWxheSDCoCDCoCDCoCDCoCDCoCDCoDE0Ljk5IMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIGJyaWRnZSBmb3J3YXJkIGRlbGF5IMKgIMKgIMKgMTQuOTk8L2Rpdj48ZGl2PsKgYWdlaW5n
IHRpbWUgwqAgwqAgwqAgwqAgwqAgwqAgMjk5Ljk1PC9kaXY+PGRpdj7CoGhlbGxvIHRpbWVyIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIDAuNTAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgdGNuIHRpbWVy
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgMC4wMDwvZGl2PjxkaXY+wqB0b3BvbG9neSBjaGFu
Z2UgdGltZXIgwqAgwqAgMC4wMCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBnYyB0aW1lciDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAxLjUwPC9kaXY+PGRpdj7CoGhhc2ggZWxhc3RpY2l0eSDC
oCDCoCDCoCDCoCDCoCA0IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaGFzaCBtYXggwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgNTEyPC9kaXY+PGRpdj7CoG1jIGxhc3QgbWVtYmVyIGNvdW50
IMKgIMKgIMKgMiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoG1jIGluaXQgcXVlcnkgY291
bnQgwqAgwqAgwqAgwqAyPC9kaXY+PGRpdj7CoG1jIHJvdXRlciDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCAxIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgbWMgc25vb3BpbmcgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAxPC9kaXY+PGRpdj7CoG1jIGxhc3QgbWVtYmVyIHRpbWVyIMKgIMKgIMKg
MC45OSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBtYyBtZW1iZXJzaGlwIHRpbWVyIMKgIMKgIMKg
MjU5Ljk2PC9kaXY+PGRpdj7CoG1jIHF1ZXJpZXIgdGltZXIgwqAgwqAgwqAgwqAyNTQuOTYgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgbWMgcXVlcnkgaW50ZXJ2YWwgwqAgwqAgwqAgwqAxMjQuOTg8
L2Rpdj48ZGl2PsKgbWMgcmVzcG9uc2UgaW50ZXJ2YWwgwqAgwqAgwqA5Ljk5IMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIG1jIGluaXQgcXVlcnkgaW50ZXJ2YWwgwqAgwqAzMS4yNDwvZGl2PjxkaXY+
wqBmbGFnczwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+ZW9ncmUgKDAp
PC9kaXY+PGRpdj7CoHBvcnQgaWQgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAwMDAwIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgc3RhdGUgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBmb3J3YXJk
aW5nPC9kaXY+PGRpdj7CoGRlc2lnbmF0ZWQgcm9vdCDCoCDCoCDCoCDCoDgwMDAuMDgwMDI3NWU3
ZjgzIMKgIMKgIMKgIHBhdGggY29zdCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDEwMDwvZGl2Pjxk
aXY+wqBkZXNpZ25hdGVkIGJyaWRnZSDCoCDCoCDCoDgwMDAuMDgwMDI3NWU3ZjgzIMKgIMKgIMKg
IG1lc3NhZ2UgYWdlIHRpbWVyIMKgIMKgIMKgIMKgIMKgMC4wMDwvZGl2PjxkaXY+wqBkZXNpZ25h
dGVkIHBvcnQgwqAgwqAgwqAgwqA4MDAxIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZm9y
d2FyZCBkZWxheSB0aW1lciDCoCDCoCDCoCDCoDAuMDA8L2Rpdj48ZGl2PsKgZGVzaWduYXRlZCBj
b3N0IMKgIMKgIMKgIMKgIMKgIDAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBob2xkIHRp
bWVyIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDAuMDA8L2Rpdj48ZGl2PsKgbWMgcm91dGVyIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIDE8L2Rpdj48ZGl2PsKgZmxhZ3M8L2Rpdj48ZGl2Pjxicj48
L2Rpdj48ZGl2PmV0aDIgKDApPC9kaXY+PGRpdj7CoHBvcnQgaWQgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAwMDAwIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc3RhdGUgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBmb3J3YXJkaW5nPC9kaXY+PGRpdj7CoGRlc2lnbmF0ZWQgcm9vdCDCoCDCoCDC
oCDCoDgwMDAuMDgwMDI3NWU3ZjgzIMKgIMKgIMKgIHBhdGggY29zdCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoDQ8L2Rpdj48ZGl2PsKgZGVzaWduYXRlZCBicmlkZ2UgwqAgwqAgwqA4MDAwLjA4
MDAyNzVlN2Y4MyDCoCDCoCDCoCBtZXNzYWdlIGFnZSB0aW1lciDCoCDCoCDCoCDCoCDCoDAuMDA8
L2Rpdj48ZGl2PsKgZGVzaWduYXRlZCBwb3J0IMKgIMKgIMKgIMKgODAwMiDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoGZvcndhcmQgZGVsYXkgdGltZXIgwqAgwqAgwqAgwqAwLjAwPC9kaXY+
PGRpdj7CoGRlc2lnbmF0ZWQgY29zdCDCoCDCoCDCoCDCoCDCoCAwIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgaG9sZCB0aW1lciDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAwLjAwPC9kaXY+
PGRpdj7CoG1jIHJvdXRlciDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAxPC9kaXY+PGRpdj7CoGZs
YWdzPC9kaXY+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj4xMikgZGhjbGllbnQgLWkgZXRoMiA9
PSZndDsgVGhpcyBjb21tYW5kIHRyaWdnZXJzIGEgREhDUC1ESVNDT1ZFUiBicm9hZGNhc3QoYm90
aCBsMi9sMyBicm9hZGNhc3QgZGVzdGluYXRpb24gYWRkcmVzc2VkKSBmcm9tIGV0aDIgYW5kIGlu
aXRpYXRlIGlwIGFsbG9jYXRpb24gcHJvY2Vzcy48YnI+PC9kaXY+PGRpdj48YnI+PC9kaXY+PC9k
aXY+PGRpdj5Ob3cgaWYgaSBjYXB0dXJlIHBhY2tldHMgaW4gd2lyZXNoYXJrIGluIGV0aDErYnIw
K2VvZ3JlIGludGVyZmFjZSBvZiBSb3V0ZXItMSwgaSBkb24mIzM5O3Qgc2VlIHRoZSBkaGNwLWRp
c2NvdmVyIHBhY2tldCBzZW50IGZyb20gZXRoMiBpbnRlcmZhY2UgZ29pbmcgb3ZlciBFb0dSRSBU
dW5uZWwgdG8gUm91dGVyLTIuPC9kaXY+PGRpdj5CdXQgdGhlIHNhbWUgREhDUC1EaXNjb3ZlciBw
YWNrZXQgaSBjYW4gc2VlIGlmIGkgY2FwdHVyZSBpbiBldGgyIGludGVyZmFjZShvYnZpb3VzIHJl
YXNvbikuPGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+SXMgaXQgbm90IGxpa2Ugd2hhdGV2
ZXIgcGFja2V0cyBjb21pbmcgaW4gb3Igb3JpZ2luYXRpbmcgZnJvbSBldGgyIHdpbGwgYmUgYnJp
ZGdlZCB0byBlb2dyZSBpbnRlcmZhY2UgdXNpbmcgYnJpZGdlICZxdW90O2JyMCZxdW90Oz88L2Rp
dj48ZGl2PkkgYW0gdXNpbmcga2VybmVsIDIuNiBpbiBDZW50T1M8YnI+PC9kaXY+PGRpdj48YnI+
PC9kaXY+PGRpdj5DYW4gc29tZW9uZSBwbGVhc2UgaGVscCBoZXJlPzwvZGl2PjxkaXY+PGJyPjwv
ZGl2PjxkaXY+UmVnYXJkcyw8L2Rpdj48ZGl2Pi4uLkJhbGFqaTwvZGl2PjwvZGl2Pg0K
--001a1141b25cca2f1a05438c151d--
