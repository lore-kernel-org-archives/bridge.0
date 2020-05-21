Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=jBkf6P6nSXkyKzMFNo3bLUqW/4eqoq0c19s0e7M06zY=;
 b=LdVexujeEgbDGsiI0uzhi86AsBADHpO7fcAZkjSHwVByEZ1BzgfoNWK1h/S25Nn5uV
 q8MiB1Pkj2NFuHc53bE/hg3iJ8K1W5X16BokluyyxhBHZbx6aU5XuT4KkCgLzoANwp2z
 0IkrwffwDe1Q0bNIT7SNygMo1YJX/3KNKpJak=
References: <20200520130923.3196432-1-horatiu.vultur@microchip.com>
 <20200520130923.3196432-2-horatiu.vultur@microchip.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <cecbdbf0-bb49-1e3c-c163-8e7412c6fcec@cumulusnetworks.com>
Date: Thu, 21 May 2020 11:16:44 +0300
MIME-Version: 1.0
In-Reply-To: <20200520130923.3196432-2-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH 1/3] bridge: mrp: Add br_mrp_unique_ifindex
	function
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Horatiu Vultur <horatiu.vultur@microchip.com>, jiri@resnulli.us, ivecera@redhat.com, davem@davemloft.net, kuba@kernel.org, roopa@cumulusnetworks.com, andrew@lunn.ch, UNGLinuxDriver@microchip.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org

On 20/05/2020 16:09, Horatiu Vultur wrote:
> It is not allow to have the same net bridge port part of multiple MRP
> rings. Therefore add a check if the port is used already in a different
> MRP. In that case return failure.
> 
> Fixes: 9a9f26e8f7ea ("bridge: mrp: Connect MRP API with the switchdev API")
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  net/bridge/br_mrp.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/net/bridge/br_mrp.c b/net/bridge/br_mrp.c
> index d7bc09de4c139..a5a3fa59c078a 100644
> --- a/net/bridge/br_mrp.c
> +++ b/net/bridge/br_mrp.c
> @@ -37,6 +37,32 @@ static struct br_mrp *br_mrp_find_id(struct net_bridge *br, u32 ring_id)
>  	return res;
>  }
>  
> +static bool br_mrp_unique_ifindex(struct net_bridge *br, u32 ifindex)
> +{
> +	struct br_mrp *mrp;
> +	bool res = true;
> +
> +	rcu_read_lock();

Why do you need the rcu_read_lock() here when lockdep_rtnl_is_held() is used?
You should be able to just do rtnl_dereference() below as this is used only
under rtnl.

> +	list_for_each_entry_rcu(mrp, &br->mrp_list, list,
> +				lockdep_rtnl_is_held()) {
> +		struct net_bridge_port *p;
> +
> +		p = rcu_dereference(mrp->p_port);
> +		if (p && p->dev->ifindex == ifindex) {
> +			res = false;
> +			break;
> +		}
> +
> +		p = rcu_dereference(mrp->s_port);
> +		if (p && p->dev->ifindex == ifindex) {
> +			res = false;
> +			break;
> +		}
> +	}
> +	rcu_read_unlock();
> +	return res;
> +}
> +
>  static struct br_mrp *br_mrp_find_port(struct net_bridge *br,
>  				       struct net_bridge_port *p)
>  {
> @@ -255,6 +281,11 @@ int br_mrp_add(struct net_bridge *br, struct br_mrp_instance *instance)
>  	    !br_mrp_get_port(br, instance->s_ifindex))
>  		return -EINVAL;
>  
> +	/* It is not possible to have the same port part of multiple rings */
> +	if (!br_mrp_unique_ifindex(br, instance->p_ifindex) ||
> +	    !br_mrp_unique_ifindex(br, instance->s_ifindex))
> +		return -EINVAL;
> +
>  	mrp = kzalloc(sizeof(*mrp), GFP_KERNEL);
>  	if (!mrp)
>  		return -ENOMEM;
> 

