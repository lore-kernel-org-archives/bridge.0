Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C97C3B2D39;
	Wed,  7 Oct 2026 19:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791401906; cv=none; b=Yk5mqfyHUhkSW+RPVoi7l4OOYY7Za2xx/YAqITBvvzZglzAJNd8G/Wz4YON6QNUu71rAxlRO7NulPoi2AZ3S0On4VC3rtGW9VAijTrlo7Qwey6ND7LneYRJEwfTk2krb+wHpxRSo5jV0j5DwXyRcntlF+8i/eTY2h7jKoubhlaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791401906; c=relaxed/simple;
	bh=19lq77Pl/58KA26XnoMZyITRapZiNac8RqllR8MSs+g=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cH0AtVDyl0uVz7YPsi3BKlwTV8HPJRuiiki1V4Je8V7kbJcOnPSUhnHv6i/BWLM71GhMYmGHQHfbkoRAUt+GwOOE3DGezNWj6LpNvVTKCuE5Ttmwo6iywx7Ym48fn8CASMmcCBhC+Vu5A2rh1f2/6R7UmSzWe+OZRmTzIpgJ+4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TjXBqSvS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TjXBqSvS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F2591F000FF;
	Wed,  7 Oct 2026 19:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791401905;
	bh=7+GrqV3l/plJNEr+wEy6AFv7KYtUviY1keByiJ9a8go=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=TjXBqSvScAFQVbj/dBlo8GquW+0lCybNlde4G5RizgMmR5Lfj+IS0/Blh+2VqnFd6
	 lLr5BWAL5gAzJqRUGgVkkeDsBbdLdZtJTZ+zrPY1i78t8c6/5RzmD2RE2fZUc0RDyu
	 qujriPvq+qWcpubKfpUkIkhw9rT9l30EdrX5/d+OiDADqXTuP3aV0cLbdMu8+IC6iI
	 yw3mPDCqM7jh+4TR9GvSbarExTBxCFn5SftyKuR+9Nr9agY9GBiWT9cAL3ayIqQS8k
	 geDmhMG9Ac5RemMv70vqUZf7GRkiWmflt/L4LSctKzEDBvxAc7jv0qHFFuAxrLK4I0
	 VaaTbXg8vcOSg==
Subject: Re: [PATCH net-next v2 1/3] net: bridge: cfm: count CFM config
 attributes in the link message size
From: netdev-bot+sashiko@kernel.org
To: w453y.me@gmail.com
Cc: netdev@vger.kernel.org, razor@blackwall.org, idosch@nvidia.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, horatiu.vultur@microchip.com, bridge@lists.linux.dev,
 linux-kernel@vger.kernel.org
Date: Wed, 07 Oct 2026 19:38:24 +0000
Message-ID: <179140190403.434549.10861688299324701975@kernel.org>
In-Reply-To: <20261005043822.3106580-2-w453y.me@gmail.com>
References: <20261005043822.3106580-2-w453y.me@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message is wrong about the dump path and the patch
  has no Fixes: tag.

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but the CFM
  status sizing in br_get_link_af_size_filtered() leaves out the per-…

--

net: bridge: cfm: count CFM config attributes in the link message size

With this patch, br_get_link_af_size_filtered() counts the CFM config
attributes (MEP create/config, CC config, RDI, CCM TX and peer MEP info)
when RTEXT_FILTER_CFM_CONFIG is set. Before, only RTEXT_FILTER_CFM_STATUS
caused any CFM sizing. The change prepares for a later patch that sends a
CFM config notification through br_info_notify().

> Dumps cope with that, they just get a bigger buffer. A message built by
> br_info_notify() can't, it fails with -EMSGSIZE and hits the WARN_ON
> there. No notification asks for the CFM config today, but the next
> patch adds one.

[Severity: Medium]

Is this an accurate description of the dump path?

br_get_link_af_size_filtered() is also the .get_link_af_size callback in
br_af_ops, so it sizes the dump buffer as well:

rtnetlink_rcv_msg()
    min_dump_alloc = rtnl_calcit(skb, nlh)
        if_nlmsg_size(dev, ext_filter_mask)
            rtnl_link_get_af_size()
                br_get_link_af_size_filtered()

So the bigger buffer that dumps get is sized by the same estimate that
undercounts the CFM config.

