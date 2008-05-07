From: Jaime Nebrera <jnebrera@eneotecnologia.com>
In-Reply-To: <1210152122.32216.95.camel@gentoo-jocke.transmode.se>
References: <1210152122.32216.95.camel@gentoo-jocke.transmode.se>
Content-Type: text/plain; charset=utf-8
Date: Wed, 07 May 2008 11:33:02 +0200
Message-Id: <1210152782.4861.6.camel@blas>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] STP bug, loop not detetcted
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: joakim.tjernlund@transmode.se
Cc: Bridge@lists.linux-foundation.org

  Hi Joakim,

  I'm not aware if Linux bridge is aware of this. I can tell you that in
general, STP has problems when mixed with VLANs.

  To solve this some extensions have arised: PVST by Cisco, MSTP, an
improvement more or less estandarized and PVST+, a new update only
available in Cisco environments.

  In general they run multiple "STP" instances per VLAN or VLAN group.

  Regards

El mi=C3=A9, 07-05-2008 a las 11:22 +0200, Joakim Tjernlund escribi=C3=B3:
> Got a bridge with 4 optical VLAN interfaces, eth1.1, eth1.2, eth1.3 and
> eth1.4, attached and the builtin STP enabled. eth1 is connected to
> a "switch" with 4 real interfaces, each real interface maps to one of
> the above mentioned VLANs. =20
>=20
> If I loop two or more interfaces by connecting each interface's output
> to its own input, I get a loop that STP doesn't detect.
> Looping by connecting an output from one interface to another interface
> input works fine.
>=20
> Bug or limitation in STP? If limitation, would RSTP help here?
>=20
> Kernel 2.6.25
>=20
>  Jocke =20
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge
--=20
Jaime Nebrera - jnebrera@eneotecnologia.com
Consultor TI - ENEO Tecnologia SL
Pol. PISA - C/ Manufactura 6, P1, 3B
Mairena del Aljarafe - 41927 - Sevilla
Telf.- 955 60 11 60 / 619 04 55 18

