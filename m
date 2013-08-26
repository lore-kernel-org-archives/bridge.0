Return-Path: <aenertia@aenertia.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=aenertia.net; s=dkimaenertianet;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=gdfFKRzlJPNrAL9daQ5ZBEcdr5+lz+tz5RH4Xj1AxNI=;
	b=gWBcvNF+YJ6Yb5J9KFWG3yD0pT0i4hpImMl/GD/HdgAdy/fiUaNWi58Sgr1ymImnCp
	nTegSFnAlxC+guH7nLGR79BNJZ2wmoqGnJSpHAjPEuC6GcuJtT52dtaY1kgZUbEpfHAn
	abyH0vANh2kbj8Mout6omHnx32J/v17wKpUqo=
MIME-Version: 1.0
Sender: aenertia@aenertia.net
In-Reply-To: <CABvP5W1jER8Db_XbHxUioz+h4RgZAOVWi3n4QH7R+qRp41tzNw@mail.gmail.com>
References: <CABvP5W17XQ16mRsVhTFEUf9AbyGd+WQSV0hBozDy3rANUSKofw@mail.gmail.com>
	<CAKiAkGTtgBXU9fQbvzoXPC+DO+DtM0xG73psUCDE43CgvK62oQ@mail.gmail.com>
	<CABvP5W1jER8Db_XbHxUioz+h4RgZAOVWi3n4QH7R+qRp41tzNw@mail.gmail.com>
From: =?UTF-8?Q?Joel_Wir=C4=81mu_Pauling?= <joel@aenertia.net>
Date: Mon, 26 Aug 2013 12:06:14 +1200
Message-ID: <CAKiAkGTdiV5NwEaEjWMmY1cgjbyA1+gox2q7-ckVGZ1x199QXQ@mail.gmail.com>
Content-Type: multipart/alternative; boundary=bcaec5299c93820c7904e4ce87be
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
Cc: Openl2tp-users@lists.sourceforge.net, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, lartc <lartc@vger.kernel.org>

--bcaec5299c93820c7904e4ce87be
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

What are your MTU settings?

All interfaces inside a bridge must have the the MTU of the smallest ; in
some versions of bridge-utils you can add mismatched interface mtu's and
everything breaks.

Also are all your tap devices over proper ethernet segments? As soon as you
have a Wireless segment then it will break (due to the WLAN layer2 frames
overwriting mac's / remembering only the point to point mac's).


On 26 August 2013 11:54, Jorge Pereira <jpereiran@gmail.com> wrote:

