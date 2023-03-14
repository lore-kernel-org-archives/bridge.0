Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 87FA881E29
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DD37F81E24
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112; t=1678797330;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=p84TLvp+HdQDxexv0ZVgLjFCMe9ll2v7yG7+lC1ClDs=;
 b=Mld9CHmB4FHTzkBAeS0Rb14jtQAWfKlcWa1tq0b3sPZ80TE2e0u/zDdJr1uYgJsYu5
 m42BB9k5pGSnurOlsoN5ACj9DT+SZs4Gy7nlcAX0Bvfh/TIGqkkDKA+CW775OlHUF1BY
 7E0+vEXZiVDJEs8ZuGxv9QwcwZCoYYoMo3UFmz8VSaiZgMfZbtgQ8+sHsY+Yy1fb5E0s
 M3Xo29UGyw1SSxVIH17lg4HsIbDef2pkRMkHD7EP+W++6Edj+ycq3mMIJ+mgCP1Ne86k
 yDrBDrkYVbocUKJfvKYD7vFZl4K4JgSb6vX/pupmNdSU0JHx0Fx+vAH0k2tF1HQ/3F0n
 6vGA==
Message-ID: <ce921c1d-2acf-6e67-8bf3-3d5a133c15b9@blackwall.org>
Date: Tue, 14 Mar 2023 14:35:28 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20230313145349.3557231-1-idosch@nvidia.com>
 <20230313145349.3557231-11-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20230313145349.3557231-11-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 10/11] vxlan: Enable MDB support
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: petrm@nvidia.com, mlxsw@nvidia.com, edumazet@google.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

On 13/03/2023 16:53, Ido Schimmel wrote:
> Now that the VXLAN MDB control and data paths are in place we can expose
> the VXLAN MDB functionality to user space.
> 
> Set the VXLAN MDB net device operations to the appropriate functions,
> thereby allowing the rtnetlink code to reach the VXLAN driver.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  drivers/net/vxlan/vxlan_core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
> index 1e55c5582e67..e473200b731f 100644
> --- a/drivers/net/vxlan/vxlan_core.c
> +++ b/drivers/net/vxlan/vxlan_core.c
> @@ -3083,6 +3083,9 @@ static const struct net_device_ops vxlan_netdev_ether_ops = {
>  	.ndo_fdb_del		= vxlan_fdb_delete,
>  	.ndo_fdb_dump		= vxlan_fdb_dump,
>  	.ndo_fdb_get		= vxlan_fdb_get,
> +	.ndo_mdb_add		= vxlan_mdb_add,
> +	.ndo_mdb_del		= vxlan_mdb_del,
> +	.ndo_mdb_dump		= vxlan_mdb_dump,
>  	.ndo_fill_metadata_dst	= vxlan_fill_metadata_dst,
>  };
>  

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

