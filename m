Return-Path: <kuba@kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2523341F59
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1D46641EFC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1680923000;
 bh=Qf5obg+kL73O79EP37quol4/OI6cp1moqLG2S8Dpxws=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=rsmamPDtsh4Efg7NE67BKnZ0i0b5Rf4UZmYjmvrwQF5g5vN6lRJmdxJZ3KgatruuJ
 iYlFpEKBJ+DnSutf6kimjmyfDQ0ZSdRLpVJfQ6quNLiIAt1fKFHOOEUqyIE0nuaWoH
 qMP3TUG9O4R6VygrURyNJ1BINKABFdq/16OVQ/9O1P+338aEeWxyObnJDS0BXMhHSH
 ucR0UlJ/H0NP9HagRVhKwC+sQVWnsqp934Oe6Q4maBj2d6sQpn96ddwbeFL6tTCPk1
 d6YcbuAXyHK9owauYuDJBsmUTJbdAQQ6vuG0wyfDQigd8bmUWewPU8R46vRr5Z/lcE
 yll5YHTeRN1qQ==
Date: Fri, 7 Apr 2023 20:03:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20230407200319.72fd763f@kernel.org>
In-Reply-To: <202304061930349843930@zte.com.cn>
References: <202304061930349843930@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] net/bridge: add drop reasons for
 bridge forwarding
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: yang.yang29@zte.com.cn
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, edumazet@google.com, zhang.yunkai@zte.com.cn, jiang.xuexin@zte.com.cn, roopa@nvidia.com, pabeni@redhat.com, davem@davemloft.net

On Thu, 6 Apr 2023 19:30:34 +0800 (CST) yang.yang29@zte.com.cn wrote:
> From: xu xin <xu.xin16@zte.com.cn>
> 
> This creates six drop reasons as follows, which will help users know the
> specific reason why bridge drops the packets when forwarding.
> 
> 1) SKB_DROP_REASON_BRIDGE_FWD_NO_BACKUP_PORT: failed to get a backup
>    port link when the destination port is down.
> 
> 2) SKB_DROP_REASON_BRIDGE_FWD_SAME_PORT: destination port is the same
>    with originating port when forwarding by a bridge.
> 
> 3) SKB_DROP_REASON_BRIDGE_NON_FORWARDING_STATE: the bridge's state is
>    not forwarding.
> 
> 4) SKB_DROP_REASON_BRIDGE_NOT_ALLOWED_EGRESS: the packet is not allowed
>    to go out through the port due to vlan filtering.
> 
> 5) SKB_DROP_REASON_BRIDGE_SWDEV_NOT_ALLOWED_EGRESS: the packet is not
>    allowed to go out through the port which is offloaded by a hardware
>    switchdev, checked by nbp_switchdev_allowed_egress().
> 
> 6) SKB_DROP_REASON_BRIDGE_BOTH_PORT_ISOLATED: both source port and dest
>    port are in BR_ISOLATED state when bridge forwarding.

> @@ -338,6 +344,33 @@ enum skb_drop_reason {
>  	 * for another host.
>  	 */
>  	SKB_DROP_REASON_IPV6_NDISC_NS_OTHERHOST,
> +	/** @SKB_DROP_REASON_BRIDGE_FWD_NO_BACKUP_PORT: failed to get a backup
> +	 * port link when the destination port is down.
> +	 */

That's not valid kdoc. Text can be on the same line as the value only
in one-line comments. Otherwise:
	/**
	 * @VALUE: bla bla bla
	 *	more blas.
	 */

> +static inline bool should_deliver(const struct net_bridge_port *p, const struct sk_buff *skb,
> +					 enum skb_drop_reason *need_reason)
>  {
>  	struct net_bridge_vlan_group *vg;
> +	enum skb_drop_reason reason;
> 
>  	vg = nbp_vlan_group_rcu(p);
> -	return ((p->flags & BR_HAIRPIN_MODE) || skb->dev != p->dev) &&
> -		p->state == BR_STATE_FORWARDING && br_allowed_egress(vg, skb) &&
> -		nbp_switchdev_allowed_egress(p, skb) &&
> -		!br_skb_isolated(p, skb);
> +	if (!(p->flags & BR_HAIRPIN_MODE) && skb->dev == p->dev) {
> +		reason = SKB_DROP_REASON_BRIDGE_FWD_SAME_PORT;
> +		goto undeliverable;
> +	}
> +	if (p->state != BR_STATE_FORWARDING) {
> +		reason = SKB_DROP_REASON_BRIDGE_NON_FORWARDING_STATE;
> +		goto undeliverable;
> +	}
> +	if (!br_allowed_egress(vg, skb)) {
> +		reason = SKB_DROP_REASON_BRIDGE_NOT_ALLOWED_EGRESS;
> +		goto undeliverable;
> +	}
> +	if (!nbp_switchdev_allowed_egress(p, skb)) {
> +		reason = SKB_DROP_REASON_BRIDGE_SWDEV_NOT_ALLOWED_EGRESS;
> +		goto undeliverable;
> +	}
> +	if (br_skb_isolated(p, skb)) {
> +		reason = SKB_DROP_REASON_BRIDGE_BOTH_PORT_ISOLATED;
> +		goto undeliverable;
> +	}
> +	return true;
> +
> +undeliverable:
> +	if (need_reason)
> +		*need_reason = reason;
> +	return false;

You can return the reason from this function. That's the whole point of
SKB_NOT_DROPPED_YET existing and being equal to 0.

Which is not to say that I know whether the reasons are worth adding
here. We'll need to hear from bridge experts on that.