> Hi Joel,
>
> thanks for your answer!! but i CAN'T understand why my bridge (SERVER
> A) don't forward the arp-request
> from LAN to my other side of L2TPv3 (SERVER B).... so, all i need it's
> that my 'bridge' forward (broadcast, anycast, unicast, arp, ...)
> everything to other side of L2TPv3 bridge... let me try to explain
> below...
>
> e.g:
>
> +------------------------------------------------+
> | Bahia: lan network 10.251.0.0/16 |
> +------------------------------------------------+
>  |
>  |      +-----------------------------+
>  +--> | Bridge   A               |
>         | LAN: bridge/promisc|
>         | WAN: 200.199.10.1 |
>  +---- +-----------------------------+
>  |
>  |
>  \     +--------------------------------------------------------+
>   +---| L2TPv3 / promisc / l2tpeth0 over WAN |
>  /     +--------------------------------------------------------+
>  |
>  |      +-----------------------------+
>  +--> | Bridge   B               |
>         | LAN: bridge/promisc|
>         | WAN: 200.199.10.2 |
> +-----+-----------------------------+
> |
> +-------------------------------------------------+
> | Recife: lan network 10.251.0.0/16 |
> +-------------------------------------------------+
>
> e.g - 1: from side 'B', i can send icmp request to anyone in
> 10.251.0.0/16. but can't receive response because
> my bridge A ignore/discard all packets arp/unicast/...  and does not
> forward to Bridge B. only broadcast!
>
> e.g - 2: (sysct/proxy_arp) don't solves my problem... if somebody have
> any suggestion, please! tell me! :)
>
>
> On Fri, Aug 23, 2013 at 2:22 AM, Joel Wir=C4=81mu Pauling <joel@aenertia.=
net>
> wrote:
> > You can't bridge 802.11 segments with normal ethernet segments. Wifi AP=
's
> > that do this use magic; or hidden pesudo bridges to do the same.
> >
> > You will need to use something like relayd to form a psuedo bridge
> between
> > your wired and wireless segments or use routing.
> >
> >
> > -Joel
> >
> >
> > On 23 August 2013 14:21, Jorge Pereira <jpereiran@gmail.com> wrote:
> >>
> >> hi everyone,
> >>
> >>     so,first it seemed a trivial question to me, but since I could not
> >> find anybody being neither able to answer
> >> this question nor giving a short config example. after a few sleepless
> >> nights and exhausting all the reading
> >> and research. here I am sharing my problem with all of you, in the hop=
e
> of
> >> some possible solution/sugestion.
> >> or is it that this is impossible??
> >>
> >> below my scheme/layout.
> >>
> >> +---------------------------------------------------------+
> >> | MAIN SERVER - 10.60.61.1 (DHCP SERVER) |
> >> +---------------------------------------------------------+
> >>                      |
> >> +---------------------------+
> >> |    NETWORK vlan601 |
> >> |  net 10.251.0.0/16      |
> >> |  gw:10.251.0.1            |
> >> +---------------------------+
> >>                     |
> >> +------------------------------------------------------------------+
> >>  | SERVER B (BRIDGE / unmanaged L2TPv3) - BAHIA |
> >> +------------------------------------------------------------------+
> >>
> >> root@bahia:~#  ip -d addr show eth0 # WAN
> >> 2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast
> state
> >> UP qlen 1000
> >>     link/ether 00:50:56:a7:13:49 brd ff:ff:ff:ff:ff:ff
> >>     inet 200.243.1.5/24 brd 200.243.1.255 scope global eth0
> >>     inet6 fe80::250:56ff:fea7:1349/64 scope link
> >>        valid_lft forever preferred_lft forever
> >> root@bahia:~#  ip -d addr show eth1 # LAN (VLAN/TRUNK)
> >> 3: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast
> state
> >> UP qlen 1000
> >>     link/ether 00:50:56:a7:13:4a brd ff:ff:ff:ff:ff:ff
> >>     inet6 fe80::250:56ff:fea7:134a/64 scope link
> >>        valid_lft forever preferred_lft forever
> >> root@bahia:~#  ip link add link eth1 name eth1.601 mtu 1500 type vlan
> id
> >> 601
> >> root@bahia:~#  ip link set dev eth1.601 up promisc on
> >> root@bahia:~#  ip -d addr show eth1.601
> >> 9: eth1.601@eth1: <BROADCAST,MULTICAST,PROMISC,UP,LOWER_UP> mtu 1500
> qdisc
> >> noqueue state UP
> >>     link/ether 00:50:56:a7:13:4a brd ff:ff:ff:ff:ff:ff
> >>     inet6 fe80::250:56ff:fea7:134a/64 scope link
> >>        valid_lft forever preferred_lft forever
> >> root@bahia:~#  ip route show
> >> default via 200.243.1.254 dev eth0
> >> 200.243.1.0/24 dev eth0  proto kernel  scope link  src 200.243.1.5
> >> root@bahia:~#
> >>
> >> and.... we've the interface l2tpeth0 (L2TPv3) established with other
> node
> >> into the internet by eth0 (WAN), plugged
> >> with vlan601 (eth1.601) by bridge called "br-red"
> >>
> >> root@bahia:~# brctl show
> >> bridge name bridge id STP enabled interfaces
> >> root@bahia:~# brctl addbr br-red
> >> root@bahia:~# brctl addif br-red eth1.601
> >> root@bahia:~# ip l2tp add tunnel tunnel_id 45 peer_tunnel_id 42
> udp_sport
> >> 5001 udp_dport 5000 encap udp local 200.243.1.5 remote 200.199.10.12
> >> root@bahia:~# ip l2tp add session tunnel_id 45 session_id 5196755
> >> peer_session_id 128
> >> root@bahia:~# ip link set l2tpeth0 up promisc on master br-red
> >> root@bahia:~# ip link set br-red up
> >> root@bahia:~# brctl show br-red
> >> bridge name bridge id STP enabled interfaces
> >> br-red 8000.005056a7134a no eth1.601
> >> l2tpeth0
> >> root@bahia:~# brctl showstp br-red
> >> br-red
> >>  bridge id 8000.005056a7134a
> >>  designated root 8000.005056a7134a
> >>  root port         0 path cost   0
> >>  max age         20.00 bridge max age  20.00
> >>  hello time 2.00 bridge hello time   2.00
> >>  forward delay 15.00 bridge forward delay  15.00
> >>  ageing time 300.01
> >>  hello timer 1.06 tcn timer   0.00
> >>  topology change timer   0.00 gc timer   5.08
> >>  flags
> >>
> >> eth1.601 (1)
> >>  port id 8001 state     forwarding
> >>  designated root 8000.005056a7134a path cost   4
> >>  designated bridge 8000.005056a7134a message age timer   0.00
> >>  designated port 8001 forward delay timer   0.00
> >>  designated cost   0 hold timer   0.06
> >>  flags
> >>
> >> l2tpeth0 (2)
> >>  port id 8002 state     forwarding
> >>  designated root 8000.005056a7134a path cost 100
> >>  designated bridge 8000.005056a7134a message age timer   0.00
> >>  designated port 8002 forward delay timer   0.00
> >>  designated cost   0 hold timer   0.05
> >>  flags
> >>
> >> root@bahia:~#
> >>
> >> it's ok, my bridge "by-red" listen all traffic over my LAN (vlan 601)
> and
> >> my L2TPv3 over internet. (wan)
> >>
> >> root@bahia:~#  tcpdump -nve -i br-red "host 10.251.0.1"
> >> tcpdump: WARNING: br-red: no IPv4 address assigned
> >> tcpdump: listening on br-red, link-type EN10MB (Ethernet), capture siz=
e
> >> 65535 bytes
> >> 20:58:17.860060 d4:ae:52:84:37:ae > ff:ff:ff:ff:ff:ff, ethertype ARP
> >> (0x0806), length 60: Ethernet (len 6), IPv4 (len 4), Request who-has
> >> 10.251.90.157 tell 10.251.0.1, length 46
> >> 20:58:17.980065 d4:ae:52:84:37:ae > ff:ff:ff:ff:ff:ff, ethertype ARP
> >> (0x0806), length 60: Ethernet (len 6), IPv4 (len 4), Request who-has
> >> 10.251.153.31 tell 10.251.0.1, length 46
> >> ^C
> >> 7 packets captured
> >> 7 packets received by filter
> >> 0 packets dropped by kernel
> >> root@bahia:~#
> >>
> >>
> >>
> +------------------------------------------------------------------------=
-----------------+
> >>  | SERVER B (BRIDGE/L2TPv3 + WIRELESS ACCESS POINT) - RECIFE |
> >>
> >>
> +------------------------------------------------------------------------=
-----------------+
> >>
> >> root@recife:~# ip addr show eth1 # (WAN)
> >> 3: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel sta=
te
> >> UP qlen 1000
> >>     link/ether a0:f3:c1:a3:c4:11 brd ff:ff:ff:ff:ff:ff
> >>     inet 200.199.10.12/21 brd 200.199.10.255 scope global eth1
> >>        valid_lft forever preferred_lft forever
> >>     inet6 fe80::a2f3:c1ff:fea3:c411/64 scope link
> >>        valid_lft forever preferred_lft forever
> >> root@recife:~# ip route show
> >> default via 200.199.10.254 dev eth1  proto static
> >> 200.199.10.0/21 dev eth1  proto kernel  scope link  src 200.199.10.12
> >> 192.168.1.0/24 dev br-lan  proto kernel  scope link  src 192.168.1.1
> >> root@recife:~# ip l2tp add tunnel tunnel_id 42 peer_tunnel_id 45
> udp_sport
> >> 5000 udp_dport 5001 encap udp local 200.199.10.12 remote 200.243.1.5
> >> root@recife:~# ip l2tp add session tunnel_id 42 session_id 128
> >> peer_session_id 5196755
> >> root@recife:~# ip link set dev l2tpeth0 up promisc on master br-red
> >> root@recife:~# brctl show
> >> bridge name     bridge id               STP enabled     interfaces
> >> br-lan          7fff.a0f3c1a3c40f       no              eth0
> >> root@recife:~# brctl addbr br-red
> >> root@recife:~# brctl addif br-red l2tpeth0
> >> root@recife:~# brctl addif br-red wlan0
> >> root@recife:~# ifconfig br-red up
> >> root@recife:~# ip link set br-red up
> >> root@recife:~# brctl show
> >> bridge name     bridge id                     STP enabled     interfac=
es
> >> br-lan                7fff.a0f3c1a3c40f       no
> eth0
> >> br-red                8000.1ae0f4a30221  no                     l2tpet=
h0
> >>
> >> wlan0
> >> root@recife:~#
> >>
> >> ....::: RESUME :::...
> >>
> >> 1) sorry for the long email....
> >> 2) when i'm "recife hostspot"... I can join in wireless "Recife
> Wireless"
> >> from my device, but i can't receive ip from dhcp (10.60.61.1).
> >> 3) from "server A[bahia] (bridge with vlan601 network) and "server B
> >> [recife]", i can "see/listen" the broadcast request from my
> >> device mac "5c:95:ae:22:d6:6e" like below.
> >>
> >> root@bahia:~# tcpdump -nve -i br-red "ether host ether
> 5c:95:ae:22:d6:6e"
> >> 00:08:52.653667 5c:95:ae:22:d6:6e > ff:ff:ff:ff:ff:ff, ethertype IPv4
> >> (0x0800), length 342: (tos 0x0, ttl 255, id 37839, offset 0, flags
> [none],
> >> proto UDP (17), length 328)
> >>     0.0.0.0.68 > 255.255.255.255.67: BOOTP/DHCP, Request from
> >> 5c:95:ae:22:d6:6e, length 300, xid 0xe6f1d0a5, Flags [none]
> >>           Client-Ethernet-Address 5c:95:ae:22:d6:6e
> >>           Vendor-rfc1048 Extensions
> >>             Magic Cookie 0x63825363
> >>             DHCP-Message Option 53, length 1: Discover
> >>             Parameter-Request Option 55, length 6:
> >>               Subnet-Mask, Default-Gateway, Domain-Name-Server,
> >> Domain-Name
> >>               Option 119, Option 252
> >>             MSZ Option 57, length 2: 1500
> >>             Client-ID Option 61, length 7: ether 5c:95:ae:22:d6:6e
> >>             Lease-Time Option 51, length 4: 7776000
> >>             Hostname Option 12, length 14: "Straces-iPhone"
> >> ^C
> >> 1 packets captured
> >> 1 packets received by filter
> >> root@bahia:~#
> >>
> >> same thing result at "bridge a" (root@recife:~#) side...
> >>
> >> 4) the strangest thing of all and that, from bridge-b (recife). i can
> get
> >> ip from dhcp/broadcast request over L2TPv3...
> >> but without option "broadcast" i can't receive ip from dhcp (10.61.60.=
1)
> >>
> >> root@recife:~# udhcpc -B -i br-red
> >> udhcpc (v1.19.4) started
> >> Sending discover...
> >> Sending select for 10.251.157.22...
> >> Lease of 10.251.157.22 obtained, lease time 300
> >> udhcpc: ifconfig br-red 10.251.157.22 netmask 255.255.0.0 broadcast +
> >> udhcpc: setting default routers: 10.251.0.1
> >> root@recife:~# ip route add 200.243.1.5 via 200.199.10.254 dev eth1
> >> root@recife:~# ip route show
> >> default via 10.251.0.1 dev br-red
> >> 10.251.0.0/16 dev br-red  proto kernel  scope link  src 10.251.157.22
> >> 200.199.10.0/21 dev eth1  proto kernel  scope link  src 200.199.10.12
> >> 200.243.1.5 via 200.199.10.254 dev eth1
> >> 192.168.1.0/24 dev br-lan  proto kernel  scope link  src 192.168.1.1
> >> root@recife:~# ping -c2 10.251.0.1
> >> PING 10.251.0.1 (10.251.0.1): 56 data bytes
> >>
> >> --- 10.251.0.1 ping statistics ---
> >> 2 packets transmitted, 0 packets received, 100% packet loss
> >> root@recife:~#
> >>
> >> 5) output of tcpdump listen the bridge "br-red" request from
> >> bridge-a-natal http://pastebin.com/t8wn3zRK
> >> 6) output of tcpdump listen the bridge "br-red" request from
> >> bridge-b-recife http://pastebin.com/njTQfd5k
> >> 7) after several researches i found the kernel options to set like
> >> "arp_filter", "bridge-nf-*",... but i don't have
> >> idea which option should enable / disable. tried some combinations but
> >> without success....
> >> 8) the DHCP-OFFER doesn't forward by "bridge-a"...  problems with
> unicast?
> >> multicast? arp_proxy? ....
> >> 9) we need join in the network by wireless and access the server
> >> 10.251.0.1 over bridge/l2tpv3 (unmanaged)
> >> 10) in our case, can use only L2TPv3. (may not be OpenVPN, ...)
> >> 11) all is Linux, without any iptables rules.
> >> 12) who will win a beer?! =3D]
> >>
> >> Best regards,
> >> Jorge Pereira
> >
> >
>

