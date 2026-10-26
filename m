Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793028547;
	b=IG2dHhNi6TI9iRID6adCgznxndaCt88/rHOYtd8aSb7ZQmjRerHeORFotHSEcff7QmnM
	 OgbnMktF78o2o+FjZSoeF42GR/lw3by1cGaB0Y/u8xiiJpKc7DsqL9uwIRJBQMFXFjZwo
	 JKYm+yFcvkcpzAOZ84bSjnRAtTqp3oo1zbpegZnI9U7ZdySYfLcttWh3z9T2F2eWr9D/C
	 U5Pm7bhU1P0Y0uH2aXUtImDPhArNXH6xKyP4Z59gP0ee9rc+Mw2IWdu94UAxRv0s6a1ED
	 6hcpuTS0rGO53GJlX8bfVo4AWK0t3fcj8BlTFXh7QnPGGwdgHlL8x0Ypowknn6sgU8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793028547;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=C3oJnVN+Hwvm5Jbw2TkkoHl94T3jd8kkc2EwWgGtdRs=;
	b=hz5/E/IVvOq4dwC3tUgW6hWwSkEzCzSykhxfAWcbIZaiQRamccMXu7Qmlgc1voHe/DYg
	 iwGwnwbUcnzHEnJrY6IDn49fYfQ8uhJzvjAr34uO1PcBTg0ARmAjKTp5N0DS8c/bbr3nL
	 7lvZrvKry6AXNm+ffit0zhauhwyNC8yAoq31XEFRUane3XNp4mWR8vagbVzx5PyGlu4C3
	 GkDD+ybUWMNiJF2EtBF5mU2MbJQlHe/ON8CsOGk4FyLN+4fPJaRvRGw8zsPuKMdFlctg7
	 aZUQi4xqNkcl8Zp4gcBvEoZcAW4SaH9kKhKAOkOKbgTpP4koA4spSv+8Bo3Fm48+yFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HCnFYEo2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0118B606A31A;
	Mon, 26 Oct 2026 15:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HCnFYEo2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C430B1F01825;
	Mon, 26 Oct 2026 15:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793028546;
	bh=C3oJnVN+Hwvm5Jbw2TkkoHl94T3jd8kkc2EwWgGtdRs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HCnFYEo2VZpk4lWe7IE/EFDnLdw6iW6il7r8s2Ga7KmYF6xN80CElgzQQBzlXvecA
	 3k8pZGQBLoEjNoizGISJZAQr6dZLaRWg6DfZj9S26prBK5IHOJ3sATiqe5UNQc37Yq
	 +BIzGJZ+3uTEsefS5meCrKHwXTe0XKDCa93JwJNQVf5EKb1szQCSs455EP5FjYII4/
	 HeKW/vop9dXo6M0HzLbRw57CqLLecRS9NGllrNuISevz5Dil+cHCeVNEmPtXj5w9pJ
	 5zfqyaxNR85nzVJJUyXM9j0NqGZPOogGffJwd/gQv0MHIE7rlAVGv9nnyu53Ms1hKW
	 45/tIlbDTYeLw==
Subject: Re: [PATCH net] net: bridge: do not bypass port state for MST without
 VLAN filtering
From: netdev-bot+sashiko@kernel.org
To: teel4res@gmail.com
Cc: razor@blackwall.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 bridge@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 tobias@waldekranz.com
Date: Mon, 26 Oct 2026 15:29:05 +0000
Message-ID: <179302854528.3134.18358959701165767967@kernel.org>
In-Reply-To: <179268538303.70821.3493915601694605045@gmail.com>
References: <179268538303.70821.3493915601694605045@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch adds a live, lockless read of BROPT_VLAN_ENABLED to
  br_mst_is_enabled() (net/bridge/br_private.h:1956).

--

net: bridge: do not bypass port state for MST without VLAN filtering

