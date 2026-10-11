Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10A922A7F6;
	Sun, 11 Oct 2026 06:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791699354; cv=none; b=VNyE2SukK7h7dNUptz2s8QNsFoid16S3Bglp48pQCHl0j9lvp7zIPOgmCpZEGVBkvKl/MUFG3tuf4pU+X0KzGOKm4eyTlg3uAd7iNQaMxXBrQ9UFFoKwvZugZSPTRQbo8hOLjfjTcv3987K7Zs4ksCJIdgY9zyF1OHiylDAY40c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791699354; c=relaxed/simple;
	bh=QdwlSdD4e8pIxx8RaYVNZobwNMHOaf3eJSCGNU+vnrI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t7IL7w011ZOQJpcqxigkAf3vDtq+WhwgCjS/6BI44NWYjKTrhP9Ib1Jx3vbyIsNu3PFNJyrWtpC+5gki4CG7L71DFleWxfgkzGwclqdHkMaBSyP4vNgA2guoyMqkIjpHtLgbVYHg3S1Wq97mq2akzmTDl1ZB1MKT92gb+TMY33A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fO5tj43I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fO5tj43I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E33B51F0089B;
	Sun, 11 Oct 2026 06:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791699352;
	bh=Kw8eIFWLJdO0vJMNss4vKqPZ2tB+xPBa5E7C4a8Opp0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fO5tj43I2wMBVp9IPZVleY/HYOOdwCFtZmwWgyDRzA5BQ8iXxF9fxZyNddWXp5JLm
	 07OuTjPBlvDktkabsFHZ0I2ovq1+s1ZRrxWs4cdWb8gDK48iF1wxQ7JmUCJ9zJZQga
	 wsnoRFyIXMt8v4Rb2yiPNu3kS2O22iZu2XrvpJiIDBBJ5m2YsNXI6cil1Ci6Sh3rYG
	 8Uq2+Z9Q8C0f/0inV+D28Z/ALWE/N0YtSC09BAla5aEIt3e21H20T5A20YLW53koAP
	 8rjvOIPaiXF0/k2GKpen3uPnybEWex81Rr95YxMa7Je5oCiwnXAAeAzesg7jKOximT
	 qOEr9l7yo1Ktg==
Subject:
 Re: [PATCH net] net: bridge: don't under-estimate the VLAN tunnel info size
From: netdev-bot+sashiko@kernel.org
To: yimingqian591@gmail.com
Cc: razor@blackwall.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 bridge@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 11 Oct 2026 06:15:51 +0000
Message-ID: <179169935141.434549.18249145287675691158@kernel.org>
In-Reply-To: <20261007055939.63100-1-yimingqian591@gmail.com>
References: <20261007055939.63100-1-yimingqian591@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete.
- [High] The commit message says the change 'keeps br_nlmsg_size() an
  upper bound of what the fill needs', but the IFLA_BRIDGE_VLAN_INFO…
- [Medium] On any bridge port with vlan_tunnel enabled,
  br_get_vlan_tunnel_info_size() now reserves __get_vlan_tinfo_size()…

--

net: bridge: don't under-estimate the VLAN tunnel info size

br_get_vlan_tunnel_info_size() used to count the compressed ranges of VLANs
that currently have a tunnel mapping. This patch makes it reserve one
IFLA_BRIDGE_VLAN_TUNNEL_INFO attribute for every usable VLAN in the group.
The goal is to stop br_info_notify() from hitting
WARN_ON(err == -EMSGSIZE) when mappings change between br_nlmsg_size() and
br_fill_ifinfo() on the STP timer path, which runs without RTNL.

> Size the tunnel info for the maximum number of attributes that
> br_fill_vlan_tunnel_info() can emit for the VLAN group instead of for the
> mappings that are currently installed.  Consecutive VIDs with consecutive
> tunnel IDs are compressed into two attributes, so the fill never emits more
> attributes than there are usable VLANs, which keeps br_nlmsg_size() an upper
> bound of what the fill needs.

[Severity: High]
Does br_nlmsg_size() really become an upper bound with this change? The
IFLA_BRIDGE_VLAN_INFO part of the same message is still sized from a
snapshot.

