Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E87E740527
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1DBC0400DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20221208.gappssmtp.com; s=20221208; t=1685371777; x=1687963777;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GcrQMrKy+OprIuWHewbOIu72Ifyis4UMZQEl5zsj5eY=;
 b=5WKAVKkEka7F0V0UH/QnKyjgdHe+0JlZ0H/UYvuVK0qFeJdBKuUTGb7Ccq3NilLS1S
 TLrrUB/INdpL2M8vqh60VCxX1sHnDt2DHwOgVT7tbRB0l9UGhcELh2EFolhT5vfQTzw6
 nJoWcyC0TayAZCw1zX5V0ojydpm1ay5LFdludzqFNmOqKlAXg0t7WqmL7rg7t3HXKTG8
 Ypzx+MAqYQNJpxwl0l3oYtFp6aKR/KYTWkkDEVywSyM3UKE+h+fZWTd6QPJv4C0s4k0y
 oRLru+0fOFmYXUAX1BCuYBr59dsQTa3pzdT8WPotzHaURpElQoOuSXC2wB50IxO3KgVe
 AmbA==
Message-ID: <923b2fdc-6313-67d7-5577-720da309eccf@blackwall.org>
Date: Mon, 29 May 2023 17:49:35 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20230529114835.372140-1-idosch@nvidia.com>
 <20230529114835.372140-7-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20230529114835.372140-7-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v2 6/8] mlxsw: spectrum_flower: Do not
 force matching on iif
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: taras.chornyi@plvision.eu, petrm@nvidia.com, alexandre.belloni@bootlin.com, jiri@resnulli.us, leon@kernel.org, vladimir.oltean@nxp.com, roopa@nvidia.com, claudiu.manoil@nxp.com, UNGLinuxDriver@microchip.com, edumazet@google.com, jhs@mojatatu.com, xiyou.wangcong@gmail.com, simon.horman@corigine.com, kuba@kernel.org, pabeni@redhat.com, saeedm@nvidia.com, davem@davemloft.net

On 29/05/2023 14:48, Ido Schimmel wrote:
> Currently, mlxsw only supports the 'ingress_ifindex' field in the
> 'FLOW_DISSECTOR_KEY_META' key, but subsequent patches are going to add
> support for the 'l2_miss' field as well. It is valid to only match on
> 'l2_miss' without 'ingress_ifindex', so do not force matching on it.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
> 
> Notes:
>     v2:
>     * New patch.
> 
>  drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c
> index 2b0bae847eb9..9c62c12e410b 100644
> --- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c
> +++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c
> @@ -290,6 +290,9 @@ mlxsw_sp_flower_parse_meta_iif(struct mlxsw_sp_acl_rule_info *rulei,
>  	struct mlxsw_sp_port *mlxsw_sp_port;
>  	struct net_device *ingress_dev;
>  
> +	if (!match->mask->ingress_ifindex)
> +		return 0;
> +
>  	if (match->mask->ingress_ifindex != 0xFFFFFFFF) {
>  		NL_SET_ERR_MSG_MOD(extack, "Unsupported ingress ifindex mask");
>  		return -EINVAL;


Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

