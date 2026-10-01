Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1EA492E38;
	Thu,  1 Oct 2026 11:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790855959; cv=none; b=HIaXRgDx2slLoOEghr3SEsoDlitbfHvFB+0qS3853t3PbKRQh4TcyKoFxd9XtGWfQ1dKt+D7uSEAD7TerrhCZgxEL6yw+YatMaeojatQ27UH0RJA5dYlIWP5s1iTdPthyZ/VhDHcTQHa7Fx3GF+k20nT5NXvQ4SU+RwiRDepj54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790855959; c=relaxed/simple;
	bh=NsjqsP/01iOs+ECuCP0LUatb4A7a7qqQSBOyJyNxb/0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X/0duVdi3Hgk2M//r6qxj0sUYQDwUfupOklwi0PeegxgcG54BTegf0NTE2AwvdZUHCQJ7msXkpvmLqgfBOTJixKnXRBThpT+ToP8221Zja+Y8y/v3Oa9SUxvRFaCmV6onZtE3UPxn821Ik84g9iEfhCJRYWiuN+gV3X4k85QjvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gl+Eq2Ss; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gl+Eq2Ss"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A74901F00898;
	Thu,  1 Oct 2026 11:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790855952;
	bh=NajJoebvjHslqpH38SDZm1jicJm6kccmtfahkFNxqiI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=gl+Eq2Ss1uZLw4aUSgYyfxZUOqoaklUMeJKTBdLxHCEj9X3zcCi3fOSd0/CTDmF5Y
	 10p9HO5e/bPwh9D3VrAdfG64ZRBp/m9fdA0VhLB4bt5N5Q6beCTX172QH/omf8XZce
	 Ml1B0G070tvOWSqqLvGyI44SrE7piAWL1M1vKEH6gWS6Qlkb4WR3buIHDsL1Yp2hZA
	 +XA66YoNBLp11B4xSj5cTMXu+cpJIExnwrWwz69bPC+NsdqTDtjx8pnWNImn4gFQz8
	 0wM6XFUResZguKB93hfDmu1Ra5MdCYK9wefw1VlpqAezP7OpecW5JvkrYNod2sYjX1
	 dfRgoHd5vzQaw==
Subject: Re: [PATCH net-next 08/12] net: bridge: vlan: quiesce readers before
 freeing port VLANs
From: netdev-bot+sashiko@kernel.org
To: razor@blackwall.org
Cc: netdev@vger.kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 bridge@lists.linux.dev
Date: Thu, 01 Oct 2026 11:59:11 +0000
Message-ID: <179085595119.434549.4421493167752460988@kernel.org>
In-Reply-To: <20260930071411.2786201-9-razor@blackwall.org>
References: <20260930071411.2786201-9-razor@blackwall.org>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] nbp_vlan_delete() in net/bridge/br_vlan.c now calls
  synchronize_net() for every port-VLAN it deletes.
- [Low] br_fdb_cleanup_by_dst() in net/bridge/br_fdb.c reads f->dst once
  into `dst`.

--

net: bridge: vlan: quiesce readers before freeing port VLANs

This patch prepares for fdb entries caching port-VLAN pointers. A port
VLAN is now unpublished, a grace period passes, and only then are the fdb
references purged or rewritten and the VLAN freed. During port teardown
the whole VLAN group is unpublished first, so all VLANs share one grace
period.

> diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
> index 7c68b540b3580..307f9c12914ef 100644
> --- a/net/bridge/br_fdb.c
> +++ b/net/bridge/br_fdb.c
> @@ -883,7 +883,9 @@ void br_fdb_cleanup_by_dst(struct net_bridge *br,
>
>  	spin_lock_bh(&br->hash_lock);
>  	hlist_for_each_entry_safe(f, tmp, &br->fdb_list, fdb_node) {
> -		if (br_fdb_dst_port(f) != p)
> +		struct net_bridge_dst dst = br_fdb_dst_read(f);
> +
> +		if (br_dst_port(dst) != p)
>  			continue;
>

[ ... ]

> +			     !test_bit(BR_FDB_OFFLOADED, &f->flags))) {
> +				/* The entry outlives the VLAN, so it must fall
> +				 * back to the raw port destination
> +				 */
> +				if (vlan && br_dst_vlan(dst) == vlan)
> +					br_fdb_dst_write(f,
> +							 br_port_to_dst(p));

[Severity: Low]
Can this unconditional write lose a concurrent roam?

dst is read once at the top of the loop. br_fdb_update() roams entries by
writing fdb->dst under RCU only, without br->hash_lock:

br_fdb_update()
    br_fdb_dst_write(fdb, br_port_to_dst(source));

If a roam lands between br_fdb_dst_read() and this br_fdb_dst_write(), the
new port would be overwritten with p.

This branch can't be reached at this commit. Every br_fdb_dst_write()
caller stores br_port_to_dst(), so br_dst_vlan(dst) is always NULL here.

Later in the series, "net: bridge: fdb: cache port VLANs in learned
entries" replaces this with br_fdb_dst_replace(f, dst, br_port_to_dst(p)).
That is a cmpxchg against the snapshot, so a concurrent roam is kept.

Would it make sense to use the conditional replace here from the start?

>  				continue;
> +			}
> +		}

[ ... ]

> diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
> index 8a914e249767a..0675f74cf1b99 100644
> --- a/net/bridge/br_vlan.c
> +++ b/net/bridge/br_vlan.c
> @@ -1406,23 +1406,32 @@ int nbp_vlan_delete(struct net_bridge_port *port, u16 vid)
>  	v = br_vlan_find(vg, vid);
>  	if (!v)
>  		return -ENOENT;
> -	br_fdb_cleanup_by_dst(port->br, br_vlan_to_dst(v), vid, 0);
>  	__vlan_unpublish(vg, v);
> +	synchronize_net();

[Severity: Medium]
Does this add one expedited grace period for each port VLAN deleted, all
while RTNL is held?

Every caller of nbp_vlan_delete() holds RTNL, so synchronize_net() always
goes through synchronize_rcu_expedited(). Range requests are processed one
VID at a time under a single RTNL hold:

br_process_vlan_info()
    for (v = (*vinfo_last)->vid; v <= vinfo_curr->vid; v++) {
        br_vlan_info()
            nbp_vlan_delete(p, vinfo->vid)
                synchronize_net()

So a request like "bridge vlan del dev swp1 vid 1-4094" could run up to
4094 expedited grace periods back to back with RTNL held. The
cond_resched() in that loop doesn't drop RTNL.

The per-port loops in br_vlan_disable_default_pvid() and
__br_vlan_set_default_pvid() also now take one grace period per bridge
port. That includes the error unwind loop in __br_vlan_set_default_pvid().

Before this patch, nbp_vlan_delete() waited for no grace period at all,
because __vlan_del() only queues call_rcu().

The commit message only describes batching for port teardown:

  "This lets all VLANs share one grace period."

Could range deletion be batched the same way? For example, unpublish the
whole range, wait once, then clean the fdbs and free the VLANs.

At this commit, no fdb writer stores a VLAN dst yet. That starts with "net:
bridge: fdb: cache port VLANs in learned entries". The per-VLAN
synchronize_net() is still unchanged at the end of the series, in "net:
bridge: fdb: avoid VLAN lookups in unicast forwarding".

> +	/* Traffic may still use v through cached fdb dsts until they are
> +	 * cleaned below. This is acceptable during vlan deletion. Above we
> +	 * drain the readers that could republish the dst before cleaning it
> +	 */
> +	br_fdb_cleanup_by_dst(port->br, br_vlan_to_dst(v), vid, 0);
>  	__vlan_del(vg, v);
>
>  	return 0;
>  }

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930071411.2786201-1-razor%40blackwall.org
