Message-ID: <4D8121EF.3030200@free.fr>
Date: Wed, 16 Mar 2011 21:47:43 +0100
From: =?ISO-8859-1?Q?Nicolas_de_Peslo=FCan?= <nicolas.2p.debian@free.fr>
MIME-Version: 1.0
References: <1300302933.1462.5.camel@bordalnx>
In-Reply-To: <1300302933.1462.5.camel@bordalnx>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [Bonding-devel] bonding inside a bridge does not work
 when using arp monitoring
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Leonardo Borda <leonardo.borda@canonical.com>
Cc: Bridge <bridge@lists.linux-foundation.org>, bonding-devel@lists.sourceforge.net

Le 16/03/2011 20:15, Leonardo Borda a =E9crit :
> Hi Guys,
>
> In case you're interested or you guys have some hints to add to this
> thread, I've opened a bug in Ubuntu Launchpad regarding Bonding + Bridge
> issues.
>
> https://bugs.launchpad.net/bugs/736226
>
> Please let me know your thoughts about it.
>

Hi Leonardo,

I'm afraid I don't understand your setup.

See my comments below.

 > auto bond0
 > iface bond0 inet manual
 >     post-up ifconfig $IFACE up
 >     pre-down ifconfig $IFACE down
 >     bond-slaves none
 >     bond-mode active-backup
 >     bond_arp_ip_target 10.153.107.1
 >     bond_arp_interval 100

 > auto eth0
 > allow-bond0 eth0
 > iface eth0 inet manual
 >     bond-master bond0

 > auto eth1
 > allow-bond0 eth1
 > iface eth1 inet manual
 >     bond-master bond0

eth0----+
         |
         +----bond0
         |
eth1----+

'sounds good up to this point.

 > auto bond0.100
 > iface bond0.100 inet manual
 >     post-up ifconfig $IFACE up
 >     pre-down ifconfig $IFACE down
 >     vlan-raw-device bond0

 > auto bond0.200
 > iface bond0.200 inet manual
 >     post-up ifconfig $IFACE up
 >     pre-down ifconfig $IFACE down
 >     vlan-raw-device bond0

eth0----+             +----bond0.100
         |             |
         +----bond0----+
         |             |
eth1----+             +----bond0.200

So you split based on the VLAN ID.

 > auto br0
 > iface br0 inet static
 >     address 10.153.107.110
 >     netmask 255.255.255.0
 >     gateway 10.153.107.1
 >     bridge_ports bond0
 >     bridge_stp off
 >     bridge_fd 0
 >     bridge_maxwait 0

eth0----+             +----bond0.100
         |             |
         +----bond0----+----br0
         |             |
eth1----+             +----bond0.200

br0 clearly is built on bond0. Starting from this point, I'm not sure I und=
erstand your setup.

Because bond0.100, bond0.200 and br0 are all built on bond0, I can imagine =
bonding will take the=20
frame before bridge have a chance to see it (because bonding handling happe=
ns before bridge handling=20
in __netif_receive_skb(), in the kernel version you use).

 > auto br0-100
 > iface br0-100 inet manual
 >     post-up ifconfig $IFACE up
 >     pre-down ifconfig $IFACE down
 >     bridge_ports bond0.100
 >     bridge_stp off
 >     bridge_fd 0
 >     bridge_maxwait 0

 > auto br0-200
 > iface br0-200 inet manual
 >     post-up ifconfig $IFACE up
 >     pre-down ifconfig $IFACE down
 >     bridge_ports bond0.200
 >     bridge_stp off
 >     bridge_fd 0
 >     bridge_maxwait 0

eth0----+             +----bond0.100----br0-100
         |             |
         +----bond0----+----br0
         |             |
eth1----+             +----bond0.200----br0-200

br0-100 is built on bond0.100 and br0-200 is built on bond0.200.

So you end up with 3 bridges, all having a single port... this sounds usele=
ss, from my point of view.

Can you do some sort of ascii art to describe your expected setup?

The only reason I can imagine to stack a bridge on top of bonding is the fo=
llowing:

eth0----+
         |
         +----bond0----+
         |             |
eth1----+             |
                       +----br0
eth2----+             |
         |             |
         +----bond1----+
         |
eth3----+

That way, the bridge becomes 802.3ad capable, thanks to bonding.

And if you want to do vlan on top of that:

eth0----+
         |
         +----bond0----+
         |             |           +----br0.100
eth1----+             |           |
                       +----br0----+
eth2----+             |           |
         |             |           +----br0.200
         +----bond1----+
         |
eth3----+

The following (untested) setup should provide this configuration:

auto bond0
iface bond0 inet manual
     bond-slaves none
     bond-mode active-backup
     bond_arp_ip_target 10.153.107.1
     bond_arp_interval 100

auto eth0
allow-bond0 eth0
iface eth0 inet manual
     bond-master bond0

auto eth1
allow-bond0 eth1
iface eth1 inet manual
     bond-master bond0

auto eth2
allow-bond1 eth2
iface eth0 inet manual
     bond-master bond1

auto eth3
allow-bond1 eth3
iface eth1 inet manual
     bond-master bond1

auto br0
iface br0 inet static
     bridge_ports bond0 bond1
     bridge_stp off
     bridge_fd 0
     bridge_maxwait 0

auto br0.100
iface br0.100 inet manual
     vlan-raw-device br0
     address 10.153.107.110
     netmask 255.255.255.0
     gateway 10.153.107.1

auto br0.200
iface br0.200 inet manual
     vlan-raw-device br0

	Nicolas.
