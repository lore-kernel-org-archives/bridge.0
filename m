Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795461804;
	b=f+KDmD4On+WB+S6AYWC8TA7YJ8crt/S1O3AJK6HgotBXS28kUjEB0Hh1FXSOV823vW0+
	 Ke+gdOXSI4fkJ/Dl1Qnj9iuJXcuCjtQ90kcbXcsqsmAK1gOTf3BIOMHUyXkPZkcAU1Syw
	 Hko5XNlP27v5qY76QLC/vWsRIPx9EZEg+qQTT4+VO5hnteC8ZK8DLoLw/JdhwmHL8CUO4
	 OVyY7EhK3ZlKREohbBtDPEgZfVPo6qUm6plUeZeCk0qNe9OIHuml3nzyc2NF1827bOip+
	 9Qqlc6xvkfRTjkiuuBMNFvw8CewKP1huX4D3VcCvmOopAKKCREvZ4unUJdXH2MKmHMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795461804;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=fhUKm+do3TxAyyEFU4NqF0vG45kG3h279znbQEFbaTE=;
	b=rXMEybIVDT9zKjOuOxloMtRYE4wveZ2vdek2jgouwReIvKb3N/OVJJMMZJ6FT89zOXif
	 C6vhelzZvpqlwtfYsIsJAKyuZCixPFM4uk9E3nw43xt9dW3HBzQ2ZhyEb9tP+sbSCR78k
	 cB6SOwN4UaTwOZl2qzcJIkicax5/OhXXrVpu8CdUu4h3KjottC6ngwfPQ+9qwJk1u79+/
	 fBBUTPFXd4ogiyS82QrC2nGlGYkcmPJNUShS8+ljql8QXnTmkvy6PM+FYT6fa+FH77Nej
	 pyX6XLnDwMZ1D5UcyCwaxb1oUK/im8RTdi62dfplxuxvTQtmTCYhNTR95rO7DGC5Oew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MFBOQgTC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9809606A31A;
	Mon, 23 Nov 2026 19:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MFBOQgTC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EC111F000CF;
	Mon, 23 Nov 2026 19:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795461804;
	bh=fhUKm+do3TxAyyEFU4NqF0vG45kG3h279znbQEFbaTE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MFBOQgTCSu5rbSwBW/SqlX9d7qB+cyS88fufP4nm9z+y7FDjjzNn9PpuH/+eYINrt
	 QWDHRGjOzC4QzPBG4evm828OGlyOxi8jm03ZvymlmFin9qcvubM7Uuwvp/5bdBaOvk
	 AnvXaQgrVx6/n9X3RK3rQdr1GLLAMgfxa/nB4XbDz72KxS0V3O7lAf8k0n22NG7aLx
	 nW7rrx73FmRyvxZkbZ4Egv6SDwD9RLkqN5CvEv5kJkr8SrXJ52ZH7jzqlnRvv3uqKc
	 5hr+bo42pefH9TQuWP4uiumJTz7RGmZqcCiHV7LmJYptN1VXcHey+YEFh4LTbjR0of
	 HswAq/oDDClxA==
Subject: Re: [PATCH net-next v2 1/2] net: bridge: withdraw the switchdev entry
 of an fdb entry made dynamic
From: netdev-bot+sashiko@kernel.org
To: julius@bairaktaris.de
Cc: razor@blackwall.org, idosch@nvidia.com, netdev@vger.kernel.org,
 bridge@lists.linux.dev, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, olteanv@gmail.com,
 vladimir.oltean@nxp.com, jbrandeb@kernel.org
Date: Mon, 23 Nov 2026 19:23:22 +0000
Message-ID: <179546180293.3135.5862034760494795708@kernel.org>
In-Reply-To: <20261122192118.1204290-2-julius@bairaktaris.de>
References: <20261122192118.1204290-2-julius@bairaktaris.de>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 3 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] A late driver offload report can set BR_FDB_OFFLOADED again
  after the new withdrawal has cleared it.
- [Medium] The new withdrawal does its check and its action as separate
  steps, with nothing that excludes the lockless packet path.
- [Medium] The patch treats br_switchdev_fdb_notify()'s filter as the
  definition of what is reported, and withdraws an entry…

--

net: bridge: withdraw the switchdev entry of an fdb entry made dynamic

Two paths turn an fdb entry into a user-added dynamic entry, which
br_switchdev_fdb_notify() no longer reports. They are fdb_add_entry()
("replace ... master dynamic") and the NTF_USE branch of __fdb_update()
("replace ... master use"). Before either path does so, the patch now
sends a switchdev deletion for the entry and clears BR_FDB_OFFLOADED, and
br_fdb_offloaded_set() now assigns the offloaded flag instead of toggling
it.

> diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
> index b601245ad9239..4af091c192449 100644
> --- a/net/bridge/br_fdb.c
> +++ b/net/bridge/br_fdb.c

[ ... ]

> @@ -1032,6 +1033,7 @@ static void __fdb_update(struct net_bridge *br,
>  			br_switchdev_fdb_notify(br, fdb, RTM_DELNEIGH);
>  			br_fdb_dst_write(fdb, dst);
>  			fdb_modified = true;
> +			roamed = true;
>  			/* take over HW learned entry */
>  			if (unlikely(test_bit(BR_FDB_ADDED_BY_EXT_LEARN,
>  					      &fdb->flags)))
> @@ -1049,6 +1051,12 @@ static void __fdb_update(struct net_bridge *br,
>  	}
>  
>  	if (unlikely(test_bit(BR_FDB_ADDED_BY_USER, &flags))) {
> +		if (!test_bit(BR_FDB_STATIC, &fdb->flags) &&
> +		    !test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags)) {
> +			if (!roamed)
> +				br_switchdev_fdb_notify(br, fdb, RTM_DELNEIGH);
> +			clear_bit(BR_FDB_OFFLOADED, &fdb->flags);
> +		}
> +		set_bit(BR_FDB_ADDED_BY_USER, &fdb->flags);

[Severity: Medium]
Can the packet path slip in between this withdrawal and the
set_bit(BR_FDB_ADDED_BY_USER) below it?

The NTF_USE branch gets here from __br_fdb_add() holding only
local_bh_disable() and rcu_read_lock(). The packet path,
br_fdb_update() -> fdb_find_rcu() -> __fdb_update(), takes no lock at
all.

Three things happen in separate steps: the check that the entry is still
reported, the DEL, and the move to the never-reported state.

Take M learned on port A, with a frame from M arriving on a non-sticky
port B:

CPU0 (bridge fdb replace M dev vA master use)
__fdb_update()
    br_switchdev_fdb_notify(br, fdb, RTM_DELNEIGH);    /* DEL for A */

CPU1 (frame from M on port B)
__fdb_update()
    if (source != old_port) {
        br_switchdev_fdb_notify(br, fdb, RTM_DELNEIGH); /* DEL for A again */
        br_fdb_dst_write(fdb, dst);
    ...
    fdb_notify(br, fdb, RTM_NEWNEIGH, true);           /* ADD for B */

CPU0
    clear_bit(BR_FDB_OFFLOADED, &fdb->flags);
    set_bit(BR_FDB_ADDED_BY_USER, &fdb->flags);

CPU1's notifications get through the filter in br_switchdev_fdb_notify()
because BR_FDB_ADDED_BY_USER is still clear.

Once CPU0 sets the bit, the filter drops every later notification for
the entry, including its final deletion. So the hardware entry for B is
never withdrawn. For a host address on the DSA CPU port, the refcounted
entry from dsa_port_do_fdb_add() stays installed after the bridge drops
or moves the entry.

The second DEL for A has no matching ADD. On the CPU port,
dsa_port_do_fdb_del() returns -ENOENT. With fdb_isolation off,
db.bridge.num is 0 and shared across bridges, so it can instead drop a
reference that another bridge holds for the same addr/vid.

fdb_add_entry() holds hash_lock, but the packet path doesn't take it. So
the same window exists there, between the DEL and the later
fdb_update_dst(), set_bit(BR_FDB_ADDED_BY_USER) and clearing of
BR_FDB_STATIC.

The following patch in the series only adds clear_bit(BR_FDB_OFFLOADED)
on the roam path, so it doesn't close this window.

>  		if (test_and_clear_bit(BR_FDB_DYNAMIC_LEARNED, &fdb->flags))
>  			atomic_dec(&br->fdb_n_learned);
> @@ -1262,6 +1270,12 @@ static int fdb_add_entry(struct net_bridge *br, struct net_bridge_dst dst,
>  		if (flags & NLM_F_EXCL)
>  			return -EEXIST;
>  
> +		if (!(state & (NUD_PERMANENT | NUD_NOARP)) &&
> +		    !test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags)) {
> +			br_switchdev_fdb_notify(br, fdb, RTM_DELNEIGH);
> +			clear_bit(BR_FDB_OFFLOADED, &fdb->flags);
> +		}
> +

[Severity: Medium]
How does this withdrawal interact with br_switchdev_fdb_replay()?

The patch treats the br_switchdev_fdb_notify() filter as the definition
of which entries are reported. Replay doesn't use that filter. It walks
every entry, including user-added dynamic ones:

net/bridge/br_switchdev.c:br_switchdev_fdb_replay() {
    ...
	hlist_for_each_entry_rcu(fdb, &br->fdb_list, fdb_node) {
		err = br_switchdev_fdb_replay_one(br, nb, fdb, action, ctx);
    ...
}

When a DSA port leaves the bridge, a converted entry gets a second DEL:

dsa_port_pre_bridge_leave()
    switchdev_bridge_port_unoffload()
        br_switchdev_fdb_replay(adding=false)

added_by_user is now set, so switchdev_fdb_is_dynamically_learned() in
dsa_user_fdb_event() doesn't filter this DEL. It reaches
dsa_port_bridge_host_fdb_del() or dsa_port_fdb_del(), and
dsa_flush_workqueue() runs while dp->bridge is still valid.

Before this patch, the replay DEL was the only DEL for a converted
entry. Now it has no matching ADD:

- On the CPU port, dsa_port_do_fdb_del() returns -ENOENT and the driver
  logs "port %d failed to delete %pM vid %d from fdb".
- With fdb_isolation off, it can drop another bridge's reference for the
  same addr/vid.

The other direction has a problem too. A port that joins after the
conversion gets a replay ADD for the user-dynamic entry. Its later
ageing or deletion is filtered by br_switchdev_fdb_notify(), so drivers
can still keep the entry after the bridge has dropped it.

That direction already affects every user-dynamic entry since commit
927cdea5d209. It doesn't match the commit message, though, which says
br_switchdev_fdb_notify():

  "reports neither the addition nor the deletion of an entry that the
  user added without NUD_PERMANENT or NUD_NOARP"

Replay reports both. The following patch in the series doesn't touch
replay either.

>  		old_dst = br_fdb_dst_read(fdb);
>  		modified = fdb_update_dst(fdb, old_dst, dst);
>  
> @@ -1706,8 +1720,8 @@ void br_fdb_offloaded_set(struct net_bridge *br, struct net_bridge_port *p,
>  	spin_lock_bh(&br->hash_lock);
>  
>  	fdb = br_fdb_find(br, addr, vid);
> -	if (fdb && offloaded != test_bit(BR_FDB_OFFLOADED, &fdb->flags))
> -		change_bit(BR_FDB_OFFLOADED, &fdb->flags);
> +	if (fdb)
> +		assign_bit(BR_FDB_OFFLOADED, &fdb->flags, offloaded);

[Severity: Medium]
Can a late offload report from the driver set BR_FDB_OFFLOADED again
after the new withdrawal in fdb_add_entry() or __fdb_update() has
cleared it?

DSA programs FDB entries from an ordered workqueue:
dsa_user_fdb_event() calls dsa_schedule_work(), which queues on dsa_owq.

When an ADD work item finishes, it calls dsa_fdb_offload_notify() with
offloaded=true. That goes through br_switchdev_event() to
br_fdb_offloaded_set(). A DEL work item never reports offloaded=false.

For example:

  bridge fdb add A dev lan1 master static
      queues ADD work
  bridge fdb replace A dev lan1 master dynamic
      fdb_add_entry() queues DEL work and clears BR_FDB_OFFLOADED,
      which isn't set yet
  ADD work runs
      programs the hardware and reports offloaded=true
      br_fdb_offloaded_set() -> assign_bit(..., true)
  DEL work runs
      removes A from the hardware

The entry is now ADDED_BY_USER, !STATIC and !EXT_LEARN, so
br_switchdev_fdb_notify() filters every later notification and nothing
corrects the flag.

fdb_fill_info() keeps reporting NTF_OFFLOADED, and
"bridge fdb flush ... offloaded" keeps matching the entry. The NTF_USE
path in __fdb_update() does the same when a learned or host entry still
has ADD work pending.

The commit message says the clear is there so the entry is not:

  "still be shown as offloaded, and matched as such by "bridge fdb
  flush", after the hardware dropped it"

Moving to assign_bit() stops a concurrent report from inverting the
flag, but it doesn't stop a late report from setting it.

Could br_fdb_offloaded_set() ignore entries that br_switchdev_fdb_notify()
no longer reports?

The following patch in the series, "net: bridge: clear the offloaded
flag of an fdb entry that roams", doesn't touch br_fdb_offloaded_set(),
so this window is still there at the end of the series.

>  
>  	spin_unlock_bh(&br->hash_lock);
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261122192118.1204290-1-julius%40bairaktaris.de
