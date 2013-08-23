Return-Path: <jpereiran@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:from:date:message-id:subject:to:content-type;
	bh=oDnUQE9q9mdKiegu7cjc3oKBbN4hdeuADXf/Ez5KOyw=;
	b=GI9PImIlTAsbjSjIo42987OHW72EKP4Jl5b7bE6w7NROHZsU8NzfO0NLMY5RtyGMxo
	SluFQ7beXzJ+8+fcAWGZCs0O6MnFk0UAUWJKW2OKsNJZOISOLK1aSvbyxTHnn2EjtlaW
	KVndP30ZonGhVwKZyc49sUZXVHdnDCmbXQ0vDJbGRVQxPzC3wCS+npWwrLZqUBcdjHcw
	4V0dkFseE8+nxsxaUeoKymoqVywjUPtAnXM5X3vS+X0JYLwxrO74E+5ORfBU+KNlzjIp
	sqNHDYuFM9+eJtOEOrmcxF7ldfC/pDOdq1vhGsH4r3c9YQIMqICsFeG5CxSFsGGjLl2t
	hIXA==
MIME-Version: 1.0
From: Jorge Pereira <jpereiran@gmail.com>
Date: Thu, 22 Aug 2013 23:21:14 -0300
Message-ID: <CABvP5W17XQ16mRsVhTFEUf9AbyGd+WQSV0hBozDy3rANUSKofw@mail.gmail.com>
Content-Type: multipart/alternative; boundary=001a11c309e8fda0cb04e4941118
Subject: [Bridge] challenge of year: connect to LAN using wireless-ap over
 bridge + unmanaged l2tpv3 tunnel + bridge? it's possible?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org, lartc@vger.kernel.org, Openl2tp-users@lists.sourceforge.net

--001a11c309e8fda0cb04e4941118
Content-Type: text/plain; charset=ISO-8859-1

hi everyone,

    so,first it seemed a trivial question to me, but since I could not find
anybody being neither able to answer
this question nor giving a short config example. after a few sleepless
nights and exhausting all the reading
and research. here I am sharing my problem with all of you, in the hope of
some possible solution/sugestion.
or is it that this is impossible??

below my scheme/layout.

+---------------------------------------------------------+
| MAIN SERVER - 10.60.61.1 (DHCP SERVER) |
+---------------------------------------------------------+
                     |
+---------------------------+
|    NETWORK vlan601 |
|  net 10.251.0.0/16      |
|  gw:10.251.0.1            |
+---------------------------+
                    |
+------------------------------------------------------------------+
 | SERVER B (BRIDGE / unmanaged L2TPv3) - BAHIA |
+------------------------------------------------------------------+

*root@bahia:~# * ip -d addr show eth0 *# WAN*
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state
UP qlen 1000
    link/ether 00:50:56:a7:13:49 brd ff:ff:ff:ff:ff:ff
    inet 200.243.1.5/24 brd 200.243.1.255 scope global eth0
    inet6 fe80::250:56ff:fea7:1349/64 scope link
       valid_lft forever preferred_lft forever
*root@bahia:~# * ip -d addr show eth1 *# LAN (VLAN/TRUNK)*
3: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state
UP qlen 1000
    link/ether 00:50:56:a7:13:4a brd ff:ff:ff:ff:ff:ff
    inet6 fe80::250:56ff:fea7:134a/64 scope link
       valid_lft forever preferred_lft forever
*root@bahia:~# * ip link add link eth1 name eth1.601 mtu 1500 type vlan id
601
*root@bahia:~# * ip link set dev eth1.601 up promisc on
*root@bahia:~# * ip -d addr show eth1.601
9: eth1.601@eth1: <BROADCAST,MULTICAST,PROMISC,UP,LOWER_UP> mtu 1500 qdisc
noqueue state UP
    link/ether 00:50:56:a7:13:4a brd ff:ff:ff:ff:ff:ff
    inet6 fe80::250:56ff:fea7:134a/64 scope link
       valid_lft forever preferred_lft forever
*root@bahia:~# ** *ip route show
default via 200.243.1.254 dev eth0
200.243.1.0/24 dev eth0  proto kernel  scope link  src 200.243.1.5
*root@bahia:~# *

and.... we've the interface l2tpeth0 (L2TPv3) established with other node
into the internet by eth0 (WAN), plugged
with vlan601 (eth1.601) by bridge called "br-red"

