Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4D0267B89;
	Thu, 10 Sep 2026 06:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789022698; cv=none; b=rGyRXwz54d/AZhQM74wDDFTmSQQRCrJwljucRObKiSPnnitM4CMT64aE/op6Nyw+7i+Q1IggrvwAh5Dj3WlUtVr6Tz+jKgQD/ObyEhZuy3QhkDuLrkfJpDyrCGn9EEu64u3r1doRUURqWm9lBlP28Ho1zMgMGsVyv64+4L8mfSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789022698; c=relaxed/simple;
	bh=u27dG1rBmqmjpK8YSsvlrOYBUK4zx068XOmkDunU4jM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F/tPlc1/lA/prIxNEesETdk8trpz169NdaC/VwUFa/X3EKLlGgIOPtpiFxU2PBbshBnkLtFl/UHRamxfUPV7WMqHIoUhSVHmzk7hbaz6hk9MBnWzjDoi+pSypwPuKhPbuHO9GScaG1Ii3tbK1mVxOL333C2M8UB874hgY5QQ2WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YG35K4ZE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YG35K4ZE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0FC91F000FF;
	Thu, 10 Sep 2026 06:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789022696;
	bh=Jw8hlI2fgUpdKqVVf7y3g+RPckF+M6yOdJNAGCV+/24=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=YG35K4ZEzL46QJvVk8j5eft9Mca4Ek9yJut1QvkMDtXVBlVcI6B0SfnbkZ4gppkSI
	 GYee+f22LByOEjWT5VxspBSmpVAObT2IBnWcvPCQVBSWDideSGeAZvVuAzSKFKgUmO
	 1Hyb49eCD46/izAUICWqro3ur1BUwtW7TL01if6tM+gQivuHDi5Q4Jhg8rB3BhfR3R
	 OTZzdOrQIedBm6XxeNqXAug3w/YN2GDd0J9Ws4lA3lfJ/o3N37ralpH8m0OFo6l30B
	 pIkJw0PC0hElxhmnQ5mAxBdCjroaYacWpBa/xk6smB5LfQJPh5Ndh/GVhAeQ3SmUvG
	 FOErVgFivz52g==
Subject: Re: [PATCH net-next] net: bridge: bound the port VLAN lists in the
 IFLA_AF_SPEC nest
From: netdev-bot+sashiko@kernel.org
To: iprintercanon@gmail.com
Cc: netdev@vger.kernel.org, bridge@lists.linux.dev, razor@blackwall.org,
 idosch@nvidia.com, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, davem@davemloft.net, corbet@lwn.net,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 10 Sep 2026 06:44:55 +0000
Message-ID: <178902269514.219967.12409929351424983943@kernel.org>
In-Reply-To: <20260906224246.21719-1-iprintercanon@gmail.com>
References: <20260906224246.21719-1-iprintercanon@gmail.com>
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
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 0

- [Medium] No Fixes: tag on a patch that fixes user-visible malformed
  netlink output.

Pre-existing issues:
- [Medium] The u16 nla_len wrap of the IFLA_AF_SPEC nest remains
  reachable for the bridge device: br_fill_ifinfo() still emits…

--

net: bridge: bound the port VLAN lists in the IFLA_AF_SPEC nest

The patch stops br_fill_ifinfo() from putting more than 65535 bytes into
the single IFLA_AF_SPEC nest by asking br_af_spec_has_room() for room
before each VLAN, VLAN tunnel or MST entry, and clamps the size estimate
in br_get_link_af_size_filtered() to U16_MAX. Documentation/networking/bridge.rst
gets a section describing the per-entry costs and pointing at RTM_GETVLAN.

Two questions below, one about the tag block and one about the remaining
paths into the same nest.

> net: bridge: bound the port VLAN lists in the IFLA_AF_SPEC nest
>
> br_fill_ifinfo() opens one IFLA_AF_SPEC nest, fills it with the VLAN
> information of a bridge port and closes it with nla_nest_end(), which
> stores the accumulated length into nla_len. That field is a u16, so for
> a nest larger than 65535 bytes the stored length wraps modulo 65536.
> The encoding has never been able to describe more than that; nothing
> regressed.

[Severity: Medium]
Should this carry a Fixes: tag anyway?

The rest of the changelog describes user visible breakage in shipped
kernels: a 115048 byte RTM_NEWLINK with an nla_len of 49088 broadcast to
every RTNLGRP_LINK listener in the netns, 2341 attributes after the nest
misread as IFLA_IFNAME, a 147776 byte RTM_GETLINK reply whose attribute
walk derails 16672 bytes in, and a CONFIG_DEBUG_NET splat from
nla_nest_end(). Without a Fixes: line stable selection has no anchor.