--bcaec5299c93820c7904e4ce87be
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>What are your MTU settings?<br><br></div>All interfac=
es inside a bridge must have the the MTU of the smallest ; in some versions=
 of bridge-utils you can add mismatched interface mtu&#39;s and everything =
breaks.<br>

<br>Also are all your tap devices over proper ethernet segments? As soon as=
 you have a Wireless segment then it will break (due to the WLAN layer2 fra=
mes overwriting mac&#39;s / remembering only the point to point mac&#39;s).=
<br>

</div><div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">On 26 A=
ugust 2013 11:54, Jorge Pereira <span dir=3D"ltr">&lt;<a href=3D"mailto:jpe=
reiran@gmail.com" target=3D"_blank">jpereiran@gmail.com</a>&gt;</span> wrot=
e:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Hi Joel,<br>
<br>
thanks for your answer!! but i CAN&#39;T understand why my bridge (SERVER<b=
r>
A) don&#39;t forward the arp-request<br>
from LAN to my other side of L2TPv3 (SERVER B).... so, all i need it&#39;s<=
br>
that my &#39;bridge&#39; forward (broadcast, anycast, unicast, arp, ...)<br=
>
everything to other side of L2TPv3 bridge... let me try to explain<br>
below...<br>
<br>
e.g:<br>
<br>
+------------------------------------------------+<br>
| Bahia: lan network <a href=3D"http://10.251.0.0/16" target=3D"_blank">10.=
251.0.0/16</a> |<br>
+------------------------------------------------+<br>
=C2=A0|<br>
=C2=A0| =C2=A0 =C2=A0 =C2=A0+-----------------------------+<br>
=C2=A0+--&gt; | Bridge =C2=A0 A =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 | LAN: bridge/promisc|<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 | WAN: 200.199.10.1 |<br>
=C2=A0+---- +-----------------------------+<br>
=C2=A0|<br>
=C2=A0|<br>
=C2=A0\ =C2=A0 =C2=A0 +----------------------------------------------------=
----+<br>
=C2=A0 +---| L2TPv3 / promisc / l2tpeth0 over WAN |<br>
=C2=A0/ =C2=A0 =C2=A0 +----------------------------------------------------=
----+<br>
=C2=A0|<br>
=C2=A0| =C2=A0 =C2=A0 =C2=A0+-----------------------------+<br>
=C2=A0+--&gt; | Bridge =C2=A0 B =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 | LAN: bridge/promisc|<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 | WAN: 200.199.10.2 |<br>
+-----+-----------------------------+<br>
|<br>
+-------------------------------------------------+<br>
| Recife: lan network <a href=3D"http://10.251.0.0/16" target=3D"_blank">10=
.251.0.0/16</a> |<br>
+-------------------------------------------------+<br>
<br>
e.g - 1: from side &#39;B&#39;, i can send icmp request to anyone in<br>
<a href=3D"http://10.251.0.0/16" target=3D"_blank">10.251.0.0/16</a>. but c=
an&#39;t receive response because<br>
my bridge A ignore/discard all packets arp/unicast/... =C2=A0and does not<b=
r>
forward to Bridge B. only broadcast!<br>
<br>
e.g - 2: (sysct/proxy_arp) don&#39;t solves my problem... if somebody have<=
br>
any suggestion, please! tell me! :)<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
<br>
On Fri, Aug 23, 2013 at 2:22 AM, Joel Wir=C4=81mu Pauling &lt;<a href=3D"ma=
ilto:joel@aenertia.net">joel@aenertia.net</a>&gt; wrote:<br>
&gt; You can&#39;t bridge 802.11 segments with normal ethernet segments. Wi=
fi AP&#39;s<br>
&gt; that do this use magic; or hidden pesudo bridges to do the same.<br>
&gt;<br>
&gt; You will need to use something like relayd to form a psuedo bridge bet=
ween<br>
&gt; your wired and wireless segments or use routing.<br>
&gt;<br>
&gt;<br>
&gt; -Joel<br>
&gt;<br>
&gt;<br>
&gt; On 23 August 2013 14:21, Jorge Pereira &lt;<a href=3D"mailto:jpereiran=
@gmail.com">jpereiran@gmail.com</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; hi everyone,<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 so,first it seemed a trivial question to me, but sin=
ce I could not<br>
&gt;&gt; find anybody being neither able to answer<br>
&gt;&gt; this question nor giving a short config example. after a few sleep=
less<br>
&gt;&gt; nights and exhausting all the reading<br>
&gt;&gt; and research. here I am sharing my problem with all of you, in the=
 hope of<br>
