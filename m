Return-Path: <martin@linuxlounge.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxlounge.net;
	s=mail; t=1562071051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
	references:references:openpgp:openpgp:autocrypt:autocrypt;
	bh=QwFRkItdW1M7k4agnxTsrRvmLb/4bS9WjKKcKoKQ+Xw=;
	b=uFMFM7iuNjrk0oV+0w6ldYsORzv+QTLui1LftPBTockPtiRVI6V08jpc3Yo8JsglcDk021
	FhOAajzg2HXVA5kzsOaoN4lf/j2ETGs5DbepGfi7BQI7wVrG8OST/Jej7z4M/b7dtpZxR5
	8NtBWKQe2JRBIZM3SQzOQljIl3buy9Q=
References: <20190702120021.13096-1-nikolay@cumulusnetworks.com>
	<20190702120021.13096-3-nikolay@cumulusnetworks.com>
From: Martin Weinelt <martin@linuxlounge.net>
Message-ID: <fdd4c5d2-1872-bac5-3aa9-107e2081b18f@linuxlounge.net>
Date: Tue, 2 Jul 2019 14:37:28 +0200
In-Reply-To: <20190702120021.13096-3-nikolay@cumulusnetworks.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="aUTpxe2HGk2DC1XXzq6MoiRXZ0eHKSzRs"
Subject: Re: [Bridge] [PATCH net 2/4] net: bridge: mcast: fix stale ipv6 hdr
 pointer when handling v6 query
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, netdev@vger.kernel.org
Cc: yoshfuji@linux-ipv6.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aUTpxe2HGk2DC1XXzq6MoiRXZ0eHKSzRs
Content-Type: multipart/mixed; boundary="NfWoGR4PvcfAR9f75qVkkbowdPSqBgO69";
 protected-headers="v1"
From: Martin Weinelt <martin@linuxlounge.net>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, netdev@vger.kernel.org
Cc: roopa@cumulusnetworks.com, davem@davemloft.net,
 bridge@lists.linux-foundation.org, yoshfuji@linux-ipv6.org
Message-ID: <fdd4c5d2-1872-bac5-3aa9-107e2081b18f@linuxlounge.net>
Subject: Re: [PATCH net 2/4] net: bridge: mcast: fix stale ipv6 hdr pointer
 when handling v6 query
References: <20190702120021.13096-1-nikolay@cumulusnetworks.com>
 <20190702120021.13096-3-nikolay@cumulusnetworks.com>
In-Reply-To: <20190702120021.13096-3-nikolay@cumulusnetworks.com>

--NfWoGR4PvcfAR9f75qVkkbowdPSqBgO69
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Tested-by: Martin Weinelt <martin@linuxlounge.net>

On 7/2/19 2:00 PM, Nikolay Aleksandrov wrote:
> We get a pointer to the ipv6 hdr in br_ip6_multicast_query but we may
> call pskb_may_pull afterwards and end up using a stale pointer.
> So use the header directly, it's just 1 place where it's needed.
>=20
> Fixes: 08b202b67264 ("bridge br_multicast: IPv6 MLD support.")
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> ---
>  net/bridge/br_multicast.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
> index f37897e7b97b..3d8deac2353d 100644
> --- a/net/bridge/br_multicast.c
> +++ b/net/bridge/br_multicast.c
> @@ -1279,7 +1279,6 @@ static int br_ip6_multicast_query(struct net_brid=
ge *br,
>  				  u16 vid)
>  {
>  	unsigned int transport_len =3D ipv6_transport_len(skb);
> -	const struct ipv6hdr *ip6h =3D ipv6_hdr(skb);
>  	struct mld_msg *mld;
>  	struct net_bridge_mdb_entry *mp;
>  	struct mld2_query *mld2q;
> @@ -1323,7 +1322,7 @@ static int br_ip6_multicast_query(struct net_brid=
ge *br,
> =20
>  	if (is_general_query) {
>  		saddr.proto =3D htons(ETH_P_IPV6);
> -		saddr.u.ip6 =3D ip6h->saddr;
> +		saddr.u.ip6 =3D ipv6_hdr(skb)->saddr;
> =20
>  		br_multicast_query_received(br, port, &br->ip6_other_query,
>  					    &saddr, max_delay);
>=20



--NfWoGR4PvcfAR9f75qVkkbowdPSqBgO69--

--aUTpxe2HGk2DC1XXzq6MoiRXZ0eHKSzRs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE7tAWAry9GWw4vJofvUqgUo9j8X4FAl0bUAgACgkQvUqgUo9j
8X5fcAf/cxwx2Jd5RMEWJU3S5Mc06qa6MpH+ssC31UKha2emhkwE4wZxkknT7viv
CRTcMcWJRPk4qkrYHFYpWuy5z7G+fjS9PlhwzHrIbtF8Qv+zausK+MTFqeI6QtsC
z3xrUPvb6oO0l1cqAAuwezXH+1HBmN97tTNXZrBQe2fjaYC5fZ+qUD8PsxpxT5QA
37WJvkb7BVQhkXPZLCNFZpO/0R6dtNlx0c/iHX4LyaSGuXOd5Z3ZppvAiQL9UGtp
lw7CjWuLhLhWU2s4yrXTc1gOEMJnRZDU/rO39Xck0Zf4K3pMsWxQx82B1LqrExfB
LsxsDRwFEjjO7gQdld64Qj/XnH2rsw==
=74Je
-----END PGP SIGNATURE-----

--aUTpxe2HGk2DC1XXzq6MoiRXZ0eHKSzRs--
