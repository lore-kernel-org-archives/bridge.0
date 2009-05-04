Message-ID: <49FF435A.3040806@free.fr>
Date: Mon, 04 May 2009 21:34:50 +0200
From: =?ISO-8859-1?Q?Nicolas_de_Peslo=FCan?= <nicolas.2p.debian@free.fr>
MIME-Version: 1.0
References: <20090428124009.GA26387@kallisti.us>	<2e59e6970904281200u44e3ebbfga0f074dfaa78c1ab@mail.gmail.com>	<49F77248.1050800@gmail.com>	<2e59e6970904281600u42142392vb8e0eb45c4ede15c@mail.gmail.com>	<49F87D4E.4060705@gmail.com>
	<20090429162651.GA9455@kallisti.us>	<49F882F9.4010100@gmail.com>
	<20090429165329.GA9893@kallisti.us>	<49F8C4C3.9020504@gmail.com>	<2e59e6970904292118u71ff441ft19448f753c1b6dd9@mail.gmail.com>
	<db99f77d0904292330n4c460ccbv45e60f06bfa49c4@mail.gmail.com>
	<49FA1E28.5020604@free.fr> <49FC4764.3030707@gmail.com>
	<49FDD890.1090302@free.fr> <49FF41C4.4090404@gmail.com>
In-Reply-To: <49FF41C4.4090404@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] Ubuntu: network bridging between wireless and wired
 connection fails
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jochen Hebbrecht <jochenhebbrecht@gmail.com>
Cc: bridge@lists.linux-foundation.org

Jochen Hebbrecht a =E9crit :
>=20
>=20
> Nicolas de Peslo=FCan schreef:
>> Ok, now we understand what you are trying to do. In particular, I=20
>> assume the DHCP server is on the subnet of location B (or behind a=20
>> router connected on this subnet), so the expected DHCP offer will come=20
>> from the wire interface (eth0) and definitely not from the wireless=20
>> interface (eth1).
>>
> Maybe my picture isn't very clear, but my WAN access is on location A.=20
> There's a router which receives an ip from the ISP. On the other side,=20
> I'm having a 192.168.1.0/24 network

I'm no more really sure I understand your configuration.

The server you are curently trying to setup as a bridge is located in=20
location B (UBUNTU SERVER) and has two interfaces : eth0 (ethernet) and=20
eth1 (wifi).

Am I right ?

>> Let's try a step-by-step bridge configuration :
>>
>> 1/ Try to setup a non-bridge configuration and ensure you successfully=20
>> get a DHCP answer using eth0.
>>
>> auto eth0
>> iface eth0 inet dhcp
>>
>> #auto eth1
>> #iface eth1 inet dhcp
>> #wpa-driver wext
>> #wpa-ssid ##SSID##
>> #wpa-ap-scan 1
>> #wpa-proto RSN
>> #wpa-pairwise CCMP
>> #wpa-group CCMP
>> #wpa-key-mgmt WPA-PSK
>> #wpa-psk ##PSK KEY##
>>
>> #auto br0
>> #iface br0 inet dhcp
>> #bridge_ports eth0 eth1
> I tried this:
>=20
> $ cat /etc/network/interfaces
> auto lo
> iface lo inet loopback
>=20
> auto eth1
> iface eth1 inet dhcp
> wpa-driver wext
> wpa-ssid ##SSID##
> wpa-ap-scan 1
> wpa-proto RSN
> wpa-pairwise CCMP
> wpa-group CCMP
> wpa-key-mgmt WPA-PSK
> wpa-psk ##PSK KEY##
>=20
> This configuration works fine. I'm receiving a DHCP offer from my router =

> (in location A)
>>
>> 2/ Try to setup a bridge with only eth0 (wire interface) and ensure=20
>> this work well, using a static IP address.
>>
>> #auto eth0
>> iface eth0 inet manual
>>
>> #auto eth1
>> iface eth1 inet manual
>>
>> auto br0
>> iface br0 inet static
>> bridge_ports eth0
>> address 192.168.1.111
>> netmask 255.255.255.0
> $ cat /etc/network/interfaces
> auto lo
> iface lo inet loopback
>=20
> auto eth1
> iface eth1 inet manual
> wpa-driver wext
> wpa-ssid ##SSID##
> wpa-ap-scan 1
> wpa-proto RSN
> wpa-pairwise CCMP
> wpa-group CCMP
> wpa-key-mgmt WPA-PSK
> wpa-psk ##PSK KEY##
>=20
> auto br0
> iface br0 inet static
> bridge_ports eth1
> address 192.168.1.111
> netmask 255.255.255.0
> gateway 192.168.1.1
>=20
> $ sudo /etc/init.d/networking restart
> * Reconfiguring network=20
> interfaces...                                       =20
> Waiting for br0 to get ready (MAXWAIT is 32 seconds).
>                                                                        =20
> [ OK ]
> $ route -n
> Kernel IP routing table
> Destination     Gateway         Genmask         Flags Metric Ref    Use=20
> Iface
> 192.168.1.0     0.0.0.0         255.255.255.0   U     0      0        0 b=
r0
> 169.254.0.0     0.0.0.0         255.255.0.0     U     1000   0        0 b=
r0
> 0.0.0.0         192.168.1.1     0.0.0.0         UG    100    0        0 b=
r0
>=20
> $ sudo brctl show br0
> bridge name     bridge id               STP enabled     interfaces
> br0             8000.0015001f20a6       no              eth1
>=20
> $ ifconfig eth1
> eth1      Link encap:Ethernet  HWaddr 00:15:00:1f:20:a6          inet6=20
> addr: fe80::215:ff:fe1f:20a6/64 Scope:Link
>          UP BROADCAST MULTICAST  MTU:1500  Metric:1
>          RX packets:7 errors:82 dropped:84 overruns:0 frame:0
>          TX packets:1 errors:0 dropped:19 overruns:0 carrier:0
>          collisions:0 txqueuelen:1000
>          RX bytes:1056452 (1.0 MB)  TX bytes:149964 (146.4 KB)
>          Interrupt:21 Base address:0xa000 Memory:c8006000-c8006fff
>=20
> $ ifconfig br0
> br0       Link encap:Ethernet  HWaddr 00:15:00:1f:20:a6          inet=20
> addr:192.168.1.111  Bcast:192.168.1.255  Mask:255.255.255.0
>          inet6 addr: fe80::215:ff:fe1f:20a6/64 Scope:Link
>          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>          TX packets:27 errors:0 dropped:0 overruns:0 carrier:0
>          collisions:0 txqueuelen:0
>          RX bytes:0 (0.0 B)  TX bytes:1350 (1.3 KB)
>=20
> $ ping 192.168.1.1
> PING 192.168.1.1 (192.168.1.1) 56(84) bytes of data.
>  From 192.168.1.111 icmp_seq=3D2 Destination Host Unreachable
>  From 192.168.1.111 icmp_seq=3D3 Destination Host Unreachable
>  From 192.168.1.111 icmp_seq=3D5 Destination Host Unreachable
>  From 192.168.1.111 icmp_seq=3D6 Destination Host Unreachable
>=20
> So here it goes wrong. I didn't execute any other steps as step 2 fails=20
> :-( ...
>=20
>=20