&gt;&gt; some possible solution/sugestion.<br>
&gt;&gt; or is it that this is impossible??<br>
&gt;&gt;<br>
&gt;&gt; below my scheme/layout.<br>
&gt;&gt;<br>
&gt;&gt; +---------------------------------------------------------+<br>
&gt;&gt; | MAIN SERVER - 10.60.61.1 (DHCP SERVER) |<br>
&gt;&gt; +---------------------------------------------------------+<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|<br>
&gt;&gt; +---------------------------+<br>
&gt;&gt; | =C2=A0 =C2=A0NETWORK vlan601 |<br>
&gt;&gt; | =C2=A0net <a href=3D"http://10.251.0.0/16" target=3D"_blank">10.=
251.0.0/16</a> =C2=A0 =C2=A0 =C2=A0|<br>
&gt;&gt; | =C2=A0gw:10.251.0.1 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|<b=
r>
&gt;&gt; +---------------------------+<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |<br>
&gt;&gt; +-----------------------------------------------------------------=
-+<br>
&gt;&gt; =C2=A0| SERVER B (BRIDGE / unmanaged L2TPv3) - BAHIA |<br>
&gt;&gt; +-----------------------------------------------------------------=
-+<br>
&gt;&gt;<br>
&gt;&gt; root@bahia:~# =C2=A0ip -d addr show eth0 # WAN<br>
&gt;&gt; 2: eth0: &lt;BROADCAST,MULTICAST,UP,LOWER_UP&gt; mtu 1500 qdisc pf=
ifo_fast state<br>
&gt;&gt; UP qlen 1000<br>
&gt;&gt; =C2=A0 =C2=A0 link/ether 00:50:56:a7:13:49 brd ff:ff:ff:ff:ff:ff<b=
r>
&gt;&gt; =C2=A0 =C2=A0 inet <a href=3D"http://200.243.1.5/24" target=3D"_bl=
ank">200.243.1.5/24</a> brd 200.243.1.255 scope global eth0<br>
&gt;&gt; =C2=A0 =C2=A0 inet6 fe80::250:56ff:fea7:1349/64 scope link<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0valid_lft forever preferred_lft forever=
<br>
&gt;&gt; root@bahia:~# =C2=A0ip -d addr show eth1 # LAN (VLAN/TRUNK)<br>
&gt;&gt; 3: eth1: &lt;BROADCAST,MULTICAST,UP,LOWER_UP&gt; mtu 1500 qdisc pf=
ifo_fast state<br>
&gt;&gt; UP qlen 1000<br>
&gt;&gt; =C2=A0 =C2=A0 link/ether 00:50:56:a7:13:4a brd ff:ff:ff:ff:ff:ff<b=
r>
&gt;&gt; =C2=A0 =C2=A0 inet6 fe80::250:56ff:fea7:134a/64 scope link<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0valid_lft forever preferred_lft forever=
<br>
&gt;&gt; root@bahia:~# =C2=A0ip link add link eth1 name eth1.601 mtu 1500 t=
ype vlan id<br>
&gt;&gt; 601<br>
&gt;&gt; root@bahia:~# =C2=A0ip link set dev eth1.601 up promisc on<br>
&gt;&gt; root@bahia:~# =C2=A0ip -d addr show eth1.601<br>
&gt;&gt; 9: eth1.601@eth1: &lt;BROADCAST,MULTICAST,PROMISC,UP,LOWER_UP&gt; =
mtu 1500 qdisc<br>
&gt;&gt; noqueue state UP<br>
&gt;&gt; =C2=A0 =C2=A0 link/ether 00:50:56:a7:13:4a brd ff:ff:ff:ff:ff:ff<b=
r>
&gt;&gt; =C2=A0 =C2=A0 inet6 fe80::250:56ff:fea7:134a/64 scope link<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0valid_lft forever preferred_lft forever=
<br>
&gt;&gt; root@bahia:~# =C2=A0ip route show<br>
&gt;&gt; default via 200.243.1.254 dev eth0<br>
&gt;&gt; <a href=3D"http://200.243.1.0/24" target=3D"_blank">200.243.1.0/24=
</a> dev eth0 =C2=A0proto kernel =C2=A0scope link =C2=A0src 200.243.1.5<br>
&gt;&gt; root@bahia:~#<br>
&gt;&gt;<br>
&gt;&gt; and.... we&#39;ve the interface l2tpeth0 (L2TPv3) established with=
 other node<br>