*root@bahia:~#* brctl show
bridge name bridge id STP enabled interfaces
*root@bahia:~#* brctl addbr br-red
*root@bahia:~#* brctl addif br-red eth1.601
*root@bahia:~#** *ip l2tp add tunnel tunnel_id 45 peer_tunnel_id 42
udp_sport 5001 udp_dport 5000 encap udp local 200.243.1.5 remote
200.199.10.12
*root@bahia:~#** *ip l2tp add session tunnel_id 45 session_id 5196755
peer_session_id 128
*root@bahia:~#* ip link set l2tpeth0 up promisc on master br-red

*root@bahia:~#* ip link set br-red up
*root@bahia:~#* brctl show br-red
bridge name bridge id STP enabled interfaces
br-red 8000.005056a7134a no eth1.601
l2tpeth0
*root@bahia:~# *brctl showstp br-red
br-red
 bridge id 8000.005056a7134a
 designated root 8000.005056a7134a
 root port         0 path cost   0
 max age         20.00 bridge max age  20.00
 hello time 2.00 bridge hello time   2.00
 forward delay 15.00 bridge forward delay  15.00
 ageing time 300.01
 hello timer 1.06 tcn timer   0.00
 topology change timer   0.00 gc timer   5.08
 flags

eth1.601 (1)
 port id 8001 state     forwarding
 designated root 8000.005056a7134a path cost   4
 designated bridge 8000.005056a7134a message age timer   0.00
 designated port 8001 forward delay timer   0.00
 designated cost   0 hold timer   0.06
 flags

l2tpeth0 (2)
 port id 8002 state     forwarding
 designated root 8000.005056a7134a path cost 100
 designated bridge 8000.005056a7134a message age timer   0.00
 designated port 8002 forward delay timer   0.00
 designated cost   0 hold timer   0.05
 flags

*root@bahia:~# *
*
*
it's ok, my bridge "by-red" listen all traffic over my LAN (vlan 601) and
my L2TPv3 over internet. (wan)*
*
*
*
*root@bahia:~# ** *tcpdump -nve -i *br-red* "host 10.251.0.1"
tcpdump: WARNING: br-red: no IPv4 address assigned
tcpdump: listening on br-red, link-type EN10MB (Ethernet), capture size
65535 bytes
20:58:17.860060 d4:ae:52:84:37:ae > ff:ff:ff:ff:ff:ff, ethertype ARP
(0x0806), length 60: Ethernet (len 6), IPv4 (len 4), Request who-has
10.251.90.157 tell *10.251.0.1*, length 46
20:58:17.980065 d4:ae:52:84:37:ae > ff:ff:ff:ff:ff:ff, ethertype ARP
(0x0806), length 60: Ethernet (len 6), IPv4 (len 4), Request who-has
10.251.153.31 tell *10.251.0.1*, length 46
^C
7 packets captured
7 packets received by filter
0 packets dropped by kernel
*root@bahia:~# *

+-----------------------------------------------------------------------------------------+
 | SERVER B (BRIDGE/L2TPv3 + WIRELESS ACCESS POINT) - RECIFE |
+-----------------------------------------------------------------------------------------+

*root@recife:~#* ip addr show eth1 *# (WAN)*
3: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP
qlen 1000
    link/ether a0:f3:c1:a3:c4:11 brd ff:ff:ff:ff:ff:ff
    inet 200.199.10.12/21 brd 200.199.10.255 scope global eth1
       valid_lft forever preferred_lft forever
    inet6 fe80::a2f3:c1ff:fea3:c411/64 scope link
       valid_lft forever preferred_lft forever
*root@recife:~#* ip route show
default via 200.199.10.254 dev eth1  proto static
200.199.10.0/21 dev eth1  proto kernel  scope link  src 200.199.10.12
192.168.1.0/24 dev br-lan  proto kernel  scope link  src 192.168.1.1
*root@recife:~#* ip l2tp add tunnel tunnel_id 42 peer_tunnel_id 45
udp_sport 5000 udp_dport 5001 encap udp local 200.199.10.12 remote
200.243.1.5
*root@recife:~#* ip l2tp add session tunnel_id 42 session_id 128
peer_session_id 5196755
*root@recife:~#* ip link set dev l2tpeth0 up promisc on master br-red
*root@recife:~#* brctl show
bridge name     bridge id               STP enabled     interfaces
br-lan          7fff.a0f3c1a3c40f       no              eth0
*root@recife:~#* brctl addbr br-red
*root@recife:~#* brctl addif br-red l2tpeth0
*root@recife:~#* brctl addif br-red wlan0
*root@recife:~#* ifconfig br-red up
*root@recife:~#* ip link set br-red up
*root@recife:~#* brctl show
bridge name     bridge id                     STP enabled     interfaces
br-lan                7fff.a0f3c1a3c40f       no                     eth0
br-red                8000.1ae0f4a30221  no                     l2tpeth0

         wlan0
