Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=WehkoX0W6PSIoJu7M0GhJIMXcm2Th0uwmObbAuHv728=;
	b=ENf+vvQeQnG8nrOApqcCP8kwDHEkhigbVHimCHIW2s3WwYByDkOYM4Dqv4D1oKV3we
	giFRmszPUfyhFLGR9maNKwWT9C+l2FBd7LK4UQKd1UWN7n3PWI2herimv2LK6xHgzBNN
	eT0Md1KRZ8+eqxBCGhxw2Aih8guxOcUISlJ2w=
References: <20180510101306.4891-1-idosch@mellanox.com>
	<20180510101306.4891-2-idosch@mellanox.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <98180677-0f57-cc89-8c7d-db6b3b62baf4@cumulusnetworks.com>
Date: Thu, 10 May 2018 15:06:47 +0300
MIME-Version: 1.0
In-Reply-To: <20180510101306.4891-2-idosch@mellanox.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 1/4] net: bridge: Allow bridge master
 in br_vlan_get_info()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@mellanox.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: petrm@mellanox.com, jiri@mellanox.com, mlxsw@mellanox.com, davem@davemloft.net

On 10/05/18 13:13, Ido Schimmel wrote:
> From: Petr Machata <petrm@mellanox.com>
> 
> Mirroring offload in mlxsw needs to check that a given VLAN is allowed
> to ingress the bridge device. br_vlan_get_info() is the function that is
> used for this, however currently it only supports bridge port devices.
> Extend it to support bridge masters as well.
> 
> Signed-off-by: Petr Machata <petrm@mellanox.com>
> Signed-off-by: Ido Schimmel <idosch@mellanox.com>
> ---
>  net/bridge/br_vlan.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
> index df37a5137c25..dc832c0934c6 100644
> --- a/net/bridge/br_vlan.c
> +++ b/net/bridge/br_vlan.c
> @@ -1176,6 +1176,8 @@ int br_vlan_get_info(const struct net_device *dev, u16 vid,
>  	p = br_port_get_check_rtnl(dev);
>  	if (p)
>  		vg = nbp_vlan_group(p);
> +	else if (netif_is_bridge_master(dev))
> +		vg = br_vlan_group(netdev_priv(dev));
>  	else
>  		return -EINVAL;
>  
> 

Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

