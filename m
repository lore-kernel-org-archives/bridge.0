Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m96s0A8yWAc/y2o1wu4C3ADL3df0rGv1s3OLK82OF4o=;
 b=Enr9SUqbIHmEfSPjXK7JYLa4D5crQfBZ7kw3b06R6mSFiRIdbCKB8eEYdgf24FgA2ieuDIlUmZlbgGsvQgAWT++KEM5+FDR2r5LlqNajOHo9iOlEXc/ylQQQaDr8QUmi2UjsgleNSjr3uNDaxt1Z8Ye5XiMMeMZ7V9oo3bekuFQ=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Mon, 11 Apr 2022 20:23:15 +0000
Message-ID: <20220411202315.mxgqmvktodavdmwr@skbuf>
References: <20220411133837.318876-1-troglobit@gmail.com>
 <20220411133837.318876-10-troglobit@gmail.com>
In-Reply-To: <20220411133837.318876-10-troglobit@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D35A160572A0034CBD022B8C0B006BAB@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH RFC net-next 09/13] selftests: forwarding:
 rename test groups for next bridge mdb tests
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

On Mon, Apr 11, 2022 at 03:38:33PM +0200, Joachim Wiberg wrote:
> Rename test groups to PASS and FAIL, respectively, for upcoming changes
> to test suite.
>=20
> Signed-off-by: Joachim Wiberg <troglobit@gmail.com>
> ---
>  .../selftests/net/forwarding/bridge_mdb.sh     | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
>=20
> diff --git a/tools/testing/selftests/net/forwarding/bridge_mdb.sh b/tools=
/testing/selftests/net/forwarding/bridge_mdb.sh
> index b1ba6876dd86..c0b84b7d4364 100755
> --- a/tools/testing/selftests/net/forwarding/bridge_mdb.sh
> +++ b/tools/testing/selftests/net/forwarding/bridge_mdb.sh
> @@ -7,9 +7,15 @@
>  ALL_TESTS=3D"mdb_add_del_test"
>  NUM_NETIFS=3D2
> =20
> -TEST_GROUP_IP4=3D"225.1.2.3"
> -TEST_GROUP_IP6=3D"ff02::42"
> -TEST_GROUP_MAC=3D"01:00:01:c0:ff:ee"
> +PASS_GRP_IP4=3D"225.1.2.3"
> +FAIL_GRP_IP4=3D"225.1.2.4"

This is more than just the advertised rename, the fail groups are new
and not used in this change.

> +
> +PASS_GRP_MAC=3D"01:00:01:c0:ff:ee"
> +FAIL_GRP_MAC=3D"01:00:01:c0:ff:ef"
> +
> +PASS_GRP_IP6=3D"ff02::42"
> +FAIL_GRP_IP6=3D"ff02::43"
> +
> =20
>  source lib.sh
> =20
> @@ -88,9 +94,9 @@ do_mdb_add_del()
> =20
>  mdb_add_del_test()
>  {
> -	do_mdb_add_del $TEST_GROUP_MAC permanent
> -	do_mdb_add_del $TEST_GROUP_IP4
> -	do_mdb_add_del $TEST_GROUP_IP6
> +	do_mdb_add_del $PASS_GRP_MAC permanent
> +	do_mdb_add_del $PASS_GRP_IP4
> +	do_mdb_add_del $PASS_GRP_IP6
>  }
> =20
>  trap cleanup EXIT
> --=20
> 2.25.1
>=
