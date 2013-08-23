Return-Path: <aenertia@aenertia.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=aenertia.net; s=dkimaenertianet;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=FDFOFVES2REX2wi+BmnUWgqBhJN5Dnw3IyUSVZfA3ko=;
	b=dMROGz5f9lGBUVTW8uoF0R4chb0X4BEcu4pb7R6KNM0vVU6Lebnf1cry5SsHyLtjMq
	CHSX6Kng/9rjZ2Rt6ih5rpVafmfkHMmmanV25IsyaAFEm5pYw63h0xPV2lAs158VmHVk
	XwcGwVkWTy7nZpwN7QcOlhBiOXjOARMo+J2wI=
MIME-Version: 1.0
Sender: aenertia@aenertia.net
In-Reply-To: <CABvP5W17XQ16mRsVhTFEUf9AbyGd+WQSV0hBozDy3rANUSKofw@mail.gmail.com>
References: <CABvP5W17XQ16mRsVhTFEUf9AbyGd+WQSV0hBozDy3rANUSKofw@mail.gmail.com>
From: =?UTF-8?Q?Joel_Wir=C4=81mu_Pauling?= <joel@aenertia.net>
Date: Fri, 23 Aug 2013 17:22:52 +1200
Message-ID: <CAKiAkGTtgBXU9fQbvzoXPC+DO+DtM0xG73psUCDE43CgvK62oQ@mail.gmail.com>
Content-Type: multipart/alternative; boundary=047d7b15fc2d590a0e04e4969a1a
Subject: Re: [Bridge] challenge of year: connect to LAN using wireless-ap
 over bridge + unmanaged l2tpv3 tunnel + bridge? it's possible?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jorge Pereira <jpereiran@gmail.com>
Cc: Openl2tp-users@lists.sourceforge.net, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, lartc@vger.kernel.org

--047d7b15fc2d590a0e04e4969a1a
Content-Type: text/plain; charset=UTF-8

You can't bridge 802.11 segments with normal ethernet segments. Wifi AP's
that do this use magic; or hidden pesudo bridges to do the same.

You will need to use something like relayd to form a psuedo bridge between
your wired and wireless segments or use routing.


-Joel


On 23 August 2013 14:21, Jorge Pereira <jpereiran@gmail.com> wrote:

