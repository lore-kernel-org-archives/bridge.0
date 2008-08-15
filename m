Message-ID: <48A5EF12.5030902@free.fr>
Date: Fri, 15 Aug 2008 23:03:14 +0200
From: Benoit PAPILLAULT <benoit.papillault@free.fr>
MIME-Version: 1.0
References: <48A0B4AD.6030703@free.fr>
	<20080811163159.49cf9980@extreme>	<48A5E1E3.5060907@free.fr>
	<alpine.DEB.1.10.0808152114540.27001@callisto.moose.malc.org.uk>
In-Reply-To: <alpine.DEB.1.10.0808152114540.27001@callisto.moose.malc.org.uk>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] frame destinated to individual port MAC address
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Malcolm Scott <Malcolm.Scott@cl.cam.ac.uk>
Cc: Bridge@lists.linux-foundation.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Malcolm Scott a =E9crit :
| At 22:06 today, Benoit PAPILLAULT wrote:
|
|> I am in a very preliminary phase, trying to learn how to implement
|> routing and bridging under Linux. In order for the routing protocol to
|> have proper topology view, it somehow needs to assign a unique IP on all
|> interfaces and for bridging and those interfaces needs to be in the same
|> bridge.
|
| By my understanding (and it's a while since I read that paper so I
might be
| wrong) you don't need unique IP addresses on all interfaces;
everything uses
| MAC addresses.  To quote section 4.2 of the draft:
|
|     o  it runs directly over Layer 2, so therefore may be run with zero
|        configuration (no IP addresses need to be assigned)
|

Correct since the spec is using IS-IS. However, i'd like to use OSPF
instead. I'm reading IS-IS and OSPF details to understand whever a
unique IP is needed per interface. A single IP over the whole would be
more convenient I must admit.

Regards,
Benoit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFIpe8SOR6EySwP7oIRAg5hAKDGrR+MTJ3PfQGwH3GZyFxBKBjSMACbBro8
6la94mShMYWybEzogEaF54A=3D
=3DIRKY
-----END PGP SIGNATURE-----
