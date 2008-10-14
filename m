From: Uli Luckas <u.luckas@road.de>
Date: Tue, 14 Oct 2008 11:36:20 +0200
References: <200809182133.59751.luckas@musoft.de>
	<200810131805.54024.u.luckas@road.de>
	<20081013111016.7b0b1ab9@extreme>
In-Reply-To: <20081013111016.7b0b1ab9@extreme>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1332933.p88MWNv8o0";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200810141136.27333.u.luckas@road.de>
Subject: Re: [Bridge] delay in bridge learning when forward delay is 0
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: bridge@lists.linux-foundation.org

--nextPart1332933.p88MWNv8o0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

> On Mon, 13 Oct 2008 18:04:37 +0200
> Uli Luckas <u.luckas@road.de> wrote:
> > Hello Stephen,
> > you are mentioned in the MAINTAINERS file in the linux kernel tree for
> > "ETHERNET BRIDGE". Could you at least, please acknowledge the reception
> > of this mail? And maybe let us know what you think of the bug report?
> >
> > regards,
> > Uli
>
> Yes, I saw it but the resulting patches were too messy and was
> more concerned about breaking other things. It is on my todo list
> to go back and fix the hold and forwarding timers in general for
> the non STP case. For example, the hold timer keeps running but
> is unused when STP is disabled.

Hi Stephen,
thanks for your reply.=20
If there is anything I can do to help in getting this fixed, please let me=
=20
know.

regards,
Uli


--nextPart1332933.p88MWNv8o0
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkj0aBYACgkQG/Gdq+fBSQvUOwCeO7XX8TGU54PDwQd/pLKQ7Mft
SPYAn1uA5YyG+H6CBmJQP3qZILQEulnT
=bxtI
-----END PGP SIGNATURE-----

--nextPart1332933.p88MWNv8o0--