> hi everyone,
>
>     so,first it seemed a trivial question to me, but since I could not
> find anybody being neither able to answer
> this question nor giving a short config example. after a few sleepless
> nights and exhausting all the reading
> and research. here I am sharing my problem with all of you, in the hope of
> some possible solution/sugestion.
> or is it that this is impossible??
>
> below my scheme/layout.
>
> +---------------------------------------------------------+
> | MAIN SERVER - 10.60.61.1 (DHCP SERVER) |
> +---------------------------------------------------------+
>                      |
> +---------------------------+
> |    NETWORK vlan601 |
> |  net 10.251.0.0/16      |
> |  gw:10.251.0.1            |
> +---------------------------+
>                     |
> +------------------------------------------------------------------+
>  | SERVER B (BRIDGE / unmanaged L2TPv3) - BAHIA |
> +------------------------------------------------------------------+
>
> *root@bahia:~# * ip -d addr show eth0 *# WAN*
> 2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state
> UP qlen 1000
>     link/ether 00:50:56:a7:13:49 brd ff:ff:ff:ff:ff:ff
>     inet 200.243.1.5/24 brd 200.243.1.255 scope global eth0
>     inet6 fe80::250:56ff:fea7:1349/64 scope link
>        valid_lft forever preferred_lft forever
> *root@bahia:~# * ip -d addr show eth1 *# LAN (VLAN/TRUNK)*
> 3: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state
> UP qlen 1000
>     link/ether 00:50:56:a7:13:4a brd ff:ff:ff:ff:ff:ff
>     inet6 fe80::250:56ff:fea7:134a/64 scope link
>        valid_lft forever preferred_lft forever
> *root@bahia:~# * ip link add link eth1 name eth1.601 mtu 1500 type vlan
> id 601
> *root@bahia:~# * ip link set dev eth1.601 up promisc on
> *root@bahia:~# * ip -d addr show eth1.601
> 9: eth1.601@eth1: <BROADCAST,MULTICAST,PROMISC,UP,LOWER_UP> mtu 1500
> qdisc noqueue state UP
>     link/ether 00:50:56:a7:13:4a brd ff:ff:ff:ff:ff:ff
>     inet6 fe80::250:56ff:fea7:134a/64 scope link
>        valid_lft forever preferred_lft forever
> *root@bahia:~# ** *ip route show
> default via 200.243.1.254 dev eth0
> 200.243.1.0/24 dev eth0  proto kernel  scope link  src 200.243.1.5
> *root@bahia:~# *
>
> and.... we've the interface l2tpeth0 (L2TPv3) established with other node
> into the internet by eth0 (WAN), plugged
> with vlan601 (eth1.601) by bridge called "br-red"
>
> *root@bahia:~#* brctl show
> bridge name bridge id STP enabled interfaces
> *root@bahia:~#* brctl addbr br-red
> *root@bahia:~#* brctl addif br-red eth1.601
> *root@bahia:~#** *ip l2tp add tunnel tunnel_id 45 peer_tunnel_id 42
> udp_sport 5001 udp_dport 5000 encap udp local 200.243.1.5 remote
> 200.199.10.12
> *root@bahia:~#** *ip l2tp add session tunnel_id 45 session_id 5196755
> peer_session_id 128
> *root@bahia:~#* ip link set l2tpeth0 up promisc on master br-red
>
> *root@bahia:~#* ip link set br-red up
> *root@bahia:~#* brctl show br-red
> bridge name bridge id STP enabled interfaces
> br-red 8000.005056a7134a no eth1.601
> l2tpeth0
> *root@bahia:~# *brctl showstp br-red
> br-red
>  bridge id 8000.005056a7134a
>  designated root 8000.005056a7134a
>  root port         0 path cost   0
>  max age         20.00 bridge max age  20.00
>  hello time 2.00 bridge hello time   2.00
>  forward delay 15.00 bridge forward delay  15.00
>  ageing time 300.01
>  hello timer 1.06 tcn timer   0.00
>  topology change timer   0.00 gc timer   5.08
>  flags
>
> eth1.601 (1)
>  port id 8001 state     forwarding
>  designated root 8000.005056a7134a path cost   4
>  designated bridge 8000.005056a7134a message age timer   0.00
>  designated port 8001 forward delay timer   0.00
>  designated cost   0 hold timer   0.06
>  flags
>
> l2tpeth0 (2)
>  port id 8002 state     forwarding
>  designated root 8000.005056a7134a path cost 100
>  designated bridge 8000.005056a7134a message age timer   0.00
>  designated port 8002 forward delay timer   0.00
>  designated cost   0 hold timer   0.05
>  flags
>
> *root@bahia:~# *
> *
> *
> it's ok, my bridge "by-red" listen all traffic over my LAN (vlan 601) and
> my L2TPv3 over internet. (wan)*
> *
> *
> *
> *root@bahia:~# ** *tcpdump -nve -i *br-red* "host 10.251.0.1"
> tcpdump: WARNING: br-red: no IPv4 address assigned
> tcpdump: listening on br-red, link-type EN10MB (Ethernet), capture size
> 65535 bytes
> 20:58:17.860060 d4:ae:52:84:37:ae > ff:ff:ff:ff:ff:ff, ethertype ARP
> (0x0806), length 60: Ethernet (len 6), IPv4 (len 4), Request who-has
> 10.251.90.157 tell *10.251.0.1*, length 46
> 20:58:17.980065 d4:ae:52:84:37:ae > ff:ff:ff:ff:ff:ff, ethertype ARP
> (0x0806), length 60: Ethernet (len 6), IPv4 (len 4), Request who-has
> 10.251.153.31 tell *10.251.0.1*, length 46
> ^C
> 7 packets captured
> 7 packets received by filter
> 0 packets dropped by kernel
> *root@bahia:~# *
>
>
> +-----------------------------------------------------------------------------------------+
>  | SERVER B (BRIDGE/L2TPv3 + WIRELESS ACCESS POINT) - RECIFE |
>
> +-----------------------------------------------------------------------------------------+
>
> *root@recife:~#* ip addr show eth1 *# (WAN)*
> 3: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state
> UP qlen 1000
>     link/ether a0:f3:c1:a3:c4:11 brd ff:ff:ff:ff:ff:ff
>     inet 200.199.10.12/21 brd 200.199.10.255 scope global eth1
>        valid_lft forever preferred_lft forever
>     inet6 fe80::a2f3:c1ff:fea3:c411/64 scope link
>        valid_lft forever preferred_lft forever
> *root@recife:~#* ip route show
> default via 200.199.10.254 dev eth1  proto static
> 200.199.10.0/21 dev eth1  proto kernel  scope link  src 200.199.10.12
> 192.168.1.0/24 dev br-lan  proto kernel  scope link  src 192.168.1.1
> *root@recife:~#* ip l2tp add tunnel tunnel_id 42 peer_tunnel_id 45
> udp_sport 5000 udp_dport 5001 encap udp local 200.199.10.12 remote
> 200.243.1.5
> *root@recife:~#* ip l2tp add session tunnel_id 42 session_id 128
> peer_session_id 5196755
> *root@recife:~#* ip link set dev l2tpeth0 up promisc on master br-red
> *root@recife:~#* brctl show
> bridge name     bridge id               STP enabled     interfaces
> br-lan          7fff.a0f3c1a3c40f       no              eth0
> *root@recife:~#* brctl addbr br-red
> *root@recife:~#* brctl addif br-red l2tpeth0
> *root@recife:~#* brctl addif br-red wlan0
> *root@recife:~#* ifconfig br-red up
> *root@recife:~#* ip link set br-red up
> *root@recife:~#* brctl show
> bridge name     bridge id                     STP enabled     interfaces
> br-lan                7fff.a0f3c1a3c40f       no                     eth0
> br-red                8000.1ae0f4a30221  no                     l2tpeth0
>
>            wlan0
> *root@recife:~#*
> *
> *
> *....::: RESUME :::...*
>
> 1) sorry for the long email....
> 2) when i'm "recife hostspot"... I can join in wireless "Recife Wireless"
> from my device, but i can't receive ip from dhcp (10.60.61.1).
> 3) from "server A[bahia] (bridge with vlan601 network) and "server B
> [recife]", i can "see/listen" the broadcast request from my
> device mac "5c:95:ae:22:d6:6e" like below.
>
> *root@bahia:~# *tcpdump -nve -i br-red "ether host ether
> 5c:95:ae:22:d6:6e"
> 00:08:52.653667 5c:95:ae:22:d6:6e > ff:ff:ff:ff:ff:ff, ethertype IPv4
> (0x0800), length 342: (tos 0x0, ttl 255, id 37839, offset 0, flags [none],
> proto UDP (17), length 328)
>     0.0.0.0.68 > 255.255.255.255.67: BOOTP/DHCP, Request from
> 5c:95:ae:22:d6:6e, length 300, xid 0xe6f1d0a5, Flags [none]
>           Client-Ethernet-Address 5c:95:ae:22:d6:6e
>           Vendor-rfc1048 Extensions
>             Magic Cookie 0x63825363
>             DHCP-Message Option 53, length 1: Discover
>             Parameter-Request Option 55, length 6:
>               Subnet-Mask, Default-Gateway, Domain-Name-Server, Domain-Name
>               Option 119, Option 252
>             MSZ Option 57, length 2: 1500
>             Client-ID Option 61, length 7: ether 5c:95:ae:22:d6:6e
>             Lease-Time Option 51, length 4: 7776000
>             Hostname Option 12, length 14: "Straces-iPhone"
> ^C
> 1 packets captured
> 1 packets received by filter
> *root@bahia:~#*
>
> same thing result at "bridge a" (*root@recife:~#) *side...
>
> 4) the strangest thing of all and that, from bridge-b (recife). i can get
> ip from dhcp/broadcast request over L2TPv3...
> but without option "broadcast" i can't receive ip from dhcp (10.61.60.1)
>
> *root@recife:~#* udhcpc -B -i br-red
> udhcpc (v1.19.4) started
> Sending discover...
> Sending select for 10.251.157.22...
> Lease of 10.251.157.22 obtained, lease time 300
> udhcpc: ifconfig br-red 10.251.157.22 netmask 255.255.0.0 broadcast +
> udhcpc: setting default routers: 10.251.0.1
> *root@recife:~# *ip route add 200.243.1.5 via 200.199.10.254 dev eth1
> *root@recife:~# *ip route show
> default via 10.251.0.1 dev br-red
> 10.251.0.0/16 dev br-red  proto kernel  scope link  src 10.251.157.22
> 200.199.10.0/21 dev eth1  proto kernel  scope link  src 200.199.10.12
> 200.243.1.5 via 200.199.10.254 dev eth1
> 192.168.1.0/24 dev br-lan  proto kernel  scope link  src 192.168.1.1
> *root@recife:~#* ping -c2 10.251.0.1
> PING 10.251.0.1 (10.251.0.1): 56 data bytes
>
> --- 10.251.0.1 ping statistics ---
> 2 packets transmitted, 0 packets received, 100% packet loss
> *root@recife:~#*
>
> 5) output of tcpdump listen the bridge "br-red" request from
> bridge-a-natal http://pastebin.com/t8wn3zRK
> 6) output of tcpdump listen the bridge "br-red" request from
> bridge-b-recife http://pastebin.com/njTQfd5k
> 7) after several researches i found the kernel options to set like
> "arp_filter", "bridge-nf-*",... but i don't have
> idea which option should enable / disable. tried some combinations but
> without success....
> 8) the DHCP-OFFER doesn't forward by "bridge-a"...  problems with unicast?
> multicast? arp_proxy? ....
> 9) we need join in the network by wireless and access the server
> 10.251.0.1 over bridge/l2tpv3 (unmanaged)
> 10) in our case, can use only L2TPv3. (may not be OpenVPN, ...)
> 11) all is Linux, without any iptables rules.
> 12) who will win a beer?! =]
>
> Best regards,
> Jorge Pereira
>

