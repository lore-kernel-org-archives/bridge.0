Return-Path: <idosch@idosch.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-me-sender
	:x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=VwSbSwTUHCQpbsNc43
	Z9rP4Isz/DPPnt7E7vu7kBF0o=; b=mEskFHhRh4BIXVHIoT/bScsV/Mi0XLX+sK
	cs77Z/yqISmYfoIZZBu9EVIvnbPVmgktGyVP9mEKpnUicLWTRAgXbNxn0kVs6v6w
	U6pnAgS6cg1KPrazDQpTnDhCWpZcExWBOtdcrrQg7QaeLWXiOS5aJbe1F7Y/3YFk
	DVnVQb+YpF2Lfotj2SpWesOgZhKIQ6djkQ7kzdpYPDYcz5MlrMeXSyAVsSQDvpAW
	BNHJwUZXDwUBMEF/g8lw5QD8nCadidEASvuBe3gAXql5dQf1bpk3AA5UeajxscqO
	LbLXLUhcC8//sM6Zzv60wTOKHFmkOIm5T49QhWKZs6jTgoaEvJmg==
Date: Wed, 4 Oct 2017 16:24:03 +0300
From: Ido Schimmel <idosch@idosch.org>
Message-ID: <20171004132403.GA14864@splinter>
References: <1507093134-20406-1-git-send-email-dsahern@gmail.com>
	<1507093134-20406-8-git-send-email-dsahern@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1507093134-20406-8-git-send-email-dsahern@gmail.com>
Subject: Re: [Bridge] [PATCH net-next 7/7] mlxsw: spectrum: Add extack
 messages for enslave failures
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Ahern <dsahern@gmail.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, idosch@mellanox.com, jiri@mellanox.com, vfalico@gmail.com, j.vosburgh@gmail.com, davem@davemloft.net

On Tue, Oct 03, 2017 at 09:58:54PM -0700, David Ahern wrote:
> mlxsw fails device enslavement for a number of reasons. Use the extack
> facility to return an error message to the user stating why the enslave
> is failing.
> 
> Messages are prefixed with "spectrum" so users know it is a constraint
> imposed by the hardware driver. For example:
>     $ ip li add br0.11 link br0 type vlan id 11
>     $ ip li set swp11 master br0
>     Error: spectrum: Enslaving a port to a device that already has an upper device is not supported.
> 
> Signed-off-by: David Ahern <dsahern@gmail.com>

Great stuff, thanks David!

Reviewed-by: Ido Schimmel <idosch@mellanox.com>
Tested-by: Ido Schimmel <idosch@mellanox.com>

See one small nit below, but I would like to patch
mlxsw_sp_netdevice_port_vlan_event() as well, so I can take care of it
then.

> ---
>  drivers/net/ethernet/mellanox/mlxsw/spectrum.c | 46 ++++++++++++++++++++------
>  1 file changed, 36 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
> index 3adf237c951a..a6cc00e4e543 100644
> --- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
> +++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
> @@ -4019,14 +4019,20 @@ static int mlxsw_sp_lag_index_get(struct mlxsw_sp *mlxsw_sp,
>  static bool
>  mlxsw_sp_master_lag_check(struct mlxsw_sp *mlxsw_sp,
>  			  struct net_device *lag_dev,
> -			  struct netdev_lag_upper_info *lag_upper_info)
> +			  struct netdev_lag_upper_info *lag_upper_info,
> +			  struct netlink_ext_ack *extack)
>  {
>  	u16 lag_id;
>  
> -	if (mlxsw_sp_lag_index_get(mlxsw_sp, lag_dev, &lag_id) != 0)
> +	if (mlxsw_sp_lag_index_get(mlxsw_sp, lag_dev, &lag_id) != 0) {
> +		NL_SET_ERR_MSG(extack, "spectrum: Unknown LAG device");

A more accurate message would be:
"spectrum: Exceeded number of supported LAG devices"

>  		return false;
> -	if (lag_upper_info->tx_type != NETDEV_LAG_TX_TYPE_HASH)
> +	}
> +	if (lag_upper_info->tx_type != NETDEV_LAG_TX_TYPE_HASH) {
> +		NL_SET_ERR_MSG(extack,
> +			       "spectrum: LAG device using unsupported Tx type");
>  		return false;
> +	}
>  	return true;
>  }