br_get_link_af_size_filtered() gets that size from __get_num_vlan_infos().
That function counts compressed ranges using the current PVID, the
BRIDGE_VLAN_INFO_UNTAGGED flag of each VLAN and the current VLAN set:

net/bridge/br_netlink.c:br_get_link_af_size_filtered() {
    ...
	num_vlan_infos = br_get_num_vlan_infos(vg, filter_mask);
    ...
	vinfo_sz += num_vlan_infos * nla_total_size(sizeof(struct bridge_vlan_info));
    ...
}

br_fill_ifvlaninfo_compressed() later works out the ranges again from live
state. br_ifinfo_notify() always passes RTEXT_FILTER_BRVLAN_COMPRESSED,
including on the br_forward_delay_timer_expired() path in the trace.

Suppose an RTM_SETLINK under RTNL does one of the following while the timer
is between sizing and filling:

- toggles UNTAGGED on a VLAN in the middle of a range (one 2-attribute
  range becomes 2+1+2)
- changes the PVID
- adds non-adjacent VLANs through __vlan_add()->__vlan_add_list()

Can't br_fill_ifvlaninfo_compressed() still return -EMSGSIZE and hit the
same WARN_ON in br_info_notify()? This applies to tunnel and non-tunnel
ports alike.

About 30 extra 8-byte attributes are enough to go past the kmalloc slack.
A single setlink with many IFLA_BRIDGE_VLAN_INFO entries can produce that
many.

The patch only makes the tunnel half of br_get_link_af_size_filtered()
pessimistic. The two halves now follow different sizing rules.