--047d7b15fc2d590a0e04e4969a1a
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>You can&#39;t bridge 802.11 segments with normal ethe=
rnet segments. Wifi AP&#39;s that do this use magic; or hidden pesudo bridg=
es to do the same.<br><br>You will need to use something like relayd to for=
m a psuedo bridge between your wired and wireless segments or use routing.<=
br>

<br><br></div>-Joel<br></div><div class=3D"gmail_extra"><br><br><div class=
=3D"gmail_quote">On 23 August 2013 14:21, Jorge Pereira <span dir=3D"ltr">&=
lt;<a href=3D"mailto:jpereiran@gmail.com" target=3D"_blank">jpereiran@gmail=
.com</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div>hi everyone,</div><div=
><br></div><div>=C2=A0 =C2=A0 so,first it seemed a trivial question to me, =
but since I could not find anybody being neither able to answer</div>

<div>this question nor giving a short config example. after a few sleepless=
 nights and exhausting all the reading</div>


<div>and research. here I am sharing my problem with all of you, in the hop=
e of some possible solution/sugestion.</div><div>or is it that this is impo=
ssible??</div><div><br></div><div>below my scheme/layout.</div><div><div>




<br>+---------------------------------------------------------+<br>| MAIN S=
ERVER - 10.60.61.1 (DHCP SERVER) |<br>+------------------------------------=
---------------------+<br>

