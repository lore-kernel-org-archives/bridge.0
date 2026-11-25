Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795565931;
	b=05zoPls6bLwJsSETjnHPFRZeu6M/Ixcw2Ick7s53c+oGbpWltDZ0K6nRVj3yo2qUhh02
	 OENC90sF4X3k/tNaFYjzha98lkabMSq/vhs3h/offtfiVZmCEvZsWD6lit4qv3Jqatd+7
	 eEmvyBJIcFVquepLvCxsimr6nZ3ul9ic+PLt6OnGv/f/Ff9PuYYn4DyXQCjF+3T7tAkIV
	 PNxF8VuRJaYXEeQVWa3hc5ebn7xTWDfil57FeZS3w5xCJcZyhT8LWalS0icLO5LGE5kJ4
	 ie2zj/Yb0wfKMQUFk0wqvDq7xhE6qeg3aOvTkPrO1185N3Kdonm30S/CQOt+4lnh8IA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795565931;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=e3N24i4nZ8F2OWKXy0Bm7z+tiwdFnxgOz1isOAlyjuU=;
	b=KrP59oaehDO2Rvc3wC878yoFeeyPkutfIrsUzdkMpur0CrgMxYeSP5jx8mVPEXLBS7xh
	 tlFPUxvCuZWhYuL2C4vIdvk2kiBtpFmbKX+Jg82fm84faTmwlAUi1ujWI1/Vi8TMV9YXD
	 MVD/It2YfcZh3iUDElUlKEb0mZt11aGeKm0U5PukX8WEMRfWUD3vvTxspr2mnTwYE4bi0
	 x1PaDxtOWf3gqCylvnFgkh0s2xUD9ibnLV6ZP7IDP/JKOa0Bn8Vw/Xb38tQ0bvszpZYMY
	 qtnhZN8ggiIpkBlF3BTxnoE4y3ot24sjTVFF34KbXtr/rBYb4xDCX8kZfVsSILjPw6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PecvGAob;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2790E606A31E;
	Wed, 25 Nov 2026 00:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PecvGAob
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EC3E1F000C4;
	Wed, 25 Nov 2026 00:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795565930;
	bh=e3N24i4nZ8F2OWKXy0Bm7z+tiwdFnxgOz1isOAlyjuU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PecvGAoboHIqjiCMCYdaddsz7Afw/VluQbP5J8emv39Jra0ecR7GSO6Ha6bpOQbTo
	 3xel9nzvvyhbwgGZ/EEGbUmLd7t+U1K5aix6BRj65WpDfQqKmWzduLNjFTB+fbW9Mf
	 lgBY1/vQBNS/4NKKZSQiXzx5y15+lSk1Trkefh8BPA+0Hyn9q/TMTqNyxSoz0sNjSZ
	 gvMS/oo4UjuVXPNBh0fOaKvHvNHnWp+vfsaoyCcdKYhHkWX5eTkKx74lEEqgF4Li5Q
	 ypMX3WJSPZHwVg5UsFWxijk8n1oiBOrjI8Tzudb6sFKy3lyoiXeeFTgL2vEFbN0ivb
	 TJq44Y4Ozpb3Q==
Subject: Re: [PATCH net] net: bridge: withdraw the switchdev entry of an fdb
 entry made dynamic
From: netdev-bot+sashiko@kernel.org
To: julius@bairaktaris.de
Cc: razor@blackwall.org, idosch@nvidia.com, netdev@vger.kernel.org,
 bridge@lists.linux.dev, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, willemb@google.com, horms@kernel.org,
 olteanv@gmail.com, vladimir.oltean@nxp.com, jbrandeb@kernel.org
Date: Wed, 25 Nov 2026 00:18:49 +0000
Message-ID: <179556592915.3135.5085820048352606016@kernel.org>
In-Reply-To: <20261121191638.1724620-1-julius@bairaktaris.de>
References: <20261121191638.1724620-1-julius@bairaktaris.de>
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

Critical: 0 · High: 1 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch balances only the event-driven notifications.
- [Medium] fdb_switchdev_hide() (net/bridge/br_fdb.c:1003-1007) sends
  SWITCHDEV_FDB_DEL_TO_DEVICE, and the driver removes the entry from its…
- [Medium] The new withdrawal is not atomic with respect to the packet
  path.