&gt;&gt; into the internet by eth0 (WAN), plugged<br>
&gt;&gt; with vlan601 (eth1.601) by bridge called &quot;br-red&quot;<br>
&gt;&gt;<br>
&gt;&gt; root@bahia:~# brctl show<br>
&gt;&gt; bridge name bridge id STP enabled interfaces<br>
&gt;&gt; root@bahia:~# brctl addbr br-red<br>
&gt;&gt; root@bahia:~# brctl addif br-red eth1.601<br>
&gt;&gt; root@bahia:~# ip l2tp add tunnel tunnel_id 45 peer_tunnel_id 42 ud=
p_sport<br>
&gt;&gt; 5001 udp_dport 5000 encap udp local 200.243.1.5 remote 200.199.10.=
12<br>
&gt;&gt; root@bahia:~# ip l2tp add session tunnel_id 45 session_id 5196755<=
br>
&gt;&gt; peer_session_id 128<br>
&gt;&gt; root@bahia:~# ip link set l2tpeth0 up promisc on master br-red<br>
&gt;&gt; root@bahia:~# ip link set br-red up<br>
&gt;&gt; root@bahia:~# brctl show br-red<br>
&gt;&gt; bridge name bridge id STP enabled interfaces<br>
&gt;&gt; br-red 8000.005056a7134a no eth1.601<br>
&gt;&gt; l2tpeth0<br>
&gt;&gt; root@bahia:~# brctl showstp br-red<br>
&gt;&gt; br-red<br>
&gt;&gt; =C2=A0bridge id 8000.005056a7134a<br>
&gt;&gt; =C2=A0designated root 8000.005056a7134a<br>
&gt;&gt; =C2=A0root port =C2=A0 =C2=A0 =C2=A0 =C2=A0 0 path cost =C2=A0 0<b=
r>
&gt;&gt; =C2=A0max age =C2=A0 =C2=A0 =C2=A0 =C2=A0 20.00 bridge max age =C2=
=A020.00<br>
&gt;&gt; =C2=A0hello time 2.00 bridge hello time =C2=A0 2.00<br>
&gt;&gt; =C2=A0forward delay 15.00 bridge forward delay =C2=A015.00<br>
&gt;&gt; =C2=A0ageing time 300.01<br>
&gt;&gt; =C2=A0hello timer 1.06 tcn timer =C2=A0 0.00<br>
&gt;&gt; =C2=A0topology change timer =C2=A0 0.00 gc timer =C2=A0 5.08<br>
&gt;&gt; =C2=A0flags<br>
&gt;&gt;<br>
&gt;&gt; eth1.601 (1)<br>
&gt;&gt; =C2=A0port id 8001 state =C2=A0 =C2=A0 forwarding<br>
&gt;&gt; =C2=A0designated root 8000.005056a7134a path cost =C2=A0 4<br>
&gt;&gt; =C2=A0designated bridge 8000.005056a7134a message age timer =C2=A0=
 0.00<br>