=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|<br>+---------------------------+</div><div>| =C2=A0 =C2=A0NETWORK vlan=
601 |<br>| =C2=A0net <a href=3D"http://10.251.0.0/16" target=3D"_blank">10.=
251.0.0/16</a> =C2=A0 =C2=A0 =C2=A0|<div>| =C2=A0gw:10.251.0.1 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|<br>+---------------------------+<br>






=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |<div=
>+------------------------------------------------------------------+</div>=
<div>=C2=A0| SERVER B (BRIDGE / unmanaged L2TPv3) - BAHIA |</div><div>+----=
--------------------------------------------------------------+<br>



</div></div><div><br><b>root@bahia:~#=C2=A0</b>=C2=A0ip -d addr show eth0 <=
b># WAN</b><br>


2: eth0: &lt;BROADCAST,MULTICAST,UP,LOWER_UP&gt; mtu 1500 qdisc pfifo_fast =
state UP qlen 1000<br>=C2=A0 =C2=A0 link/ether 00:50:56:a7:13:49 brd ff:ff:=
ff:ff:ff:ff<br>=C2=A0 =C2=A0 inet=C2=A0<a href=3D"http://200.243.1.5/24" ta=
rget=3D"_blank">200.243.1.5/24</a> brd=C2=A0200.243.1.255 scope global eth0=
<br>






=C2=A0 =C2=A0 inet6 fe80::250:56ff:fea7:1349/64 scope link<br>=C2=A0 =C2=A0=
 =C2=A0 =C2=A0valid_lft forever preferred_lft forever<br><b>root@bahia:~#=
=C2=A0</b>=C2=A0ip -d addr show eth1 <b># LAN (VLAN/TRUNK)</b><br>3: eth1: =
&lt;BROADCAST,MULTICAST,UP,LOWER_UP&gt; mtu 1500 qdisc pfifo_fast state UP =
qlen 1000<br>






=C2=A0 =C2=A0 link/ether 00:50:56:a7:13:4a brd ff:ff:ff:ff:ff:ff<br>=C2=A0 =
=C2=A0 inet6 fe80::250:56ff:fea7:134a/64 scope link<br>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0valid_lft forever preferred_lft forever<br><b>root@bahia:~#=C2=A0</b=
>=C2=A0ip link add link eth1 name eth1.601 mtu 1500 type vlan id 601<br>






<b>root@bahia:~#=C2=A0</b>=C2=A0ip link set dev eth1.601 up promisc on<br><=
b>root@bahia:~#=C2=A0</b>=C2=A0ip -d addr show eth1.601<br>9: eth1.601@eth1=
: &lt;BROADCAST,MULTICAST,PROMISC,UP,LOWER_UP&gt; mtu 1500 qdisc noqueue st=
ate UP<br>=C2=A0 =C2=A0 link/ether 00:50:56:a7:13:4a brd ff:ff:ff:ff:ff:ff<=
br>






=C2=A0 =C2=A0 inet6 fe80::250:56ff:fea7:134a/64 scope link<br>=C2=A0 =C2=A0=
 =C2=A0 =C2=A0valid_lft forever preferred_lft forever<br><b>root@bahia:~#=
=C2=A0</b><b>=C2=A0</b>ip route show<br>default via 200.243.1.254 dev eth0<=
br><a href=3D"http://200.243.1.0/24" target=3D"_blank">200.243.1.0/24</a> d=
ev eth0 =C2=A0proto kernel =C2=A0scope link =C2=A0src=C2=A0200.243.1.5<br>






