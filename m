Return-Path: <matthijs@stdin.nl>
From: Matthijs Kooijman <matthijs@stdin.nl>
Message-ID: <20140627200049.GI1353@login.tika.stderr.nl>
References: <20140627174837.GG1353@login.tika.stderr.nl>
	<20140627185207.GA2843@breakpoint.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oPYnW2SrAqZUvu4n"
Content-Disposition: inline
In-Reply-To: <20140627185207.GA2843@breakpoint.cc>
Subject: Re: [Bridge] Unable to DNAT packets back into originating bridge
	port
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Fri, 27 Jun 2014 20:01:09 -0000
To: Florian Westphal <fw@strlen.de>
Cc: Stephen Hemminger <stephen@networkplumber.org>, bridge@lists.linux-foundation.org, Bart De Schuymer <bart.de.schuymer@pandora.be>, netfilter-devel@vger.kernel.org


--oPYnW2SrAqZUvu4n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hey Florian,

> Sounds like
> http://marc.info/?t=136627796900001&r=1&w=2
Yup, I'm pretty sure this is the same issue. I hadn't realize the need
for source mac address mangling yet. It didn't show up as a problem
in my setup, but I guess it can be needed in some setups.

Gr.

Matthijs

--oPYnW2SrAqZUvu4n
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlOtzXEACgkQz0nQ5oovr7ytWQCfX3Pqn3htX0USPc8jRFfAgY7v
xg8An1s+Vdd6fOU+WRs8e44vVrHRA0xp
=s1HB
-----END PGP SIGNATURE-----

--oPYnW2SrAqZUvu4n--
