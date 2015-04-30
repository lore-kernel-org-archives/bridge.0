Return-Path: <jeffrey.t.kirsher@intel.com>
Message-ID: <1430398906.2669.111.camel@jtkirshe-mobl>
From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Thu, 30 Apr 2015 06:01:46 -0700
In-Reply-To: <1430238831-29966-3-git-send-email-nicolas.dichtel@6wind.com>
References: <1430238831-29966-1-git-send-email-nicolas.dichtel@6wind.com>
	<1430238831-29966-3-git-send-email-nicolas.dichtel@6wind.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-Wia7gmDkFlwWdnjSRV8w"
Mime-Version: 1.0
Subject: Re: [Bridge] [PATCH net 2/3] bridge/nl: remove wrong use of
	NLM_F_MULTI
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Sathya Perla <sathya.perla@emulex.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Ajit Khaparde <ajit.khaparde@emulex.com>, John Fastabend <john.r.fastabend@intel.com>, Scott Feldman <sfeldma@gmail.com>, intel-wired-lan@lists.osuosl.org, dmitry.tarnyaginuug.ch@6wind.com, Subbu Seetharaman <subbu.seetharaman@emulex.com>, davem@davemloft.net


--=-Wia7gmDkFlwWdnjSRV8w
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2015-04-28 at 18:33 +0200, Nicolas Dichtel wrote:
> NLM_F_MULTI must be used only when a NLMSG_DONE message is sent. In
> fact,
> it is sent only at the end of a dump.
>=20
> Libraries like libnl will wait forever for NLMSG_DONE.
>=20
> Fixes: e5a55a898720 ("net: create generic bridge ops")
> Fixes: 815cccbf10b2 ("ixgbe: add setlink, getlink support to ixgbe and
> ixgbevf")
> CC: John Fastabend <john.r.fastabend@intel.com>
> CC: Sathya Perla <sathya.perla@emulex.com>
> CC: Subbu Seetharaman <subbu.seetharaman@emulex.com>
> CC: Ajit Khaparde <ajit.khaparde@emulex.com>
> CC: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> CC: intel-wired-lan@lists.osuosl.org
> CC: Jiri Pirko <jiri@resnulli.us>
> CC: Scott Feldman <sfeldma@gmail.com>
> CC: Stephen Hemminger <stephen@networkplumber.org>
> CC: bridge@lists.linux-foundation.org
> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

Acked-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

For the i40e and ixgbe driver changes

> ---
>  drivers/net/ethernet/emulex/benet/be_main.c   |  5 +++--
>  drivers/net/ethernet/intel/i40e/i40e_main.c   |  7 ++++---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  4 ++--
>  drivers/net/ethernet/rocker/rocker.c          |  5 +++--
>  include/linux/netdevice.h                     |  6 ++++--
>  include/linux/rtnetlink.h                     |  2 +-
>  net/bridge/br_netlink.c                       |  4 ++--
>  net/bridge/br_private.h                       |  2 +-
>  net/core/rtnetlink.c                          | 12 +++++++-----
>  9 files changed, 27 insertions(+), 20 deletions(-)



--=-Wia7gmDkFlwWdnjSRV8w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJVQie6AAoJEOVv75VaS+3ODhwQAJaclgRr5r7vTkBv6gMGn7y7
tvEan35xxboPRfjfGlZH3bzjuwdagrs6eeC+9Vm9K0I007jIbe+ItJu5FThK4JQH
bvUHZkyPIryeXuYryfoVI/BsuOUavC+WNOr4nNcba5H4E2Vq7CtvczyrUxne4sRc
n7WUYmHCN27C0a5dxRCbEjIL4t1usfU8Ofw0KvgAup8Y9KUXhRVgkVO2DYH9m2to
qSTa9WMSqeXwWJ7tb5f0lHVz6ccuxJWj5VV5JEMNGwul+mULLZbAG7yfcmYyahoS
geGrN/kWZTZkheS46LO5zHnKK1D2H8cRrWMV9hlxU5JbNeklglzTZz6hquTlvz25
nfLCusPkg/f2ddQ7rVW2F7vPYtgngUoQ8YhlQKw738OMiv0UxSSeq+KyGQIVs0yS
LoaxNuW/xEhg75Y06l4hBIfev49ltQgctXpWcDEd79/Kyak0MjWcAPw4oEimgair
+qe/+MzCE89romkvfPF3O2R6guiDx7x1w0MyiGPSBewuQwE/cfvhl52adEMwKMv/
Div5YnqJGCSwQlFqZdmDezHgoQkKO+DTs5GpdL3WrhlBfIyL52ZE2RyBQUZbQqHb
ACvXYu7gceWkkBbV509uEGH/4m3duk6OpoU5mTYD8B0Fj6nFy4i+zamkwVCdAdD5
FdHhI8u9ynqu0ppqICL+
=U8Qp
-----END PGP SIGNATURE-----

--=-Wia7gmDkFlwWdnjSRV8w--