&gt;&gt; =C2=A0designated port 8001 forward delay timer =C2=A0 0.00<br>
&gt;&gt; =C2=A0designated cost =C2=A0 0 hold timer =C2=A0 0.06<br>
&gt;&gt; =C2=A0flags<br>
&gt;&gt;<br>
&gt;&gt; l2tpeth0 (2)<br>
&gt;&gt; =C2=A0port id 8002 state =C2=A0 =C2=A0 forwarding<br>
&gt;&gt; =C2=A0designated root 8000.005056a7134a path cost 100<br>
&gt;&gt; =C2=A0designated bridge 8000.005056a7134a message age timer =C2=A0=
 0.00<br>
&gt;&gt; =C2=A0designated port 8002 forward delay timer =C2=A0 0.00<br>
&gt;&gt; =C2=A0designated cost =C2=A0 0 hold timer =C2=A0 0.05<br>
&gt;&gt; =C2=A0flags<br>
&gt;&gt;<br>
&gt;&gt; root@bahia:~#<br>
&gt;&gt;<br>
&gt;&gt; it&#39;s ok, my bridge &quot;by-red&quot; listen all traffic over =
my LAN (vlan 601) and<br>
&gt;&gt; my L2TPv3 over internet. (wan)<br>
&gt;&gt;<br>
&gt;&gt; root@bahia:~# =C2=A0tcpdump -nve -i br-red &quot;host 10.251.0.1&q=
uot;<br>
&gt;&gt; tcpdump: WARNING: br-red: no IPv4 address assigned<br>
&gt;&gt; tcpdump: listening on br-red, link-type EN10MB (Ethernet), capture=
 size<br>
