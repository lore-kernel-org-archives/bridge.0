Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7743A36308E;
	Fri,  4 Sep 2026 22:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788560716; cv=none; b=NxAul3ruL4N0uxS5WtfbvFddKXgtFNEF/eZGWEFosi/4Xq9ytFSwTTXX+PcKpdRtALCmphJhPZhy1b+EK3E827WVD/WQpY+UgdpiPYymXCjC6CwPmySqJWr478m9A95kFP8ToFJFsFQiuusdtfhOVmU9m01B8bsi+fW1AIpl+5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788560716; c=relaxed/simple;
	bh=7p96NrWBUjUiGqN0M7SNT7B8OM8ZCO/4IrcwKuFVE/4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HYj9Yh//pMXIjVqLTnXGzHfBBV8GOZcaVL5iIFORmyafFviyd+E+aPLbwmDyIWF1iEFTCxoVObDVxymyo/4FIhUFlf2BwDmhfFNX8juF7g7gPnfhf+4irlgy+iz10I1LmUdAfk9TpgEoZdxxeJ1jFG0HAgCA0yW9h7kjYSCY2H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EOVh77Dv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EOVh77Dv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FDCA1F00A3F;
	Fri,  4 Sep 2026 22:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788560711;
	bh=i15EN1U5L1+AMGl0F51fl4gLwj313pfdWXT3D8YvNNs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=EOVh77Dvw1eUwmG6dfo1O3/wNRABoG5JkC3+piATtt0QpO4ISwyddm+BSXVGacz4p
	 BZ/xthIXTgAtZVgCQOYNGnAl5wNqlMcaFrTXuNPfP19+ywD/CVtUQlTH8pzPE4rblj
	 q0znXlwbGIRgx3E4fGy8mFVTjdKBPYXMk/BmfGDVN1ALn0k1FmkdXlGaCv/RG054MG
	 N+5CW2LZRMc3hMLX9JCL5DKg5WqDZrGLb9lLCAHNlb8wqOz63Wbc3Q7+VrjUK4x7GJ
	 1QXprP3bFRJugHN/1N0tg/7i3A4hp4j81/zL/M7a3ZcyVi5bzzT9hFghKT001rZGuU
	 oWxgdsnkoXbiQ==
Subject:
 Re: [PATCH net] bridge: skip generic XDP on locally re-injected packets
From: netdev-bot+sashiko@kernel.org
To: shxzhaosr@163.com
Cc: netdev@vger.kernel.org, razor@blackwall.org, idosch@nvidia.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 bridge@lists.linux.dev, syzbot+128e9f5a0f85a51215b1@syzkaller.appspotmail.com
Date: Fri, 04 Sep 2026 22:25:10 +0000
Message-ID: <178856071073.219967.3609952218897637391@kernel.org>
In-Reply-To: <20260831113051.13072-1-shxzhaosr@163.com>
References: <20260831113051.13072-1-shxzhaosr@163.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 1 · Low: 2

- [High] net/bridge/br_input.c:35 — br_netif_receive_skb()
  unconditionally calls skb_set_redirected_noclear(skb, false) on every…
- [Medium] The changelog's causal chain is not supported by the code it
  points at.
- [Low] The commit fixes a user-visible KASAN slab-use-after-free
  reported by syzbot (Reported-by:…
- [Low] The new call abuses the documented meaning of two skb bits.

--

bridge: skip generic XDP on locally re-injected packets

This marks locally delivered bridge frames as redirected in
br_netif_receive_skb() so that netif_receive_generic_xdp() bails out early
and does not run generic XDP on the bridge device.  The stated goal is to
avoid the pskb_expand_head() head reallocation inside
netif_skb_check_for_xdp() that syzbot reported as a use-after-free in
br_handle_frame().

Link: https://lore.kernel.org/all/6a6d4406.2d659fcc.1d46f5.01ad.GAE@google.com/T/

A few questions about the changelog first.

>     If the
>     bridge device has an XDP program attached, __netif_receive_skb_core()
>     runs do_xdp_generic() a second time on such packets.

[Severity: High]
Is "a second time" accurate here?  do_xdp_generic() is called with the
program of the current skb->dev:

net/core/dev.c:__netif_receive_skb_core() {
	...
	ret2 = do_xdp_generic(rcu_dereference(skb->dev->xdp_prog),
			      &skb);
	...
}

br_pass_frame_up() already switched skb->dev to the bridge master:

net/bridge/br_input.c:br_pass_frame_up() {
	...
	indev = skb->dev;
	skb->dev = brdev;
	...
}

So the program being run in the second round is the one attached to br0,
not the one that ran on the ingress port.  When no XDP program is attached
to the port (the common case) this is the first and only invocation of the
bridge's program.

>     netif_receive_generic_xdp() already refuses to run generic XDP on
>     reinjected packets by checking skb_is_redirected().  Reuse that marker:
>     set it right before the bridge re-injects the packet, so generic XDP is
>     skipped and the head buffer is left intact.

[Severity: Medium]
Does the described causal chain hold?  The changelog says the realloc
"frees the head that the bridge rx path (br_handle_frame() /
br_handle_frame_finish()) is still using", but in br_input.c every header
dereference in those functions happens before the handoff.

