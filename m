Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27683211
	for <bridge@lists.linux-foundation.org>; Tue,  3 Dec 2024 11:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733225978; cv=none; b=Sw1Y6ph3aIXZSdmYGA6LJRXL6FvXhP50iXvr15v3PDr/4JUbIHqK+FYMj/rTNmKdl8a6dU+mNlAZGJxKgZT4yEmhEfVHxTL2xZp3CSkX5FP/VWuK5gK1/ZgVDbf2H9zHYUAsLooNNOXR9UlEwrAp/iSs7froHf4cx2wt1lQXa/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733225978; c=relaxed/simple;
	bh=xxB5eT/PDAcuDICGqGMt8FVxmu5wEVaevgCwd/b2Pzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CJkCi2p+lLhUjlX2jSWGxOU2jwa29qtyAdt1Lze6svrJm4iwrsOpXuHEcjV1FtW6a2y7woqFfEFstTwW5gt9qzTRSuvN/PwszZ/Ve6t3LwE0K45x0LuBr5clGy7/Tu5yagInylNsTTysvofYS6S/pjwLIIJv3NmCXP2o/YvCT6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3E72D40720
	for <bridge@lists.linux-foundation.org>; Tue,  3 Dec 2024 11:39:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.2
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cBY6QXKkaFiU for <bridge@lists.linux-foundation.org>;
 Tue,  3 Dec 2024 11:39:35 +0000 (UTC)
X-Greylist: delayed 1165 seconds by postgrey-1.37 at util1.osuosl.org; Tue, 03 Dec 2024 11:39:34 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 65EE44070D
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 65EE44070D
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a0a:edc0:2:b01:1d::104; helo=metis.whiteo.stw.pengutronix.de; envelope-from=mkl@pengutronix.de; receiver=<UNKNOWN> 
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 65EE44070D
	for <bridge@lists.linux-foundation.org>; Tue,  3 Dec 2024 11:39:34 +0000 (UTC)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tIQwo-00021j-K0; Tue, 03 Dec 2024 12:20:06 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tIQwn-001SwD-04;
	Tue, 03 Dec 2024 12:20:05 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 6E4F93847C0;
	Tue, 03 Dec 2024 11:20:05 +0000 (UTC)
Date: Tue, 3 Dec 2024 12:20:04 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Fabian Pfitzner <f.pfitzner@pengutronix.de>
Cc: netdev@vger.kernel.org, dsahern@gmail.com, entwicklung@pengutronix.de, 
	roopa@nvidia.com, razor@blackwall.org, bridge@lists.linux-foundation.org, 
	stephen@networkplumber.org
Subject: Re: [PATCH v3 iproute] bridge: dump mcast querier state
Message-ID: <20241203-calculating-offbeat-cuttlefish-1812c8-mkl@pengutronix.de>
References: <20241101115039.2604631-1-f.pfitzner@pengutronix.de>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="foac5pniaaxhdgcc"
Content-Disposition: inline
In-Reply-To: <20241101115039.2604631-1-f.pfitzner@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: bridge@lists.linux-foundation.org


--foac5pniaaxhdgcc
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 iproute] bridge: dump mcast querier state
MIME-Version: 1.0

Hello,

can someone take the patch? It still applies to current main.

regards,
Marc

