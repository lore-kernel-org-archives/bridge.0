Return-Path: <jpereiran@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-type:content-transfer-encoding;
	bh=onx8jyoh7lVJ5nqi9nuB+WRIBM2ymGr16rgEhwAoMMg=;
	b=ee8sHt2X5tJ0sLrfdC5rm9te5CC3FITKBs3iz293ov2tubJqApt5sfINODvm/XAzzP
	Z1+ts6JIahCSiwMZwS0kDtKcriB4+QuEt/UR04yydlxX8PCg5mZ5zWjuuaxVYCTRgXKE
	13tUDb2jo09evvjpt/1h9ApF7O8ibFq7H+67xPp6oXOYbQoIwjdcomrc6FbGDhu0ABIY
	ibXT/IE/K+1v+dQ57gHockgJsnnhxkiG+uOEZhTrE3tqScrPzlPoMJ12mk0b5UYomz9q
	qpAl7TH7fAsyRiFOJGLaLj+jWmVVAqW1F4SVWmQ7t9ICgd6Y0YFwjXylpawKzM/Wr0v/
	6L2Q==
MIME-Version: 1.0
In-Reply-To: <CAKiAkGTtgBXU9fQbvzoXPC+DO+DtM0xG73psUCDE43CgvK62oQ@mail.gmail.com>
References: <CABvP5W17XQ16mRsVhTFEUf9AbyGd+WQSV0hBozDy3rANUSKofw@mail.gmail.com>
	<CAKiAkGTtgBXU9fQbvzoXPC+DO+DtM0xG73psUCDE43CgvK62oQ@mail.gmail.com>
From: Jorge Pereira <jpereiran@gmail.com>
Date: Sun, 25 Aug 2013 20:54:37 -0300
Message-ID: <CABvP5W1jER8Db_XbHxUioz+h4RgZAOVWi3n4QH7R+qRp41tzNw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
To: =?UTF-8?Q?Joel_Wir=C4=81mu_Pauling?= <joel@aenertia.net>
Cc: Openl2tp-users@lists.sourceforge.net, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, lartc <lartc@vger.kernel.org>

Hi Joel,

thanks for your answer!! but i CAN'T understand why my bridge (SERVER
A) don't forward the arp-request
from LAN to my other side of L2TPv3 (SERVER B).... so, all i need it's
that my 'bridge' forward (broadcast, anycast, unicast, arp, ...)
everything to other side of L2TPv3 bridge... let me try to explain
below...

e.g:

+------------------------------------------------+
| Bahia: lan network 10.251.0.0/16 |
+------------------------------------------------+
 |
 |      +-----------------------------+
 +--> | Bridge   A               |
        | LAN: bridge/promisc|
        | WAN: 200.199.10.1 |
 +---- +-----------------------------+
 |
 |
 \     +--------------------------------------------------------+
  +---| L2TPv3 / promisc / l2tpeth0 over WAN |
 /     +--------------------------------------------------------+
 |
 |      +-----------------------------+
 +--> | Bridge   B               |
        | LAN: bridge/promisc|
        | WAN: 200.199.10.2 |
+-----+-----------------------------+
|
+-------------------------------------------------+
| Recife: lan network 10.251.0.0/16 |
+-------------------------------------------------+

e.g - 1: from side 'B', i can send icmp request to anyone in
10.251.0.0/16. but can't receive response because
my bridge A ignore/discard all packets arp/unicast/...  and does not
forward to Bridge B. only broadcast!

e.g - 2: (sysct/proxy_arp) don't solves my problem... if somebody have
any suggestion, please! tell me! :)