Before this patch, a PF_BRIDGE RTM_GETLINK dump with only
RTEXT_FILTER_CFM_CONFIG in IFLA_EXT_MASK added nothing for CFM to
min_dump_alloc. For the bridge master, br_fill_ifinfo() still wrote about
248 bytes per MEP and 20 bytes per peer MEP.

If that single message does not fit in the dump skb, the skb is still
empty, so rtnl_bridge_getlink() passes the error back to userspace:

net/core/rtnetlink.c:rtnl_bridge_getlink() {
    ...
				if (err < 0 && err != -EOPNOTSUPP) {
					if (likely(skb->len))
						break;

					goto out_err;
				}
    ...
}

That happens at roughly 15 MEPs for the first skb, and at roughly 130
MEPs with a 32 KiB receive buffer.

Doesn't that mean this patch also fixes a -EMSGSIZE dump failure that
userspace can see today? If so, could the commit message say that? It
could also carry a Fixes: tag for commit 5e312fc0e7fb ("bridge: cfm:
Netlink GET configuration Interface"), so the fix is picked up for net
and stable.

> diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
> index f65b8b6ca97c0..5160e801d62db 100644
> --- a/net/bridge/br_netlink.c
> +++ b/net/bridge/br_netlink.c

[ ... ]

> @@ -122,17 +152,25 @@ static size_t br_get_link_af_size_filtered(const struct net_device *dev,

[ ... ]

> -	/* CFM status info must be added */
>  	br_cfm_mep_count(br, &num_cfm_mep_infos);
>  	br_cfm_peer_mep_count(br, &num_cfm_peer_mep_infos);
>  
>  	vinfo_sz += nla_total_size(0);	/* IFLA_BRIDGE_CFM */
> +
> +	if (filter_mask & RTEXT_FILTER_CFM_CONFIG)
> +		vinfo_sz += br_cfm_config_info_size(num_cfm_mep_infos,
> +						    num_cfm_peer_mep_infos);
> +
> +	if (!(filter_mask & RTEXT_FILTER_CFM_STATUS))
> +		return vinfo_sz;
> +
> +	/* CFM status info must be added */
>  	/* For each status struct the MEP instance (u32) is added */
>  	/* MEP instance (u32) + br_cfm_mep_status */
>  	vinfo_sz += num_cfm_mep_infos *

[Severity: Medium]

This is a pre-existing issue, not one introduced by this patch. Does the
status part of this estimate leave out the nest header for each object?

br_cfm_status_fill_info() opens a nest for every MEP and every peer MEP:

net/bridge/br_cfm_netlink.c:br_cfm_status_fill_info() {
    ...
	hlist_for_each_entry_rcu(mep, &br->mep_list, head) {
		tb = nla_nest_start(skb, IFLA_BRIDGE_CFM_MEP_STATUS_INFO);
    ...
		hlist_for_each_entry_rcu(peer_mep, &mep->peer_mep_list, head) {
			tb = nla_nest_start(skb,
					    IFLA_BRIDGE_CFM_CC_PEER_STATUS_INFO);
    ...
}

The status sums in br_get_link_af_size_filtered() count only the leaf
attributes. That gives 32 bytes per MEP against 36 written, and 72 bytes
per peer MEP against 76 written.

The new br_cfm_config_info_size() does wrap each group in
nla_total_size(), so the config and status parts of this function now
count differently.

br_cfm_notify() already sends a status notification for the bridge
master:

net/bridge/br_cfm.c:br_cfm_notify() {
	u32 filter = RTEXT_FILTER_CFM_STATUS;

	br_info_notify(event, port->br, NULL, filter);
}

For a bridge master, br_nlmsg_size() leaves only about 400 bytes of
slack. The shortfall grows by 4 bytes per MEP and per peer MEP, and the
kernel does not limit either count.

With a few hundred peer MEPs, can br_fill_ifinfo() return -EMSGSIZE,
which would trigger WARN_ON(err == -EMSGSIZE) in br_info_notify() and
drop the notification? The trigger can be ccm_rx_work_expired() or
br_cfm_frame_rx() when a CCM frame arrives.

Would it make sense to add nla_total_size(0) to the per-MEP and
per-peer-MEP status terms while this function is being changed?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261005043822.3106580-1-w453y.me%40gmail.com