*root@recife:~#*
*
*
*....::: RESUME :::...*

1) sorry for the long email....
2) when i'm "recife hostspot"... I can join in wireless "Recife Wireless"
from my device, but i can't receive ip from dhcp (10.60.61.1).
3) from "server A[bahia] (bridge with vlan601 network) and "server B
[recife]", i can "see/listen" the broadcast request from my
device mac "5c:95:ae:22:d6:6e" like below.

*root@bahia:~# *tcpdump -nve -i br-red "ether host ether 5c:95:ae:22:d6:6e"
00:08:52.653667 5c:95:ae:22:d6:6e > ff:ff:ff:ff:ff:ff, ethertype IPv4
(0x0800), length 342: (tos 0x0, ttl 255, id 37839, offset 0, flags [none],
proto UDP (17), length 328)
    0.0.0.0.68 > 255.255.255.255.67: BOOTP/DHCP, Request from
5c:95:ae:22:d6:6e, length 300, xid 0xe6f1d0a5, Flags [none]
          Client-Ethernet-Address 5c:95:ae:22:d6:6e
          Vendor-rfc1048 Extensions
            Magic Cookie 0x63825363
            DHCP-Message Option 53, length 1: Discover
            Parameter-Request Option 55, length 6:
              Subnet-Mask, Default-Gateway, Domain-Name-Server, Domain-Name
              Option 119, Option 252
            MSZ Option 57, length 2: 1500
            Client-ID Option 61, length 7: ether 5c:95:ae:22:d6:6e
            Lease-Time Option 51, length 4: 7776000
            Hostname Option 12, length 14: "Straces-iPhone"
^C
1 packets captured
1 packets received by filter
*root@bahia:~#*

same thing result at "bridge a" (*root@recife:~#) *side...

4) the strangest thing of all and that, from bridge-b (recife). i can get
ip from dhcp/broadcast request over L2TPv3...
but without option "broadcast" i can't receive ip from dhcp (10.61.60.1)

*root@recife:~#* udhcpc -B -i br-red
udhcpc (v1.19.4) started
Sending discover...
Sending select for 10.251.157.22...
Lease of 10.251.157.22 obtained, lease time 300
udhcpc: ifconfig br-red 10.251.157.22 netmask 255.255.0.0 broadcast +
udhcpc: setting default routers: 10.251.0.1
*root@recife:~# *ip route add 200.243.1.5 via 200.199.10.254 dev eth1
*root@recife:~# *ip route show
default via 10.251.0.1 dev br-red
10.251.0.0/16 dev br-red  proto kernel  scope link  src 10.251.157.22
200.199.10.0/21 dev eth1  proto kernel  scope link  src 200.199.10.12
200.243.1.5 via 200.199.10.254 dev eth1
192.168.1.0/24 dev br-lan  proto kernel  scope link  src 192.168.1.1
*root@recife:~#* ping -c2 10.251.0.1
PING 10.251.0.1 (10.251.0.1): 56 data bytes

--- 10.251.0.1 ping statistics ---
2 packets transmitted, 0 packets received, 100% packet loss
*root@recife:~#*

5) output of tcpdump listen the bridge "br-red" request from bridge-a-natal
http://pastebin.com/t8wn3zRK
6) output of tcpdump listen the bridge "br-red" request from
bridge-b-recife http://pastebin.com/njTQfd5k
7) after several researches i found the kernel options to set like
"arp_filter", "bridge-nf-*",... but i don't have
idea which option should enable / disable. tried some combinations but
without success....
8) the DHCP-OFFER doesn't forward by "bridge-a"...  problems with unicast?
multicast? arp_proxy? ....
9) we need join in the network by wireless and access the server 10.251.0.1
over bridge/l2tpv3 (unmanaged)
10) in our case, can use only L2TPv3. (may not be OpenVPN, ...)
11) all is Linux, without any iptables rules.
12) who will win a beer?! =]

Best regards,
Jorge Pereira

--001a11c309e8fda0cb04e4941118
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>hi everyone,</div><div><br></div><div>=A0 =A0 so,firs=
t it seemed a trivial question to me, but since I could not find anybody be=
ing neither able to answer</div><div>this question nor giving a short confi=
g example. after a few sleepless nights and exhausting all the reading</div=
>


