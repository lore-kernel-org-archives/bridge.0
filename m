Message-ID: <4D793AB5.5030807@gmail.com>
Date: Thu, 10 Mar 2011 21:55:17 +0100
From: =?ISO-8859-1?Q?Nicolas_de_Peslo=FCan?=
 <nicolas.2p.debian@gmail.com>
MIME-Version: 1.0
References: <1299788413.4801.20.camel@bordalnx>
In-Reply-To: <1299788413.4801.20.camel@bordalnx>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
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
To: bonding-devel@lists.sourceforge.net, Bridge <bridge@lists.linux-foundation.org>

Le 10/03/2011 21:20, Leonardo Borda a =E9crit :
> Hello Guys,

Hi Leonardo,

> I am trying to configure bridge + bonding with arp monitoring enabled.
> Whenever I activate the bridge interface and assign bond0 to the bridge
> Everything stops working.
>
> I am on ubuntu 10.04 LTS.
>
> Can I have an ip address in the bond0 interface WHILE not having an IP
> address in the bridge interface?
> In order to have bond arp monitoring I must have an ip address in the
> bond interface as far as I understand.

Did you try to setup the IP address on br0 instead? I think it should work.=
 Do you have any reasons=20
to put the IP address on bond0 instead?

> Here it is my current configuration.
> PS: I have seen similar configurations although none of them have an ip
> address configured in the bond0 interface.
>
> # The loopback network interface
> auto lo
> iface lo inet loopback
>
> auto bond0
> iface bond0 inet static
>          address 10.153.107.110
>          netmask 255.255.255.0
>          gateway 10.153.107.1
> bond-slaves none
> bond-mode active-backup
> bond_arp_ip_target 10.153.107.1
> bond_arp_interval 500
>
> auto eth0
> iface eth0 inet manual
> bond-master bond0
> bond-primary eth0 eth1
>
> auto eth1
> iface eth1 inet manual
> bond-master bond0
> bond-primary eth0 eth1
>
> auto br0
> iface br0 inet manual
>      bridge_ports bond0
>      bridge_stp off
>      bridge_fd 9
>      bridge_hello 2
>      bridge_maxage 12
>      bridge_maxwait 0
>
> Leonardo
>
>
> -------------------------------------------------------------------------=
-----
> Colocation vs. Managed Hosting
> A question and answer guide to determining the best fit
> for your organization - today and in the future.
> http://p.sf.net/sfu/internap-sfd2d
> _______________________________________________
> Bonding-devel mailing list
> Bonding-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bonding-devel
>