br_handle_frame() caches the destination up front and last uses it right
before handing the skb off:

net/bridge/br_input.c:br_handle_frame() {
	...
	if (ether_addr_equal(p->br->dev->dev_addr, dest))
		skb->pkt_type = PACKET_HOST;

	return nf_hook_bridge_pre(skb, pskb);
	...
}

br_handle_frame_finish() does all its eth_hdr()/br_fdb_find_rcu() work
before "return br_pass_frame_up(...)", and br_pass_frame_up() only returns
the NF_HOOK() result without touching the skb again.

The reported fault site is also at the very top of br_handle_frame():

	if (!is_valid_ether_addr(eth_hdr(skb)->h_source))

which suggests the head was already freed before that invocation started,
rather than by a realloc happening further down the same call chain.  Could
the stale reference belong to some other holder, with this patch only
quieting the reproducer?  Was a "#syz test" run done to confirm?

>     Reported-by: syzbot+128e9f5a0f85a51215b1@syzkaller.appspotmail.com
>     Link: https://lore.kernel.org/all/6a6d4406.2d659fcc.1d46f5.01ad.GAE@google.com/T/
>     Signed-off-by: Zhao ShiRong <shxzhaosr@163.com>

[Severity: Low]
Should this carry a Fixes: tag and Cc: stable@vger.kernel.org?  This is a
memory-safety fix for a syzbot-reported use-after-free, but only
Reported-by:/Link: are present, so there is no mechanical way for
backporters to determine the affected range.  A candidate for Fixes: would
be whichever commit made generic XDP reachable on this reinjection path
(the generic-XDP-on-virtual-devices support, or the later
netif_skb_check_for_xdp() head expansion in the receive core).

> diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
> index d87a5f9fa92b..0d08c3c2036f 100644
> --- a/net/bridge/br_input.c
> +++ b/net/bridge/br_input.c
> @@ -27,6 +27,12 @@ static int
>  br_netif_receive_skb(struct net *net, struct sock *sk, struct sk_buff *skb)
>  {
>  	br_drop_fake_rtable(skb);
> +
> +	/* Re-injected for local delivery: do not let generic XDP run on the
> +	 * bridge device a second time, it could reallocate the head via
> +	 * pskb_expand_head() and free a buffer still in use.
> +	 */
> +	skb_set_redirected_noclear(skb, false);

[Severity: High]
Does this disable generic XDP on bridge devices entirely?  The bit is set
unconditionally for every locally delivered frame, and
netif_receive_generic_xdp() returns before running the program:

net/core/dev.c:netif_receive_generic_xdp() {
	/* Reinjected packets coming from act_mirred or similar should
	 * not get XDP generic processing.
	 */
	if (skb_is_redirected(skb))
		return XDP_PASS;
	...
}

Forwarded frames leave the bridge through br_forward()/dev_queue_xmit() and
never enter netif_receive_skb() on the bridge device, so locally delivered
frames look like the only traffic a generic XDP program on br0 can see.
Before this change the bit was 0 at that point, because the outer round's
skb_reset_redirect() in __netif_receive_skb_core() runs before the bridge
rx_handler, so the program did run.

Would an XDP_DROP policy attached to br0 stop being enforced after this
patch, for ordinary remote unicast/broadcast/multicast traffic entering a
bridge port?  If the underlying problem is missing headroom on TX-allocated
skbs and a stale head reference, would fixing that (giving the reinjected
skb the headroom generic XDP requires, or dropping the stale reference) be
preferable to suppressing the program?

[Severity: Low]
Separately, do the values written here match the documented meaning of the
two bits?

include/linux/skbuff.h:
 *	@redirected: packet was redirected by packet classifier
 *	@from_ingress: packet was redirected from the ingress path

No packet classifier redirected this frame, and from_ingress is passed as
false while the frame is being pushed into the ingress path.  Other in-tree
setters pass skb_at_tc_ingress(skb) (net/core/filter.c) or true for
MLX5E_TC_INT_PORT_INGRESS (drivers/net/ethernet/mellanox/mlx5/core/en/tc/int_port.c).
skb_set_redirected_noclear() does store the value under CONFIG_NET_REDIRECT,
and drivers/net/ifb.c branches on it.

Also, is there a reason to pick the _noclear variant?  The two helpers
differ only in the "if (skb->from_ingress) skb_clear_tstamp(skb);" step,
which is skipped anyway when from_ingress is false, so the choice does not
express anything different from skb_set_redirected().

>  	return netif_receive_skb(skb);
>  }
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831113051.13072-1-shxzhaosr%40163.com
