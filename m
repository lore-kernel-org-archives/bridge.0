Message-ID: <fed120860807032159x5785ece4sa7e68f222a5e8833@mail.gmail.com>
Date: Fri, 4 Jul 2008 10:29:26 +0530
From: "Srinivas M.A." <srinivas.aji@gmail.com>
In-Reply-To: <486D6A80.3010600@kolumbus.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
References: <486D6A80.3010600@kolumbus.fi>
Subject: Re: [Bridge] VLAN Bridge routing problem
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?ISO-8859-1?Q?Pekka_J=E4rvinen?= <pekkajarvinen@kolumbus.fi>
Cc: bridge@lists.linux-foundation.org

This seems to be a IP routing issue, not a bridging issue at all.

You have set up default gateways for your own IP in the interfaces
configuration for br0 and br2. Things should be better if you get rid
of the gateway lines in the br0 and br2 sections.

On Fri, Jul 4, 2008 at 5:40 AM, Pekka J=E4rvinen
<pekkajarvinen@kolumbus.fi> wrote:
> Hi,
>
> I have
> br0 - LAN
> br1 - Internet
> br2 - WLAN
>
> First problem:
> Main Linux machine which is running all this can't connect to internet.
> Physical machines connected to this bridge via switches can access intern=
et.
> So how I add default route as br1 or straight vlan 333? For some weird
> reason it seems to get only one packet.
> Like:
> # ping -c 4 ping.funet.fi
> PING ns-secondary.funet.fi (128.214.248.132) 56(84) bytes of data.
>  From 192.168.1.1 icmp_seq=3D2 Destination Host Unreachable
>  From 192.168.1.1 icmp_seq=3D3 Destination Host Unreachable
>  From 192.168.1.1 icmp_seq=3D4 Destination Host Unreachable
>
> --- ns-secondary.funet.fi ping statistics ---
> 4 packets transmitted, 0 received, +3 errors, 100% packet loss, time 3000=
ms
> , pipe 3
>
> # ping -c 4 -I br1 ping.funet.fi
> PING ns-secondary.funet.fi (128.214.248.132) from 62.204.1.12 br1:
> 56(84) bytes of data.
>  From 62.204.1.12 icmp_seq=3D2 Destination Host Unreachable
>  From 62.204.1.12 icmp_seq=3D3 Destination Host Unreachable
>  From 62.204.1.12 icmp_seq=3D4 Destination Host Unreachable
>
> --- ns-secondary.funet.fi ping statistics ---
> 4 packets transmitted, 0 received, +3 errors, 100% packet loss, time 2999=
ms
> , pipe 3
>
> # ping -c 4 -I eth1.333 ping.funet.fi
> PING ns-secondary.funet.fi (128.214.248.132) from 192.168.0.1 eth1.333:
> 56(84) bytes of data.
>  From 192.168.0.1 icmp_seq=3D2 Destination Host Unreachable
>  From 192.168.0.1 icmp_seq=3D3 Destination Host Unreachable
>  From 192.168.0.1 icmp_seq=3D4 Destination Host Unreachable
>
> --- ns-secondary.funet.fi ping statistics ---
> 4 packets transmitted, 0 received, +3 errors, 100% packet loss, time 3001=
ms
> , pipe 3
>
> How it sends UDP packet (DNS) through br1 and gets answer and then nothin=
g?
>
> Second problem:
> What do I add to br0 and br2 so those can access internet through br1?
>
>
>
> # route -n
> Kernel IP routing table
> Destination     Gateway         Genmask         Flags Metric Ref    Use
> Iface
> 62.204.1.0      0.0.0.0         255.255.255.128 U     0      0        0 b=
r1
> 192.168.1.0     0.0.0.0         255.255.255.0   U     0      0        0 b=
r2
> 192.168.0.0     0.0.0.0         255.255.255.0   U     0      0        0 b=
r0
> 0.0.0.0         192.168.1.1     0.0.0.0         UG    0      0        0 b=
r2
> 0.0.0.0         62.204.1.1      0.0.0.0         UG    0      0        0 b=
r1
> 0.0.0.0         192.168.0.1     0.0.0.0         UG    0      0        0 b=
r0
>
>
> # ip route
> 62.204.1.0/25 dev br1  proto kernel  scope link  src 62.204.1.12
> 192.168.1.0/24 dev br2  proto kernel  scope link  src 192.168.1.1
> 192.168.0.0/24 dev br0  proto kernel  scope link  src 192.168.0.1
> default via 192.168.1.1 dev br2  scope link
> default via 62.204.1.1 dev br1
> default via 192.168.0.1 dev br0  scope link
>
>
> # cat /etc/network/interfaces
> auto lo
> iface lo inet loopback
>
> # The primary network interface
> allow-hotplug eth0
> allow-hotplug eth1
>
> iface eth0 inet static
> iface eth1 inet static
>
> auto vlan111
> auto vlan222
> auto vlan333
> auto vlan444
> auto br0
> auto br1
> auto br2
>
> # LAN
> iface vlan111 inet static
>        vlan_raw_device eth0
>
> # WLAN
> iface vlan222 inet static
>        vlan_raw_device eth0
>
> # ADSL Modem
> iface vlan333 inet static
>        vlan_raw_device eth1
>
> # Internet
> iface vlan444 inet static
>        vlan_raw_device eth0
>
> # LAN
> iface br0 inet static
>        address 192.168.0.1
>        netmask 255.255.255.0
>        gateway 192.168.0.1
>        bridge_ports eth0.111
>        bridge_stp on
>
> # Internet
> iface br1 inet static
>        address 62.204.1.12
>        netmask 255.255.255.128
>        gateway 62.204.1.1
>        bridge_ports eth1.333 eth0.444
>        bridge_stp on
>
> # WLAN
> iface br2 inet static
>        address 192.168.1.1
>        netmask 255.255.255.0
>        gateway 192.168.1.1
>        bridge_ports eth0.222
>        bridge_stp on
>
>
> # ifconfig
> br0       Link encap:Ethernet  HWaddr 00:40:63:E9:1B:60
>          inet addr:192.168.0.1  Bcast:192.168.0.255  Mask:255.255.255.0
>          inet6 addr: fe80::240:63ff:fee9:1b60/64 Scope:Link
>          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>          RX packets:2677 errors:0 dropped:0 overruns:0 frame:0
>          TX packets:200 errors:0 dropped:0 overruns:0 carrier:0
>          collisions:0 txqueuelen:0
>          RX bytes:745000 (727.5 KiB)  TX bytes:18490 (18.0 KiB)
>
> br1       Link encap:Ethernet  HWaddr 00:40:63:E9:1B:60
>          inet addr:62.204.1.12  Bcast:62.204.1.127  Mask:255.255.255.128
>          inet6 addr: fe80::240:63ff:fee9:1b60/64 Scope:Link
>          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>          RX packets:16720 errors:0 dropped:0 overruns:0 frame:0
>          TX packets:1094 errors:0 dropped:0 overruns:0 carrier:0
>          collisions:0 txqueuelen:0
>          RX bytes:849739 (829.8 KiB)  TX bytes:140600 (137.3 KiB)
>
> br2       Link encap:Ethernet  HWaddr 00:40:63:E9:1B:60
>          inet addr:192.168.1.1  Bcast:192.168.1.255  Mask:255.255.255.0
>          inet6 addr: fe80::240:63ff:fee9:1b60/64 Scope:Link
>          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>          TX packets:396 errors:0 dropped:0 overruns:0 carrier:0
>          collisions:0 txqueuelen:0
>          RX bytes:0 (0.0 b)  TX bytes:16848 (16.4 KiB)
>
> eth0      Link encap:Ethernet  HWaddr 00:40:63:E9:1B:60
>          inet6 addr: fe80::240:63ff:fee9:1b60/64 Scope:Link
>          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>          RX packets:25682 errors:0 dropped:0 overruns:0 frame:0
>          TX packets:74974 errors:0 dropped:0 overruns:0 carrier:0
>          collisions:0 txqueuelen:1000
>          RX bytes:5266514 (5.0 MiB)  TX bytes:20590320 (19.6 MiB)
>          Interrupt:177 Base address:0xd000
>
> eth1      Link encap:Ethernet  HWaddr 00:40:63:E9:1B:61
>          inet6 addr: fe80::240:63ff:fee9:1b61/64 Scope:Link
>          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>          RX packets:73147 errors:0 dropped:0 overruns:0 frame:0
>          TX packets:24442 errors:0 dropped:0 overruns:0 carrier:0
>          collisions:0 txqueuelen:1000
>          RX bytes:20674811 (19.7 MiB)  TX bytes:4443148 (4.2 MiB)
>          Interrupt:185 Base address:0xe800
>
> eth0.111  Link encap:Ethernet  HWaddr 00:40:63:E9:1B:60
>          inet6 addr: fe80::240:63ff:fee9:1b60/64 Scope:Link
>          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>          RX packets:2685 errors:0 dropped:0 overruns:0 frame:0
>          TX packets:2673 errors:0 dropped:0 overruns:0 carrier:0
>          collisions:0 txqueuelen:0
>          RX bytes:758720 (740.9 KiB)  TX bytes:157778 (154.0 KiB)
>
> eth0.222  Link encap:Ethernet  HWaddr 00:40:63:E9:1B:60
>          inet6 addr: fe80::240:63ff:fee9:1b60/64 Scope:Link
>          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>          TX packets:2838 errors:0 dropped:0 overruns:0 carrier:0
>          collisions:0 txqueuelen:0
>          RX bytes:0 (0.0 b)  TX bytes:155184 (151.5 KiB)
>
> eth0.444  Link encap:Ethernet  HWaddr 00:40:63:E9:1B:60
>          inet6 addr: fe80::240:63ff:fee9:1b60/64 Scope:Link
>          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>          RX packets:22728 errors:0 dropped:0 overruns:0 frame:0
>          TX packets:69254 errors:0 dropped:0 overruns:0 carrier:0
>          collisions:0 txqueuelen:0
>          RX bytes:4101153 (3.9 MiB)  TX bytes:20264742 (19.3 MiB)
>
> eth1.333  Link encap:Ethernet  HWaddr 00:40:63:E9:1B:61
>          inet6 addr: fe80::240:63ff:fee9:1b61/64 Scope:Link
>          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>          RX packets:66276 errors:0 dropped:0 overruns:0 frame:0
>          TX packets:24338 errors:0 dropped:0 overruns:0 carrier:0
>          collisions:0 txqueuelen:0
>          RX bytes:19135092 (18.2 MiB)  TX bytes:4436880 (4.2 MiB)
>
> lo        Link encap:Local Loopback
>          inet addr:127.0.0.1  Mask:255.0.0.0
>          inet6 addr: ::1/128 Scope:Host
>          UP LOOPBACK RUNNING  MTU:16436  Metric:1
>          RX packets:48 errors:0 dropped:0 overruns:0 frame:0
>          TX packets:48 errors:0 dropped:0 overruns:0 carrier:0
>          collisions:0 txqueuelen:0
>          RX bytes:5146 (5.0 KiB)  TX bytes:5146 (5.0 KiB)
>
>
> --
> Pekka J=E4rvinen
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge
>