This commit makes br_mst_is_enabled() also require BROPT_VLAN_ENABLED.
Without that check, a bridge with MST enabled but VLAN filtering
disabled enforces no port state at all. With the patch, the legacy STP
port state checks apply until VLAN filtering is turned on.

> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index ff746f036f548..85065304597eb 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h
> @@ -1953,6 +1953,7 @@ static inline bool br_mst_is_enabled(const struct net_bridge_port *p)
>  	/* check the port's vlan group to avoid racing with port deletion */
>  	return static_branch_unlikely(&br_mst_used) &&
>  	       br_opt_get(p->br, BROPT_MST_ENABLED) &&
> +	       br_opt_get(p->br, BROPT_VLAN_ENABLED) &&
>  	       rcu_access_pointer(p->vlgrp);
>  }

[Severity: Medium]
Can a frame now skip both the legacy port state check and the per-VLAN
MST state check while vlan_filtering is being toggled?

The predicate now depends on a bit that can change at runtime. A single
frame evaluates it separately in br_handle_frame(),
br_handle_frame_finish() and should_deliver(). br_allowed_ingress() also
reads BROPT_VLAN_ENABLED on its own. The writer flips the bit under RTNL
and does not wait for frames already in flight:

net/bridge/br_vlan.c:br_vlan_filter_toggle() {
    ...
	br_opt_toggle(br, BROPT_VLAN_ENABLED, !!val);

	err = switchdev_port_attr_set(br->dev, &attr, extack);
	if (err && err != -EOPNOTSUPP) {
		br_opt_toggle(br, BROPT_VLAN_ENABLED, !val);
		return err;
	}
    ...
}

Say VLAN filtering is being turned off while MST is enabled, and the
ingress port is in BR_STATE_BLOCKING. Here is one interleaving:

br_handle_frame()
    if (br_mst_is_enabled(p))        <-- true
        goto defer_stp_filtering;    <-- BLOCKING drop skipped
    nf_hook_bridge_pre()             <-- frame may sit in NF_QUEUE

                                     br_vlan_filter_toggle() clears
                                     BROPT_VLAN_ENABLED

br_handle_frame_finish()
    if (br_mst_is_enabled(p)) {      <-- now false
    } else {
        if (p->state == BR_STATE_DISABLED)  <-- only DISABLED dropped
        state = p->state;            <-- BLOCKING
    }
    br_allowed_ingress()             <-- returns true, filtering off
    if (state == BR_STATE_LEARNING)  <-- only remaining state check

The frame then looks like it is forwarded or flooded from a BLOCKING
port.

A similar case is when both MST checks see true and set state to
BR_STATE_FORWARDING, and the bit is cleared before br_allowed_ingress()
runs. In that case the per-VLAN MST state is never applied either.

On egress, when VLAN filtering is being turned on, ingress can record
vlan_filtered = false. should_deliver() then sees br_mst_is_enabled()
as true and skips the p->state check:

	(br_mst_is_enabled(p) || p->state == BR_STATE_FORWARDING) &&
	br_allowed_egress(vg, skb) && ...

br_allowed_egress() then passes the frame unconditionally:

	if (!BR_INPUT_SKB_CB(skb)->vlan_filtered)
		return true;

Would that let a BLOCKING egress port transmit the frame?

Before this patch, br_mst_is_enabled() did not depend on
BROPT_VLAN_ENABLED, so these interleavings look new. The window only
lasts while the reads disagree. A bridge PREROUTING NF_QUEUE rule can
stretch it.

Would it be possible to make the MST/VLAN decision once per frame and
reuse it at each check? For example, it could be carried in
BR_INPUT_SKB_CB. Another option is to skip p->state in should_deliver()
only when BR_INPUT_SKB_CB(skb)->vlan_filtered is set. A third is to
re-check BLOCKING/LISTENING in br_handle_frame_finish() when VLAN
filtering turns out to be off.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/179268538303.70821.3493915601694605045%40gmail.com