The sibling fix cited a few paragraphs later, bdd39576bf50a ("net: bridge:
prevent too big nested attributes in br_fill_linkxstats()"), does carry
one:

    Fixes: a60c090361ea ("bridge: netlink: export per-vlan stats")

For the two lists that can fill the nest on their own the candidates would
be efa5356b0d97 ("bridge: per vlan dst_metadata netlink support") for
br_fill_vlan_tunnel_info() and IFLA_BRIDGE_VLAN_TUNNEL_INFO, and the commit
that added br_mst_fill_info() and IFLA_BRIDGE_MST_ENTRY.

> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Artem Lytkin <iprintercanon@gmail.com>

> diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
> index b2cd4e39326d0..643ae06f7df8c 100644
> --- a/net/bridge/br_netlink.c
> +++ b/net/bridge/br_netlink.c

[ ... ]

> @@ -117,11 +128,19 @@ static size_t br_get_link_af_size_filtered(const struct net_device *dev,
>  		vinfo_sz += br_get_vlan_tunnel_info_size(vg);
>  
>  	/* Each VLAN is returned in bridge_vlan_info along with flags */
> -	vinfo_sz += num_vlan_infos * nla_total_size(sizeof(struct bridge_vlan_info));
> +	vinfo_sz += num_vlan_infos * BR_VLAN_INFO_SIZE;
>  
>  	if (p && vg && (filter_mask & RTEXT_FILTER_MST))
>  		vinfo_sz += br_mst_info_size(vg);
>  
> +	/* These three lists share the IFLA_AF_SPEC nest, whose length is a
> +	 * u16, and br_fill_ifinfo() stops once it is full. Do not size the
> +	 * skb for entries that will not be emitted. The CFM size below is
> +	 * only added for the bridge device, which carries no tunnel or MST
> +	 * entries and so stays far below the clamp.
> +	 */
> +	vinfo_sz = min_t(size_t, vinfo_sz, U16_MAX);
> +
>  	if (!(filter_mask & RTEXT_FILTER_CFM_STATUS))
>  		return vinfo_sz;
>  

[Severity: Medium]
This is a pre-existing issue and not introduced by the patch, but can the
same nla_len wrap still be reached for the bridge device through the CFM
status list?

The changelog says so explicitly ("CFM peer status can grow past the limit
on its own; that is a separate change"), so this is more a question about
whether the new helper could cover it in the same series than a complaint
about the scope.

br_cfm_status_fill_info() walks br->mep_list and each mep->peer_mep_list
appending roughly 64 to 76 bytes per entry with no aggregate cap:

net/bridge/br_cfm_netlink.c:br_cfm_status_fill_info() {
	hlist_for_each_entry_rcu(mep, &br->mep_list, head) {
		tb = nla_nest_start(skb, IFLA_BRIDGE_CFM_MEP_STATUS_INFO);
	...
}

br_cfm_mep_create() and br_cfm_cc_peer_mep_add() only reject duplicate
instance and mepid values under RTNL, so on the order of 860 MEP and peer
MEP entries push skb_tail_pointer(skb) - af past 65535, and the
nla_nest_end(skb, af) at the 'done:' label in br_fill_ifinfo() stores a
length truncated modulo 65536, which is the same failure this patch closes
for the port lists. Neither the IFLA_BRIDGE_CFM nest nor
br_mrp_fill_info() consults br_af_spec_has_room().

Also, the clamp above runs before the CFM terms are added, so it does not
constrain that path at all. Was that ordering intentional? The per-peer
accounting that follows the clamp also omits the
IFLA_BRIDGE_CFM_CC_PEER_STATUS_INFO nest header for each peer, which can
undersize the skb and make br_fill_ifinfo() return -EMSGSIZE.

> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index d337b1cfb980d..55dfa44269c90 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h

[ ... ]

> @@ -2161,6 +2168,18 @@ static inline int br_cfm_peer_mep_count(struct net_bridge *br, u32 *count)
>  #endif
>  
>  /* br_netlink.c */
> +/* The IFLA_AF_SPEC nest that br_fill_ifinfo() builds is a single netlink
> + * attribute, so everything put inside it has to fit in the u16 nla_len.
> + * The entries have fixed sizes, so ask for room before adding one instead
> + * of closing the nest with a length that wrapped.
> + */
> +static inline bool br_af_spec_has_room(const struct sk_buff *skb,
> +				       const struct nlattr *af, size_t size)
> +{
> +	return skb_tail_pointer(skb) - (const unsigned char *)af + size <=
> +	       U16_MAX;
> +}
> +

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260906224246.21719-1-iprintercanon%40gmail.com
