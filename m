Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793595052;
	b=cG2mvkU09gEqOEkDVSsPt6LQwKm1WH8IPF9YtGWmM+9qz1YCdRbLUJVbaePs/8xussTn
	 K7RRiY9Jueg3FuVbf+SDp3vzDZz+ORFTpVmDuJYIdx7nLCtqthcMdCHSt/arjPxbKYLKt
	 /bRZk3gaNwvWBLxNGFVdWxEDqs8wNTUhW3v8cZT2/6xSJ0BH7PPPPqCVvNwf4RWrTXpQw
	 lw911Ya0Bxa5I0r1SqXwq7yrhBK/cK8UppxmyHN65DUI2Q5TXws3a3tlYqNLiRo7koCzD
	 9khWyJUTQ5u0Zm8nOrJ36K+7SXP0k/NhqzpQFlWfYxsN0vQlVM7Dxa/K0hJJPFoZfWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793595052;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=9NjwTKigzXyJcNab5AKVuwtkEGTVfIQKZBQ4FCtvQwA=;
	b=ddpSFxh+83u8S27Pi2l3OvlWt5OSk1wFV9Sv2P4xyZVTPgM8EFf/MXc7g4oAITUmgfmj
	 Noj3O3BPPy33s5xUeAprd4mnlazysvIeudz/A5Aqn8J36Yn3Xgt0CQjuGwBd62K0sx2HQ
	 msHz0dp3z9EDydm6yjXQel66kc7VOOpGQXmajmSgLMjrojbXOoulraXztkVhPUMHNAwbB
	 Fe6nVSf63sx3kfHbmlQJC60B3FmDKPQVuOa8Wfm2vQncO3GZX33a30QtlX1Wgf5Mq2E+u
	 DKGOgcKzUOaMquUMMjtEbngVugxAcFuAf1maxoA8d60Q7whfCRej2MpfKHRKI+WFX6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IOLSLxfQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE38606A324;
	Mon,  2 Nov 2026 04:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IOLSLxfQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A701F000C1;
	Mon,  2 Nov 2026 04:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793595051;
	bh=9NjwTKigzXyJcNab5AKVuwtkEGTVfIQKZBQ4FCtvQwA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=IOLSLxfQGXSJq1mJoNmIBhj1iuVg335HttuJX0YH0goMJX9+RTkhuipnqvh3VzmRa
	 nUN3UFGqRlYvmAL4655Eq9Pu0n9Flfk0B+EiIFyzGq9IcovHkkpu6OxjzHGQxLu4yl
	 wAUgQi6C7iTa/IfMQk9GPSIQd2zuDHtq6U4EdaglhoihP9V5c3/0fJklIsbc/a3+FU
	 gzK4JQC0KjTLq25/pmRAdGjRdgOcq1oLyH3RKtgnS8u3IJn+0iI88E4FzlbOCUXQfd
	 zQoUk+6mi1yZaSqjuz6o6oFN1GsGIvt/Dz8yrYZkOdPfdcRh3JT12N/BKSYtzN0SJs
	 f0GYmxuA//bxA==
Subject: Re: [PATCH net v3] net: bridge: disable MRP ports before the FDB
 flush in del_nbp()
From: netdev-bot+sashiko@kernel.org
To: teel4res@gmail.com
Cc: idosch@nvidia.com, razor@blackwall.org, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 horatiu.vultur@microchip.com, bridge@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Mon, 02 Nov 2026 04:50:50 +0000
Message-ID: <179359505012.3131.7814662128826235179@kernel.org>
In-Reply-To: <20261101044840.1595584-1-1020691186@qq.com>
References: <20261101044840.1595584-1-1020691186@qq.com>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix leaves the use-after-free reachable when
  CONFIG_BRIDGE_VLAN_FILTERING=n.
- [High] The reorder only clears BR_MRP_AWARE_BIT when br_mrp_find_port()
  can still find the port in an MRP instance.

--

net: bridge: disable MRP ports before the FDB flush in del_nbp()

This patch moves br_mrp_port_del() and br_cfm_port_del() ahead of
br_stp_disable_port() in del_nbp(). The idea is to clear
BR_MRP_AWARE_BIT before the port is moved to BR_STATE_DISABLED. That
should stop frames received during port removal from learning FDB entries
that still point at the port after the final FDB flush.

Link: https://lore.kernel.org/netdev/20261012123051.GA714215@shredder/
Closes: https://lore.kernel.org/netdev/20261022090431.3641707-1-teel4res@gmail.com/

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

Does this reorder cover a port that is still MRP-aware but is no longer
referenced by any MRP instance?

br_mrp_port_del() only clears BR_MRP_AWARE_BIT when br_mrp_find_port()
finds an instance whose p_port, s_port or i_port is this port:

br_mrp_port_del() {
	struct br_mrp *mrp = br_mrp_find_port(br, p);

	/* If the port is not part of a MRP instance just bail out */
	if (!mrp)
		return;
    ...
}

