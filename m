Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793679522;
	b=kp5PADt9Q5pUPV8WeLCR9a/y8rPuExSanj8U7DlwBtZTHSmF5ogAj9fp2o5K3h4C9698
	 2Z0VGT3NpHf3EZ0Sql4k4iHq/JFPsn+w8Vfl2cM0dPDKwaWxcOwpZBlt9QURIsy5PBkRs
	 RWQQdq8iKmeNwSu7IfqYmdL9JcRGkl/78by7ayZ5kL+XjQjdYAUQ7xihtTH/PJAhXjtK1
	 jhdlkrIGpU/pZCAl48O6YoOaXSwo+OpAjf2SjPfizbCqcdLscEC7PSyO1C4fHdOUpMBjL
	 T2IJr8mYSd2QFGSkkGQDETZki2DuheiEgqN4mCO9mrkM1r7KpimVwhEvPCWJ8EMmSUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793679522;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=AJFKR2DVegmCOvKm+XgKiQZC99Uzm4Ks3f9FW73MosI=;
	b=FXak1FuGGNH5ruK1df4wUxmmWdd8QtvQuPZxK73UY7i95hMu1V3zSsVCs/YFmhSVrKeB
	 7Ry9uEnOGyU6Gkz2xyV4pX0ymoXPHrDVlUWEuTEnTjLVY5K+1uULE4dbAsHwlAgCxXm+E
	 0XMiWYiwaVn5797FJTOR3f64J9cv4Z9towaDEmwsyS1G7CAXRNksy0LSnKtM2JdtXcBWq
	 xFajkkY2kvCWL2J/6oYV2roj7UdqErmOdg4HCOl0D7I4EVh8gK3M9+YSNpGyFdRaIc0b9
	 A+LzDijtnxh9R8Uwv+2RaWIbZPjo/HRIcULd3WlvcBK+PEQ5E131012jw8pKCfv5uog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d2M0IvLc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADE7606A338;
	Tue,  3 Nov 2026 04:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d2M0IvLc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5D191F00919;
	Tue,  3 Nov 2026 04:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793679521;
	bh=AJFKR2DVegmCOvKm+XgKiQZC99Uzm4Ks3f9FW73MosI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=d2M0IvLcWRf9nosJBt3+PWZBmLgaROlN4XFALkCf7RFXZWo3jq6bzyTLqJIcf1RAK
	 5BdHk33tG7M5c8e0xvOV6YqdFwEj1RmmN3DrleFIxfE23+lsgHMNuT7fe2PQ0r+JQa
	 KxXLEwKQ8IX6KzY63ldagGkvcmU1aRQ0VC/yQ9V5cTADLzTzhM6ZAZHmqb/IEtcRDv
	 NqQugqweg2ll4i843lt4p8z0Idug/0UDqtlJ3YLJ2SUsBDkujcRnH031H/4l4LAu1y
	 l7z339Bv+XIyf5gTKsOccBD9sPA0R/s/9NyQCn0izzAyfhfTbUzFBBEBbwsa3oGvpZ
	 qiqF1sXbAjjmw==
Subject: Re: [PATCH net v2] net: bridge: disable MRP ports before the FDB
 flush in del_nbp()
From: netdev-bot+sashiko@kernel.org
To: teel4res@gmail.com
Cc: idosch@nvidia.com, razor@blackwall.org, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 horatiu.vultur@microchip.com, bridge@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Tue, 03 Nov 2026 04:18:40 +0000
Message-ID: <179367952018.488856.4094824897348236390@kernel.org>
In-Reply-To: <179333317814.2102764.8780283783548366593@gmail.com>
References: <179333317814.2102764.8780283783548366593@gmail.com>
X-sashiko-severity: High
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix needs an RCU grace period between br_stp_disable_port()
  writing p->state = BR_STATE_DISABLED (br_if.c:348) and the final…
- [High] The reorder assumes br_mrp_port_del() always clears
  BR_MRP_AWARE_BIT on the port being deleted, so that…
- [Medium] The commit message's safety argument describes code that is
  not in the target tree.

--

net: bridge: disable MRP ports before the FDB flush in del_nbp()

This patch moves br_mrp_port_del() and br_cfm_port_del() ahead of
br_stp_disable_port() in del_nbp(). An MRP ring port then has
BR_MRP_AWARE_BIT cleared before STP disables it. The goal is for the port
to really reach BR_STATE_DISABLED before the FDB flush, so that no frame
is learned with dst == p and later forwarded to the freed port.

Link: https://lore.kernel.org/netdev/20261012123051.GA714215@shredder/

> Remove the MRP and CFM instances before disabling the port, so that
> br_stp_disable_port() actually transitions the port to BR_STATE_DISABLED.
> The synchronize_net() in nbp_vlan_flush() then drains the receive paths
> that could still learn with the old state, and the FDB flush that
> follows removes their entries.  No frame can be learned after that
> flush and before netdev_rx_handler_unregister().

[Severity: Medium]
Does this description match the tree the patch applies to?

Earlier in the message the flush is called br_fdb_delete_by_port(), but
that function no longer exists under net/bridge/. The current del_nbp()
does this:

	vg = nbp_vlan_group(p);
	nbp_vlan_group_unpublish(p);
	br_fdb_cleanup_by_dst(br, br_port_to_dst(p), 0, 1);
	nbp_vlan_flush(p, vg);

nbp_vlan_flush() contains no synchronize_net(), and it runs after the FDB
flush:

net/bridge/br_vlan.c:nbp_vlan_flush() {
	ASSERT_RTNL();

	__vlan_flush(port->br, port, vg);
	__vlan_group_free(vg);
}

