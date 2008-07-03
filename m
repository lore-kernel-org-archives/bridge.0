Date: Thu, 3 Jul 2008 09:59:39 -0400
From: Solomon Peachy <solomon@linux-wlan.com>
Message-ID: <20080703135939.GA31482@linux-wlan.com>
References: <20080702230917.GD21344@linux-wlan.com>
	<fed120860807022323u5147beedn33960694ab4e05a5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mojUlQ0s9EVzWg2t"
Content-Disposition: inline
In-Reply-To: <fed120860807022323u5147beedn33960694ab4e05a5@mail.gmail.com>
Subject: Re: [Bridge] [patch] rstpd crashes with GARP/GMRP packets
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "Srinivas M.A." <srinivas.aji@gmail.com>
Cc: bridge@lists.linux-foundation.org


--mojUlQ0s9EVzWg2t
Content-Type: multipart/mixed; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Whoops, the correct patch is attached.

On Thu, Jul 03, 2008 at 11:53:06AM +0530, Srinivas M.A. wrote:
> This looks like the earlier patch, for NETLINK size fixes. Could you
> resend the intended patch. Thanks.
>
> On Thu, Jul 3, 2008 at 4:39 AM, Solomon Peachy <solomon@linux-wlan.com> w=
rote:
> > The attached patch, against Shrinivas's May 7, 2008 snapshot, fixes a
> > null pointer dereference that occurs when we receive a packet from the
> > brige interface that bears the STP MACADDR, but is *not* a STP packet.
> >
> > Specifically, I was receiving GMRP packets (see 802.1D-2004 10.1) from a
> > 3Com switch.
> >
> > I don't know what we should do with these -- but crashing isn't it.  I
> > can send over a packet dump and more debugging info if desired.
>=20
> Looks like we aren't validating the BPDU as we should be. Please send
> any debugging information you have.

--=20
Solomon Peachy                        solomon@linux-wlan.com
AbsoluteValue Systems                 http://www.linux-wlan.com
721-D North Drive                     +1 (321) 259-0737  (office)
Melbourne, FL 32934                   +1 (321) 259-0286  (fax)

--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="rstpd_crash_fix.diff"
Content-Transfer-Encoding: quoted-printable

diff --git a/packages/foss/rstp/bridge_track.c b/packages/foss/rstp/bridge_=
track.c
index e93c014..becfff6 100644
--- a/packages/foss/rstp/bridge_track.c
+++ b/packages/foss/rstp/bridge_track.c
@@ -448,6 +448,12 @@ void bridge_bpdu_rcv(int if_index, const unsigned char=
 *data, int len)
 		return;
=20
 	TST(ifc->up,);
+
+	/* Note, we can receive packets via the bridge interface=20
+	   that are not STP, eg GMRP */
+	if (!ifc->master)=20
+		return;
+
 	if (!ifc->master->stp_up)
 		return;
=20

--RnlQjJ0d97Da+TV1--

--mojUlQ0s9EVzWg2t
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFIbNtKhinxHf95MjYRAuT/AJ9PRHMyAReaFSCvKfw0QzY1QaTEywCglbnD
flUh814v8wNLaBBSOHT/k/w=
=L7vP
-----END PGP SIGNATURE-----

--mojUlQ0s9EVzWg2t--