--

net: bridge: withdraw the switchdev entry of an fdb entry made dynamic

Some entries become user-added dynamic entries, which
br_switchdev_fdb_notify() no longer reports. This patch reports an FDB
deletion to switchdev just before that happens. The two paths are
fdb_add_entry() ("bridge fdb replace ... master dynamic") and the NTF_USE
branch of __fdb_update() ("... master use").

> diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
> index b601245ad9239..377ca83410294 100644
> --- a/net/bridge/br_fdb.c
> +++ b/net/bridge/br_fdb.c
> @@ -996,6 +996,16 @@ static bool __fdb_mark_active(struct net_bridge_fdb_entry *fdb)
>  		  test_and_clear_bit(BR_FDB_NOTIFY_INACTIVE, &fdb->flags));
>  }
>  
> +/* Called before @fdb becomes an entry that the user added as dynamic, which
> + * br_switchdev_fdb_notify() does not report: report the deletion of the entry
> + * switchdev was told about, if it was
> + */
> +static void fdb_switchdev_hide(struct net_bridge *br,
> +			       const struct net_bridge_fdb_entry *fdb)
> +{
> +	br_switchdev_fdb_notify(br, fdb, RTM_DELNEIGH);
> +}

[Severity: Medium]
Does this leave BR_FDB_OFFLOADED set on an entry that is no longer in
hardware?

fdb_switchdev_hide() sends SWITCHDEV_FDB_DEL_TO_DEVICE and the driver
removes the entry, but nothing clears the offloaded bit. After the hide
the entry is ADDED_BY_USER && !STATIC && !EXT_LEARN, so
br_switchdev_fdb_notify() never reports it again. No driver will then send
SWITCHDEV_FDB_OFFLOADED to correct the bit.

The SWITCHDEV_FDB_OFFLOADED senders for bridge FDB entries only report
offloaded=true, and only after an ADD. For example in DSA:

net/dsa/user.c:dsa_fdb_offload_notify() {
	...
	info.offloaded = true;
	call_switchdev_notifiers(SWITCHDEV_FDB_OFFLOADED,
				 switchdev_work->orig_dev, &info.info, NULL);
}

mlxsw sends offloaded=false only on its VXLAN path. On the bridge side
the bit is only cleared in br_fdb_clear_offload() and
br_fdb_offloaded_set().

So fdb_fill_info() keeps reporting it:

	if (test_bit(BR_FDB_OFFLOADED, &fdb->flags))
		ndm->ndm_flags |= NTF_OFFLOADED;

After "bridge fdb replace ... master dynamic" or "... master use",
"bridge fdb show" would then print "offload" for an entry that only
exists in software.

The commit message says:

    The offloaded flag of the entry stays as the drivers report it.

Drivers don't report un-offloading on DEL_TO_DEVICE, so does the flag just
go stale here? Should the hide path also clear BR_FDB_OFFLOADED?

[ ... ]

> @@ -1048,7 +1060,12 @@ static void __fdb_update(struct net_bridge *br,
>  		}
>  	}
>  
> +	/* Only from netlink (NTF_USE), with the user's flag in @flags */
>  	if (unlikely(test_bit(BR_FDB_ADDED_BY_USER, &flags))) {
> +		/* After a roam the deletion was reported above */
> +		if (!roamed && !test_bit(BR_FDB_STATIC, &fdb->flags) &&
> +		    !test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags))
> +			fdb_switchdev_hide(br, fdb);
>  		set_bit(BR_FDB_ADDED_BY_USER, &fdb->flags);

[Severity: Medium]
Can a concurrent roam from the packet path send an ADD between
fdb_switchdev_hide() and set_bit(BR_FDB_ADDED_BY_USER)?