<div>and research. here I am sharing my problem with all of you, in the hop=
e of some possible solution/sugestion.</div><div>or is it that this is impo=
ssible??</div><div><br></div><div>below my scheme/layout.</div><div><div>


<br>+---------------------------------------------------------+<br>| MAIN S=
ERVER - 10.60.61.1 (DHCP SERVER) |<br>+------------------------------------=
---------------------+<br>

=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|<br>+--------------------------=
-+</div><div>| =A0 =A0NETWORK vlan601 |<br>| =A0net <a href=3D"http://10.25=
1.0.0/16" target=3D"_blank">10.251.0.0/16</a> =A0 =A0 =A0|<div>| =A0gw:10.2=
51.0.1 =A0 =A0 =A0 =A0 =A0 =A0|<br>+---------------------------+<br>




=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |<div>+----------------------------=
--------------------------------------+</div><div>=A0| SERVER B (BRIDGE / u=
nmanaged L2TPv3) - BAHIA |</div><div>+-------------------------------------=
-----------------------------+<br>

</div></div><div><br><b>root@bahia:~#=A0</b>=A0ip -d addr show eth0 <b># WA=
N</b><br>


2: eth0: &lt;BROADCAST,MULTICAST,UP,LOWER_UP&gt; mtu 1500 qdisc pfifo_fast =
state UP qlen 1000<br>=A0 =A0 link/ether 00:50:56:a7:13:49 brd ff:ff:ff:ff:=
ff:ff<br>=A0 =A0 inet=A0<a href=3D"http://200.243.1.5/24" target=3D"_blank"=
>200.243.1.5/24</a> brd=A0200.243.1.255 scope global eth0<br>




=A0 =A0 inet6 fe80::250:56ff:fea7:1349/64 scope link<br>=A0 =A0 =A0 =A0vali=
d_lft forever preferred_lft forever<br><b>root@bahia:~#=A0</b>=A0ip -d addr=
 show eth1 <b># LAN (VLAN/TRUNK)</b><br>3: eth1: &lt;BROADCAST,MULTICAST,UP=
,LOWER_UP&gt; mtu 1500 qdisc pfifo_fast state UP qlen 1000<br>




=A0 =A0 link/ether 00:50:56:a7:13:4a brd ff:ff:ff:ff:ff:ff<br>=A0 =A0 inet6=
 fe80::250:56ff:fea7:134a/64 scope link<br>=A0 =A0 =A0 =A0valid_lft forever=
 preferred_lft forever<br><b>root@bahia:~#=A0</b>=A0ip link add link eth1 n=
ame eth1.601 mtu 1500 type vlan id 601<br>




<b>root@bahia:~#=A0</b>=A0ip link set dev eth1.601 up promisc on<br><b>root=
@bahia:~#=A0</b>=A0ip -d addr show eth1.601<br>9: eth1.601@eth1: &lt;BROADC=
AST,MULTICAST,PROMISC,UP,LOWER_UP&gt; mtu 1500 qdisc noqueue state UP<br>=
=A0 =A0 link/ether 00:50:56:a7:13:4a brd ff:ff:ff:ff:ff:ff<br>




=A0 =A0 inet6 fe80::250:56ff:fea7:134a/64 scope link<br>=A0 =A0 =A0 =A0vali=
d_lft forever preferred_lft forever<br><b>root@bahia:~#=A0</b><b>=A0</b>ip =
route show<br>default via 200.243.1.254 dev eth0<br><a href=3D"http://200.2=
43.1.0/24" target=3D"_blank">200.243.1.0/24</a> dev eth0 =A0proto kernel =
=A0scope link =A0src=A0200.243.1.5<br>




<b>root@bahia:~#=A0</b><br><div><br></div><div>and.... we&#39;ve the interf=
ace l2tpeth0 (L2TPv3) established with other node into the internet by eth0=
 (WAN), plugged</div><div>with vlan601 (eth1.601) by bridge called &quot;br=
-red&quot;</div>




<div><br></div><div><div><b>root@bahia:~#</b>=A0brctl show</div><div>bridge=
 name<span style=3D"white-space:pre-wrap">	</span>bridge id<span style=3D"w=
hite-space:pre-wrap">		</span>STP enabled<span style=3D"white-space:pre-wra=
p">	</span>interfaces</div>




<div><b>root@bahia:~#</b>=A0brctl addbr br-red</div><div><b>root@bahia:~#</=
b>=A0brctl addif br-red eth1.601</div></div><div><b>root@bahia:~#</b><b>=A0=
</b>ip l2tp add tunnel tunnel_id 45 peer_tunnel_id 42 udp_sport 5001 udp_dp=
ort 5000 encap udp local 200.243.1.5 remote 200.199.10.12<br>