<b>root@bahia:~#=C2=A0</b><br><div><br></div><div>and.... we&#39;ve the int=
erface l2tpeth0 (L2TPv3) established with other node into the internet by e=
th0 (WAN), plugged</div><div>with vlan601 (eth1.601) by bridge called &quot=
;br-red&quot;</div>






<div><br></div><div><div><b>root@bahia:~#</b>=C2=A0brctl show</div><div>bri=
dge name<span style=3D"white-space:pre-wrap">	</span>bridge id<span style=
=3D"white-space:pre-wrap">		</span>STP enabled<span style=3D"white-space:pr=
e-wrap">	</span>interfaces</div>






<div><b>root@bahia:~#</b>=C2=A0brctl addbr br-red</div><div><b>root@bahia:~=
#</b>=C2=A0brctl addif br-red eth1.601</div></div><div><b>root@bahia:~#</b>=
<b>=C2=A0</b>ip l2tp add tunnel tunnel_id 45 peer_tunnel_id 42 udp_sport 50=
01 udp_dport 5000 encap udp local 200.243.1.5 remote 200.199.10.12<br>






</div><div><div><b>root@bahia:~#</b><b>=C2=A0</b>ip l2tp add session tunnel=
_id 45 session_id 5196755 peer_session_id 128</div><div><b>root@bahia:~#</b=
>=C2=A0ip link set l2tpeth0 up promisc on master br-red =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0</div>






<div><b>root@bahia:~#</b>=C2=A0ip link set br-red up</div></div><div><b>roo=
t@bahia:~#</b>=C2=A0brctl show br-red<br></div><div><div>bridge name<span s=
tyle=3D"white-space:pre-wrap">	</span>bridge id<span style=3D"white-space:p=
re-wrap">		                </span>STP enabled<span style=3D"white-space:pre=
-wrap">	</span>interfaces</div>






<div>br-red<span style=3D"white-space:pre-wrap">		</span>8000.005056a7134a<=
span style=3D"white-space:pre-wrap">	</span>no<span style=3D"white-space:pr=
e-wrap">	                </span>eth1.601</div><div><span style=3D"white-spa=
ce:pre-wrap">							                                </span>l2tpeth0</div>






</div></div><div><div><b>root@bahia:~#=C2=A0</b>brctl showstp br-red</div><=
div>br-red</div><div>=C2=A0bridge id<span style=3D"white-space:pre-wrap">		=
        </span>8000.005056a7134a</div><div>=C2=A0designated root<span style=
=3D"white-space:pre-wrap">	</span>8000.005056a7134a</div>






<div>=C2=A0root port<span style=3D"white-space:pre-wrap">		</span>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 0<span style=3D"white-space:pre-wrap">			</span>path c=
ost<span style=3D"white-space:pre-wrap">		</span> =C2=A0 0</div><div>=C2=A0=
max age<span style=3D"white-space:pre-wrap">		</span>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 20.00<span style=3D"white-space:pre-wrap">		</span>bridge max age<sp=
an style=3D"white-space:pre-wrap">		</span> =C2=A020.00</div>






<div>=C2=A0hello time<span style=3D"white-space:pre-wrap">		</span>2.00<spa=
n style=3D"white-space:pre-wrap">			</span>bridge hello time<span style=3D"=
white-space:pre-wrap">	</span> =C2=A0 2.00</div><div>=C2=A0forward delay<sp=
an style=3D"white-space:pre-wrap">		</span>15.00<span style=3D"white-space:=
pre-wrap">		</span>bridge forward delay<span style=3D"white-space:pre-wrap"=
>	</span> =C2=A015.00</div>






<div>=C2=A0ageing time<span style=3D"white-space:pre-wrap">		</span> 300.01=
</div><div>=C2=A0hello timer<span style=3D"white-space:pre-wrap">		</span>1=
.06<span style=3D"white-space:pre-wrap">			</span>tcn timer<span style=3D"w=
hite-space:pre-wrap">		</span> =C2=A0 0.00</div>






<div>=C2=A0topology change timer<span style=3D"white-space:pre-wrap">	</spa=
n> =C2=A0 0.00<span style=3D"white-space:pre-wrap">			</span>gc timer<span =
style=3D"white-space:pre-wrap">		</span> =C2=A0 5.08</div><div>=C2=A0flags<=
span style=3D"white-space:pre-wrap">			</span></div>






