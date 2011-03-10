From: Leonardo Borda <leonardo.borda@canonical.com>
In-Reply-To: <4D793AB5.5030807@gmail.com>
References: <1299788413.4801.20.camel@bordalnx> <4D793AB5.5030807@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 10 Mar 2011 18:39:25 -0500
Message-ID: <1299800365.9834.10.camel@bordalnx>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [Bonding-devel] bridge + bonding with arp monitoring
 enabled
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nicolas de =?ISO-8859-1?Q?Peslo=FCan?= <nicolas.2p.debian@gmail.com>
Cc: Zaid Al Hamami <zaid@canonical.com>, Bridge <bridge@lists.linux-foundation.org>, bonding-devel@lists.sourceforge.net

Hi Nicolas,

Thank you for your suggestion, it works.
Actually I was thinking that in order to have arp monitoring
(bond_arp_ip_target <ip>) enabled the bond0 interface had to have an ip
address configured and as per tcpdump samples show that is not true.=20
So here it is my current working configuration.

# The loopback network interface
auto lo
iface lo inet loopback

auto bond0
iface bond0 inet manual
bond-slaves none
bond-mode active-backup
bond_arp_ip_target 10.153.107.1
bond_arp_interval 60


auto eth0
iface eth0 inet manual
bond-master bond0
bond-primary eth0 eth1

auto eth1
iface eth1 inet manual
bond-master bond0
bond-primary eth0 eth1

auto br0
iface br0 inet static
address 10.153.107.110
netmask 255.255.255.0
gateway 10.153.107.1
bridge_ports bond0
bridge_stp off
bridge_fd 9
bridge_hello 2
bridge_maxage 12
bridge_maxwait 0

###
Tcpdump output

00:1c:c4:6b:38:4a > ff:ff:ff:ff:ff:ff, ARP, length 60: Request who-has
10.153.107.1 tell 0.0.0.0, length 46
00:1c:c4:6b:38:4a > ff:ff:ff:ff:ff:ff, ARP, length 60: Request who-has
10.153.107.1 tell 0.0.0.0, length 46
00:1c:c4:6b:38:4a > ff:ff:ff:ff:ff:ff, ARP, length 60: Request who-has
10.153.107.1 tell 0.0.0.0, length 46

Thanks guys.

Leonardo

On Thu, 2011-03-10 at 21:55 +0100, Nicolas de Peslo=C3=BCan wrote:=20
> Le 10/03/2011 21:20, Leonardo Borda a =C3=A9crit :
> > Hello Guys,
>=20
> Hi Leonardo,
>=20
> > I am trying to configure bridge + bonding with arp monitoring enabled.
> > Whenever I activate the bridge interface and assign bond0 to the bridge
> > Everything stops working.
> >
> > I am on ubuntu 10.04 LTS.
> >
> > Can I have an ip address in the bond0 interface WHILE not having an IP
> > address in the bridge interface?
> > In order to have bond arp monitoring I must have an ip address in the
> > bond interface as far as I understand.
>=20
> Did you try to setup the IP address on br0 instead? I think it should wor=
k. Do you have any reasons=20
> to put the IP address on bond0 instead?
>=20
> > Here it is my current configuration.
> > PS: I have seen similar configurations although none of them have an ip
> > address configured in the bond0 interface.
> >
> > # The loopback network interface
> > auto lo
> > iface lo inet loopback
> >
> > auto bond0
> > iface bond0 inet static
> >          address 10.153.107.110
> >          netmask 255.255.255.0
> >          gateway 10.153.107.1
> > bond-slaves none
> > bond-mode active-backup
> > bond_arp_ip_target 10.153.107.1
> > bond_arp_interval 500
> >
> > auto eth0
> > iface eth0 inet manual
> > bond-master bond0
> > bond-primary eth0 eth1
> >
> > auto eth1
> > iface eth1 inet manual
> > bond-master bond0
> > bond-primary eth0 eth1
> >
> > auto br0
> > iface br0 inet manual
> >      bridge_ports bond0
> >      bridge_stp off
> >      bridge_fd 9
> >      bridge_hello 2
> >      bridge_maxage 12
> >      bridge_maxwait 0
> >
> > Leonardo
> >
> >
> > -----------------------------------------------------------------------=
-------
> > Colocation vs. Managed Hosting
> > A question and answer guide to determining the best fit
> > for your organization - today and in the future.
> > http://p.sf.net/sfu/internap-sfd2d
> > _______________________________________________
> > Bonding-devel mailing list
> > Bonding-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bonding-devel
> >
>=20
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge

--=20
Leonardo Borda
Server Support Analyst
Canonical Canada

