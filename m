Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6yyCytTOz3zUDRFj1r8da8s5XHjZ589DIs83L3QOOL0=;
 b=NbksI5KZJ6m3EZa3ZUZa4w4YDgPOvwJRycPSKSZsBYwRd0ns6jB1Sp8VjwzvB5qmv9xxayKqhBPfwRja4J33bz+2K5lwWNg9Ea1GBCk9UB5Yc0n1oMNMdtQvn2SFcuyyUiHQf4oL9VrvTQKg/ww2HVzy2eValePfifBDvh1vtsg=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Mon, 11 Apr 2022 17:20:42 +0000
Message-ID: <20220411172042.prh3hy7ehpc5o34f@skbuf>
References: <20220411133837.318876-1-troglobit@gmail.com>
 <20220411133837.318876-6-troglobit@gmail.com>
In-Reply-To: <20220411133837.318876-6-troglobit@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2DDD7F5B57E7C649929B958CE877A162@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH RFC net-next 05/13] selftests: forwarding: add
 TCPDUMP_EXTRA_FLAGS to lib.sh
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Joachim Wiberg <troglobit@gmail.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, Tobias Waldekranz <tobias@waldekranz.com>

On Mon, Apr 11, 2022 at 03:38:29PM +0200, Joachim Wiberg wrote:
> For some use-cases we may want to change the tcpdump flags used in
> tcpdump_start().  For instance, observing interfaces without the PROMISC
> flag, e.g. to see what's really being forwarded to the bridge interface.
>=20
> Signed-off-by: Joachim Wiberg <troglobit@gmail.com>
> ---
>  tools/testing/selftests/net/forwarding/lib.sh | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>  mode change 100644 =3D> 100755 tools/testing/selftests/net/forwarding/li=
b.sh
>=20
> diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testin=
g/selftests/net/forwarding/lib.sh
> old mode 100644
> new mode 100755
> index 664b9ecaf228..00cdcab7accf
> --- a/tools/testing/selftests/net/forwarding/lib.sh
> +++ b/tools/testing/selftests/net/forwarding/lib.sh
> @@ -1369,7 +1369,13 @@ tcpdump_start()
>  		capuser=3D"-Z $SUDO_USER"
>  	fi
> =20
> -	$ns_cmd tcpdump -e -n -Q in -i $if_name \
> +	if [ -z $TCPDUMP_EXTRA_FLAGS ]; then
> +		extra_flags=3D""
> +	else
> +		extra_flags=3D"$TCPDUMP_EXTRA_FLAGS"
> +	fi
> +
> +	$ns_cmd tcpdump $extra_flags -e -n -Q in -i $if_name \

Could you call directly "$ns_cmd tcpdump $TCPDUMP_EXTRA_FLAGS ..." here,
without an intermediary "extra_flags" global variable which holds the
same content?

You could initialize it just like the way other variables are
initialized, at the beginning of lib.sh:

TCPDUMP_EXTRA_FLAGS=3D${TCPDUMP_EXTRA_FLAGS:=3D}

>  		-s 65535 -B 32768 $capuser -w $capfile > "$capout" 2>&1 &
>  	cappid=3D$!
> =20
> --=20
> 2.25.1
>=