<div><br></div><div>eth1.601 (1)</div><div>=C2=A0port id<span style=3D"whit=
e-space:pre-wrap">		</span>8001<span style=3D"white-space:pre-wrap">			</sp=
an>state<span style=3D"white-space:pre-wrap">		</span> =C2=A0 =C2=A0 forwar=
ding</div>
<div>=C2=A0designated root<span style=3D"white-space:pre-wrap">	</span>8000=
.005056a7134a<span style=3D"white-space:pre-wrap">	</span>path cost<span st=
yle=3D"white-space:pre-wrap">		</span> =C2=A0 4</div><div>=C2=A0designated =
bridge<span style=3D"white-space:pre-wrap">	</span>8000.005056a7134a<span s=
tyle=3D"white-space:pre-wrap">	</span>message age timer<span style=3D"white=
-space:pre-wrap">	</span> =C2=A0 0.00</div>






<div>=C2=A0designated port<span style=3D"white-space:pre-wrap">	</span>8001=
<span style=3D"white-space:pre-wrap">			</span>forward delay timer<span sty=
le=3D"white-space:pre-wrap">	</span> =C2=A0 0.00</div><div>=C2=A0designated=
 cost<span style=3D"white-space:pre-wrap">	</span> =C2=A0 0<span style=3D"w=
hite-space:pre-wrap">			</span>hold timer<span style=3D"white-space:pre-wra=
p">		</span> =C2=A0 0.06</div>






<div>=C2=A0flags<span style=3D"white-space:pre-wrap">			</span></div><div><=
br></div><div>l2tpeth0 (2)</div><div>=C2=A0port id<span style=3D"white-spac=
e:pre-wrap">		</span>8002<span style=3D"white-space:pre-wrap">			</span>sta=
te<span style=3D"white-space:pre-wrap">		</span> =C2=A0 =C2=A0 forwarding</=
div>






<div>=C2=A0designated root<span style=3D"white-space:pre-wrap">	</span>8000=
.005056a7134a<span style=3D"white-space:pre-wrap">	</span>path cost<span st=
yle=3D"white-space:pre-wrap">		</span> 100</div><div>=C2=A0designated bridg=
e<span style=3D"white-space:pre-wrap">	</span>8000.005056a7134a<span style=
=3D"white-space:pre-wrap">	</span>message age timer<span style=3D"white-spa=
ce:pre-wrap">	</span> =C2=A0 0.00</div>






<div>=C2=A0designated port<span style=3D"white-space:pre-wrap">	</span>8002=
<span style=3D"white-space:pre-wrap">			</span>forward delay timer<span sty=
le=3D"white-space:pre-wrap">	</span> =C2=A0 0.00</div><div>=C2=A0designated=
 cost<span style=3D"white-space:pre-wrap">	</span> =C2=A0 0<span style=3D"w=
hite-space:pre-wrap">			</span>hold timer<span style=3D"white-space:pre-wra=
p">		</span> =C2=A0 0.05</div>






<div>=C2=A0flags<span style=3D"white-space:pre-wrap">			</span></div><div><=
br></div><div><b>root@bahia:~#=C2=A0</b><br></div></div><div><b><br></b></d=
iv><div>it&#39;s ok, my bridge &quot;by-red&quot; listen all traffic over m=
y LAN (vlan 601) and my L2TPv3 over internet. (wan)<b><br>






</b></div><div><b><br></b></div><div><b>root@bahia:~#=C2=A0</b><b>=C2=A0</b=
>tcpdump -nve -i <b>br-red</b> &quot;host 10.251.0.1&quot;<br><div><div>tcp=
dump: WARNING: br-red: no IPv4 address assigned</div><div>tcpdump: listenin=
g on br-red, link-type EN10MB (Ethernet), capture size 65535 bytes</div>






<div>20:58:17.860060 d4:ae:52:84:37:ae &gt; ff:ff:ff:ff:ff:ff, ethertype AR=
P (0x0806), length 60: Ethernet (len 6), IPv4 (len 4), Request who-has 10.2=
51.90.157 tell=C2=A0<b>10.251.0.1</b>, length 46</div><div>20:58:17.980065 =
d4:ae:52:84:37:ae &gt; ff:ff:ff:ff:ff:ff, ethertype ARP (0x0806), length 60=
: Ethernet (len 6), IPv4 (len 4), Request who-has 10.251.153.31 tell=C2=A0<=
b>10.251.0.1</b>, length 46</div>






<div>^C</div><div>7 packets captured</div><div>7 packets received by filter=
</div><div>0 packets dropped by kernel</div><div><b>root@bahia:~#=C2=A0</b>=
</div></div></div></div><div><br></div><div><div>+-------------------------=
----------------------------------------------------------------+</div>






<div>=C2=A0| SERVER B (BRIDGE/L2TPv3 + WIRELESS ACCESS POINT) - RECIFE |</d=
iv><div>+------------------------------------------------------------------=
-----------------------+<br></div></div><div><br></div><div><div><b>root@re=
cife:~#</b> ip addr show eth1 <b># (WAN)</b></div>




<div>3: eth1: &lt;BROADCAST,MULTICAST,UP,LOWER_UP&gt; mtu 1500 qdisc fq_cod=
el state UP qlen 1000</div>

