Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6126323A99F;
	Mon,  5 Oct 2026 04:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791173793; cv=none; b=sp0WBMfyiV0ngQKXDalb3nZnndA2kkLZQGTcawmqIVJX0+bC+LkjxuLJOR3T7SYEXR4yYHq+3tyP96P5xtrcOmE2Gsn/r+e771MWqE+TIWs1eImLiqn/7NA3jmUHT/z3iR35s7Rq//e3CF0fxamm7hgxL1r971aj8RJcIGf4vSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791173793; c=relaxed/simple;
	bh=th6nWGSKd6xIzfI0gxSeIq4uYuIBFdEnLlpcUUrCdL0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qqc5UXsg39lPJ46Afr1qcfGbEwYMorp7oAL+POoPsIkUXg2wkFZvMLe1x+MC4yQ/QMbNzZwT/95GXGyQY+/PphiBht6jfFn+uguCA9amKY6ZG0k27rwoQOVcnf2RfqZGkiuQc0KNaupsq6BNqRdaLYqu2v2H88hrhtAEVEpIa3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HC/iq/YU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HC/iq/YU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 980741F000FF;
	Mon,  5 Oct 2026 04:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791173790;
	bh=0l0oG3Rk79/4j2rYWUPEHVTt8L/8m1YX2NMq+q+S7fc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HC/iq/YURq7VVA1EGZE9wPc7jcRopFNTOHSjCj8PAC/6LQEF5KP1nCAyqEoWYgpzD
	 X/0udchz02N1g9mB+eErtoheBGJ20HPqH1jMkI9urJsrjJVbaf7RB7xBfoLlRuKIak
	 ZwntHs8+XCZvF1YLt2EbpJAPvyjeWVgWOjShHo8c2oIHuLj7FQLl1HHl1Ah+546n4B
	 YDau6x+92aCJDuZuD58H80xSYuBFNQ9bvew1Y3EuwWoUA01KwSp7S4ElKPr747I1dS
	 mpb64Qes/kQYtlPglN2na9bHsq01YifJacMoTZyfcNiD76VIKExqPgITTXJ/K6tGwP
	 PKr5r2s4wN42Q==
Subject:
 Re: [PATCH net-next] net: bridge: cfm: notify userspace on CFM config changes
From: netdev-bot+sashiko@kernel.org
To: w453y.me@gmail.com
Cc: netdev@vger.kernel.org, razor@blackwall.org, idosch@nvidia.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, horatiu.vultur@microchip.com, bridge@lists.linux.dev,
 linux-kernel@vger.kernel.org
Date: Mon, 05 Oct 2026 04:16:29 +0000
Message-ID: <179117378916.434549.16185635728868721491@kernel.org>
In-Reply-To: <20261004041320.2684045-1-w453y.me@gmail.com>
References: <20261004041320.2684045-1-w453y.me@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new config notification uses an skb that is too small, so a
  user can trigger WARN_ON and the notification is lost.
- [Medium] Deleting the last MEP sends a notification that does not show
  the CFM config is now empty.

--

net: bridge: cfm: notify userspace on CFM config changes

This patch makes br_cfm_parse() send one RTM_NEWLINK through
br_info_notify() with RTEXT_FILTER_CFM_CONFIG after any CFM config group
in the request is applied. The message is still sent if a later group in
the same request fails.

> diff --git a/net/bridge/br_cfm_netlink.c b/net/bridge/br_cfm_netlink.c
> index 91b9922dc3f25..56309e6f4b1be 100644
> --- a/net/bridge/br_cfm_netlink.c
> +++ b/net/bridge/br_cfm_netlink.c

[ ... ]

> @@ -399,59 +400,72 @@ int br_cfm_parse(struct net_bridge *br, struct net_bridge_port *p,
>  		err = br_mep_create_parse(br, tb[IFLA_BRIDGE_CFM_MEP_CREATE],
>  					  extack);
>  		if (err)
> -			return err;
> +			goto out;
> +		changed = true;
>  	}
>  
>  	if (tb[IFLA_BRIDGE_CFM_MEP_DELETE]) {
>  		err = br_mep_delete_parse(br, tb[IFLA_BRIDGE_CFM_MEP_DELETE],
>  					  extack);
>  		if (err)
> -			return err;
> +			goto out;
> +		changed = true;
>  	}

[Severity: Medium]
What does userspace receive when this request deletes the last MEP?

After br_mep_delete_parse() succeeds, br->mep_list is empty. When
br_info_notify() builds the message, br_fill_ifinfo() takes this branch:

