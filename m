From: Leonardo Borda <leonardo.borda@canonical.com>
In-Reply-To: <4D8121EF.3030200@free.fr>
References: <1300302933.1462.5.camel@bordalnx>  <4D8121EF.3030200@free.fr>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 23 Mar 2011 17:13:14 -0400
Message-ID: <1300914794.32252.68.camel@bordalnx>
Mime-Version: 1.0
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
To: Nicolas de =?ISO-8859-1?Q?Peslo=FCan?= <nicolas.2p.debian@free.fr>
Cc: Bridge <bridge@lists.linux-foundation.org>, bonding-devel@lists.sourceforge.net

Hi Nicolas,

Thank you for answering my question.
Actually this is what I want to achieve:

eth0----+               +----bond0.100----br0-100---{+virtual machines
          |             |
          +----bond0----+----br0---(LAN)
          |             |
eth1----+               +----bond0.200----br0-200---{+virtual machines


br0 --> br0 in my understanding is an untagged vlan therefore it
provides access to my LAN. So i am able to access that server from my
internal network.
br0-100 and br0-200 -> Vlans over a bridged interface will allow me to
have many virtual machines in the same vlan on each bridged interface.

I am misunderstanding concepts, maybe?
If you need to do further tests I have a test environment ready for use.

Leonardo


On Wed, 2011-03-16 at 21:47 +0100, Nicolas de Peslo=C3=BCan wrote:=20
> Le 16/03/2011 20:15, Leonardo Borda a =C3=A9crit :
> > Hi Guys,
> >
> > In case you're interested or you guys have some hints to add to this
> > thread, I've opened a bug in Ubuntu Launchpad regarding Bonding + Bridg=
e
> > issues.
> >
> > https://bugs.launchpad.net/bugs/736226
> >
> > Please let me know your thoughts about it.
> >
>=20
> Hi Leonardo,
>=20
> I'm afraid I don't understand your setup.
>=20
> See my comments below.
>=20
>  > auto bond0
>  > iface bond0 inet manual
>  >     post-up ifconfig $IFACE up
>  >     pre-down ifconfig $IFACE down
>  >     bond-slaves none
>  >     bond-mode active-backup
>  >     bond_arp_ip_target 10.153.107.1
>  >     bond_arp_interval 100
>=20
>  > auto eth0
>  > allow-bond0 eth0
>  > iface eth0 inet manual
>  >     bond-master bond0
>=20
>  > auto eth1
>  > allow-bond0 eth1
>  > iface eth1 inet manual
>  >     bond-master bond0
>=20
> eth0----+
>          |
>          +----bond0
>          |
> eth1----+
>=20
> 'sounds good up to this point.
>=20
>  > auto bond0.100
>  > iface bond0.100 inet manual
>  >     post-up ifconfig $IFACE up
>  >     pre-down ifconfig $IFACE down
>  >     vlan-raw-device bond0
>=20
>  > auto bond0.200
>  > iface bond0.200 inet manual
>  >     post-up ifconfig $IFACE up
>  >     pre-down ifconfig $IFACE down
>  >     vlan-raw-device bond0
>=20
> eth0----+             +----bond0.100
>          |             |
>          +----bond0----+
>          |             |
> eth1----+             +----bond0.200
>=20
> So you split based on the VLAN ID.
>=20
>  > auto br0
>  > iface br0 inet static
>  >     address 10.153.107.110
>  >     netmask 255.255.255.0
>  >     gateway 10.153.107.1
>  >     bridge_ports bond0
>  >     bridge_stp off
>  >     bridge_fd 0
>  >     bridge_maxwait 0
>=20
> eth0----+             +----bond0.100
>          |             |
>          +----bond0----+----br0
>          |             |
> eth1----+             +----bond0.200
>=20
> br0 clearly is built on bond0. Starting from this point, I'm not sure I u=
nderstand your setup.
>=20
> Because bond0.100, bond0.200 and br0 are all built on bond0, I can imagin=
e bonding will take the=20
> frame before bridge have a chance to see it (because bonding handling hap=
pens before bridge handling=20
> in __netif_receive_skb(), in the kernel version you use).
>=20
>  > auto br0-100
>  > iface br0-100 inet manual
>  >     post-up ifconfig $IFACE up
>  >     pre-down ifconfig $IFACE down
>  >     bridge_ports bond0.100
>  >     bridge_stp off
>  >     bridge_fd 0
>  >     bridge_maxwait 0
>=20
>  > auto br0-200
>  > iface br0-200 inet manual
>  >     post-up ifconfig $IFACE up
>  >     pre-down ifconfig $IFACE down
>  >     bridge_ports bond0.200
>  >     bridge_stp off
>  >     bridge_fd 0
>  >     bridge_maxwait 0
>=20
> eth0----+             +----bond0.100----br0-100
>          |             |
>          +----bond0----+----br0
>          |             |
> eth1----+             +----bond0.200----br0-200
>=20
> br0-100 is built on bond0.100 and br0-200 is built on bond0.200.
>=20
> So you end up with 3 bridges, all having a single port... this sounds use=
less, from my point of view.
>=20
> Can you do some sort of ascii art to describe your expected setup?
>=20
> The only reason I can imagine to stack a bridge on top of bonding is the =
following:
>=20
> eth0----+
>          |
>          +----bond0----+
>          |             |
> eth1----+             |
>                        +----br0
> eth2----+             |
>          |             |
>          +----bond1----+
>          |
> eth3----+
>=20
> That way, the bridge becomes 802.3ad capable, thanks to bonding.
>=20
> And if you want to do vlan on top of that:
>=20
> eth0----+
>          |
>          +----bond0----+
>          |             |           +----br0.100
> eth1----+             |           |
>                        +----br0----+
> eth2----+             |           |
>          |             |           +----br0.200
>          +----bond1----+
>          |
> eth3----+
>=20
> The following (untested) setup should provide this configuration:
>=20
> auto bond0
> iface bond0 inet manual
>      bond-slaves none
>      bond-mode active-backup
>      bond_arp_ip_target 10.153.107.1
>      bond_arp_interval 100
>=20
> auto eth0
> allow-bond0 eth0
> iface eth0 inet manual
>      bond-master bond0
>=20
> auto eth1
> allow-bond0 eth1
> iface eth1 inet manual
>      bond-master bond0
>=20
> auto eth2
> allow-bond1 eth2
> iface eth0 inet manual
>      bond-master bond1
>=20
> auto eth3
> allow-bond1 eth3
> iface eth1 inet manual
>      bond-master bond1
>=20
> auto br0
> iface br0 inet static
>      bridge_ports bond0 bond1
>      bridge_stp off
>      bridge_fd 0
>      bridge_maxwait 0
>=20
> auto br0.100
> iface br0.100 inet manual
>      vlan-raw-device br0
>      address 10.153.107.110
>      netmask 255.255.255.0
>      gateway 10.153.107.1
>=20
> auto br0.200
> iface br0.200 inet manual
>      vlan-raw-device br0
>=20
> 	Nicolas.

--=20
Leonardo Borda
Server Support Analyst
Canonical Canada

