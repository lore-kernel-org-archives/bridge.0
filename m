Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=bqOLOWJcEnmegQMbnR/7WAD5Ory2NkimcCLFj6PkXT4=;
 b=MNKVdqYIQu1sZpEEWrjFHTTAgUy+R5a9ibTbTktvHRxg5WU3UwsT+DYDhAfDTZ1ZVN
 WUkF2IPbZmlF4VcwHRt2g+0rwVYfAWsxUMpNDxOZKs9mfmROSBdrBuvxcGKRLC1byQ50
 gtHo3VrT/HT9vEGVkBYTSpJJxyNB1z1PPj1jQ=
References: <20200520130923.3196432-1-horatiu.vultur@microchip.com>
 <20200520130923.3196432-4-horatiu.vultur@microchip.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <05ddf496-9f6d-ae23-1bdb-40f0fe0e3b3c@cumulusnetworks.com>
Date: Thu, 21 May 2020 11:18:20 +0300
MIME-Version: 1.0
In-Reply-To: <20200520130923.3196432-4-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH 3/3] bridge: mrp: Restore port state when
 deleting MRP instance
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
> When a MRP instance is deleted, then restore the port according to the
> bridge state. If the bridge is up then the ports will be in forwarding
> state otherwise will be in disabled state.
> 
> Fixes: 9a9f26e8f7ea ("bridge: mrp: Connect MRP API with the switchdev API")
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  net/bridge/br_mrp.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

> diff --git a/net/bridge/br_mrp.c b/net/bridge/br_mrp.c
> index a5a3fa59c078a..bdd8920c15053 100644
> --- a/net/bridge/br_mrp.c
> +++ b/net/bridge/br_mrp.c
> @@ -229,6 +229,7 @@ static void br_mrp_test_work_expired(struct work_struct *work)
>  static void br_mrp_del_impl(struct net_bridge *br, struct br_mrp *mrp)
>  {
>  	struct net_bridge_port *p;
> +	u8 state;
>  
>  	/* Stop sending MRP_Test frames */
>  	cancel_delayed_work_sync(&mrp->test_work);
> @@ -240,20 +241,24 @@ static void br_mrp_del_impl(struct net_bridge *br, struct br_mrp *mrp)
>  	p = rtnl_dereference(mrp->p_port);
>  	if (p) {
>  		spin_lock_bh(&br->lock);
> -		p->state = BR_STATE_FORWARDING;
> +		state = netif_running(br->dev) ?
> +				BR_STATE_FORWARDING : BR_STATE_DISABLED;
> +		p->state = state;
>  		p->flags &= ~BR_MRP_AWARE;
>  		spin_unlock_bh(&br->lock);
> -		br_mrp_port_switchdev_set_state(p, BR_STATE_FORWARDING);
> +		br_mrp_port_switchdev_set_state(p, state);
>  		rcu_assign_pointer(mrp->p_port, NULL);
>  	}
>  
>  	p = rtnl_dereference(mrp->s_port);
>  	if (p) {
>  		spin_lock_bh(&br->lock);
> -		p->state = BR_STATE_FORWARDING;
> +		state = netif_running(br->dev) ?
> +				BR_STATE_FORWARDING : BR_STATE_DISABLED;
> +		p->state = state;
>  		p->flags &= ~BR_MRP_AWARE;
>  		spin_unlock_bh(&br->lock);
> -		br_mrp_port_switchdev_set_state(p, BR_STATE_FORWARDING);
> +		br_mrp_port_switchdev_set_state(p, state);
>  		rcu_assign_pointer(mrp->s_port, NULL);
>  	}
>  
> 

