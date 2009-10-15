Message-ID: <4AD779A5.80004@free.fr>
Date: Thu, 15 Oct 2009 21:36:05 +0200
From: =?ISO-8859-15?Q?Nicolas_de_Peslo=FCan?= <nicolas.2p.debian@free.fr>
MIME-Version: 1.0
References: <4AD737A7.3090103@futureware.at>
In-Reply-To: <4AD737A7.3090103@futureware.at>
Content-Type: text/plain; charset="iso-8859-15"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] Linux Dynamic Bridging Support
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?ISO-8859-15?Q?Philipp_G=FChring?= <pg@futureware.at>
Cc: bridge@osdl.org

Philipp G=FChring a =E9crit :
> Hi,
>=20
> The scenario I have is that I have a computer with one network interface
> eth0, that is receiving it's configuration through DHCP, and uses
> complex firewalling rules for eth0.
>=20
> Now I want to add a virtual machine on that computer
>=20
> According to the usual recipies, I have to do the following:
>=20
> ifconfig eth0 0.0.0.0
> brctl addbr br0
> brctl addif br0 eth0
> dhclient br0
>=20
> Afterwards I can add interfaces to the bridge:
> brctl addif br0 tun0
>=20
> This has several disadvantages:
> * It causes a network outage for up to a few seconds (mostly due to the
> unnecessary DHCP)
> * It does not migrate the firewall rules to br0
> * It breaks all firewall-rules that were written for eth0
> * If I use eth0 in the office today, wlan0 at home, and ppp0 when I am
> outside, then I would need lots of different scripts for all the
> different bridging combinations.
>=20
> Now the idea is to add migration support to Linux Bridging.
>=20
> It could look like this:
>=20
> brctl addbr br0
> brctl takeif br0 eth0
>=20
> take-interface would migrate the IP address, and routing entries from
> the eth0 interface to the bridge, in a more-or-less atomic fashion, and
> add eth0 as interface to the brige. It would also adapt iptables-rules
> that were written for eth0 to be pointing to br0 now.
>=20
> To release the bridge again, it could be done like this:
> brctl releaseif br0 eth0
> brctl delbr br0
>=20
> Since all that is a bit complex, I still have an alternative proposal:
> What if we bridge-enable all normal interfaces?
> It could look like this:
>=20
> brctl enablebr eth0
>=20
> This would enable bridging mode for the eth0 interface. It automatically
> is able to use the DHCP ip address it was given, the firewalling, ...
> I can then easily add additional interfaces to the bridge-enabled
> interface like this:
>=20
> brctl addif eth0 tun0
>=20
> And I don't need to worry about DHCP, firewalls, ... anymore.
>=20
> So my question now is:
> Which way should we go? Migrating interface configuration into bridges,
> or bridge-enabling interfaces?

So you expect some changes in the kernel to reduce the complexity of the sc=
ripts that manage your=20
different network setup... I'm not sure that adding complexity into the ker=
nel to reduce a script=20
complexity is about to happen at some time... :-)

If building a generic script for your network setup is really too complex, =
you can try and=20
dynamically rename your interfaces... For example, you arrange for ppp0, et=
h0 or br0 to be named=20
myinterface0, based on your current needs, then setup myinterface0, with th=
e setup you expect.

HTH.

	Nicolas.
