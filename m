Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B24747F2FA;
	Mon,  5 Oct 2026 12:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791204183; cv=none; b=EaN+L92tXoEmixQQ8aek4xyMG4VPbbuyGtwaWnGzbHeSojcC2qJrl5d7gEdmniWSjVpHZL9EHS9sER/HDklbBaX8wCEojsMQ9DEz4mh3w9PeL8p9nM2HblCCNKwlhGarclwLeAQGCEUkKOjNuDJ3TuKDuYPYA3Q17ScDy7eeeU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791204183; c=relaxed/simple;
	bh=+TC0b0KdY6aXNXFyI+Caifs/LZbEPr30Xvs6kvDT+pY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IQTIEAC85k/YMvkFtIoPmi7OVupIYyP9yIJG01aIudmQXVvtUE0hb0pUkf+bNESLuwkV3FHaBT6PM7zR68BkwEHYjIjL4Uax6pZD/RHI9Fl3TFRxP/XbZ+i6wBkmvUuJkP5pY9GwWqY6SOeG+9Gpq1CES9X7fJsV3fxZIAuwZCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UNphiJi1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UNphiJi1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83A441F000FF;
	Mon,  5 Oct 2026 12:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791204182;
	bh=UEJCS7FV2WIHrYzkjgOwV9Dni0wyjgpaELEWgL9L5tQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UNphiJi1TIMAY4TMAiXwr5yD46uWnO29Iao+n8SH1sJbsUNxc4GQ3zLbSZ0Xwglyz
	 7EcvXy16IHQ4KDPfiK/xN/79bYAPHnhiAf4kvW9+GMLV4JgXqPkXgZGd0NVDffXkzo
	 UWHgRj2XLmfm09V3D4bGqrXDz2x+7zy8ctsDuqMNBIjBQbTjd5evSGVqUCaL7kdvcg
	 rW+KVEk+Rpafd4so+DJGLqlGcFwP+JIuJ5mJrHx7AZJAJde1Henhd/OaB+61rINZqP
	 8c6iTHG8I+TSU6QnTt4aqYLjGuyX1qbaS5U+lUtSCkgDdq8VsvFmtZxTKSA77kyJQw
	 NI1dvmqTUd7lg==
Subject: Re: [PATCH net] net: bridge: fdb: hold hash_lock when an entry roams
From: netdev-bot+sashiko@kernel.org
To: julius@bairaktaris.de
Cc: netdev@vger.kernel.org, bridge@lists.linux.dev, razor@blackwall.org,
 idosch@nvidia.com, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, andrew@lunn.ch, vladimir.oltean@nxp.com,
 linux-kernel@vger.kernel.org
Date: Mon, 05 Oct 2026 12:43:01 +0000
Message-ID: <179120418105.434549.6770789108608147842@kernel.org>
In-Reply-To: <20261004124254.3525496-1-julius@bairaktaris.de>
References: <20261004124254.3525496-1-julius@bairaktaris.de>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 (1) · Medium: 0 (2) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] br_fdb_update() looks up the entry with fdb_find_rcu() and
  checks it without a lock, then takes br->hash_lock…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but on a MAB-
  enabled locked port, br_fdb_update() can roam an existing entry onto…
- [Medium] Peer-site inconsistency, not introduced by this patch.
- [Medium] TOCTOU on BR_FDB_LOCAL, not introduced by this patch.

--

net: bridge: fdb: hold hash_lock when an entry roams

With this patch, br_fdb_update() takes br->hash_lock when an existing
entry roams to a new port or its flags change. The switchdev delete and
add notifications for the roam are then sent under that lock. The common
case, where the entry neither roams nor changes, stays lockless.

> diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
> index e4570bbed8544..c8680ae3ef08b 100644
> --- a/net/bridge/br_fdb.c
> +++ b/net/bridge/br_fdb.c
> @@ -995,8 +995,17 @@ void br_fdb_update(struct net_bridge *br, struct net_bridge_port *source,
>  				fdb_modified = __fdb_mark_active(fdb);
>  			}
>  
> -			/* fastpath: update of existing entry */
> -			if (unlikely(source != READ_ONCE(fdb->dst) &&
> +			if (likely(!fdb_modified &&
> +				   (source == READ_ONCE(fdb->dst) ||
> +				    test_bit(BR_FDB_STICKY, &fdb->flags)) &&
> +				   !test_bit(BR_FDB_ADDED_BY_USER, &flags)))
> +				return;
> +
> +			/* keep a roam and its two switchdev notifications
> +			 * atomic against a roam on another CPU
> +			 */
> +			spin_lock(&br->hash_lock);
> +			if (unlikely(source != fdb->dst &&
>  				     !test_bit(BR_FDB_STICKY, &fdb->flags))) {
>  				br_switchdev_fdb_notify(br, fdb, RTM_DELNEIGH);
>  				WRITE_ONCE(fdb->dst, source);

[Severity: High]
Is fdb still in the table by the time hash_lock is taken here?

The entry was found with fdb_find_rcu() before the lock was taken. In
that window, any hash_lock holder can run fdb_delete() on it:

net/bridge/br_fdb.c:fdb_delete() {
    ...
	hlist_del_init_rcu(&f->fdb_node);
	rhashtable_remove_fast(&br->fdb_hash_tbl, &f->rhnode,
			       br_fdb_rht_params);
    ...
	fdb_notify(br, f, RTM_DELNEIGH, swdev_notify);
	kfree_rcu(f, rcu);
}

fdb_delete() does not touch fdb->dst. So when this CPU gets the lock,
source != fdb->dst is still true and the following happens:

- a second switchdev RTM_DELNEIGH goes out for the old port
- fdb->dst is rewritten
- a switchdev add and a netlink RTM_NEWNEIGH go out for the new port

At that point the entry is in neither fdb_list nor the rhashtable, so
nothing will ever send the matching delete. The next frame from that MAC
then goes through fdb_create() and sends another add.

Isn't this the same "two deletions for one addition" imbalance the commit
message describes, with the DSA CPU port host address refcount leaking?

Possible deleters include br_fdb_delete_by_port() (port disable or
removal), br_fdb_cleanup() (ageing and STP fast ageing), br_fdb_flush(),
and user or external-learn deletes. br_fdb_delete_by_port() holds
hash_lock for its whole walk. A roaming CPU spinning on the lock would
only get it after the entry has already been removed.

Other code in this file that finds an entry locklessly re-checks it after
taking the lock. For example, br_fdb_cleanup():

			spin_lock_bh(&br->hash_lock);
			if (!hlist_unhashed(&f->fdb_node))
				fdb_delete(br, f, true);
			spin_unlock_bh(&br->hash_lock);

Would a similar check right after spin_lock() be needed here?

	if (unlikely(hlist_unhashed(&fdb->fdb_node))) {
		spin_unlock(&br->hash_lock);
		return;
	}

[Severity: Medium]
This isn't a bug introduced by this patch, but br_fdb_update() tests
BR_FDB_LOCAL before taking the lock and does not test it again inside the
new hash_lock section:

		if (unlikely(test_bit(BR_FDB_LOCAL, &fdb->flags))) {

A concurrent "bridge fdb replace ... permanent" runs fdb_add_entry() under
hash_lock. In that window it can set the local and static bits on the
entry:

		if (state & NUD_PERMANENT) {
			set_bit(BR_FDB_LOCAL, &fdb->flags);
			if (!test_and_set_bit(BR_FDB_STATIC, &fdb->flags))
				fdb_add_hw_addr(br, addr);

Could the roam then move a newly permanent entry onto the receiving port?
Since the lock is now held here anyway, could BR_FDB_LOCAL be re-checked
under it?

The impact looks limited. The switchdev notifications stay balanced
because both target br->dev for local entries, and frames to a local
entry are still delivered locally. Hitting this needs CAP_NET_ADMIN and
the right timing.

[Severity: High]
This is a pre-existing issue, but can this roam move an entry onto a
locked MAB port and leave it unlocked?

br_handle_frame_finish() decides about the locked port from a lockless
lookup. On a mismatch it drops "without roaming":

net/bridge/br_input.c:br_handle_frame_finish() {
    ...
		if (!fdb_src) {
			...
			if (test_bit(BR_PORT_MAB_BIT, &p->flags))
				br_fdb_update(br, p, eth_hdr(skb)->h_source,
					      vid, BIT(BR_FDB_LOCKED));
			goto drop;
		} else if (READ_ONCE(fdb_src->dst) != p ||
			   test_bit(BR_FDB_LOCAL, &fdb_src->flags)) {
			/* FDB mismatch. Drop the packet without roaming. */
			goto drop;
		} else if (test_bit(BR_FDB_LOCKED, &fdb_src->flags)) {
			...
			br_fdb_update(br, p, eth_hdr(skb)->h_source, vid,
				      BIT(BR_FDB_LOCKED));
			goto drop;
		}
    ...
}

br_fdb_update() then does the lookup again. On the existing-entry path it
ignores BIT(BR_FDB_LOCKED) in flags. It roams whenever source != fdb->dst
and BR_FDB_STICKY is clear, and it clears BR_FDB_LOCKED on the assumption
that it is "roaming to an unlocked port".

Two interleavings seem possible.

In the first, the lookup in br_handle_frame_finish() misses. Before
br_fdb_update() does its own lookup, a legitimate host on unlocked port q
creates the entry. The entry is then roamed onto locked port p with
BR_FDB_LOCKED cleared.

In the second, a locked entry for MAC M sits on p. The legitimate host on
q roams it to q, which clears BR_FDB_LOCKED. A concurrent frame on p has
already passed the dst == p && BR_FDB_LOCKED check. It calls
br_fdb_update(br, p, ..., BIT(BR_FDB_LOCKED)), sees dst == q, and roams
the entry back to p, unlocked.

In both cases, later frames from p with that source MAC pass the locked
port check and are forwarded. Traffic for M also goes to p until the
host roams the entry back.

The roam now runs under hash_lock. Would that be a good place to refuse
the roam when BIT(BR_FDB_LOCKED) is set in flags, or when the source port
is locked?

[ ... ]

> @@ -1023,6 +1032,7 @@ void br_fdb_update(struct net_bridge *br, struct net_bridge_port *source,
>  				trace_br_fdb_update(br, source, addr, vid, flags);
>  				fdb_notify(br, fdb, RTM_NEWNEIGH, true);
>  			}
> +			spin_unlock(&br->hash_lock);
>  		}

[Severity: Medium]
This isn't a bug introduced by this patch, but the other places that
change fdb->dst don't use the order this path uses: delete for the old
port, then add for the new one.

fdb_add_entry() does:

		if (READ_ONCE(fdb->dst) != source) {
			WRITE_ONCE(fdb->dst, source);
			modified = true;
		}

br_fdb_external_learn_add() does:

		if (READ_ONCE(fdb->dst) != p) {
			WRITE_ONCE(fdb->dst, p);
			modified = true;
		}

Afterwards both only call fdb_notify() with RTM_NEWNEIGH. Neither sends a
switchdev RTM_DELNEIGH for the old port.

Can a "bridge fdb replace" that moves a static or ext-learned entry
between a foreign port and a DSA user port unbalance the DSA CPU port
host address refcount in the same way? This needs CAP_NET_ADMIN, and it
is separate from the race this patch addresses.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261004124254.3525496-1-julius%40bairaktaris.de