</div><div><div><b>root@bahia:~#</b><b>=A0</b>ip l2tp add session tunnel_id=
 45 session_id 5196755 peer_session_id 128</div><div><b>root@bahia:~#</b>=
=A0ip link set l2tpeth0 up promisc on master br-red =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0</div>




<div><b>root@bahia:~#</b>=A0ip link set br-red up</div></div><div><b>root@b=
ahia:~#</b>=A0brctl show br-red<br></div><div><div>bridge name<span style=
=3D"white-space:pre-wrap">	</span>bridge id<span style=3D"white-space:pre-w=
rap">		                </span>STP enabled<span style=3D"white-space:pre-wra=
p">	</span>interfaces</div>




<div>br-red<span style=3D"white-space:pre-wrap">		</span>8000.005056a7134a<=
span style=3D"white-space:pre-wrap">	</span>no<span style=3D"white-space:pr=
e-wrap">	                </span>eth1.601</div><div><span style=3D"white-spa=
ce:pre-wrap">							                                </span>l2tpeth0</div>




</div></div><div><div><b>root@bahia:~#=A0</b>brctl showstp br-red</div><div=
>br-red</div><div>=A0bridge id<span style=3D"white-space:pre-wrap">		      =
  </span>8000.005056a7134a</div><div>=A0designated root<span style=3D"white=
-space:pre-wrap">	</span>8000.005056a7134a</div>




<div>=A0root port<span style=3D"white-space:pre-wrap">		</span>=A0 =A0 =A0 =
=A0 0<span style=3D"white-space:pre-wrap">			</span>path cost<span style=3D=
"white-space:pre-wrap">		</span> =A0 0</div><div>=A0max age<span style=3D"w=
hite-space:pre-wrap">		</span>=A0 =A0 =A0 =A0 20.00<span style=3D"white-spa=
ce:pre-wrap">		</span>bridge max age<span style=3D"white-space:pre-wrap">		=
</span> =A020.00</div>




<div>=A0hello time<span style=3D"white-space:pre-wrap">		</span>2.00<span s=
tyle=3D"white-space:pre-wrap">			</span>bridge hello time<span style=3D"whi=
te-space:pre-wrap">	</span> =A0 2.00</div><div>=A0forward delay<span style=
=3D"white-space:pre-wrap">		</span>15.00<span style=3D"white-space:pre-wrap=
">		</span>bridge forward delay<span style=3D"white-space:pre-wrap">	</span=
> =A015.00</div>




<div>=A0ageing time<span style=3D"white-space:pre-wrap">		</span> 300.01</d=
iv><div>=A0hello timer<span style=3D"white-space:pre-wrap">		</span>1.06<sp=
an style=3D"white-space:pre-wrap">			</span>tcn timer<span style=3D"white-s=
pace:pre-wrap">		</span> =A0 0.00</div>




<div>=A0topology change timer<span style=3D"white-space:pre-wrap">	</span> =
=A0 0.00<span style=3D"white-space:pre-wrap">			</span>gc timer<span style=
=3D"white-space:pre-wrap">		</span> =A0 5.08</div><div>=A0flags<span style=
=3D"white-space:pre-wrap">			</span></div>




<div><br></div><div>eth1.601 (1)</div><div>=A0port id<span style=3D"white-s=
pace:pre-wrap">		</span>8001<span style=3D"white-space:pre-wrap">			</span>=
state<span style=3D"white-space:pre-wrap">		</span> =A0 =A0 forwarding</div=
>
<div>=A0designated root<span style=3D"white-space:pre-wrap">	</span>8000.00=
5056a7134a<span style=3D"white-space:pre-wrap">	</span>path cost<span style=
=3D"white-space:pre-wrap">		</span> =A0 4</div><div>=A0designated bridge<sp=
an style=3D"white-space:pre-wrap">	</span>8000.005056a7134a<span style=3D"w=
hite-space:pre-wrap">	</span>message age timer<span style=3D"white-space:pr=
e-wrap">	</span> =A0 0.00</div>




<div>=A0designated port<span style=3D"white-space:pre-wrap">	</span>8001<sp=
an style=3D"white-space:pre-wrap">			</span>forward delay timer<span style=
=3D"white-space:pre-wrap">	</span> =A0 0.00</div><div>=A0designated cost<sp=
an style=3D"white-space:pre-wrap">	</span> =A0 0<span style=3D"white-space:=
pre-wrap">			</span>hold timer<span style=3D"white-space:pre-wrap">		</span=
> =A0 0.06</div>




