Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAF84E532A;
	Wed,  7 Oct 2026 19:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791401908; cv=none; b=m6iLwb1s3F4hSqxWzQ21CZQ0TjUawrkf/aHY7yUSGiNRL56BI/oXBh/GCs25pZ/yI+NBLZFpVdukVB6I4Ng8hUVsxb35KLZQdrE+bxedOo+KZEktrrEQ2k7n1x6qQ/aMyOU6zirx6fdOTex05B+RoTOLqkpUGV4xKrmFivVqoTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791401908; c=relaxed/simple;
	bh=m96NchbNgEjsE3Lu4KxezPfVLpDEvdP7+L0VUHNLQFY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=APEYG5/EWJzzzNDI7odVvLdEFfMvGknxzF/xANoXrdXKB/fHdZm362csTP/VCNoSu4QhxohTSqstMV4R8+QowDmc4gMo94fYKMkE5dVOZqOMRaC296IavQWByKFOrAxUAW6/20mfwuH9s6lah06Xz1YxPi0fg70d77Qg0/6uaCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ya0ti4cw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ya0ti4cw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B38241F00893;
	Wed,  7 Oct 2026 19:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791401906;
	bh=znraM8Heq9xYfdQsMDRax6NDlKnKBPkbdm21j+sd4HU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Ya0ti4cwHK8kIfJsnqS4gXda2W1aV2GNwSsi6X6tjsFEh6DiMiUAQfQibnSBYpooh
	 Q6Svk2OGaDNLBKo/waNP0izrPCMwEnBw2aikfnDeSJA3HQtzOLwo+JN4sRK2Hg9L2m
	 A3ru7tTrjVifAQ06v034kEaWvlvcIhC/Luj/35eT/HkCW+TgXWcI2C8fhb6IoOXykb
	 /jgDD0OGD9WUxIQH2jpH5DM1uWTJTISlmwZ0nLXcEIMtPaPJxcTEjm2+T6V7KQletd
	 CK3U5Tkm74n302Tb4MS/vCi1XxMh8P7cUjYthhE8YI8zCW/M+5t9sDwTXP7jJ0yd5b
	 vdcUDCKytR1Pg==
Subject: Re: [PATCH net-next v2 2/3] net: bridge: cfm: send an empty CFM nest
 when a bridge has no MEPs
From: netdev-bot+sashiko@kernel.org
To: w453y.me@gmail.com
Cc: netdev@vger.kernel.org, razor@blackwall.org, idosch@nvidia.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, horatiu.vultur@microchip.com, bridge@lists.linux.dev,
 linux-kernel@vger.kernel.org
Date: Wed, 07 Oct 2026 19:38:25 +0000
Message-ID: <179140190527.434549.17731059672642938002@kernel.org>
In-Reply-To: <20261005043822.3106580-3-w453y.me@gmail.com>
References: <20261005043822.3106580-3-w453y.me@gmail.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] At this commit alone, the new `!IS_ENABLED(CONFIG_BRIDGE_CFM)`
  branch in br_fill_ifinfo() (net/bridge/br_netlink.c:609) cannot send…
- [Low] The patch also changes GETLINK dump replies, and the commit
  message does not say so plainly.
- [Low] This patch removed the only caller of br_cfm_created() (in
  br_fill_ifinfo()), and nothing calls it any more.

