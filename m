Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2B649A3D6;
	Thu,  1 Oct 2026 11:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790855956; cv=none; b=aZHhaYiK37E4T0eNRy4X+N0L2YIeqfB1IhzIvvrSu6NP03exLDtNLPMl7jtPxxOQanObiaHGd7U9vyoHRi/GlDaEWXpRdg268v/EjR/Wmtv1Jtbb+35C1lx1fyXAXVqqCHl+kjmXVFQXUkxlDT/mhudGoR/Uc9BAIEIXell4ZPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790855956; c=relaxed/simple;
	bh=l3ffvqJcT9cxYbCaYxoa7krkO5s5wFI9u5DNiq7KD5M=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kwUOEW5KcxnVoTheoWqcXG3Nesnjqoo+5ihBIR3W9AWThNQQpbExiYnEnB5TRiSGpMQgTjN3xbkQ72fTHR+Ys+MX5GXL4CK14sy/BiOdYY2+d0H0p6hMpHC9w7ARIrj78fbIOLFOYjIj1Xq0f206uAEJQLeiWRVcaKpYv08duWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ervGpyfE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ervGpyfE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EE0B1F000FF;
	Thu,  1 Oct 2026 11:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790855950;
	bh=W6hgFj+3tmIhywyIDHage8g9Szjc7DXc3/BZ/RIDNL4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ervGpyfEBZEEjYEQPbQV+1zvmV0xPkpWR9AIySCw7N0Zm8wEzGOAw5R83+v+mHNBw
	 sdII3b5rQpnrnHj7Xr9owz8BfdazSrsgxLVeFpm9HCi5F8VPwBruCNdpRtMpfUxYF2
	 CXQN4x5b8hYcBubOkrs1fGmGMAAiHMmBvHaK1opDk//36taXZExbN/423XepruAC7+
	 ZkifwItfw+1+938oxgQLmeIfhtiWmbsp1UvI9B4dHChjEA0cjcezUjypfdAv+uj3tT
	 m/O5C4KChH/uJjqIsIWKBKDO9iDFFWCCbA/QI/rab9nEB8aYGmIFlaMBmoWVHpOswx
	 g4S6s39agvVjA==
Subject: Re: [PATCH net-next 03/12] net: bridge: add VLAN support to bridge
 destinations
From: netdev-bot+sashiko@kernel.org
To: razor@blackwall.org
Cc: netdev@vger.kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 bridge@lists.linux.dev
Date: Thu, 01 Oct 2026 11:59:09 +0000
Message-ID: <179085594902.434549.16785666588384507596@kernel.org>
In-Reply-To: <20260930071411.2786201-4-razor@blackwall.org>
References: <20260930071411.2786201-4-razor@blackwall.org>
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

- [Low] Baseline decision: false positive.

--

net: bridge: add VLAN support to bridge destinations

This commit sets bit 0 of struct net_bridge_dst to mark a port-VLAN
pointer, so it can be told apart from a bridge port pointer. It adds
helpers that build VLAN destinations and decode them back into a port and
a VLAN. Nothing creates a VLAN destination yet.

> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index bbb59b53e7452..2bf7f4429a3b2 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h

[ ... ]

> @@ -702,10 +704,56 @@ br_port_to_dst(const struct net_bridge_port *p)
>  	return dst;
>  }
>  
> +static inline struct net_bridge_dst
> +br_vlan_to_dst(const struct net_bridge_vlan *v)
> +{
> +	struct net_bridge_dst dst;
> +
> +	ACCESS_PRIVATE(&dst, value) = (unsigned long)v | BR_DST_VLAN_TAG;
> +
> +	return dst;
> +}
> +
> +static inline void br_dst_decode(struct net_bridge_dst dst,
> +				 struct net_bridge_port **port,
> +				 struct net_bridge_vlan **vlan)
> +{
> +	struct net_bridge_vlan *v;
> +	unsigned long value;
> +
> +	value = ACCESS_PRIVATE(&dst, value);
> +	if (!(value & BR_DST_VLAN_TAG)) {
> +		*port = (struct net_bridge_port *)value;
> +		*vlan = NULL;
> +		return;
> +	}
> +
> +	v = (struct net_bridge_vlan *)(value & ~BR_DST_VLAN_TAG);
> +	*port = v->port;

[Severity: Low]
This isn't a bug, but br_vlan_to_dst() takes any struct net_bridge_vlan
pointer, and br_dst_decode() reads v->port without checking which kind of
VLAN entry it has.

In struct net_bridge_vlan, port is in a union with br:

	union {
		struct net_bridge	*br;
		struct net_bridge_port	*port;
	};

For a bridge master VLAN, br is the active member. Decoding one would hand
back a struct net_bridge pointer typed as a struct net_bridge_port.
Passing NULL would encode to 0x1, and decoding that would dereference a
near-NULL address.

As far as I can tell, no caller can hit this. Later in the series, all of
br_fdb_update(), __br_fdb_add(), br_fdb_resolve_dst() and
nbp_vlan_delete() pass a non-NULL VLAN taken from a port VLAN group.
__br_fdb_add() also excludes the bridge master case on purpose:

	dst = p && vlan ? br_vlan_to_dst(vlan) : br_port_to_dst(p);

Would a comment on br_vlan_to_dst() be worth adding, stating that it only
takes non-NULL port VLANs? Something like
WARN_ON_ONCE(br_vlan_is_master(v)) would also enforce that.

> +	*vlan = v;
> +}
> +

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930071411.2786201-1-razor%40blackwall.org