<div>=A0flags<span style=3D"white-space:pre-wrap">			</span></div><div><br>=
</div><div>l2tpeth0 (2)</div><div>=A0port id<span style=3D"white-space:pre-=
wrap">		</span>8002<span style=3D"white-space:pre-wrap">			</span>state<spa=
n style=3D"white-space:pre-wrap">		</span> =A0 =A0 forwarding</div>




<div>=A0designated root<span style=3D"white-space:pre-wrap">	</span>8000.00=
5056a7134a<span style=3D"white-space:pre-wrap">	</span>path cost<span style=
=3D"white-space:pre-wrap">		</span> 100</div><div>=A0designated bridge<span=
 style=3D"white-space:pre-wrap">	</span>8000.005056a7134a<span style=3D"whi=
te-space:pre-wrap">	</span>message age timer<span style=3D"white-space:pre-=
wrap">	</span> =A0 0.00</div>




<div>=A0designated port<span style=3D"white-space:pre-wrap">	</span>8002<sp=
an style=3D"white-space:pre-wrap">			</span>forward delay timer<span style=
=3D"white-space:pre-wrap">	</span> =A0 0.00</div><div>=A0designated cost<sp=
an style=3D"white-space:pre-wrap">	</span> =A0 0<span style=3D"white-space:=
pre-wrap">			</span>hold timer<span style=3D"white-space:pre-wrap">		</span=
> =A0 0.05</div>




<div>=A0flags<span style=3D"white-space:pre-wrap">			</span></div><div><br>=
</div><div><b>root@bahia:~#=A0</b><br></div></div><div><b><br></b></div><di=
v>it&#39;s ok, my bridge &quot;by-red&quot; listen all traffic over my LAN =
(vlan 601) and my L2TPv3 over internet. (wan)<b><br>




</b></div><div><b><br></b></div><div><b>root@bahia:~#=A0</b><b>=A0</b>tcpdu=
mp -nve -i <b>br-red</b> &quot;host 10.251.0.1&quot;<br><div><div>tcpdump: =
WARNING: br-red: no IPv4 address assigned</div><div>tcpdump: listening on b=
r-red, link-type EN10MB (Ethernet), capture size 65535 bytes</div>




<div>20:58:17.860060 d4:ae:52:84:37:ae &gt; ff:ff:ff:ff:ff:ff, ethertype AR=
P (0x0806), length 60: Ethernet (len 6), IPv4 (len 4), Request who-has 10.2=
51.90.157 tell=A0<b>10.251.0.1</b>, length 46</div><div>20:58:17.980065 d4:=
ae:52:84:37:ae &gt; ff:ff:ff:ff:ff:ff, ethertype ARP (0x0806), length 60: E=
thernet (len 6), IPv4 (len 4), Request who-has 10.251.153.31 tell=A0<b>10.2=
51.0.1</b>, length 46</div>




<div>^C</div><div>7 packets captured</div><div>7 packets received by filter=
</div><div>0 packets dropped by kernel</div><div><b>root@bahia:~#=A0</b></d=
iv></div></div></div><div><br></div><div><div>+----------------------------=
-------------------------------------------------------------+</div>




<div>=A0| SERVER B (BRIDGE/L2TPv3 + WIRELESS ACCESS POINT) - RECIFE |</div>=
<div>+---------------------------------------------------------------------=
--------------------+<br></div></div><div><br></div><div><div><b>root@recif=
e:~#</b> ip addr show eth1 <b># (WAN)</b></div>


<div>3: eth1: &lt;BROADCAST,MULTICAST,UP,LOWER_UP&gt; mtu 1500 qdisc fq_cod=
el state UP qlen 1000</div>

<div>=A0 =A0 link/ether a0:f3:c1:a3:c4:11 brd ff:ff:ff:ff:ff:ff</div><div>=
=A0 =A0 inet=A0<a href=3D"http://200.199.10.12/21" target=3D"_blank">200.19=
9.10.12/21</a> brd=A0200.199.10.255=A0scope global eth1</div><div>=A0 =A0 =
=A0 =A0valid_lft forever preferred_lft forever</div>




<div>=A0 =A0 inet6 fe80::a2f3:c1ff:fea3:c411/64 scope link=A0</div><div>=A0=
 =A0 =A0 =A0valid_lft forever preferred_lft forever</div><div><b>root@recif=
e:~#</b> ip route show</div><div>default via=A0200.199.10.254=A0dev eth1 =
=A0proto static=A0</div>




