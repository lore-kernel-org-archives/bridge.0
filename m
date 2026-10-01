Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3C849D5A6;
	Thu,  1 Oct 2026 11:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790855957; cv=none; b=cYl2lgSR0ljO/W88hcVH3y99lcWCYoSbZimDcrw9YZbnA1kEE8ZapfccY5q4Mr8o69PyILKotDBuiZCxcKA1SF6UxyL7NzzlYvfyxMf6Q4jvq2kihWcvw/+HVLkvff8LPWEIhsPhzGaonXXbPFzlPvi2GsXag2phqHzr5Tv7IVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790855957; c=relaxed/simple;
	bh=paXupNxwIAnxdima1KhWRJKHOHPuK0QeHl4VG9J+B5Y=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ORIfi3Pv2R2pGj6+EQQ44nJf+yzv7pLKd+gTwaRN+xDtsySUe3Qn5g7fstKs+mB25O1Ru44D13GxZAROEW4Gjewrwd6tlBTEDCGC/irD3C3b+OVFx/j/9FMzqerorgy/KXSmTORqWjWHpTBsMLHcz/EUPPNPlbc9Wtf3j72E//k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RlNvctr4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RlNvctr4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90DA71F00899;
	Thu,  1 Oct 2026 11:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790855951;
	bh=+baQP+miX9UvZedEpnTDa9/FQzsPj7cKy/tVwXbKjYQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RlNvctr452KN6SaHSfJWmf/KsLJXrNhnZhuynLA2rmCkUcrjnqQxZlua6a0yuNdfT
	 l7Z0Yr42bLlUJtZzPBxZ4bH6Hg+dZUQw4d+4DFUvQFuiClsEYUgcxbGsISLITWa09a
	 1lOpkQu+j+657CH7sk8gXVZygvfLu72mVA5+GWhV4cDtIbWlF7VN/TFdg9li8hYWNd
	 wdHXrd6AWgJQGwDhMSTJ1+nSmpxHZL0t1DbhFIgMLSDpGR15k/YALD/R/vRRaeDjk1
	 KH7+P1hECjnWZulQXF1TYc2SOXkn3I9nzvvVFwE0ZM/7QHlkam0xxJK8g4EI0wlLUi
	 Kd2O9pjU0pS4A==
Subject:
 Re: [PATCH net-next 06/12] net: bridge: fdb: consolidate port-VLAN cleanup
From: netdev-bot+sashiko@kernel.org
To: razor@blackwall.org
Cc: netdev@vger.kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 bridge@lists.linux.dev
Date: Thu, 01 Oct 2026 11:59:10 +0000
Message-ID: <179085595018.434549.16034696945314071975@kernel.org>
In-Reply-To: <20260930071411.2786201-7-razor@blackwall.org>
References: <20260930071411.2786201-7-razor@blackwall.org>
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

- [Low] The patch rewrote the header comment of br_fdb_cleanup_by_dst()
  in net/bridge/br_fdb.c, but the comment does not describe what the…

--

net: bridge: fdb: consolidate port-VLAN cleanup

This renames br_fdb_delete_by_port() to br_fdb_cleanup_by_dst() and passes
a bridge dst, so the function can tell a port-VLAN from a raw port. For a
port-VLAN dst, the port's automatically generated local entry for that VLAN
is now removed in the same locked fdb walk that flushes dynamic entries.
As a result, nbp_vlan_delete() no longer calls br_fdb_find_delete_local()
separately.

> diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
> index 9cd6deae86359..7c68b540b3580 100644
> --- a/net/bridge/br_fdb.c
> +++ b/net/bridge/br_fdb.c
> @@ -868,15 +868,16 @@ int br_fdb_delete_bulk(struct nlmsghdr *nlh, struct net_device *dev,
>  	return 0;
>  }
>  
> -/* Flush all entries referring to a specific port.
> +/* Clean up all entries referring to a specific destination.
>   * if do_all is set also flush static entries
>   * if vid is set delete all entries that match the vlan_id
>   */
> -void br_fdb_delete_by_port(struct net_bridge *br,
> -			   const struct net_bridge_port *p,
> -			   u16 vid,
> +void br_fdb_cleanup_by_dst(struct net_bridge *br,
> +			   struct net_bridge_dst cleanup_dst, u16 vid,
>  			   int do_all)
>  {
> +	const struct net_bridge_vlan *vlan = br_dst_vlan(cleanup_dst);
> +	const struct net_bridge_port *p = br_dst_port(cleanup_dst);
>  	struct net_bridge_fdb_entry *f;
>  	struct hlist_node *tmp;
>  
> @@ -885,6 +886,14 @@ void br_fdb_delete_by_port(struct net_bridge *br,
>  		if (br_fdb_dst_port(f) != p)
>  			continue;
>  
> +		if (vlan && f->key.vlan_id == vlan->vid &&
> +		    test_bit(BR_FDB_LOCAL, &f->flags) &&
> +		    !test_bit(BR_FDB_ADDED_BY_USER, &f->flags) &&
> +		    ether_addr_equal(f->key.addr.addr, p->dev->dev_addr)) {
> +			fdb_delete_local(br, p, f);
> +			continue;
> +		}
> +
>  		if (!do_all)
>  			if (test_bit(BR_FDB_STATIC, &f->flags) ||
>  			    (test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &f->flags) &&

[Severity: Low]
This isn't a bug, but does the rewritten header comment above
br_fdb_cleanup_by_dst() still describe what the function does?

The comment says static entries are only flushed when do_all is set. With a
port-VLAN dst, the new branch runs before the do_all check. It removes the
port's auto-generated local entry even when do_all == 0. fdb_add_local()
creates that entry as static:

net/bridge/br_fdb.c:fdb_add_local() {
    ...
	fdb = fdb_create(br, source, addr, vid,
			 BIT(BR_FDB_LOCAL) | BIT(BR_FDB_STATIC));
    ...
}

The comment also says the function cleans up "all entries referring to a
specific destination". The walk only compares the port part of the dst:

	if (br_fdb_dst_port(f) != p)
		continue;

The VLAN part is used only for the local-entry case.

The local-entry match uses vlan->vid, but the dynamic-entry filter uses the
separate vid argument, and nothing ties the two together. nbp_vlan_delete()
is fine today because it gets v from br_vlan_find(vg, vid).

A later caller might pass br_vlan_to_dst(v) with vid == 0 or with a
different vid. That call would remove v's local entry. It would then flush
dynamic entries across all of the port's VLANs, or in a different VLAN.

Could the comment say that vid is expected to match the VLAN's vid when a
VLAN dst is passed?

The line "if vid is set delete all entries that match the vlan_id" was
already inaccurate before this patch, because vid is ignored under do_all
and static or ext-learned entries are kept. That part is pre-existing, but
the patch kept the line when it rewrote the comment.

Later in the series, in "net: bridge: fdb: avoid VLAN lookups in unicast
forwarding", the comment is still the same. By then the function does more
VLAN-specific work, including falling back from the VLAN dst to the port
dst.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930071411.2786201-1-razor%40blackwall.org
