Subject: Re: [Bridge] Static arp entries in showmacs?
From: Matthew Hall <matt@ecsc.co.uk>
In-Reply-To: <20040514090520.1030bddd@dell_ss3.pdx.osdl.net>
References: <1084545329.3681.65.camel@miyazaki>
	<20040514090520.1030bddd@dell_ss3.pdx.osdl.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-uBZSpQqTw2Bo87TXaUCK"
Date: Fri, 14 May 2004 17:27:19 +0100
Message-Id: <1084552039.3681.98.camel@miyazaki>
Mime-Version: 1.0
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: bridge@lists.osdl.org


--=-uBZSpQqTw2Bo87TXaUCK
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-05-14 at 09:05 -0700, Stephen Hemminger wrote:
> What is the (pseudo) hardware address of the bridge (ie ifconfig br0)?
> Also, how is IP setup on the linux box.  You need to assign an IP address
> to the bridge (br0) and not to the the ethernet ports (eth0,eth1,eth2...)

It is like so, the bridge has the ip addr 10.0.0.1; the bridge itself
contains the interfaces eth1,2,4 and 5; all of these interfaces _do not_
have an ip address; they are just "ip link set eth$ up'd"; e.g:


br0: <BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue
    link/ether 00:50:c2:11:34:9d brd ff:ff:ff:ff:ff:ff
    inet 10.0.0.1/24 brd 10.255.255.255 scope global br0
eth1: <BROADCAST,MULTICAST,PROMISC,UP> mtu 1500 qdisc pfifo_fast qlen 100
    link/ether 00:50:c2:11:34:9d brd ff:ff:ff:ff:ff:ff
eth2: <BROADCAST,MULTICAST,PROMISC,UP> mtu 1500 qdisc pfifo_fast qlen 100
    link/ether 00:50:c2:11:34:9e brd ff:ff:ff:ff:ff:ff
eth4: <BROADCAST,MULTICAST,PROMISC,UP> mtu 1500 qdisc pfifo_fast qlen 100
    link/ether 00:50:c2:11:36:50 brd ff:ff:ff:ff:ff:ff
eth5: <BROADCAST,MULTICAST,PROMISC,UP> mtu 1500 qdisc pfifo_fast qlen 100
    link/ether 00:50:c2:11:36:51 brd ff:ff:ff:ff:ff:ff

bridge name     bridge id               STP enabled     interfaces
br0             8000.0050c211349d       no              eth1
                                                        eth2
                                                        eth4
                                                        eth5

(The other interfaces are not part of the bridge, one is the external
line (eth0); and the other a separate private network (eth3 -
192.168.x.x).

I will also add, I did a little research on msdn, and found out
something about the MS way of loadbalancing; in that 03:bf:0a:00:00:15
address seems to be a multicast hardware address; frames sent to this
would get sent to all of the hardware addresses in that 'group' (the
other three windows machines (which is why i'm seeing 3 arp replies for
1 request, methinks)).

Happy to oblige with any more info, if required.

Cheers,
Matt

--=-uBZSpQqTw2Bo87TXaUCK
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBApPNnw5xT5S6r89URAhNlAJ4lTAWmlG7O4an7lYRaqykE+PJvSgCaA7zW
qWpLRVIB6r9RTWXv7PV9bc8=
=8gGc
-----END PGP SIGNATURE-----

--=-uBZSpQqTw2Bo87TXaUCK--

