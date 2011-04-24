Date: Sun, 24 Apr 2011 09:40:49 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20110424094049.022a2e80@nehalam>
In-Reply-To: <4DB43C0F.9080502@gmail.com>
References: <4DB43C0F.9080502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] brctl problem: broadcast doesn't get through
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ireneusz =?UTF-8?B?U3pjemXFm25pYWs=?= <irek.szczesniak@gmail.com>
Cc: bridge@lists.linux-foundation.org

On Sun, 24 Apr 2011 17:04:47 +0200
Ireneusz Szcze=C5=9Bniak <irek.szczesniak@gmail.com> wrote:

> Hi,
>=20
> I'm creating a bridge, and then add to it two tap interfaces. No=20
> physical interface is added to the bridge. These are the commands:
>=20
> brctl addbr test
> ip tuntap add mode tap tap0
> ip tuntap add mode tap tap1
> ifconfig test up
> ifconfig tap0 up
> ifconfig tap1 up
> brctl addif test tap0
> brctl addif test tap1
>=20
> The problem is that the bridge doesn't seem to work correctly. I sent=20
> through tap0 some broadcast frames (WOL frames), and they didn't reach=20
> tap1. I was sending packets with:
>=20
> etherwake -b -i tap0 00:00:00:00:00:00
>=20
> The tshark command for tap0 showed the frames being sent with tap0,=20
> but another tshark for tap1 didn't show them.
>=20
> Then I added to tap0 the IP address 192.168.10.1/24, and did:
>=20
> arping 192.168.1.2
>=20
> I saw ARP request broadcast frames on tap0, but they didn't reach tap1.
>=20
> This is the output of ifconfig for test, tap0, and tap1 interfaces:
>=20
> root@computer:~# ifconfig test
> test Link encap:Ethernet HWaddr 02:07:b1:eb:2c:2a
> inet6 addr: fe80::944b:d9ff:fe10:b240/64 Scope:Link
> UP BROADCAST RUNNING PROMISC MULTICAST MTU:1500 Metric:1
> RX packets:0 errors:0 dropped:0 overruns:0 frame:0
> TX packets:19 errors:0 dropped:0 overruns:0 carrier:0
> collisions:0 txqueuelen:0
> RX bytes:0 (0.0 B) TX bytes:3377 (3.2 KiB)
>=20
> root@computer:~# ifconfig tap0
> tap0 Link encap:Ethernet HWaddr 02:07:b1:eb:2c:2a
> inet addr:192.168.10.0 Bcast:192.168.10.255 Mask:255.255.255.0
> inet6 addr: fe80::7:b1ff:feeb:2c2a/64 Scope:Link
> UP BROADCAST RUNNING PROMISC MULTICAST MTU:1500 Metric:1
> RX packets:0 errors:0 dropped:0 overruns:0 frame:0
> TX packets:0 errors:0 dropped:278 overruns:0 carrier:0
> collisions:0 txqueuelen:500
> RX bytes:0 (0.0 B) TX bytes:0 (0.0 B)
>=20
> root@computer:~# ifconfig tap1
> tap1 Link encap:Ethernet HWaddr b2:ee:2c:f9:d5:0d
> inet6 addr: fe80::b0ee:2cff:fef9:d50d/64 Scope:Link
> UP BROADCAST RUNNING PROMISC MULTICAST MTU:1500 Metric:1
> RX packets:0 errors:0 dropped:0 overruns:0 frame:0
> TX packets:0 errors:0 dropped:19 overruns:0 carrier:0
> collisions:0 txqueuelen:500
> RX bytes:0 (0.0 B) TX bytes:0 (0.0 B)
>=20
> The output of the brctl:
>=20
> root@computer:~# brctl show
> bridge name bridge id STP enabled interfaces
> pan0 8000.000000000000 no
> test 8000.0207b1eb2c2a no tap0
> tap1
> root@computer:~# brctl showmacs test
> port no mac addr is local? ageing timer
> 1 02:07:b1:eb:2c:2a yes 0.00
> 2 b2:ee:2c:f9:d5:0d yes 0.00
>=20
> The output of route:
>=20
> root@computer:/home/iszczesniak# route -n
> Kernel IP routing table
> Destination Gateway Genmask Flags Metric Ref Use Iface
> 192.168.2.0 0.0.0.0 255.255.255.0 U 2 0 0 eth1
> 192.168.10.0 0.0.0.0 255.255.255.0 U 0 0 0 tap0
> 169.254.0.0 0.0.0.0 255.255.0.0 U 1000 0 0 eth1
> 0.0.0.0 192.168.2.1 0.0.0.0 UG 0 0 0 eth1
>=20
> What am I doing wrong?
>=20
>=20
> Thanks,
> Irek
>=20

00:00:00:00:00:00 is an invalid ethernet address and is always dropped
by bridge to be in compliance with standards.  Use a real ethernet address,
for kernel devices there is a convenience routine to generate a random ethe=
rnet
address.

--=20
