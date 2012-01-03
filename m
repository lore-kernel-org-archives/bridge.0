Return-Path: <richard@nod.at>
Message-ID: <4F03650D.8050200@nod.at>
Date: Tue, 03 Jan 2012 21:29:01 +0100
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <4F025A07.2000304@nod.at>
	<1325597164-13459-1-git-send-email-richard@nod.at>
	<1325597164-13459-2-git-send-email-richard@nod.at>
	<20120103081521.2fec3a29@nehalam.linuxnetplumber.net>
	<4F033E11.5060707@nod.at> <4F0361D7.3000602@pandora.be>
In-Reply-To: <4F0361D7.3000602@pandora.be>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6E73FD4239D9CA1170A15979"
Subject: Re: [Bridge] [PATCH] netfilter: Fix br_nf_pre_routing() in
 conjunction with bridge-nf-call-ip(6)tables=0
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Bart De Schuymer <bdschuym@pandora.be>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org, Stephen Hemminger <shemminger@vyatta.com>, davem@davemloft.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6E73FD4239D9CA1170A15979
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Am 03.01.2012 21:15, schrieb Bart De Schuymer:
> The documentation is probably not explicit enough, but I would keep the=

> behavior as it is now. Setting bridge-nf-call-iptables to 0 makes
> iptables behave as if bridge-netfilter was not enabled at compilation.
> Anyway, your patch is almost certainly flawed since the fact that
> skb->nf_bridge can be NULL is used as part of the logic in
> br_netfilter.c: it indicates that bridge-nf-call-iptables was 0 when th=
e
> packet was first processed by bridge-netfilter and should therefore not=

> be given to iptables in any other netfilter hook.

Thanks for the explanation!

Wouldn't it make sense to check for bridge-nf-call-iptables in xt_physdev=
?
So that the user gets warned that his iptables rule will never match...

Thanks,
//richard



--------------enig6E73FD4239D9CA1170A15979
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQEcBAEBAgAGBQJPA2UNAAoJEN9758yqZn9esRYIAIk5GxS5s1dkDZwOKdvuUUCZ
3AQddHjP1yAMsluheZCXjgZNJ6cItl0T+y+0iwKZow0oNHkjp8czgCfyF6W97xSm
4fAKYDwAMfwiJsqunvOowVBo1+xFTVLBsOo9fAf/6zsRbKJrth2oNG3ijRa5iZuf
mwbs1j3AdCWGUksF7vKVDemkO3eXFX8tdDbqfFKGfjdjPXRMo0AGzMkkNKZFfhJ8
v1llsdO1y5+Z+G8fK3BOyHdUzaCUHqYtLJ4GEznF3IqyFXcSir51dhwkfnidAnUP
rtKYds5Rd7WsbAnSseb0eJWMLHz4/XwqEdOJBpAG+TzLIZA48B8kST6DZdFoQCc=
=LJRl
-----END PGP SIGNATURE-----

--------------enig6E73FD4239D9CA1170A15979--