<div>=C2=A0 =C2=A0 link/ether a0:f3:c1:a3:c4:11 brd ff:ff:ff:ff:ff:ff</div>=
<div>=C2=A0 =C2=A0 inet=C2=A0<a href=3D"http://200.199.10.12/21" target=3D"=
_blank">200.199.10.12/21</a> brd=C2=A0200.199.10.255=C2=A0scope global eth1=
</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0valid_lft forever preferred_lft forev=
er</div>






<div>=C2=A0 =C2=A0 inet6 fe80::a2f3:c1ff:fea3:c411/64 scope link=C2=A0</div=
><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0valid_lft forever preferred_lft forever</d=
iv><div><b>root@recife:~#</b> ip route show</div><div>default via=C2=A0200.=
199.10.254=C2=A0dev eth1 =C2=A0proto static=C2=A0</div>






<div><a href=3D"http://200.199.10.0/21" target=3D"_blank">200.199.10.0/21</=
a> dev eth1 =C2=A0proto kernel =C2=A0scope link =C2=A0src 200.199.10.12</di=
v><div><a href=3D"http://192.168.1.0/24" target=3D"_blank">192.168.1.0/24</=
a> dev br-lan =C2=A0proto kernel =C2=A0scope link =C2=A0src 192.168.1.1=C2=
=A0</div>






<div><b>root@recife:~#</b> ip l2tp add tunnel tunnel_id 42 peer_tunnel_id 4=
5 udp_sport 5000 udp_dport 5001 encap udp local=C2=A0200.199.10.12=C2=A0rem=
ote 200.243.1.5</div></div><div><div><b>root@recife:~#</b>=C2=A0ip l2tp add=
 session tunnel_id 42 session_id 128 peer_session_id 5196755</div>






<div><b>root@recife:~#</b>=C2=A0ip link set dev l2tpeth0 up promisc on mast=
er br-red<br></div><div><b>root@recife:~#</b>=C2=A0brctl show</div><div>bri=
dge name =C2=A0 =C2=A0 bridge id =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 STP enabled =C2=A0 =C2=A0 interfaces<br></div><div><div>






br-lan =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A07fff.a0f3c1a3c40f =C2=A0 =C2=A0 =
=C2=A0 no =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0eth0</div><div><b=
>root@recife:~#</b>=C2=A0brctl addbr br-red</div><div><b>root@recife:~#</b>=
=C2=A0brctl addif br-red l2tpeth0</div><div><b>root@recife:~#</b>=C2=A0brct=
l addif br-red wlan0</div>






<div><b>root@recife:~#</b>=C2=A0ifconfig br-red up</div><div><b>root@recife=
:~#</b>=C2=A0ip link set br-red up</div><div><b>root@recife:~#</b>=C2=A0brc=
tl show</div><div>bridge name =C2=A0 =C2=A0 bridge id =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 STP enabled =C2=A0 =C2=A0 =
interfaces</div>






<div>br-lan =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A07fff.a0f=
3c1a3c40f =C2=A0 =C2=A0 =C2=A0 no =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 eth0</div><div>br-red =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A08000.1ae0f4a30221 =C2=A0no =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 l2tpeth0</div><div>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0wlan0</div>






<div><b>root@recife:~#</b>=C2=A0</div></div><div><b><br></b></div><div><b>.=
...::: RESUME :::...</b></div></div><div><br></div><div>1) sorry for the lo=
ng email....</div><div>2) when i&#39;m &quot;recife hostspot&quot;... I can=
 join in wireless &quot;Recife Wireless&quot; from my device, but i can&#39=
;t receive ip from dhcp (10.60.61.1).</div>






<div>3) from &quot;server A[bahia] (bridge with vlan601 network) and &quot;=
server B [recife]&quot;, i can &quot;see/listen&quot; the broadcast request=
 from my</div><div>device mac &quot;5c:95:ae:22:d6:6e&quot; like below.</di=
v>






<div><br></div><div><b>root@bahia:~#=C2=A0</b>tcpdump -nve -i br-red &quot;=
ether host ether 5c:95:ae:22:d6:6e&quot;<br></div><div><div><div>00:08:52.6=
53667 5c:95:ae:22:d6:6e &gt; ff:ff:ff:ff:ff:ff, ethertype IPv4 (0x0800), le=
ngth 342: (tos 0x0, ttl 255, id 37839, offset 0, flags [none], proto UDP (1=
7), length 328)</div>






<div>=C2=A0 =C2=A0 0.0.0.0.68 &gt; 255.255.255.255.67: BOOTP/DHCP, Request =
from 5c:95:ae:22:d6:6e, length 300, xid 0xe6f1d0a5, Flags [none]</div><div>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Client-Ethernet-Address 5c:95:ae:22:d6:6=
e</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Vendor-rfc1048 Extensions</d=
iv>