&gt;&gt; 65535 bytes<br>
&gt;&gt; 20:58:17.860060 d4:ae:52:84:37:ae &gt; ff:ff:ff:ff:ff:ff, ethertyp=
e ARP<br>
&gt;&gt; (0x0806), length 60: Ethernet (len 6), IPv4 (len 4), Request who-h=
as<br>
&gt;&gt; 10.251.90.157 tell 10.251.0.1, length 46<br>
&gt;&gt; 20:58:17.980065 d4:ae:52:84:37:ae &gt; ff:ff:ff:ff:ff:ff, ethertyp=
e ARP<br>
&gt;&gt; (0x0806), length 60: Ethernet (len 6), IPv4 (len 4), Request who-h=
as<br>
&gt;&gt; 10.251.153.31 tell 10.251.0.1, length 46<br>
&gt;&gt; ^C<br>
&gt;&gt; 7 packets captured<br>
&gt;&gt; 7 packets received by filter<br>
&gt;&gt; 0 packets dropped by kernel<br>
&gt;&gt; root@bahia:~#<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; +-----------------------------------------------------------------=
------------------------+<br>
&gt;&gt; =C2=A0| SERVER B (BRIDGE/L2TPv3 + WIRELESS ACCESS POINT) - RECIFE =
|<br>
&gt;&gt;<br>
&gt;&gt; +-----------------------------------------------------------------=
------------------------+<br>
&gt;&gt;<br>
&gt;&gt; root@recife:~# ip addr show eth1 # (WAN)<br>
&gt;&gt; 3: eth1: &lt;BROADCAST,MULTICAST,UP,LOWER_UP&gt; mtu 1500 qdisc fq=
_codel state<br>
&gt;&gt; UP qlen 1000<br>
&gt;&gt; =C2=A0 =C2=A0 link/ether a0:f3:c1:a3:c4:11 brd ff:ff:ff:ff:ff:ff<b=
r>
&gt;&gt; =C2=A0 =C2=A0 inet <a href=3D"http://200.199.10.12/21" target=3D"_=
blank">200.199.10.12/21</a> brd 200.199.10.255 scope global eth1<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0valid_lft forever preferred_lft forever=
<br>
&gt;&gt; =C2=A0 =C2=A0 inet6 fe80::a2f3:c1ff:fea3:c411/64 scope link<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0valid_lft forever preferred_lft forever=
<br>
&gt;&gt; root@recife:~# ip route show<br>
&gt;&gt; default via 200.199.10.254 dev eth1 =C2=A0proto static<br>
&gt;&gt; <a href=3D"http://200.199.10.0/21" target=3D"_blank">200.199.10.0/=
21</a> dev eth1 =C2=A0proto kernel =C2=A0scope link =C2=A0src 200.199.10.12=
<br>
&gt;&gt; <a href=3D"http://192.168.1.0/24" target=3D"_blank">192.168.1.0/24=
</a> dev br-lan =C2=A0proto kernel =C2=A0scope link =C2=A0src 192.168.1.1<b=
r>
&gt;&gt; root@recife:~# ip l2tp add tunnel tunnel_id 42 peer_tunnel_id 45 u=
dp_sport<br>
&gt;&gt; 5000 udp_dport 5001 encap udp local 200.199.10.12 remote 200.243.1=
.5<br>
&gt;&gt; root@recife:~# ip l2tp add session tunnel_id 42 session_id 128<br>
&gt;&gt; peer_session_id 5196755<br>
&gt;&gt; root@recife:~# ip link set dev l2tpeth0 up promisc on master br-re=
d<br>
&gt;&gt; root@recife:~# brctl show<br>
&gt;&gt; bridge name =C2=A0 =C2=A0 bridge id =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 STP enabled =C2=A0 =C2=A0 interfaces<br>
&gt;&gt; br-lan =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A07fff.a0f3c1a3c40f =C2=A0 =
=C2=A0 =C2=A0 no =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0eth0<br>
&gt;&gt; root@recife:~# brctl addbr br-red<br>
&gt;&gt; root@recife:~# brctl addif br-red l2tpeth0<br>
&gt;&gt; root@recife:~# brctl addif br-red wlan0<br>
&gt;&gt; root@recife:~# ifconfig br-red up<br>
&gt;&gt; root@recife:~# ip link set br-red up<br>
&gt;&gt; root@recife:~# brctl show<br>
&gt;&gt; bridge name =C2=A0 =C2=A0 bridge id =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 STP enabled =C2=A0 =C2=A0 interfa=
ces<br>
&gt;&gt; br-lan =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A07fff=
.a0f3c1a3c40f =C2=A0 =C2=A0 =C2=A0 no =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 eth0<br>
&gt;&gt; br-red =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A08000=
.1ae0f4a30221 =C2=A0no =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 l2tpeth0<br>
&gt;&gt;<br>
&gt;&gt; wlan0<br>
&gt;&gt; root@recife:~#<br>
&gt;&gt;<br>
&gt;&gt; ....::: RESUME :::...<br>
&gt;&gt;<br>
&gt;&gt; 1) sorry for the long email....<br>
&gt;&gt; 2) when i&#39;m &quot;recife hostspot&quot;... I can join in wirel=
ess &quot;Recife Wireless&quot;<br>
&gt;&gt; from my device, but i can&#39;t receive ip from dhcp (10.60.61.1).=
<br>
&gt;&gt; 3) from &quot;server A[bahia] (bridge with vlan601 network) and &q=
uot;server B<br>
&gt;&gt; [recife]&quot;, i can &quot;see/listen&quot; the broadcast request=
 from my<br>
&gt;&gt; device mac &quot;5c:95:ae:22:d6:6e&quot; like below.<br>
&gt;&gt;<br>
&gt;&gt; root@bahia:~# tcpdump -nve -i br-red &quot;ether host ether 5c:95:=
ae:22:d6:6e&quot;<br>
&gt;&gt; 00:08:52.653667 5c:95:ae:22:d6:6e &gt; ff:ff:ff:ff:ff:ff, ethertyp=
e IPv4<br>
&gt;&gt; (0x0800), length 342: (tos 0x0, ttl 255, id 37839, offset 0, flags=
 [none],<br>
&gt;&gt; proto UDP (17), length 328)<br>
&gt;&gt; =C2=A0 =C2=A0 0.0.0.0.68 &gt; 255.255.255.255.67: BOOTP/DHCP, Requ=
est from<br>
&gt;&gt; 5c:95:ae:22:d6:6e, length 300, xid 0xe6f1d0a5, Flags [none]<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Client-Ethernet-Address 5c:95:a=
e:22:d6:6e<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Vendor-rfc1048 Extensions<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Magic Cookie 0x63825363<=
br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DHCP-Message Option 53, =
length 1: Discover<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Parameter-Request Option=
 55, length 6:<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Subnet-Mask, Defa=
