Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795570692;
	b=K4l+XnmXokKzaaplqr3wXRS4chtOIr4PX/1FDogNeLyT7CjTj4n1JK278KV6WZe7Gehb
	 sxnL87Ndjv17fKMsgZFVe5mpxEU+C+izPpYdGPXL1BXyr0DLCDTgmRzOOSrr6GSeetbdL
	 7CGM3yZmkgH14k8seiSSkBueeJ+MrQ8KlNCgAte7BjsVw3OsGNeH1M+OoSDKoz/jQ50T+
	 zgOi9h+2GWKV1GOdSehQ6rHetbNBYaZrOV1FMgnwc4zYo4fnt1PFsClKWZq0GoXadcodN
	 Md4Rgesrg2gUvkuHYm/cCrNA2l3EtjHkA2/35YlCYqa2KU5iOA68z0PH/VanwXye9Qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795570692;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Nr1mvIMHP/Apoq8Z0zeyI+Z1HpRcP0Mhyt7l5VEY68k=;
	b=Cp8MH+XzNgE/d9JkeAh4S5PNhBw5GImvui1r6qmUtwXzPjzKuiV1UT0WsobdCPcGxbjq
	 DkgYvPwyFzw1woGFYGM/grUZmBd1P62ZBKlDfRP8mIQLYYiV2YVQZYIrcsZYwQj6k6v2Q
	 b3EurN/kvdGn2eQsO+IQO5zMPXzLO2Lmka96QIdEz0UM9gHYCyHiUeP0hOc/xVF6HhBlQ
	 pFDgTdbfk3sbargKHLtXj1xR8+pmjxzLJCE4Saed+CzxPaL8R1WCsSwjt0matTxa4W3gU
	 qtLZLmG2qMBNkkXZmvqLIWq/rdSsgntXn5Ib+mLeGcljC3GOq7+gvEGH4dZe+DurBSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KqKIVXjD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F87606A323;
	Wed, 25 Nov 2026 01:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KqKIVXjD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF1351F000C6;
	Wed, 25 Nov 2026 01:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795570691;
	bh=Nr1mvIMHP/Apoq8Z0zeyI+Z1HpRcP0Mhyt7l5VEY68k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KqKIVXjDRzKUm2uEwHjGxaWGtAstsh9p2nV3Tu9QJJkWcSAvO09Qb50f/42G7C3K5
	 afUXDc/E6HaMXSW01/U7LJTLipMOR5JcNgtkdDRoBXCoT5Igq6tjTfIskMaaBJ71lc
	 GzgBAGN0Ei8rXxE8J+G5eb5hCECJjwcDcOKKRC7WvdejcNTqcPvvTqWJBEhPmp+5NF
	 zKYKt4z7CnhjSA7V5MbEbEQ48pAeLBYtPCA65as+IhIadZrQ5KBaNuOW+6PqsRxZd0
	 640aeWN8jFrkQJ+/Ssa85Z+l74UcNtse//iUu+T4KKSBJix81RS64hKgyg4qoM8CCi
	 ZsnCsKAPsb2mQ==
Subject: Re: [PATCH net] net: bridge: switchdev: clear the hwdom of a port
 that stops the offload
From: netdev-bot+sashiko@kernel.org
To: koralilgun@gmail.com
Cc: razor@blackwall.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, willemb@google.com,
 horms@kernel.org, vladimir.oltean@nxp.com, ioana.ciornei@nxp.com,
 andrew@lunn.ch, bridge@lists.linux.dev, netdev@vger.kernel.org
Date: Wed, 25 Nov 2026 01:38:10 +0000
Message-ID: <179557069026.3135.3993063298740413532@kernel.org>
In-Reply-To: <20261124011639.990261-1-koralilgun@gmail.com>
References: <20261124011639.990261-1-koralilgun@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Post: <mailto:bridge@lists.linux.dev>
List-Help: <mailto:bridge+help@lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
List-Owner: <mailto:bridge+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 3 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In net/bridge/br_switchdev.c, nbp_switchdev_add() sets
  `p->ppid = ppid; p->offload_count = 1;` (lines 304-305) before it…
- [Medium] The new `WRITE_ONCE(p->hwdom, 0)` in nbp_switchdev_del()
  (net/bridge/br_switchdev.c:329-332) runs from dsa_port_pre_lag_leave()…
- [Medium] net: bridge: switchdev: unreset offload_count on hwdom_set()
  error
- [Low] The patch adds a lockless writer of p->hwdom:
  `WRITE_ONCE(p->hwdom, 0)` in nbp_switchdev_del()…

--

net: bridge: switchdev: clear the hwdom of a port that stops the offload

When the last offload of a bridge port stops while the port stays in the
bridge, this patch clears p->hwdom in nbp_switchdev_del() so the hwdom is
no longer leaked. It also makes nbp_switchdev_hwdom_set() skip ports that
have no hwdom. It replaces nbp_switchdev_can_offload_tx_fwd() with
nbp_switchdev_tx_fwd_hwdom(), which reads the hwdom once with READ_ONCE().

> diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
> index 10f3aea6a1f82..7b368fa82f762 100644
> --- a/net/bridge/br_switchdev.c
> +++ b/net/bridge/br_switchdev.c

[ ... ]

> @@ -53,8 +69,10 @@ void nbp_switchdev_frame_mark_tx_fwd_offload(const struct net_bridge_port *p,
>  void nbp_switchdev_frame_mark_tx_fwd_to_hwdom(const struct net_bridge_port *p,
>  					      struct sk_buff *skb)
>  {
> -	if (nbp_switchdev_can_offload_tx_fwd(p, skb))
> -		set_bit(p->hwdom, &BR_INPUT_SKB_CB(skb)->fwd_hwdoms);
> +	int hwdom = nbp_switchdev_tx_fwd_hwdom(p, skb);
> +
> +	if (hwdom)
> +		set_bit(hwdom, &BR_INPUT_SKB_CB(skb)->fwd_hwdoms);
>  }
>  
>  void nbp_switchdev_frame_mark(const struct net_bridge_port *p,

[Severity: Low]

This isn't a functional bug, but nbp_switchdev_del() now does a lockless
WRITE_ONCE(p->hwdom, 0) on a port that RCU readers can still reach. Should
the other readers of p->hwdom get an annotation too?

nbp_switchdev_frame_mark() and nbp_switchdev_allowed_egress() each read
the field twice with plain loads:

	if (p->hwdom)
		BR_INPUT_SKB_CB(skb)->src_hwdom = p->hwdom;

	return !test_bit(p->hwdom, &cb->fwd_hwdoms) &&
		(!skb->offload_fwd_mark || cb->src_hwdom != p->hwdom);

The notes below the changelog say that any mix of the old and new values
gives the result of one of the two states. That seems to hold for the
current expressions.

KCSAN will still report these loads as data races against the new writer.
That can happen when nbp_switchdev_del() runs under RTNL during a LAG
leave or a conduit change, while br_handle_frame() or should_deliver()
runs in softirq on another CPU. The plain loads are also inconsistent with
the READ_ONCE() in nbp_switchdev_tx_fwd_hwdom().

Would it be better to read p->hwdom once into a local with READ_ONCE() in
these helpers? If the race is intended, data_race() would also work.

[ ... ]

> @@ -221,10 +239,14 @@ static int nbp_switchdev_hwdom_set(struct net_bridge_port *joining)
>  	struct net_bridge_port *p;
>  	int hwdom;
>  
> -	/* joining is yet to be added to the port list. */
> +	/*
> +	 * joining can already be in the port list, and so can another port
> +	 * that stopped the offload but stays a member. Both have no hwdom.
> +	 */
>  	list_for_each_entry(p, &br->port_list, list) {
> -		if (netdev_phys_item_id_same(&joining->ppid, &p->ppid)) {
> -			joining->hwdom = p->hwdom;
> +		if (p->hwdom &&
> +		    netdev_phys_item_id_same(&joining->ppid, &p->ppid)) {
> +			WRITE_ONCE(joining->hwdom, p->hwdom);
>  			return 0;
>  		}
>  	}

[Severity: Medium]
Can this skip make nbp_switchdev_hwdom_set() fail for a port that stays
in the bridge? Would that leave the port with a stale offload_count?

Before this patch, a port already in br->port_list always matched
itself in this loop, because nbp_switchdev_add() has just copied the
ppid into joining->ppid. The -EBUSY return could only be reached from
br_add_if(), where a failure destroys the new port anyway.

With the new p->hwdom check, a port that is already a member and has no
hwdom falls through to find_next_zero_bit(). It gets -EBUSY once all
BR_HWDOM_MAX - 1 hwdoms are busy. At that point nbp_switchdev_add() has
already set the count and the ppid, and it does not undo them:

	p->ppid = ppid;
	p->offload_count = 1;

	err = nbp_switchdev_hwdom_set(p);
	if (err)
		return err;

br_switchdev_port_offload() then returns the error without calling
nbp_switchdev_del(). Several paths offload a port that is already in
the bridge and can hit this:

- a LAG whose first switch port joins it, via dsa_port_lag_join() or
  lan966x_lag_port_join()
- a VXLAN bridge port in mlxsw_sp_bridge_vxlan_join()
- the rejoin in dsa_port_change_conduit(), where the port now has no
  hwdom because nbp_switchdev_del() cleared it

The port is then left with offload_count == 1, the switch's ppid and
hwdom == 0.

A later offload from the same switch, including a retry of the same
command, takes the if (p->offload_count) branch in nbp_switchdev_add().
That branch increments the count and returns 0. The port is then
offloaded but never gets a hwdom, and BR_TX_FWD_OFFLOAD is never set.
This is the hwdom 0 state that the commit message says the skip fixes.
A frame from such a LAG with offload_fwd_mark would again be refused
toward every port without a hwdom.

An offload from a different switch is refused with "Same bridge port
cannot be offloaded by two physical switches", because offload_count
is non-zero.

The count also stays one above the real number of offloads. So
nbp_switchdev_del() never reaches its cleanup until the port leaves
the bridge.

Should nbp_switchdev_add() reset offload_count, and probably ppid, when
nbp_switchdev_hwdom_set() fails?

[Severity: Medium]

If the hwdom allocation fails, can this skip leave a LAG bridge port with a
stale offload_count?

Before this patch, a LAG that is already a bridge port always matched
itself here, because nbp_switchdev_add() has just set joining->ppid. So
nbp_switchdev_hwdom_set() could not return -EBUSY for it.

With the new p->hwdom check, the LAG falls through to
find_next_zero_bit(). That returns -EBUSY once all BR_HWDOM_MAX - 1
hwdoms are busy.

nbp_switchdev_add() sets the count and ppid before this call, and does not
undo them on failure:

net/bridge/br_switchdev.c:nbp_switchdev_add() {
    ...
	p->ppid = ppid;
	p->offload_count = 1;

	err = nbp_switchdev_hwdom_set(p);
	if (err)
		return err;
    ...
}

br_switchdev_port_offload() returns that error without calling
nbp_switchdev_del(). dsa_port_bridge_join() then jumps to
out_rollback_unbridge, which comes after the unoffload rollback.

The LAG then stays in the bridge with offload_count == 1, the switch's
ppid and hwdom == 0. A later join of a port from the same switch,
including a retry of the same command, takes this branch in
nbp_switchdev_add():

	if (p->offload_count) {
		...
		p->offload_count++;

		return 0;
	}

After that, no hwdom is ever assigned. The commit message says the skip
fixes a LAG with hwdom 0, where nbp_switchdev_allowed_egress() refuses
frames from the LAG with offload_fwd_mark toward every port without a
hwdom. Doesn't this path bring that state back?

offload_count also stays one above the real number of offloads, so
nbp_switchdev_del() never reaches its cleanup. Until the LAG leaves the
bridge, ports of any other switch are refused with "Same bridge port
cannot be offloaded by two physical switches".

Would it help to reset offload_count and ppid in nbp_switchdev_add() when
nbp_switchdev_hwdom_set() fails?

[ ... ]

> @@ -304,8 +326,10 @@ static void nbp_switchdev_del(struct net_bridge_port *p)
>  	if (p->offload_count)
>  		return;
>  
> -	if (p->hwdom)
> +	if (p->hwdom) {
>  		nbp_switchdev_hwdom_put(p);
> +		WRITE_ONCE(p->hwdom, 0);
> +	}

[Severity: Medium]

The commit message describes the transmit-side effect of the LAG leave
window. Does clearing the hwdom here also affect the receive side during
that window?

This runs from:

dsa_port_pre_lag_leave()
  dsa_port_pre_bridge_leave()
    switchdev_bridge_port_unoffload()
      ...
        nbp_switchdev_del()

The switch leaves the hardware bridge only later, in dsa_port_lag_leave()
-> dsa_port_bridge_leave(). The hardware trunk and the dsa_lag mapping are
removed after that. In between, the hardware still forwards between the
trunk and the other ports of the same hwdom.

With tag_dsa/edsa (mv88e6xxx), dsa_rcv_ll() injects trunk frames directly
onto the LAG device and always marks them:

net/dsa/tag_dsa.c:dsa_rcv_ll() {
    ...
		lag = dsa_lag_by_id(cpu_dp->dst, source_port + 1);
		skb->dev = lag ? lag->dev : NULL;
    ...
	if (trunk)
		skb->offload_fwd_mark = true;
    ...
}

These frames reach br_handle_frame() on the LAG's bridge port. Because
p->hwdom is now 0, nbp_switchdev_frame_mark() leaves src_hwdom at 0. In
nbp_switchdev_allowed_egress():

	return !test_bit(p->hwdom, &cb->fwd_hwdoms) &&
		(!skb->offload_fwd_mark || cb->src_hwdom != p->hwdom);

the second condition is false for every software port with hwdom 0, so
these frames are dropped toward the non-switchdev ports. The other ports
of the switch pass the check and get a software copy of frames that the
hardware already flooded to them.

The commit message says the patch fixes a bridge that "refuses each port
without a hwdom for a frame from the LAG with offload_fwd_mark". Doesn't
the same thing now happen for the length of this window?

dsa_port_change_conduit() opens a similar window for a port that is not
in a LAG:

	if (bridge_dev) {
		dsa_port_pre_bridge_leave(dp, bridge_dev);
		dsa_port_bridge_leave(dp, bridge_dev);
	}

dsa_default_offload_fwd_mark() keeps setting offload_fwd_mark from
dp->bridge until dsa_port_bridge_leave() clears it. Frames received on
that port in between also get src_hwdom 0. Before this patch the port
kept its hwdom here, which matched the hardware.

Should the commit message also describe these cases?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261124011639.990261-1-koralilgun%40gmail.com