On 01.11.2024 12:50:40, Fabian Pfitzner wrote:
> Kernel support for dumping the multicast querier state was added in this
> commit [1]. As some people might be interested to get this information
> from userspace, this commit implements the necessary changes to show it
> via
>=20
> ip -d link show [dev]
>=20
> The querier state shows the following information for IPv4 and IPv6
> respectively:
>=20
> 1) The ip address of the current querier in the network. This could be
>    ourselves or an external querier.
> 2) The port on which the querier was seen
> 3) Querier timeout in seconds
>=20
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3Dc7fa1d9b1fb179375e889ff076a1566ecc997bfc
>=20
> Signed-off-by: Fabian Pfitzner <f.pfitzner@pengutronix.de>
> ---
>=20
> v1->v2
> 	- refactor code
> 	- link to v1: https://lore.kernel.org/netdev/20241025142836.19946-1-f.pf=
itzner@pengutronix.de/
> v2->v3
> 	- use print_color_string for addresses
> 	- link to v2: https://lore.kernel.org/netdev/20241030222136.3395120-1-f.=
pfitzner@pengutronix.de/
>=20
>  ip/iplink_bridge.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
>=20
> diff --git a/ip/iplink_bridge.c b/ip/iplink_bridge.c
> index f01ffe15..9c01154b 100644
> --- a/ip/iplink_bridge.c
> +++ b/ip/iplink_bridge.c
> @@ -661,6 +661,66 @@ static void bridge_print_opt(struct link_util *lu, F=
ILE *f, struct rtattr *tb[])
>  			   "mcast_querier %u ",
>  			   rta_getattr_u8(tb[IFLA_BR_MCAST_QUERIER]));
> =20
> +	if (tb[IFLA_BR_MCAST_QUERIER_STATE]) {
> +		struct rtattr *bqtb[BRIDGE_QUERIER_MAX + 1];
> +
> +		SPRINT_BUF(other_time);
> +
> +		parse_rtattr_nested(bqtb, BRIDGE_QUERIER_MAX, tb[IFLA_BR_MCAST_QUERIER=
_STATE]);
> +		memset(other_time, 0, sizeof(other_time));
> +
> +		open_json_object("mcast_querier_state_ipv4");
> +		if (bqtb[BRIDGE_QUERIER_IP_ADDRESS]) {
> +			print_string(PRINT_FP,
> +				NULL,
> +				"%s ",
> +				"mcast_querier_ipv4_addr");
> +			print_color_string(PRINT_ANY,
> +				COLOR_INET,
> +				"mcast_querier_ipv4_addr",
> +				"%s ",
> +				format_host_rta(AF_INET, bqtb[BRIDGE_QUERIER_IP_ADDRESS]));
> +		}
> +		if (bqtb[BRIDGE_QUERIER_IP_PORT])
> +			print_uint(PRINT_ANY,
> +				"mcast_querier_ipv4_port",
> +				"mcast_querier_ipv4_port %u ",
> +				rta_getattr_u32(bqtb[BRIDGE_QUERIER_IP_PORT]));
> +		if (bqtb[BRIDGE_QUERIER_IP_OTHER_TIMER])
> +			print_string(PRINT_ANY,
> +				"mcast_querier_ipv4_other_timer",
> +				"mcast_querier_ipv4_other_timer %s ",
> +				sprint_time64(
> +					rta_getattr_u64(bqtb[BRIDGE_QUERIER_IP_OTHER_TIMER]),
> +									other_time));
> +		close_json_object();
> +		open_json_object("mcast_querier_state_ipv6");
> +		if (bqtb[BRIDGE_QUERIER_IPV6_ADDRESS]) {
> +			print_string(PRINT_FP,
> +				NULL,
> +				"%s ",
> +				"mcast_querier_ipv6_addr");
> +			print_color_string(PRINT_ANY,
> +				COLOR_INET6,
> +				"mcast_querier_ipv6_addr",
> +				"%s ",
> +				format_host_rta(AF_INET6, bqtb[BRIDGE_QUERIER_IPV6_ADDRESS]));
> +		}
> +		if (bqtb[BRIDGE_QUERIER_IPV6_PORT])
> +			print_uint(PRINT_ANY,
> +				"mcast_querier_ipv6_port",
> +				"mcast_querier_ipv6_port %u ",
> +				rta_getattr_u32(bqtb[BRIDGE_QUERIER_IPV6_PORT]));
> +		if (bqtb[BRIDGE_QUERIER_IPV6_OTHER_TIMER])
> +			print_string(PRINT_ANY,
> +				"mcast_querier_ipv6_other_timer",
> +				"mcast_querier_ipv6_other_timer %s ",
> +				sprint_time64(
> +					rta_getattr_u64(bqtb[BRIDGE_QUERIER_IPV6_OTHER_TIMER]),
> +									other_time));
> +		close_json_object();
> +	}
> +
>  	if (tb[IFLA_BR_MCAST_HASH_ELASTICITY])
>  		print_uint(PRINT_ANY,
>  			   "mcast_hash_elasticity",
> --=20
> 2.39.5
>=20

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--foac5pniaaxhdgcc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmdO6WEACgkQKDiiPnot
vG8DCAf/ed94RCRS10AEDTPrgRMXEcjirpCqPGOV1aUU/rdHnYgUDCpRZ0qpAm7W
7Po6EARhzwRE99NVuO50WhP1FVIBh+IVGyU5ekX15rf7cqSHETkIrdwnH+yHwzdd
iSdRbqXzhiK5MZx44igOOQqmOFTT14oP+mkKkKvsp8RMSKvT9kODqcSDn4mjE03U
DvbHqo0L6wlBcBs5fQk8s15I+70I+ZQnN+O7ZVYDwKoznZ/TZ/U5QOQ3FI3guELw
W7GzPybhytsaEXxfcLJCYoLgzZ8Du9XihzfJaUkiphdg8x5au1Eku2GC8hNbhD8O
29YQmlFrsuAWlGCmzBbh+voRDt2lIw==
=UcVC
-----END PGP SIGNATURE-----

--foac5pniaaxhdgcc--
