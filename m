Message-ID: <4AA1703A.9070800@free.fr>
Date: Fri, 04 Sep 2009 21:53:30 +0200
From: =?ISO-8859-1?Q?Nicolas_de_Peslo=FCan?= <nicolas.2p.debian@free.fr>
MIME-Version: 1.0
References: <f0a957c30909032014y2076c54ek9fc34c2842124321@mail.gmail.com>
In-Reply-To: <f0a957c30909032014y2076c54ek9fc34c2842124321@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] Bridge and VLANs. Strange behaviour.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Gustavo Martin <gu.martinm@gmail.com>
Cc: bridge@lists.linux-foundation.org

Gustavo Martin wrote:
> Hello list,
>=20
>       I am trying to understand how the linux-based bridges work but I=20
> am watching very strange things.
>=20
>       For example, if I have this configuration for the bridge BR0 with=20
> 2 physical interfaces eth0 and eth1:
>=20
> trying1.jpg
>=20
>      If PC1 sends an ARP REQUEST, PC2 receives this ARP REQUEST but they =

> are in different VLANs!
>      Why the VLAN 20 can receive ARP REQUEST messages from the VLAN 10=20
> and why the VLAN 10 can receive ARP REPLY messages from VLAN 20 if they=20
> are different VLANs? This is crazy for me.
>      I think linux-based bridges don't work very well with VLANs=20
> (probably I am wrong because I am just a beginner)
>      Can someone help me to understand that? Your help would be very=20
> appreciated. :-)

The behavior you describe is normal and exactly the one you asked for.

You have put eth0.10 and eth1.20 in the same bridge, so you asked to bridge=
=20
between eth0.10 and eth1.20.

When a 802.1Q tagged packet is received on eth0, the kernel removes the 802=
.1Q=20
header, having VLAN ID=3D10, then deliver the packet to eth0.10. Then, the =
kernel=20
deliver the packet to the bridge, because eth0.10 is a member of the bridge.

At this time, the bridge code has no knowledge of the original VLAN ID beca=
use=20
this VLAN ID was removed before the bridge code has an opportunity to look =
at it.

The bridge code send the un tagged packet to the right output port if it ca=
n=20
find a suitable destination mac address entry in its mac_to_port table. Els=
e, it=20
simply send the untagged packet to all ports except the one where the packe=
t was=20
received on.

So the untagged packet is sent to eth1.20. Then, the kernel add a 802.1Q he=
ader=20
to the packet, with VLAN ID=3D20, then deliver the packet to eth1, to be se=
nt on=20
the wire.

And you end up with the behavior you describe.

If you want to bridge all ports in VLAN 10 together, all ports in VLAN 20=20
together, and route between VLAN 10 and VLAN 20, you need to setup two diff=
erent=20
bridges :

br10 : eth0.10 + eth1.10 + ... + ethN.10 and possibly some non-802.1Q ports.
br20 : eth0.20 + eth1.20 + ... + ethN.20 and possibly some non-802.1Q ports.

Then setup an IP address in the right subnet on br10 (192.168.1.1) and br20=
=20
(172.16.1.1).

Then ensure that routing is enabled :

echo 1 > /proc/sys/net/ipv4/ip_forward

Feel free to ask, if all this is not clear enough.

	Nicolas.
>=20
> Thanks in advance and sorry for my English.
>=20
> --=20
> Gustavo Mart=EDn Morcuende

