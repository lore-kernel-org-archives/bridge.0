Date: Mon, 31 Jan 2005 19:25:41 +0200
From: Ville Mattila <Ville.Mattila@csc.fi>
Message-ID: <20050131172541.GL19777@sampo2.csc.fi>
References: <87pszl99je.fsf@aka.i.naked.iki.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bFsKbPszpzYNtEU6"
Content-Disposition: inline
In-Reply-To: <87pszl99je.fsf@aka.i.naked.iki.fi>
Subject: [Bridge] Re: Bridge MAC address
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Nuutti Kotivuori <naked@iki.fi>
Cc: bridge@osdl.org


--bFsKbPszpzYNtEU6
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

	Terve,


On Mon, 31 Jan 2005, Nuutti Kotivuori wrote:

> How can I set the MAC address for a bridge? The MAC address given for

	How about changing all the physical interfaces to use the same
	MAC address before `brctl addif <ethX> <brY>' ? This probably
	won't work if you have physical loops in the bridged ethernets
	and SPT is used, though. (Surely won't work either if you have=20
	to use VLANs on cheap switches that have one single MAC address=20
	table for all VLANs... like HP 4000M to name one.)


	Ville

--=20
Ville Mattila, system support specialist, Funet network, CSC
PO Box 405, FIN-02101 Espoo, Finland, fax +385 9 457 2302
CSC is the Finnish IT Center for Science, http://www.csc.fi/, email:
ville.mattila@csc.fi

--bFsKbPszpzYNtEU6
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----

iD8DBQFB/moU0UCid37yX/wRAu0VAJoCQLppr5/cDvvfKRMNbaFx7oyURACeLweO
Lp/UD3RPvWj62BnBOxGOP0Q=
=6ONV
-----END PGP SIGNATURE-----

--bFsKbPszpzYNtEU6--
