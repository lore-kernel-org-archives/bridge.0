Return-Path: <M.Roos@f1-outsourcing.eu>
Date: Sun, 8 Apr 2018 18:12:48 +0200
From: "Marc Roos" <M.Roos@f1-outsourcing.eu>
Message-ID: <"H000007100115364.1523203968.sx.f1-outsourcing.eu*"@MHS>
In-Reply-To: <20180408092621.0c9f9f8c@xeon-e3>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: Re: [Bridge] Bridge with 1x eth and 2x tun, adding 2nd eth,
	hosts become unavailable
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: stephen <stephen@networkplumber.org>
Cc: bridge <bridge@lists.linux-foundation.org>

> > In this situation I can ping a vm from br0 connected to 172.16.1.y
> >=20
> >=20
> >=20
> >                +-----------+          =20
> >                |    BR0    |          =20
> >    172.16.1.y  |           |      172.16.1.x
> >        --------|ETH2   TUN1|-------          =20
> >                |           |          =20
> >                |           |      172.16.1.x
> >                |       TUN2|-------          =20
> >                |           |
> >                +-----------+=20
> >=20
> > When only adding a 2nd eth adapter with 'brctl addif br0 eth1'=20
connected=20
> > to 10.11.12.y. The same ping is not working anymore.
> >=20
> >=20
> >                +-----------+          =20
> >                |    BR0    |          =20
> >    172.16.1.y  |           |      172.16.1.x
> >        --------|ETH2   TUN1|-------          =20
> >                |           |          =20
> >                |           |      172.16.1.x
> >     10.11.12.y |       TUN2|-------          =20
> >        --------|ETH1       |
> >                +-----------+          =20
> > 			            =20
> > When I remove the eth1 again, the ping starts working again.
> >=20
> > Can someone explain me why the bridge is behaving like this? And how=20

> > this can be fixed?
> >=20
> > =09
> >=20
> > 	  =20
>=20
> Are you creating a spanning tree loop?  Also. Bridge is a Layer 2=20
device
> not a Layer 3 device; therefore generally all interfaces in a bridge=20
have same
> subnet.
>=20
I don=E2=80=99t think I am creating a loop, I have stp on and ebtables:=20
-i eth2 -o eth1 -j DROP , pcnt =3D 301 -- bcnt =3D 17100
-i eth1 -o eth2 -j DROP , pcnt =3D 3787 -- bcnt =3D 180148

I would like to achieve that what ever hosts and networks I connect on=20
ethx on tunx, could see the other ones located on the the other ethx or=20
tunx. Is this not possible with the bridge? Is there another technique=20
to do this?
=20