The only grace period before the flush is in nbp_vlan_group_unpublish():

net/bridge/br_vlan.c:nbp_vlan_group_unpublish() {
	ASSERT_RTNL();

	RCU_INIT_POINTER(port->vlgrp, NULL);
	synchronize_net();
}

This layout came from commit 83edc87a9172 ("net: bridge: vlan: quiesce
readers before freeing port VLANs"). The testing in the changelog was
done on v7.3, which still has the older ordering.

Could the message name nbp_vlan_group_unpublish() and
br_fdb_cleanup_by_dst() instead, or describe both layouts if a stable
backport is intended? Could the patch also be tested on the target tree?

> diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
> index 2c05ebc1299d1..fb25ce3e5e646 100644
> --- a/net/bridge/br_if.c
> +++ b/net/bridge/br_if.c
> @@ -341,13 +341,13 @@ static void del_nbp(struct net_bridge_port *p)
>  
>  	nbp_delete_promisc(p);
>  
> +	br_mrp_port_del(br, p);
> +	br_cfm_port_del(br, p);
> +

[Severity: High]
Does br_mrp_port_del() always clear BR_MRP_AWARE_BIT on the port being
deleted?

br_mrp_set_port_role() can leave a port MRP-aware with no instance
pointing at it. Take a ring with primary A and secondary B. Setting
IFLA_BRIDGE_MRP_PORT_ROLE=PRIMARY on B is accepted, because B is
MRP-aware and br_mrp_find_port() finds the instance:

net/bridge/br_mrp.c:br_mrp_set_port_role() {
	...
	case BR_MRP_PORT_ROLE_PRIMARY:
		rcu_assign_pointer(mrp->p_port, p);
		break;
	...
}

Now p_port == s_port == B. A keeps BR_MRP_AWARE_BIT and stays in the
BR_STATE_FORWARDING state that br_mrp_add() set.

Later, when A is removed from the bridge, br_mrp_find_port(br, A) checks
only p_port, s_port and i_port. So br_mrp_port_del() returns early:

	if (!mrp)
		return;

br_stp_disable_port()->br_set_state() also returns early:

	if (test_bit(BR_MRP_AWARE_BIT, &p->flags))
		return;

As a result, A stays FORWARDING.

If VLAN filtering is disabled at runtime, br_allowed_ingress() returns
true without looking at the unpublished VLAN group. A frame that arrives
between br_fdb_cleanup_by_dst() and netdev_rx_handler_unregister() is then
learned with dst == A. Nothing flushes that entry before
call_rcu(&p->rcu, destroy_nbp_rcu). A later frame to that MAC would reach
br_forward() with the freed port.

This looks like the same use-after-free as the one in the changelog. It
needs no reader preemption, only traffic during the teardown window.

Should teardown force the port out of MRP-aware mode, or disable it
directly, even when no instance references it? Alternatively, should
br_mrp_set_port_role() avoid orphaning the port it displaces?

>  	spin_lock_bh(&br->lock);
>  	br_stp_disable_port(p);
>  	spin_unlock_bh(&br->lock);

[Severity: High]
Is there still a window here with CONFIG_BRIDGE_VLAN_FILTERING=n?

The fix needs a grace period between br_stp_disable_port() writing
BR_STATE_DISABLED and the final br_fdb_cleanup_by_dst(br,
br_port_to_dst(p), 0, 1) in del_nbp(). The only synchronize_net() in that
window is in nbp_vlan_group_unpublish(). Without VLAN filtering, that
function is an empty stub:

net/bridge/br_private.h:
static inline void nbp_vlan_group_unpublish(struct net_bridge_port *port)
{
}

Nothing else in the window synchronizes. That includes br_ifinfo_notify(),
list_del_rcu(), update_headroom() and netdev_reset_rx_headroom().

One possible interleaving:

CPU1 (RX softirq, br_handle_frame_finish())
    reads p->state and sees FORWARDING
    passes the BR_STATE_DISABLED check

CPU0 (del_nbp())
    br_stp_disable_port()
        br_set_state(p, BR_STATE_DISABLED)
    br_fdb_cleanup_by_dst(br, br_port_to_dst(p), 0, 1)

CPU1
    br_fdb_update(br, p, vlan, eth_hdr(skb)->h_source, 0)
        fdb_create(br, dst, addr, vid, flags)   /* dst == p */

br_fdb_update() does not check the port state again. No FDB flush runs
after this point: netdev_rx_handler_unregister() only drains, and
destroy_nbp() does no FDB cleanup. After call_rcu(destroy_nbp_rcu), a
frame to the learned MAC would reach br_forward() with the freed port.

BRIDGE_MRP and BRIDGE_CFM depend only on BRIDGE. BRIDGE_VLAN_FILTERING is
default n and depends on VLAN_8021Q. So MRP=y with VLAN_FILTERING=n is a
valid configuration. The window is short on !PREEMPT_RT, but on PREEMPT_RT
the softirq reader can be preempted inside it.

This also seems to contradict this line in the changelog: "No frame can
be learned after that flush and before netdev_rx_handler_unregister()".

Would an unconditional synchronize_net() after br_stp_disable_port() and
before the final FDB flush close this window?

>  
> -	br_mrp_port_del(br, p);
> -	br_cfm_port_del(br, p);
> -
>  	br_ifinfo_notify(RTM_DELLINK, NULL, p);
>  
>  	list_del_rcu(&p->list);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/179333317814.2102764.8780283783548366593%40gmail.com