ult-Gateway, Domain-Name-Server,<br>
&gt;&gt; Domain-Name<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Option 119, Optio=
n 252<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MSZ Option 57, length 2:=
 1500<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Client-ID Option 61, len=
gth 7: ether 5c:95:ae:22:d6:6e<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Lease-Time Option 51, le=
ngth 4: 7776000<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Hostname Option 12, leng=
th 14: &quot;Straces-iPhone&quot;<br>
&gt;&gt; ^C<br>
&gt;&gt; 1 packets captured<br>
&gt;&gt; 1 packets received by filter<br>
&gt;&gt; root@bahia:~#<br>
&gt;&gt;<br>
&gt;&gt; same thing result at &quot;bridge a&quot; (root@recife:~#) side...=
<br>
&gt;&gt;<br>
&gt;&gt; 4) the strangest thing of all and that, from bridge-b (recife). i =
can get<br>
&gt;&gt; ip from dhcp/broadcast request over L2TPv3...<br>
&gt;&gt; but without option &quot;broadcast&quot; i can&#39;t receive ip fr=
om dhcp (10.61.60.1)<br>
&gt;&gt;<br>
&gt;&gt; root@recife:~# udhcpc -B -i br-red<br>
&gt;&gt; udhcpc (v1.19.4) started<br>
&gt;&gt; Sending discover...<br>
&gt;&gt; Sending select for 10.251.157.22...<br>
&gt;&gt; Lease of 10.251.157.22 obtained, lease time 300<br>
&gt;&gt; udhcpc: ifconfig br-red 10.251.157.22 netmask 255.255.0.0 broadcas=
t +<br>
&gt;&gt; udhcpc: setting default routers: 10.251.0.1<br>
&gt;&gt; root@recife:~# ip route add 200.243.1.5 via 200.199.10.254 dev eth=
1<br>
&gt;&gt; root@recife:~# ip route show<br>
&gt;&gt; default via 10.251.0.1 dev br-red<br>
&gt;&gt; <a href=3D"http://10.251.0.0/16" target=3D"_blank">10.251.0.0/16</=
a> dev br-red =C2=A0proto kernel =C2=A0scope link =C2=A0src 10.251.157.22<b=
r>
&gt;&gt; <a href=3D"http://200.199.10.0/21" target=3D"_blank">200.199.10.0/=
21</a> dev eth1 =C2=A0proto kernel =C2=A0scope link =C2=A0src 200.199.10.12=
<br>
&gt;&gt; 200.243.1.5 via 200.199.10.254 dev eth1<br>
&gt;&gt; <a href=3D"http://192.168.1.0/24" target=3D"_blank">192.168.1.0/24=
</a> dev br-lan =C2=A0proto kernel =C2=A0scope link =C2=A0src 192.168.1.1<b=
r>
&gt;&gt; root@recife:~# ping -c2 10.251.0.1<br>
&gt;&gt; PING 10.251.0.1 (10.251.0.1): 56 data bytes<br>
&gt;&gt;<br>
&gt;&gt; --- 10.251.0.1 ping statistics ---<br>
&gt;&gt; 2 packets transmitted, 0 packets received, 100% packet loss<br>
&gt;&gt; root@recife:~#<br>
&gt;&gt;<br>
&gt;&gt; 5) output of tcpdump listen the bridge &quot;br-red&quot; request =
from<br>
&gt;&gt; bridge-a-natal <a href=3D"http://pastebin.com/t8wn3zRK" target=3D"=
_blank">http://pastebin.com/t8wn3zRK</a><br>
&gt;&gt; 6) output of tcpdump listen the bridge &quot;br-red&quot; request =
from<br>
&gt;&gt; bridge-b-recife <a href=3D"http://pastebin.com/njTQfd5k" target=3D=
"_blank">http://pastebin.com/njTQfd5k</a><br>
&gt;&gt; 7) after several researches i found the kernel options to set like=
<br>
&gt;&gt; &quot;arp_filter&quot;, &quot;bridge-nf-*&quot;,... but i don&#39;=
t have<br>
&gt;&gt; idea which option should enable / disable. tried some combinations=
 but<br>
&gt;&gt; without success....<br>
&gt;&gt; 8) the DHCP-OFFER doesn&#39;t forward by &quot;bridge-a&quot;... =
=C2=A0problems with unicast?<br>
&gt;&gt; multicast? arp_proxy? ....<br>
&gt;&gt; 9) we need join in the network by wireless and access the server<b=
r>
&gt;&gt; 10.251.0.1 over bridge/l2tpv3 (unmanaged)<br>
&gt;&gt; 10) in our case, can use only L2TPv3. (may not be OpenVPN, ...)<br=
>
&gt;&gt; 11) all is Linux, without any iptables rules.<br>
&gt;&gt; 12) who will win a beer?! =3D]<br>
&gt;&gt;<br>
&gt;&gt; Best regards,<br>
&gt;&gt; Jorge Pereira<br>
&gt;<br>
&gt;<br>
</div></div></blockquote></div><br></div>

--bcaec5299c93820c7904e4ce87be--