Pre-existing issues:
- [Low] In br_fill_ifinfo(), two earlier sections jump to `done` and skip
  the CFM block: - the VLAN section: `if (!vg ||…

--

net: bridge: cfm: send an empty CFM nest when a bridge has no MEPs

This patch changes br_fill_ifinfo() so that a bridge master with no MEPs
gets an empty IFLA_BRIDGE_CFM nest when CFM config or status is requested.
Before, it got no nest at all. The goal is to let notification listeners
see that the last MEP has been deleted. Ports still get no CFM nest.

> diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
> index 5160e801d62db..68ec4529f0d2b 100644
> --- a/net/bridge/br_netlink.c
> +++ b/net/bridge/br_netlink.c
> @@ -603,7 +603,10 @@ static int br_fill_ifinfo(struct sk_buff *skb,
>  		struct nlattr *cfm_nest = NULL;
>  		int err;
>  
> -		if (!br_cfm_created(br) || port)
> +		/* A bridge with no MEPs gets an empty IFLA_BRIDGE_CFM, so a
> +		 * listener can tell that the last MEP is gone.
> +		 */
> +		if (!IS_ENABLED(CONFIG_BRIDGE_CFM) || port)
>  			goto done;

[Severity: Low]
With only this patch applied, can any notification carry the new empty
nest?

This block only runs when filter_mask contains RTEXT_FILTER_CFM_CONFIG or
RTEXT_FILTER_CFM_STATUS. The generic bridge notification path asks for
neither:

net/bridge/br_netlink.c:br_ifinfo_notify() {
    ...
	u32 filter = RTEXT_FILTER_BRVLAN_COMPRESSED;
    ...
}

The IFLA_BRIDGE_CFM case in br_afspec() does not set *changed. Also,
br_cfm_notify() only fires from the peer MEP CCM paths, which need a live
MEP.

So at this point in the series, deleting the last MEP sends no
CFM-filtered RTM_NEWLINK. The only visible change is in RTM_GETLINK
replies.

The next patch in the series, "net: bridge: cfm: notify userspace on CFM
config changes", seems to fix this. It sets changed after a successful
br_mep_delete_parse() and adds this to br_cfm_parse():

	if (changed)
		br_info_notify(RTM_NEWLINK, br, NULL, RTEXT_FILTER_CFM_CONFIG);

Could the commit message mention that it depends on that follow-up patch?

Even at the end of the series, one case still seems to send no
CFM_CONFIG notification. When a port is deleted, its MEPs are removed
implicitly:

del_nbp()
  br_cfm_port_del()
    mep_delete_implementation()

In that path only br_ifinfo_notify(RTM_DELLINK, NULL, p) is sent for the
port. How is a listener expected to notice that the MEPs are gone?

[Severity: Low]
This also changes RTM_GETLINK and dump replies, not just notifications.

Before, a bridge with no MEPs took goto done with an empty IFLA_AF_SPEC,
and the epilogue cancelled that nest:

done:
	if (af) {
		if (nlmsg_get_pos(skb) - (void *)af > nla_attr_size(0))
			nla_nest_end(skb, af);
		else
			nla_nest_cancel(skb, af);
	}

Now, with CONFIG_BRIDGE_CFM enabled, every bridge master dumped with
RTEXT_FILTER_CFM_CONFIG or RTEXT_FILTER_CFM_STATUS gets an IFLA_AF_SPEC
that holds an empty IFLA_BRIDGE_CFM. Before, the reply for such a bridge
had no IFLA_AF_SPEC at all.

The commit message says:

    For a dump that is fine, but a notification sent after the last
    MEP is deleted then looks like any other RTM_NEWLINK for the bridge,

Could the commit message also say that dump output changes for bridges
without MEPs? Userspace can no longer treat the presence of
IFLA_BRIDGE_CFM as meaning "MEPs are configured".

The buffer sizing in br_get_link_af_size_filtered() already counts the
empty nest, so that part looks fine.

[Severity: Low]
This isn't a bug, but this removes the last caller of br_cfm_created().
Three pieces are left behind:

- the definition in net/bridge/br_cfm.c
- the prototype in net/bridge/br_private.h
- the !CONFIG_BRIDGE_CFM static inline stub in net/bridge/br_private.h

The later patches in the series add no new user. Should these be removed
here too?

[Severity: Low]
This is a pre-existing issue and was not introduced by this patch. Two
earlier sections of br_fill_ifinfo() can jump to done before the CFM
block runs:

	if (!vg || !READ_ONCE(vg->num_vlans)) {
		rcu_read_unlock();
		goto done;
	}
    ...
		if (!br_mrp_enabled(br) || port)
			goto done;

Suppose an RTM_GETLINK request combines RTEXT_FILTER_CFM_* with either
RTEXT_FILTER_BRVLAN* on a bridge with no VLANs, or RTEXT_FILTER_MRP on a
bridge without MRP. The reply then has no IFLA_BRIDGE_CFM at all: neither
the new empty nest nor real MEP data when MEPs exist.

Is that intended for combined filter masks? The notification added later
in the series uses RTEXT_FILTER_CFM_CONFIG alone, so it does not hit
these early exits.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261005043822.3106580-1-w453y.me%40gmail.com
