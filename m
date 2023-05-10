Return-Path: <enachman@marvell.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 54D3D60B22
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4208860A88
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f6qnClrr04Cd26YVnIk3hbt5OaQVuPPK+HG8FIgWTwA=;
 b=qPbEdLuhp7WJ8Sh89CMdORrG1z0E8w494r0s3HHtg+UW8LasQ5G0QsyrFB0AoHuGH0oLiwva+l+D0f/ccRr1lOGDfp/1SnxC7e9BDFN1NZSE+m0ajJiEPs+fnu98uwFY43l6797pcF/TObc7xHT11OU8k8csCic9KTiJvasQOx8=
From: Elad Nachman <enachman@marvell.com>
Date: Wed, 10 May 2023 09:57:36 +0000
Message-ID: <BN9PR18MB42515532FEB4A498D39AB073DB779@BN9PR18MB4251.namprd18.prod.outlook.com>
References: <20230509070446.246088-1-idosch@nvidia.com>
 <20230509070446.246088-4-idosch@nvidia.com>
In-Reply-To: <20230509070446.246088-4-idosch@nvidia.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [EXT] [RFC PATCH net-next 3/5] flow_offload: Reject
 matching on layer 2 miss
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@nvidia.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>
Cc: "petrm@nvidia.com" <petrm@nvidia.com>, "jiri@resnulli.us" <jiri@resnulli.us>, "taspelund@nvidia.com" <taspelund@nvidia.com>, "xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>, "razor@blackwall.org" <razor@blackwall.org>, "jhs@mojatatu.com" <jhs@mojatatu.com>, "edumazet@google.com" <edumazet@google.com>, "roopa@nvidia.com" <roopa@nvidia.com>, "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "davem@davemloft.net" <davem@davemloft.net>



> -----Original Message-----
> From: Ido Schimmel <idosch@nvidia.com>
> Sent: Tuesday, May 9, 2023 10:05 AM
> To: netdev@vger.kernel.org; bridge@lists.linux-foundation.org
> Cc: davem@davemloft.net; kuba@kernel.org; pabeni@redhat.com;
> edumazet@google.com; razor@blackwall.org; roopa@nvidia.com;
> jhs@mojatatu.com; xiyou.wangcong@gmail.com; jiri@resnulli.us;
> petrm@nvidia.com; taspelund@nvidia.com; Ido Schimmel
> <idosch@nvidia.com>
> Subject: [EXT] [RFC PATCH net-next 3/5] flow_offload: Reject matching on
> layer 2 miss
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> Adjust drivers that support the 'FLOW_DISSECTOR_KEY_META' key to reject
> filters that try to match on the newly added layer 2 miss option. Add an
> extack message to clearly communicate the failure reason to user space.
>=20
> Example:
>=20
>  # tc filter add dev swp1 egress pref 1 proto all flower skip_sw l2_miss =
true
> action drop
>  Error: mlxsw_spectrum: Can't match on "l2_miss".
>  We have an error talking to the kernel
>=20
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  .../net/ethernet/marvell/prestera/prestera_flower.c    |  6 ++++++
>  drivers/net/ethernet/mellanox/mlx5/core/en_tc.c        |  6 ++++++
>  drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c  |  6 ++++++
>  drivers/net/ethernet/mscc/ocelot_flower.c              | 10 ++++++++++
>  4 files changed, 28 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/marvell/prestera/prestera_flower.c
> b/drivers/net/ethernet/marvell/prestera/prestera_flower.c
> index 91a478b75cbf..3e20e71b0f81 100644
> --- a/drivers/net/ethernet/marvell/prestera/prestera_flower.c
> +++ b/drivers/net/ethernet/marvell/prestera/prestera_flower.c
> @@ -148,6 +148,12 @@ static int prestera_flower_parse_meta(struct
> prestera_acl_rule *rule,
>  	__be16 key, mask;
>=20
>  	flow_rule_match_meta(f_rule, &match);
> +
> +	if (match.mask->l2_miss) {
> +		NL_SET_ERR_MSG_MOD(f->common.extack, "Can't match on
> \"l2_miss\"");
> +		return -EOPNOTSUPP;
> +	}
> +
>  	if (match.mask->ingress_ifindex !=3D 0xFFFFFFFF) {
>  		NL_SET_ERR_MSG_MOD(f->common.extack,
>  				   "Unsupported ingress ifindex mask"); diff --
> git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
> b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
> index 728b82ce4031..516653568330 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
> @@ -2586,6 +2586,12 @@ static int mlx5e_flower_parse_meta(struct
> net_device *filter_dev,
>  		return 0;
>=20
>  	flow_rule_match_meta(rule, &match);
> +
> +	if (match.mask->l2_miss) {
> +		NL_SET_ERR_MSG_MOD(f->common.extack, "Can't match on
> \"l2_miss\"");
> +		return -EOPNOTSUPP;
> +	}
> +
>  	if (!match.mask->ingress_ifindex)
>  		return 0;
>=20
> diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c
> b/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c
> index 594cdcb90b3d..6fec9223250b 100644
> --- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c
> +++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c
> @@ -294,6 +294,12 @@ static int mlxsw_sp_flower_parse_meta(struct
> mlxsw_sp_acl_rule_info *rulei,
>  		return 0;
>=20
>  	flow_rule_match_meta(rule, &match);
> +
> +	if (match.mask->l2_miss) {
> +		NL_SET_ERR_MSG_MOD(f->common.extack, "Can't match on
> \"l2_miss\"");
> +		return -EOPNOTSUPP;
> +	}
> +
>  	if (match.mask->ingress_ifindex !=3D 0xFFFFFFFF) {
>  		NL_SET_ERR_MSG_MOD(f->common.extack, "Unsupported
> ingress ifindex mask");
>  		return -EINVAL;
> diff --git a/drivers/net/ethernet/mscc/ocelot_flower.c
> b/drivers/net/ethernet/mscc/ocelot_flower.c
> index ee052404eb55..e0916afcddfb 100644
> --- a/drivers/net/ethernet/mscc/ocelot_flower.c
> +++ b/drivers/net/ethernet/mscc/ocelot_flower.c
> @@ -592,6 +592,16 @@ ocelot_flower_parse_key(struct ocelot *ocelot, int
> port, bool ingress,
>  		return -EOPNOTSUPP;
>  	}
>=20
> +	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_META)) {
> +		struct flow_match_meta match;
> +
> +		flow_rule_match_meta(rule, &match);
> +		if (match.mask->l2_miss) {
> +			NL_SET_ERR_MSG_MOD(extack, "Can't match on
> \"l2_miss\"");
> +			return -EOPNOTSUPP;
> +		}
> +	}
> +
>  	/* For VCAP ES0 (egress rewriter) we can match on the ingress port
> */
>  	if (!ingress) {
>  		ret =3D ocelot_flower_parse_indev(ocelot, port, f, filter);
> --
> 2.40.1
>=20

I have reviewed the prestera part. Looks straightforward enough.

Acked-by: Elad Nachman <enachman@marvell.com>