<div><a href=3D"http://200.199.10.0/21" target=3D"_blank">200.199.10.0/21</=
a> dev eth1 =A0proto kernel =A0scope link =A0src 200.199.10.12</div><div><a=
 href=3D"http://192.168.1.0/24" target=3D"_blank">192.168.1.0/24</a> dev br=
-lan =A0proto kernel =A0scope link =A0src 192.168.1.1=A0</div>




<div><b>root@recife:~#</b> ip l2tp add tunnel tunnel_id 42 peer_tunnel_id 4=
5 udp_sport 5000 udp_dport 5001 encap udp local=A0200.199.10.12=A0remote 20=
0.243.1.5</div></div><div><div><b>root@recife:~#</b>=A0ip l2tp add session =
tunnel_id 42 session_id 128 peer_session_id 5196755</div>




<div><b>root@recife:~#</b>=A0ip link set dev l2tpeth0 up promisc on master =
br-red<br></div><div><b>root@recife:~#</b>=A0brctl show</div><div>bridge na=
me =A0 =A0 bridge id =A0 =A0 =A0 =A0 =A0 =A0 =A0 STP enabled =A0 =A0 interf=
aces<br></div><div><div>




br-lan =A0 =A0 =A0 =A0 =A07fff.a0f3c1a3c40f =A0 =A0 =A0 no =A0 =A0 =A0 =A0 =
=A0 =A0 =A0eth0</div><div><b>root@recife:~#</b>=A0brctl addbr br-red</div><=
div><b>root@recife:~#</b>=A0brctl addif br-red l2tpeth0</div><div><b>root@r=
ecife:~#</b>=A0brctl addif br-red wlan0</div>




<div><b>root@recife:~#</b>=A0ifconfig br-red up</div><div><b>root@recife:~#=
</b>=A0ip link set br-red up</div><div><b>root@recife:~#</b>=A0brctl show</=
div><div>bridge name =A0 =A0 bridge id =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 STP enabled =A0 =A0 interfaces</div>




<div>br-lan =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A07fff.a0f3c1a3c40f =A0 =A0 =A0 no=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 eth0</div><div>br-red =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A08000.1ae0f4a30221 =A0no =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 l2tpeth0</div><div>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0wlan0</div>




<div><b>root@recife:~#</b>=A0</div></div><div><b><br></b></div><div><b>....=
::: RESUME :::...</b></div></div><div><br></div><div>1) sorry for the long =
email....</div><div>2) when i&#39;m &quot;recife hostspot&quot;... I can jo=
in in wireless &quot;Recife Wireless&quot; from my device, but i can&#39;t =
receive ip from dhcp (10.60.61.1).</div>




<div>3) from &quot;server A[bahia] (bridge with vlan601 network) and &quot;=
server B [recife]&quot;, i can &quot;see/listen&quot; the broadcast request=
 from my</div><div>device mac &quot;5c:95:ae:22:d6:6e&quot; like below.</di=
v>




<div><br></div><div><b>root@bahia:~#=A0</b>tcpdump -nve -i br-red &quot;eth=
er host ether 5c:95:ae:22:d6:6e&quot;<br></div><div><div><div>00:08:52.6536=
67 5c:95:ae:22:d6:6e &gt; ff:ff:ff:ff:ff:ff, ethertype IPv4 (0x0800), lengt=
h 342: (tos 0x0, ttl 255, id 37839, offset 0, flags [none], proto UDP (17),=
 length 328)</div>




<div>=A0 =A0 0.0.0.0.68 &gt; 255.255.255.255.67: BOOTP/DHCP, Request from 5=
c:95:ae:22:d6:6e, length 300, xid 0xe6f1d0a5, Flags [none]</div><div>=A0 =
=A0 =A0 =A0 =A0 Client-Ethernet-Address 5c:95:ae:22:d6:6e</div><div>=A0 =A0=
 =A0 =A0 =A0 Vendor-rfc1048 Extensions</div>




<div>=A0 =A0 =A0 =A0 =A0 =A0 Magic Cookie 0x63825363</div><div>=A0 =A0 =A0 =
=A0 =A0 =A0 DHCP-Message Option 53, length 1: Discover</div><div>=A0 =A0 =
=A0 =A0 =A0 =A0 Parameter-Request Option 55, length 6:</div><div>=A0 =A0 =
=A0 =A0 =A0 =A0 =A0 Subnet-Mask, Default-Gateway, Domain-Name-Server, Domai=
n-Name</div>