net/bridge/br_netlink.c:br_fill_ifinfo() {
    ...
		if (!br_cfm_created(br) || port)
			goto done;
    ...
}

This filter puts nothing else in IFLA_AF_SPEC, so the nest is dropped at
done:

	if (af) {
		if (nlmsg_get_pos(skb) - (void *)af > nla_attr_size(0))
			nla_nest_end(skb, af);
		else
			nla_nest_cancel(skb, af);
	}

The resulting RTM_NEWLINK has neither IFLA_AF_SPEC nor IFLA_BRIDGE_CFM.
It looks like any other AF_BRIDGE RTM_NEWLINK for the bridge master, for
example one from br_ifinfo_notify() on a bridge with no VLANs. The filter
is not part of the message, so a listener has no way to tell that the CFM
config is now empty.

Wouldn't a listener that relies on these notifications keep a stale MEP
entry here, and still have to poll RTM_GETLINK? The commit message says
this patch removes the need for that polling.

The notification layout becomes uAPI once released. Could the empty case
emit an empty IFLA_BRIDGE_CFM nest, or otherwise be made distinguishable?

[ ... ]

>  	if (tb[IFLA_BRIDGE_CFM_CC_CCM_TX]) {
>  		err = br_cc_ccm_tx_parse(br, tb[IFLA_BRIDGE_CFM_CC_CCM_TX],
>  					 extack);
>  		if (err)
> -			return err;
> +			goto out;
> +		changed = true;
>  	}
>  
> -	return 0;
> +out:
> +	/* Earlier groups may have been applied even if a later one failed */
> +	if (changed)
> +		br_info_notify(RTM_NEWLINK, br, NULL, RTEXT_FILTER_CFM_CONFIG);

[Severity: High]
Is the skb that br_info_notify() allocates large enough for a message
with only RTEXT_FILTER_CFM_CONFIG set?

br_info_notify() sizes the skb with nlmsg_new(br_nlmsg_size(dev, filter)).
br_nlmsg_size() takes the IFLA_AF_SPEC size from
br_get_link_af_size_filtered(). That function returns before counting any
CFM attributes unless the status bit is set:

net/bridge/br_netlink.c:br_get_link_af_size_filtered() {
    ...
	if (!(filter_mask & RTEXT_FILTER_CFM_STATUS))
		return vinfo_sz;
    ...
}

No code path there sizes the config attributes at all. br_fill_ifinfo()
still writes the full config payload, though:

net/bridge/br_netlink.c:br_fill_ifinfo() {
    ...
		if (filter_mask & RTEXT_FILTER_CFM_CONFIG) {
			rcu_read_lock();
			err = br_cfm_config_fill_info(skb, br);
    ...
}

br_cfm_config_fill_info() writes about 248 bytes per MEP (CREATE_INFO,
CONFIG_INFO, CC_CONFIG_INFO with the 48-byte MAID, RDI_INFO and
CCM_TX_INFO), plus about 20 bytes per peer MEP. br_cfm_cc_peer_mep_add()
does not limit the number of peers, and each bridge port can have one MEP.

The only spare room is the unused IFLA_PROTINFO/IFLA_LINK budget plus slab
rounding. One MEP with about 20 peers, or a few MEPs on several ports,
looks like enough to overflow it.

Once that happens, br_fill_ifinfo() returns -EMSGSIZE and br_info_notify()
does this:

		/* -EMSGSIZE implies BUG in br_nlmsg_size() */
		WARN_ON(err == -EMSGSIZE);
		kfree_skb(skb);
		goto errout;
	...
errout:
	rtnl_set_sk_err(net, RTNLGRP_LINK, err);

Would every later CFM config change then hit the WARN_ON, drop the
notification, and set a socket error on every RTNLGRP_LINK listener in the
netns? With panic_on_warn set, this would panic the host.

This path only needs CAP_NET_ADMIN in the user namespace that owns the
netns:

RTM_SETLINK -> rtnl_bridge_setlink() -> br_setlink() -> br_afspec()
  -> br_cfm_parse() -> br_info_notify() -> br_fill_ifinfo()
  -> br_cfm_config_fill_info()

Before this patch, CFM_CONFIG was only written into GETLINK and dump skbs,
which handle -EMSGSIZE cleanly. Does br_get_link_af_size_filtered() need
to count the config attributes when RTEXT_FILTER_CFM_CONFIG is set?

> +
> +	return err;
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261004041320.2684045-1-w453y.me%40gmail.com