> diff --git a/net/bridge/br_netlink_tunnel.c b/net/bridge/br_netlink_tunnel.c
> index e7eceab5b515d..74627323711c1 100644
> --- a/net/bridge/br_netlink_tunnel.c
> +++ b/net/bridge/br_netlink_tunnel.c
> @@ -35,39 +35,25 @@ bool vlan_tunid_inrange(const struct net_bridge_vlan *v_curr,
>  	return (be32_to_cpu(tunid_curr) - be32_to_cpu(tunid_last)) == 1;
>  }
>  
> -static int __get_num_vlan_tunnel_infos(struct net_bridge_vlan_group *vg)
> +/* Upper bound of the number of IFLA_BRIDGE_VLAN_TUNNEL_INFO attributes that
> + * br_fill_vlan_tunnel_info() can emit for @vg.
> + *
> + * br_info_notify() is also called without RTNL (e.g. from the STP timers), so
> + * the set of VLANs that have a tunnel mapping can change between the size
> + * calculation done by br_nlmsg_size() and the actual fill.  Account for the
> + * maximum instead of the currently used mappings: consecutive VIDs with
> + * consecutive tunnel IDs are compressed into two attributes, so the fill never
> + * emits more attributes than there are usable VLANs in the group.
> + */
> +static int __get_max_num_vlan_tunnel_infos(struct net_bridge_vlan_group *vg)
>  {
> -	struct net_bridge_vlan *v, *vtbegin = NULL, *vtend = NULL;
> +	struct net_bridge_vlan *v;
>  	int num_tinfos = 0;
>  
> -	/* Count number of vlan infos */
>  	list_for_each_entry_rcu(v, &vg->vlan_list, vlist) {
>  		/* only a context, bridge vlan not activated */
> -		if (!br_vlan_should_use(v) || !v->tinfo.tunnel_id)
> -			continue;

[ ... ]

> +		if (br_vlan_should_use(v))
> +			num_tinfos++;
>  	}

[Severity: High]
Isn't this still only a bound on vlan_list as it looks at sizing time?

When called from br_forward_delay_timer_expired(), br_info_notify() holds
only br->lock and RCU. br_fill_ifinfo()->br_fill_vlan_tunnel_info() then
walks the list again and checks BR_VLAN_TUNNEL_BIT again on its own:

net/bridge/br_netlink.c:br_info_notify() {
    ...
	skb = nlmsg_new(br_nlmsg_size(dev, filter), GFP_ATOMIC);
    ...
	err = br_fill_ifinfo(skb, port, 0, 0, event, 0, filter, dev, false);
	if (err < 0) {
		/* -EMSGSIZE implies BUG in br_nlmsg_size() */
		WARN_ON(err == -EMSGSIZE);
    ...
}

The RTNL writers don't take br->lock, so two inputs can still change
between those steps.

First, VLANs can be added. __vlan_add()->__vlan_add_list() publishes them
with list_add_rcu() under RTNL only. One RTM_SETLINK can carry
IFLA_BRIDGE_VLAN_INFO followed by IFLA_BRIDGE_VLAN_TUNNEL_INFO for the new
VIDs, and br_afspec() handles both. A VLAN that wasn't on the list when
this loop ran isn't counted, but br_fill_vlan_tunnel_info() will emit it.

Second, the flag can change. br_setport() sets BR_VLAN_TUNNEL with a
lockless try_cmpxchg(), and br_setlink() then calls br_afspec() to install
mappings. If sizing saw the bit clear, nothing is reserved:

net/bridge/br_netlink.c:br_get_link_af_size_filtered() {
    ...
	if (p && test_bit(BR_VLAN_TUNNEL_BIT, &p->flags))
		vinfo_sz += br_get_vlan_tunnel_info_size(vg);
    ...
}

The fill can then see the bit set and emit one 28-byte attribute per
mapped VLAN:

net/bridge/br_netlink.c:br_fill_ifinfo() {
    ...
		if (port && test_bit(BR_VLAN_TUNNEL_BIT, &port->flags))
			err = br_fill_vlan_tunnel_info(skb, vg);
    ...
}

In either case, wouldn't br_fill_vlan_tinfo() return -EMSGSIZE and hit the
WARN_ON quoted in the commit message? Nine or more tunnel attributes that
can't be merged would exceed the usual kmalloc slack. This needs
CAP_NET_ADMIN in a network namespace, which includes unprivileged user
namespaces.

The "upper bound" in the new comment only holds while the VLAN list and
the flag stay the same, and nothing guarantees that without RTNL.

Could the size and the fill be computed from one consistent view, or use a
bound that doesn't depend on current membership? Another option is for the
non-RTNL callers to stop treating -EMSGSIZE as a bug, for example by
retrying with a larger skb.

[ ... ]

> @@ -81,7 +67,7 @@ int br_get_vlan_tunnel_info_size(struct net_bridge_vlan_group *vg)
>  		return 0;
>  
>  	rcu_read_lock();
> -	num_tinfos = __get_num_vlan_tunnel_infos(vg);
> +	num_tinfos = __get_max_num_vlan_tunnel_infos(vg);
>  	rcu_read_unlock();
>  
>  	return num_tinfos * __get_vlan_tinfo_size();

[Severity: Medium]
On a vlan_tunnel port, this now reserves __get_vlan_tinfo_size() (28
bytes) for every usable VLAN, whether it is mapped or not. Two examples:

- VLANs 1000-1999 mapped to consecutive VNIs go from 56 bytes to about
  28KB.
- A port with 4094 VLANs and few mappings now reserves about 114KB.

Is this cost intended on the br_info_notify() path itself? That path calls
nlmsg_new(br_nlmsg_size(), GFP_ATOMIC) from STP timer softirq context, so
these sizes become order-3 to order-5 atomic page allocations. When one
fails, the notification is dropped and rtnl_set_sk_err() reports ENOBUFS.

The inflated size also reaches messages outside the bridge code.
br_get_link_af_size_filtered() adds it regardless of filter_mask. It is
registered as get_link_af_size in br_af_ops, which has no fill_link_af:

static struct rtnl_af_ops br_af_ops __read_mostly = {
	.family			= AF_BRIDGE,
	.get_link_af_size	= br_get_link_af_size_filtered,
};

That has two effects:

- if_nlmsg_size()->rtnl_link_get_af_size() reserves the space for every
  generic rtmsg_ifinfo() or RTM_GETLINK message for the port, and nothing
  ever fills it.
- rtnl_calcit() takes the max of if_nlmsg_size() over every netdev in the
  netns as min_dump_alloc for RTM_GETLINK dumps that carry IFLA_EXT_MASK.
  One such port inflates those dumps for the whole namespace.

The commit message doesn't mention this cost. As noted above, the
over-reservation still doesn't guarantee the bound.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261007055939.63100-1-yimingqian591%40gmail.com