On Fri, Aug 23, 2013 at 2:22 AM, Joel Wir=C4=81mu Pauling <joel@aenertia.ne=
t> wrote:
> You can't bridge 802.11 segments with normal ethernet segments. Wifi AP's
> that do this use magic; or hidden pesudo bridges to do the same.
>
> You will need to use something like relayd to form a psuedo bridge betwee=
n
> your wired and wireless segments or use routing.
>
>
> -Joel
>
>
> On 23 August 2013 14:21, Jorge Pereira <jpereiran@gmail.com> wrote:
>>
>> hi everyone,
>>
>>     so,first it seemed a trivial question to me, but since I could not
>> find anybody being neither able to answer
>> this question nor giving a short config example. after a few sleepless
>> nights and exhausting all the reading
>> and research. here I am sharing my problem with all of you, in the hope =
of
>> some possible solution/sugestion.
>> or is it that this is impossible??
>>
>> below my scheme/layout.
>>
>> +---------------------------------------------------------+
>> | MAIN SERVER - 10.60.61.1 (DHCP SERVER) |
>> +---------------------------------------------------------+
>>                      |
>> +---------------------------+
>> |    NETWORK vlan601 |
>> |  net 10.251.0.0/16      |
>> |  gw:10.251.0.1            |
>> +---------------------------+
>>                     |
>> +------------------------------------------------------------------+
>>  | SERVER B (BRIDGE / unmanaged L2TPv3) - BAHIA |
>> +------------------------------------------------------------------+
>>
>> root@bahia:~#  ip -d addr show eth0 # WAN
>> 2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast sta=
te
>> UP qlen 1000
>>     link/ether 00:50:56:a7:13:49 brd ff:ff:ff:ff:ff:ff
>>     inet 200.243.1.5/24 brd 200.243.1.255 scope global eth0
>>     inet6 fe80::250:56ff:fea7:1349/64 scope link
>>        valid_lft forever preferred_lft forever
>> root@bahia:~#  ip -d addr show eth1 # LAN (VLAN/TRUNK)
>> 3: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast sta=
te
>> UP qlen 1000
>>     link/ether 00:50:56:a7:13:4a brd ff:ff:ff:ff:ff:ff
>>     inet6 fe80::250:56ff:fea7:134a/64 scope link
>>        valid_lft forever preferred_lft forever
>> root@bahia:~#  ip link add link eth1 name eth1.601 mtu 1500 type vlan id
>> 601
>> root@bahia:~#  ip link set dev eth1.601 up promisc on
>> root@bahia:~#  ip -d addr show eth1.601
>> 9: eth1.601@eth1: <BROADCAST,MULTICAST,PROMISC,UP,LOWER_UP> mtu 1500 qdi=
sc
>> noqueue state UP
>>     link/ether 00:50:56:a7:13:4a brd ff:ff:ff:ff:ff:ff
>>     inet6 fe80::250:56ff:fea7:134a/64 scope link
>>        valid_lft forever preferred_lft forever
>> root@bahia:~#  ip route show
>> default via 200.243.1.254 dev eth0
>> 200.243.1.0/24 dev eth0  proto kernel  scope link  src 200.243.1.5
>> root@bahia:~#
>>
>> and.... we've the interface l2tpeth0 (L2TPv3) established with other nod=
e
>> into the internet by eth0 (WAN), plugged
>> with vlan601 (eth1.601) by bridge called "br-red"
>>
>> root@bahia:~# brctl show
>> bridge name bridge id STP enabled interfaces
>> root@bahia:~# brctl addbr br-red
>> root@bahia:~# brctl addif br-red eth1.601
>> root@bahia:~# ip l2tp add tunnel tunnel_id 45 peer_tunnel_id 42 udp_spor=
t
>> 5001 udp_dport 5000 encap udp local 200.243.1.5 remote 200.199.10.12
>> root@bahia:~# ip l2tp add session tunnel_id 45 session_id 5196755
>> peer_session_id 128
>> root@bahia:~# ip link set l2tpeth0 up promisc on master br-red
>> root@bahia:~# ip link set br-red up
>> root@bahia:~# brctl show br-red
>> bridge name bridge id STP enabled interfaces
>> br-red 8000.005056a7134a no eth1.601
>> l2tpeth0
>> root@bahia:~# brctl showstp br-red
>> br-red
>>  bridge id 8000.005056a7134a
>>  designated root 8000.005056a7134a
>>  root port         0 path cost   0
>>  max age         20.00 bridge max age  20.00
>>  hello time 2.00 bridge hello time   2.00
>>  forward delay 15.00 bridge forward delay  15.00
>>  ageing time 300.01
>>  hello timer 1.06 tcn timer   0.00
>>  topology change timer   0.00 gc timer   5.08
>>  flags
>>
>> eth1.601 (1)
>>  port id 8001 state     forwarding
>>  designated root 8000.005056a7134a path cost   4
>>  designated bridge 8000.005056a7134a message age timer   0.00
>>  designated port 8001 forward delay timer   0.00
>>  designated cost   0 hold timer   0.06
>>  flags
>>
>> l2tpeth0 (2)
>>  port id 8002 state     forwarding
>>  designated root 8000.005056a7134a path cost 100
>>  designated bridge 8000.005056a7134a message age timer   0.00
>>  designated port 8002 forward delay timer   0.00
>>  designated cost   0 hold timer   0.05
>>  flags
>>
>> root@bahia:~#
>>
>> it's ok, my bridge "by-red" listen all traffic over my LAN (vlan 601) an=
d
>> my L2TPv3 over internet. (wan)
>>
>> root@bahia:~#  tcpdump -nve -i br-red "host 10.251.0.1"
>> tcpdump: WARNING: br-red: no IPv4 address assigned
>> tcpdump: listening on br-red, link-type EN10MB (Ethernet), capture size
>> 65535 bytes
>> 20:58:17.860060 d4:ae:52:84:37:ae > ff:ff:ff:ff:ff:ff, ethertype ARP
>> (0x0806), length 60: Ethernet (len 6), IPv4 (len 4), Request who-has
>> 10.251.90.157 tell 10.251.0.1, length 46
>> 20:58:17.980065 d4:ae:52:84:37:ae > ff:ff:ff:ff:ff:ff, ethertype ARP
>> (0x0806), length 60: Ethernet (len 6), IPv4 (len 4), Request who-has
>> 10.251.153.31 tell 10.251.0.1, length 46
>> ^C
>> 7 packets captured
>> 7 packets received by filter
>> 0 packets dropped by kernel
>> root@bahia:~#
>>
>>
>> +-----------------------------------------------------------------------=
------------------+
>>  | SERVER B (BRIDGE/L2TPv3 + WIRELESS ACCESS POINT) - RECIFE |
>>
>> +-----------------------------------------------------------------------=
------------------+
>>
>> root@recife:~# ip addr show eth1 # (WAN)
>> 3: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state
>> UP qlen 1000
>>     link/ether a0:f3:c1:a3:c4:11 brd ff:ff:ff:ff:ff:ff
>>     inet 200.199.10.12/21 brd 200.199.10.255 scope global eth1
>>        valid_lft forever preferred_lft forever
>>     inet6 fe80::a2f3:c1ff:fea3:c411/64 scope link
>>        valid_lft forever preferred_lft forever
>> root@recife:~# ip route show
>> default via 200.199.10.254 dev eth1  proto static
>> 200.199.10.0/21 dev eth1  proto kernel  scope link  src 200.199.10.12
>> 192.168.1.0/24 dev br-lan  proto kernel  scope link  src 192.168.1.1
>> root@recife:~# ip l2tp add tunnel tunnel_id 42 peer_tunnel_id 45 udp_spo=
rt
>> 5000 udp_dport 5001 encap udp local 200.199.10.12 remote 200.243.1.5
>> root@recife:~# ip l2tp add session tunnel_id 42 session_id 128
>> peer_session_id 5196755
>> root@recife:~# ip link set dev l2tpeth0 up promisc on master br-red
>> root@recife:~# brctl show
>> bridge name     bridge id               STP enabled     interfaces
>> br-lan          7fff.a0f3c1a3c40f       no              eth0
>> root@recife:~# brctl addbr br-red
>> root@recife:~# brctl addif br-red l2tpeth0
>> root@recife:~# brctl addif br-red wlan0
>> root@recife:~# ifconfig br-red up
>> root@recife:~# ip link set br-red up
>> root@recife:~# brctl show
>> bridge name     bridge id                     STP enabled     interfaces
>> br-lan                7fff.a0f3c1a3c40f       no                     eth=
0
>> br-red                8000.1ae0f4a30221  no                     l2tpeth0
>>
>> wlan0
>> root@recife:~#
>>
>> ....::: RESUME :::...
>>
>> 1) sorry for the long email....
>> 2) when i'm "recife hostspot"... I can join in wireless "Recife Wireless=
"
>> from my device, but i can't receive ip from dhcp (10.60.61.1).
>> 3) from "server A[bahia] (bridge with vlan601 network) and "server B
>> [recife]", i can "see/listen" the broadcast request from my
>> device mac "5c:95:ae:22:d6:6e" like below.
>>
>> root@bahia:~# tcpdump -nve -i br-red "ether host ether 5c:95:ae:22:d6:6e=
"
>> 00:08:52.653667 5c:95:ae:22:d6:6e > ff:ff:ff:ff:ff:ff, ethertype IPv4
>> (0x0800), length 342: (tos 0x0, ttl 255, id 37839, offset 0, flags [none=
],
>> proto UDP (17), length 328)
>>     0.0.0.0.68 > 255.255.255.255.67: BOOTP/DHCP, Request from
>> 5c:95:ae:22:d6:6e, length 300, xid 0xe6f1d0a5, Flags [none]
>>           Client-Ethernet-Address 5c:95:ae:22:d6:6e
>>           Vendor-rfc1048 Extensions
>>             Magic Cookie 0x63825363
>>             DHCP-Message Option 53, length 1: Discover
>>             Parameter-Request Option 55, length 6:
>>               Subnet-Mask, Default-Gateway, Domain-Name-Server,
>> Domain-Name
>>               Option 119, Option 252
>>             MSZ Option 57, length 2: 1500
>>             Client-ID Option 61, length 7: ether 5c:95:ae:22:d6:6e
>>             Lease-Time Option 51, length 4: 7776000
>>             Hostname Option 12, length 14: "Straces-iPhone"
>> ^C
>> 1 packets captured
>> 1 packets received by filter
>> root@bahia:~#
>>
>> same thing result at "bridge a" (root@recife:~#) side...
>>
>> 4) the strangest thing of all and that, from bridge-b (recife). i can ge=
t
>> ip from dhcp/broadcast request over L2TPv3...
>> but without option "broadcast" i can't receive ip from dhcp (10.61.60.1)
>>
>> root@recife:~# udhcpc -B -i br-red
>> udhcpc (v1.19.4) started
>> Sending discover...
>> Sending select for 10.251.157.22...
>> Lease of 10.251.157.22 obtained, lease time 300
>> udhcpc: ifconfig br-red 10.251.157.22 netmask 255.255.0.0 broadcast +
>> udhcpc: setting default routers: 10.251.0.1
>> root@recife:~# ip route add 200.243.1.5 via 200.199.10.254 dev eth1
>> root@recife:~# ip route show
>> default via 10.251.0.1 dev br-red
>> 10.251.0.0/16 dev br-red  proto kernel  scope link  src 10.251.157.22
>> 200.199.10.0/21 dev eth1  proto kernel  scope link  src 200.199.10.12
>> 200.243.1.5 via 200.199.10.254 dev eth1
>> 192.168.1.0/24 dev br-lan  proto kernel  scope link  src 192.168.1.1
>> root@recife:~# ping -c2 10.251.0.1
>> PING 10.251.0.1 (10.251.0.1): 56 data bytes
>>
>> --- 10.251.0.1 ping statistics ---
>> 2 packets transmitted, 0 packets received, 100% packet loss
>> root@recife:~#
>>
>> 5) output of tcpdump listen the bridge "br-red" request from
>> bridge-a-natal http://pastebin.com/t8wn3zRK
>> 6) output of tcpdump listen the bridge "br-red" request from
>> bridge-b-recife http://pastebin.com/njTQfd5k
>> 7) after several researches i found the kernel options to set like
>> "arp_filter", "bridge-nf-*",... but i don't have
>> idea which option should enable / disable. tried some combinations but
>> without success....
>> 8) the DHCP-OFFER doesn't forward by "bridge-a"...  problems with unicas=
t?
>> multicast? arp_proxy? ....
>> 9) we need join in the network by wireless and access the server
>> 10.251.0.1 over bridge/l2tpv3 (unmanaged)
>> 10) in our case, can use only L2TPv3. (may not be OpenVPN, ...)
>> 11) all is Linux, without any iptables rules.
>> 12) who will win a beer?! =3D]
>>
>> Best regards,
>> Jorge Pereira
>
>
