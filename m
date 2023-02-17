Return-Path: <aleksander.lobakin@intel.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 46DDD4159D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 444B841061
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1676641722; x=1708177722;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=zhk0/abzQCEZFdUsDh+NPfhazJaX1xSqFI0JqkGJHiY=;
 b=mUw6Xn9dSJlDo/NxtaQAk4APVCXt8leb/THdBduAw50ydXupK0/0VXjo
 xTggIMa1kin38RK7NYWC9ePRDWwH9MMcluBov1bcqiF2lxr/QtyiZIPQj
 dYDkZNz2gO3HXqyiOL7fETDGonHOPs3s0XPbzEVs/2Tolv9jQzSUFnYPI
 T3+E2/k15nqhM7KIj3wSWnG+louPi+HsVl0XMPRy8ahxmqqWyNPYsVKBF
 rFp/MSApzKFPjXQjREu1lU5L9QMgZ22hCBcXNB+CSWc0XlSzTk/dDj9i/
 oQOxiL1A/L4QOdewFf0dVYSsne8a2lGAayVK8BeiQWs2d772Fo8Qd7n/t w==;
Message-ID: <90adc80b-15d4-0938-e05c-a231991f5b77@intel.com>
Date: Fri, 17 Feb 2023 14:46:56 +0100
Content-Language: en-US
References: <20230217131657.12649-1-alsp705@gmail.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20230217131657.12649-1-alsp705@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH] net-bridge: fix unsafe dereference of
 potential null ptr in __vlan_del()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Alexander Sapozhnikov <alsp705@gmail.com>
Cc: lvc-project@linuxtesting.org, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>

From: Alexander Sapozhnikov <alsp705@gmail.com>
Date: Fri, 17 Feb 2023 16:16:57 +0300

> [PATCH] net-bridge: fix unsafe dereference of potential null ptr in
> __vlan_del()

Must be:

[PATCH net] net: bridge: fix unsafe dereference of potential null ptr in
__vlan_del()

> After having been compared to NULL value at br_vlan.c:399,
> pointer 'p' is passed as 1st parameter in call to function
> 'nbp_vlan_set_vlan_dev_state' at br_vlan.c:420, 
> where it is dereferenced at br_vlan.c:1722.

Do you have a reproducer for this or it's purely hypothetical? I'm not
saying it's strongly required, at least I wouldn't require it, just
curious. And sometimes without a stable repro you should target
net-next, not net, but better ask the bridge maintainers re this.

> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 

Here you should have a "Fixes:" tag with a reference to the commit which
introduced this nullptr-deref.

> Signed-off-by: Alexander Sapozhnikov <alsp705@gmail.com>

You have 2 copies of this patch in the list. The first one lacks proper
commit message, this one has it. But you didn't marked this resent as v2
(it's v2 in fact).
Please mark it accordingly next spin and don't forget always provide a
changelog between versions.

> ---
>  net/bridge/br_vlan.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
> index bc75fa1e4666..87091e270adf 100644
> --- a/net/bridge/br_vlan.c
> +++ b/net/bridge/br_vlan.c
> @@ -417,7 +417,8 @@ static int __vlan_del(struct net_bridge_vlan *v)
>  		rhashtable_remove_fast(&vg->vlan_hash, &v->vnode,
>  				       br_vlan_rht_params);
>  		__vlan_del_list(v);
> -		nbp_vlan_set_vlan_dev_state(p, v->vid);
> +		if (p)
> +			nbp_vlan_set_vlan_dev_state(p, v->vid);
>  		br_multicast_toggle_one_vlan(v, false);
>  		br_multicast_port_ctx_deinit(&v->port_mcast_ctx);
>  		call_rcu(&v->rcu, nbp_vlan_rcu_free);

Thanks,
Olek