The NTF_USE path runs __fdb_update() under only local_bh_disable() and
rcu_read_lock(). The packet path in br_fdb_update() updates an existing
entry without br->hash_lock:

	fdb = fdb_find_rcu(&br->fdb_hash_tbl, addr, vid);
	if (likely(fdb)) {
		__fdb_update(br, fdb, source, dst, flags);

A possible interleaving:

CPU0 (NTF_USE)                    CPU1 (RX on non-sticky port B)
__fdb_update()
  fdb_switchdev_hide()  /* DEL */
                                  __fdb_update()
                                    br_switchdev_fdb_notify(DEL)
                                    br_fdb_dst_write(fdb, B)
                                    fdb_notify(RTM_NEWNEIGH)
                                      br_switchdev_fdb_notify()
                                        /* ADDED_BY_USER still clear */
                                        SWITCHDEV_FDB_ADD_TO_DEVICE
  set_bit(BR_FDB_ADDED_BY_USER)

The entry is now user-dynamic. Its later deletion is filtered in
br_switchdev_fdb_notify(), so the driver keeps the entry on port B.

fdb_add_entry() has the same window. It holds br->hash_lock, but that
doesn't exclude the packet path. There the hide runs before
fdb_update_dst() and set_bit(BR_FDB_ADDED_BY_USER).

There is a variant with the extern_learn flag. CPU0 sees
BR_FDB_ADDED_BY_EXT_LEARN set and skips the hide. Then CPU1's roam clears
that flag and sends an ADD before CPU0's set_bit().

The window is small. It needs a station roaming onto another port while
the admin command runs. When it hits, the stale entry that this patch is
meant to remove is left in the driver.

> @@ -1262,6 +1279,10 @@ static int fdb_add_entry(struct net_bridge *br, struct net_bridge_dst dst,
>  		if (flags & NLM_F_EXCL)
>  			return -EEXIST;
>  
> +		if (!(state & (NUD_PERMANENT | NUD_NOARP)) &&
> +		    !test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags))
> +			fdb_switchdev_hide(br, fdb);
> +

[Severity: High]
This balances the event-driven notifications, but what about the replay
path? br_switchdev_fdb_replay_one() passes every entry in br->fdb_list to
the driver. It doesn't apply the filter that br_switchdev_fdb_notify()
uses:

net/bridge/br_switchdev.c:br_switchdev_fdb_replay_one() {
	...
	br_switchdev_fdb_populate(br, &item, fdb, ctx);

	err = nb->notifier_call(nb, action, &item);
	...
}

That causes two problems.

First, can an entry hidden here be installed again and then leaked? When
a DSA port joins the bridge:

dsa_port_bridge_join()
  switchdev_bridge_port_offload()
    nbp_switchdev_sync_objs()
      br_switchdev_fdb_replay(..., true, ...)
        dsa_user_switchdev_event()
          switchdev_handle_fdb_event_to_device()
            dsa_user_fdb_event()
              dsa_port_bridge_host_fdb_add()

The replayed item has added_by_user set, so it isn't treated as
dynamically learned. DSA programs it, for example as a refcounted host
address on the CPU port for an entry on a foreign veth port.

A later "bridge fdb del" goes through
fdb_delete()->fdb_notify(RTM_DELNEIGH)->br_switchdev_fdb_notify(), which
filters it out. The entry is then gone from fdb_list, so the leave-time
replay never sees it either. The driver keeps the hardware entry and the
dsa_mac_addr allocation after the bridge has dropped the entry.

This join-time replay leak is older than this patch; it goes back to
927cdea5d209. It is still the outcome the commit message says is fixed.

Second, does this add a double DEL? Before this patch, a learned entry
that was made user-dynamic got one ADD (from learning) and one DEL (from
the leave replay). With this patch it gets the ADD, a DEL from
fdb_switchdev_hide(), and another DEL when a port leaves:

nbp_switchdev_unsync_objs()
  br_switchdev_fdb_replay(br_dev, ctx, false, atomic_nb)
    ...
      dsa_port_do_fdb_del()

On the DSA CPU port the lookup fails:

net/dsa/switch.c:dsa_port_do_fdb_del() {
	...
	a = dsa_mac_addr_find(&dp->fdbs, addr, vid, db);
	if (!a) {
		trace_dsa_fdb_del_not_found(dp, addr, vid, &db);
		err = -ENOENT;
		goto out;
	}
	...
}

dsa_user_switchdev_event_work() then logs "failed to delete ... from fdb".

Another port may have added the hidden entry again through join replay.
In that case the extra DEL drops that port's reference and deletes the
hardware entry.

Would it work better to apply the same check in both
br_switchdev_fdb_notify() and the replay path, instead of sending an extra
DEL from these two event paths?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261121191638.1724620-1-julius%40bairaktaris.de
