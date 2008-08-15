Message-ID: <48A5E1E3.5060907@free.fr>
Date: Fri, 15 Aug 2008 22:06:59 +0200
From: Benoit PAPILLAULT <benoit.papillault@free.fr>
MIME-Version: 1.0
References: <48A0B4AD.6030703@free.fr> <20080811163159.49cf9980@extreme>
In-Reply-To: <20080811163159.49cf9980@extreme>
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
To: Stephen Hemminger <stephen.hemminger@vyatta.com>
Cc: Bridge@lists.linux-foundation.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Stephen Hemminger a =E9crit :
| Rather than an ask a detailed question like "what will happen if I
misconfigure
| the system, then change the behaviour", instead start a discussion about
| your requirements. Like "I need to forward only frames from some MAC
addresses
| in a firewall".  The answer might not involve bridging at all...

In fact, I'm evaluating how to implement rbridge :
http://www.postel.org/rbridge/, which is a mix of bridging and routing.

The latest specifications (IETF draft) are available here:
http://tools.ietf.org/html/draft-ietf-trill-rbridge-protocol-08

I am in a very preliminary phase, trying to learn how to implement
routing and bridging under Linux. In order for the routing protocol to
have proper topology view, it somehow needs to assign a unique IP on all
interfaces and for bridging and those interfaces needs to be in the same
bridge.

Maybe I am wrong in those assumptions, but here is the explanation on my
previous questions.

Regards,
Benoit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFIpeHjOR6EySwP7oIRAuNHAJ47gJDlSnVl40f5cefErBFJSpdToQCg8Z//
CvTdROkWhoeQssqe85U/RRU=3D
=3DuHXt
-----END PGP SIGNATURE-----
