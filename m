Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B06C36195E;
	Sat,  5 Sep 2026 20:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788640079; cv=none; b=qUpgD8BMmsQpePdRCTYxZAs3I7zdvNyym7j5EQj42xcNx3owz2umVCwNQZvNAohZUAf7tezmzXx6nvLp8C6XPN6AmHU09/gIF7nzVR9kocboycf+KhVbYhWQe03oxAIghDh8pFfdLqfamipZeMC6rtbhJ2XdnlKN/ov2vPoNc+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788640079; c=relaxed/simple;
	bh=tgWG8UhX4ip0w3ei7HeJcEq+KjBsFvn6XYTxXXAwIjU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m4DdWpOpX9TGWx8ROqT2iWbg/XyvRX3CvzjfFt2CWI2jJ47u6ZJHs/gAvZDSuSgpvjLrJdrkqA/Adkb03yyD0PVYEldgbqTJAPCpwcYOTk1DsLz93LJ76xTUsUR5vws/dENVRokKu7INLXINq47/n7CPnm5RRAegyIADasCD8kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NS/EW1r7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NS/EW1r7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CB5F1F00A3A;
	Sat,  5 Sep 2026 20:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788640077;
	bh=rS8qy5IifdTy0NzfzNiYDTKrTqX8UKX297CUWxgGGPI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NS/EW1r7zIqRGEJMc39AuxPGfNnmZwPxW8eHA8gZfKSJxpcEp++fsnPNsVYeRN/2u
	 AfYY9bwqu+u1K5rlgsYkIrmsYaerBaKh7IgS7QlVPfcLhR++ZPKoxLXlDCm1tYJp3T
	 ogZclfo0Sk2Q12Qdaa5aa/WkbwbKMilxLwAA51ZtnlV3/cUcGkL69o3zo2Sno4MTpn
	 kMwVt6zY+8LoJ/nT2wBteuzTmQ4SVXnVK/c50ENKBgx6w3Hb47GRMmAo0sOsqIL7K+
	 3lyay68oOLryhLciOA82wIHLueFA8oYx9q9IH0lLBI/94bybxkepZdHrs2Vf5MvNj4
	 CaOvgSLsl7VDg==
Subject:
 Re: [PATCH net-next v2 1/9] net: bridge: vlan: drop legacy memory barriers
From: netdev-bot+sashiko@kernel.org
To: razor@blackwall.org
Cc: netdev@vger.kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 bridge@lists.linux.dev
Date: Sat, 05 Sep 2026 20:27:56 +0000
Message-ID: <178864007675.219967.6069320085194764242@kernel.org>
In-Reply-To: <20260903143138.1574598-2-razor@blackwall.org>
References: <20260903143138.1574598-2-razor@blackwall.org>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 0 (1)

- [Medium] Writer-side publish ordering removed: in `__vlan_add()`
  (net/bridge/br_vlan.c) a new VLAN is made visible to RCU readers…

Pre-existing issues:
- [Low] Concern (retained for policy combination, but validated as
  resolved within this series): after this patch `vg->pvid` is read and…

--

net: bridge: vlan: drop legacy memory barriers

This removes the smp_wmb() calls from __vlan_add_pvid() and
__vlan_delete_pvid() and the smp_rmb() from br_get_pvid(), on the grounds
that the pvid is written under lock and read under rcu in the fast-path.
A couple of questions about the write side below.

> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index d337b1cfb980..5b2c22ad669e 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h
> @@ -1687,7 +1687,6 @@ static inline u16 br_get_pvid(const struct net_bridge_vlan_group *vg)
>  	if (!vg)
>  		return 0;
>  
> -	smp_rmb();
>  	return vg->pvid;
>  }

[Severity: Low]
This isn't a bug introduced by this patch, but with the barriers gone
vg->pvid is left as a plain C access on both sides: br_get_pvid() does
"return vg->pvid;", and the writers in br_vlan.c do "vg->pvid = v->vid;"
and "vg->pvid = 0;". There is also a direct read outside the helper in
br_mst_vlan_set_state():