<div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Magic Cookie 0x63825363</div=
><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DHCP-Message Option 53, len=
gth 1: Discover</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Paramet=
er-Request Option 55, length 6:</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 Subnet-Mask, Default-Gateway, Domain-Name-Server, Domain-=
Name</div>






<div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Option 119, Option 25=
2</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MSZ Option 57, length=
 2: 1500</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Client-ID Opti=
on 61, length 7: ether 5c:95:ae:22:d6:6e</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 Lease-Time Option 51, length 4: 7776000</div>






<div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Hostname Option 12, length 1=
4: &quot;Straces-iPhone&quot;</div></div><div>^C</div><div>1 packets captur=
ed</div><div>1 packets received by filter</div></div><div><b>root@bahia:~#<=
/b><br></div><div><br></div>






<div>same thing result at &quot;bridge a&quot; (<b>root@recife:~#)=C2=A0</b=
>side...</div><div><br></div><div>4)=C2=A0the strangest thing of all and th=
at, from bridge-b (recife). i can get ip from dhcp/broadcast request over L=
2TPv3...=C2=A0</div>



<div>but without option &quot;broadcast&quot; i can&#39;t receive ip from d=
hcp (10.61.60.1)</div><div><br></div><div><div><b>root@recife:~#</b> udhcpc=
 -B -i br-red</div><div>udhcpc (v1.19.4) started</div><div>Sending discover=
...</div>



<div>Sending select for 10.251.157.22...</div><div>Lease of 10.251.157.22 o=
btained, lease time 300</div><div>udhcpc: ifconfig br-red 10.251.157.22 net=
mask 255.255.0.0 broadcast +</div><div>udhcpc: setting default routers: 10.=
251.0.1</div>



<div><b>root@recife:~#=C2=A0</b>ip route add 200.243.1.5 via=C2=A0200.199.1=
0.254=C2=A0dev eth1</div></div><div><div><b>root@recife:~# </b>ip route sho=
w</div><div>default via 10.251.0.1 dev br-red=C2=A0</div><div><a href=3D"ht=
tp://10.251.0.0/16" target=3D"_blank">10.251.0.0/16</a> dev br-red =C2=A0pr=
oto kernel =C2=A0scope link =C2=A0src 10.251.157.22=C2=A0</div>



<div><a href=3D"http://200.199.10.0/21" target=3D"_blank">200.199.10.0/21</=
a> dev eth1 =C2=A0proto kernel =C2=A0scope link =C2=A0src 200.199.10.12</di=
v><div>200.243.1.5 via=C2=A0200.199.10.254=C2=A0dev eth1=C2=A0</div><div><a=
 href=3D"http://192.168.1.0/24" target=3D"_blank">192.168.1.0/24</a> dev br=
-lan =C2=A0proto kernel =C2=A0scope link =C2=A0src 192.168.1.1=C2=A0</div>



<div><b>root@recife:~#</b> ping -c2 10.251.0.1<br></div></div><div><div>PIN=
G 10.251.0.1 (10.251.0.1): 56 data bytes</div><div><br></div><div>--- 10.25=
1.0.1 ping statistics ---</div><div>2 packets transmitted, 0 packets receiv=
ed, 100% packet loss</div>



<div><b>root@recife:~#</b><br></div></div><div><br></div><div>5) output of =
tcpdump listen the bridge &quot;br-red&quot;=C2=A0request from bridge-a-nat=
al=C2=A0<a href=3D"http://pastebin.com/t8wn3zRK" target=3D"_blank">http://p=
astebin.com/t8wn3zRK</a><br>






</div><div>6) output of tcpdump listen the bridge &quot;br-red&quot; reques=
t from bridge-b-recife=C2=A0<a href=3D"http://pastebin.com/njTQfd5k" target=
=3D"_blank">http://pastebin.com/njTQfd5k</a><br></div><div><div>7) after se=
veral researches i found the kernel options to set like &quot;arp_filter&qu=
ot;, &quot;bridge-nf-*&quot;,... but i don&#39;t have</div>






<div>idea which option should enable / disable. tried some combinations but=
 without success....</div></div><div>8) the DHCP-OFFER doesn&#39;t forward =
by &quot;bridge-a&quot;... =C2=A0problems with unicast? multicast? arp_prox=
y? ....</div>




<div>9) we need join in the network by wireless and access the server 10.25=
1.0.1 over bridge/l2tpv3 (unmanaged)</div>

<div>10) in our case, can use only L2TPv3. (may not be OpenVPN, ...)</div><=
div>11) all is Linux, without any iptables rules.</div><div>12)=C2=A0who wi=
ll win a beer?! =3D]</div><div><br></div><div>Best regards,</div><div>Jorge=
 Pereira</div>



</div>

</div>
</blockquote></div><br></div>

--047d7b15fc2d590a0e04e4969a1a--