<div>=A0 =A0 =A0 =A0 =A0 =A0 =A0 Option 119, Option 252</div><div>=A0 =A0 =
=A0 =A0 =A0 =A0 MSZ Option 57, length 2: 1500</div><div>=A0 =A0 =A0 =A0 =A0=
 =A0 Client-ID Option 61, length 7: ether 5c:95:ae:22:d6:6e</div><div>=A0 =
=A0 =A0 =A0 =A0 =A0 Lease-Time Option 51, length 4: 7776000</div>




<div>=A0 =A0 =A0 =A0 =A0 =A0 Hostname Option 12, length 14: &quot;Straces-i=
Phone&quot;</div></div><div>^C</div><div>1 packets captured</div><div>1 pac=
kets received by filter</div></div><div><b>root@bahia:~#</b><br></div><div>=
<br></div>




<div>same thing result at &quot;bridge a&quot; (<b>root@recife:~#)=A0</b>si=
de...</div><div><br></div><div>4)=A0the strangest thing of all and that, fr=
om bridge-b (recife). i can get ip from dhcp/broadcast request over L2TPv3.=
..=A0</div>

<div>but without option &quot;broadcast&quot; i can&#39;t receive ip from d=
hcp (10.61.60.1)</div><div><br></div><div><div><b>root@recife:~#</b> udhcpc=
 -B -i br-red</div><div>udhcpc (v1.19.4) started</div><div>Sending discover=
...</div>

<div>Sending select for 10.251.157.22...</div><div>Lease of 10.251.157.22 o=
btained, lease time 300</div><div>udhcpc: ifconfig br-red 10.251.157.22 net=
mask 255.255.0.0 broadcast +</div><div>udhcpc: setting default routers: 10.=
251.0.1</div>

<div><b>root@recife:~#=A0</b>ip route add 200.243.1.5 via=A0200.199.10.254=
=A0dev eth1</div></div><div><div><b>root@recife:~# </b>ip route show</div><=
div>default via 10.251.0.1 dev br-red=A0</div><div><a href=3D"http://10.251=
.0.0/16">10.251.0.0/16</a> dev br-red =A0proto kernel =A0scope link =A0src =
10.251.157.22=A0</div>

<div><a href=3D"http://200.199.10.0/21">200.199.10.0/21</a> dev eth1 =A0pro=
to kernel =A0scope link =A0src 200.199.10.12</div><div>200.243.1.5 via=A020=
0.199.10.254=A0dev eth1=A0</div><div><a href=3D"http://192.168.1.0/24">192.=
168.1.0/24</a> dev br-lan =A0proto kernel =A0scope link =A0src 192.168.1.1=
=A0</div>

<div><b>root@recife:~#</b> ping -c2 10.251.0.1<br></div></div><div><div>PIN=
G 10.251.0.1 (10.251.0.1): 56 data bytes</div><div><br></div><div>--- 10.25=
1.0.1 ping statistics ---</div><div>2 packets transmitted, 0 packets receiv=
ed, 100% packet loss</div>

<div><b>root@recife:~#</b><br></div></div><div><br></div><div>5) output of =
tcpdump listen the bridge &quot;br-red&quot;=A0request from bridge-a-natal=
=A0<a href=3D"http://pastebin.com/t8wn3zRK" target=3D"_blank">http://pasteb=
in.com/t8wn3zRK</a><br>




</div><div>6) output of tcpdump listen the bridge &quot;br-red&quot; reques=
t from bridge-b-recife=A0<a href=3D"http://pastebin.com/njTQfd5k" target=3D=
"_blank">http://pastebin.com/njTQfd5k</a><br></div><div><div>7) after sever=
al researches i found the kernel options to set like &quot;arp_filter&quot;=
, &quot;bridge-nf-*&quot;,... but i don&#39;t have</div>




<div>idea which option should enable / disable. tried some combinations but=
 without success....</div></div><div>8) the DHCP-OFFER doesn&#39;t forward =
by &quot;bridge-a&quot;... =A0problems with unicast? multicast? arp_proxy? =
....</div>


<div>9) we need join in the network by wireless and access the server 10.25=
1.0.1 over bridge/l2tpv3 (unmanaged)</div>

<div>10) in our case, can use only L2TPv3. (may not be OpenVPN, ...)</div><=
div>11) all is Linux, without any iptables rules.</div><div>12)=A0who will =
win a beer?! =3D]</div><div><br></div><div>Best regards,</div><div>Jorge Pe=
reira</div>

</div>

</div>

--001a11c309e8fda0cb04e4941118--