net/bridge/br_mst.c:br_mst_vlan_set_state() {
	...
	if (v->vid == vg->pvid)
	...
}

The sibling field in the same struct is only touched through accessors
that mark the access:

net/bridge/br_private.h {
	static inline void br_vlan_set_pvid_state(struct net_bridge_vlan_group *vg,
						  u8 state)
	{
		WRITE_ONCE(vg->pvid_state, state);
	}
}

The follow-up patches in this series do address this - "net: bridge: vlan:
annotate lockless pvid use" converts br_get_pvid() to READ_ONCE() and both
writers to WRITE_ONCE(), and "net: bridge: mst: use br_get_pvid helper"
converts the br_mst.c read - so this only applies to the intermediate tree
state at this commit. Would it be simpler to fold the annotation into this
patch so no intermediate state has an unmarked pvid access?

> diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
> index 1e0e436629ec..2ae6ffb23399 100644
> --- a/net/bridge/br_vlan.c
> +++ b/net/bridge/br_vlan.c
> @@ -40,7 +40,6 @@ static void __vlan_add_pvid(struct net_bridge_vlan_group *vg,
>  	if (vg->pvid == v->vid)
>  		return;
>  
> -	smp_wmb();
>  	br_vlan_set_pvid_state(vg, v->state);
>  	vg->pvid = v->vid;
>  }

[Severity: Medium]
The commit message says "nothing to commit prior to changing it".  Is that
accurate for the add path?  In __vlan_add() the vlan is published to rcu
readers first, and the pvid store happens after that:

net/bridge/br_vlan.c:__vlan_add() {
	...
	/* set the state before publishing */
	br_vlan_init_state(v);

	err = rhashtable_lookup_insert_fast(&vg->vlan_hash, &v->vnode,
					    br_vlan_rht_params);
	if (err)
		goto out_fdb_insert;

	__vlan_add_list(v);
	__vlan_flags_commit(v, flags);	/* -> __vlan_add_pvid() */
	...
}

So the removed smp_wmb() sat between the rhashtable insert / list add and
the vg->pvid store.  On a weakly ordered architecture, can a fast-path
reader observe the new vg->pvid before the matching net_bridge_vlan is
visible in vg->vlan_hash?  The rhashtable bucket store has release
semantics for the insert itself, but nothing orders the later plain pvid
store after it, and the WRITE_ONCE() added by the next patch in the series
does not provide store-store ordering either.

If that can happen, the reader in __allowed_ingress() picks up the new pvid
and then fails the lookup:

net/bridge/br_vlan.c:__allowed_ingress() {
	...
	v = br_vlan_find(vg, *vid);
	if (!v || !br_vlan_should_use(v))
		goto drop;
	...
}

which would drop untagged/priority-tagged frames for the length of the
window (this lookup is reached when BROPT_MCAST_VLAN_SNOOPING_ENABLED or
BROPT_VLAN_STATS_ENABLED is set), triggered by something like
"bridge vlan add dev <port> vid N pvid untagged" for a new vlan while
untagged traffic is received on that port.

For the read side the analysis looks fine: the smp_rmb() in br_get_pvid()
preceded the pvid load, so it never ordered the pvid load against the
following hash lookup - that direction comes from the address dependency
into the bucket computation.

If the write-side ordering is still wanted without a fence in the
fast-path, would smp_store_release(&vg->pvid, v->vid) here be the right
replacement?

> @@ -50,7 +49,6 @@ static void __vlan_delete_pvid(struct net_bridge_vlan_group *vg, u16 vid)
>  	if (vg->pvid != vid)
>  		return;
>  
> -	smp_wmb();
>  	vg->pvid = 0;
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260903143138.1574598-1-razor%40blackwall.org