br_mrp_set_port_role() overwrites the role pointer. It does not clear the
displaced port's bit, and it does not swap the roles:

br_mrp_set_port_role() {
    ...
	switch (role) {
	case BR_MRP_PORT_ROLE_PRIMARY:
		rcu_assign_pointer(mrp->p_port, p);
		break;
	case BR_MRP_PORT_ROLE_SECONDARY:
		rcu_assign_pointer(mrp->s_port, p);
		break;
    ...
}

Take an instance with p_port=A and s_port=B. An IFLA_BRIDGE_MRP_PORT_ROLE
request that makes B primary leaves p_port == s_port == B. Port A stays in
BR_STATE_FORWARDING with BR_MRP_AWARE_BIT set. A follow-up request to make
A secondary fails with -EINVAL, because br_mrp_find_port(A) returns NULL.

When A is later removed through br_del_if()->del_nbp(), br_mrp_port_del()
returns early. br_stp_disable_port()->br_set_state() then still skips the
state change:

br_set_state() {
	if (test_bit(BR_MRP_AWARE_BIT, &p->flags))
		return;
    ...
}

With runtime VLAN filtering off, br_allowed_ingress() still returns true
after the VLAN group is unpublished. So br_handle_frame_finish() can keep
learning on A after the final br_fdb_cleanup_by_dst(), up until
netdev_rx_handler_unregister(). That window includes the
netdev_upper_dev_unlink() notifier chain that the reproducer delays. The
learned entries outlive destroy_nbp_rcu(), and a later frame to those MACs
would hit the same br_forward() use-after-free.

The commit message says the reorder means that "br_stp_disable_port()
actually transitions it to BR_STATE_DISABLED". Does that hold for this
state?

The role bookkeeping in br_mrp_set_port_role() predates this patch. Still,
should del_nbp() clear BR_MRP_AWARE_BIT (or force BR_STATE_DISABLED)
unconditionally? Or should br_mrp_set_port_role() be changed so it cannot
leave a port orphaned like this?

>  	spin_lock_bh(&br->lock);
>  	br_stp_disable_port(p);
>  	spin_unlock_bh(&br->lock);

[Severity: High]

Can the use-after-free still happen when CONFIG_BRIDGE_VLAN_FILTERING=n?

The commit message relies on nbp_vlan_group_unpublish() to drain the
receive path:

  With CONFIG_BRIDGE_VLAN_FILTERING=y, synchronize_net() in
  nbp_vlan_group_unpublish() also drains receive paths that could still
  learn with the old state before the final FDB cleanup.

When VLAN filtering is compiled out, that function is an empty stub in
br_private.h:

static inline void nbp_vlan_group_unpublish(struct net_bridge_port *port)
{
}

CONFIG_BRIDGE_MRP only depends on CONFIG_BRIDGE, and
CONFIG_BRIDGE_VLAN_FILTERING defaults to n. So a build with MRP=y and
VLAN_FILTERING=n is valid.

In that build, br_mrp_del_impl() sets the port back to BR_STATE_FORWARDING
(if the bridge is up) before it clears BR_MRP_AWARE_BIT. A reader in
br_handle_frame_finish() can read p->state without a lock, see FORWARDING,
and only reach br_fdb_update() later:

br_handle_frame_finish() {
    ...
		if (p->state == BR_STATE_DISABLED) {
			reason = SKB_DROP_REASON_BRIDGE_INGRESS_STP_STATE;
			goto drop;
		}

		state = p->state;
    ...
		br_fdb_update(br, p, vlan, eth_hdr(skb)->h_source, 0);
    ...
}

Between the DISABLED store and the final flush, del_nbp() never waits for
such a reader:

del_nbp()
  br_stp_disable_port()          /* p->state = BR_STATE_DISABLED */
  br_ifinfo_notify(RTM_DELLINK, ...)
  list_del_rcu(&p->list)
  nbp_vlan_group_unpublish(p)    /* empty stub, no synchronize_net() */
  br_fdb_cleanup_by_dst(br, br_port_to_dst(p), 0, 1)
  ...
  netdev_rx_handler_unregister(dev)
  call_rcu(&p->rcu, destroy_nbp_rcu)

br_fdb_update() does not check whether the source port is being removed.
If the reader gets to fdb_create() after br_fdb_cleanup_by_dst() has run,
the new entry points at the dying port. The same happens if the reader was
spinning on br->hash_lock while the cleanup held it.

netdev_rx_handler_unregister() only waits for the reader to finish. It
does not remove the entry. A later frame to the learned MAC would then
reach br_forward() through the freed port. In this configuration, the same
window seems to apply to ordinary ports as well.

Would an unconditional synchronize_net() between br_stp_disable_port() and
the final br_fdb_cleanup_by_dst() be needed here, instead of relying on a
side effect of VLAN filtering?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261101044840.1595584-1-1020691186%40qq.com
