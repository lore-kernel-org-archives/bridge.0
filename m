Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795455901;
	b=Hmm9L8jHmaE961cdhWDo5fa+8MfzZIU2Mhz6LTJoJp+k7gpIv2JB2e1XOkiUHwWWDCmt
	 hsJKRelCRJg9PVPBcqDZV3AfDfpk82y/mMUrFo/GAhSTcT0XjAoP9QFE6BzrVeMuDgnr3
	 E37mcz3XDRacCmEXafQfP94/4XFtujhF1ZPurIW7q+asUQ/jVjKRjAbwOdvTuJqrhaU3O
	 mjkvY4DC8ln3R6+cr4PJVc4kvPEVxGbrGhdVen8yGPYJuRUsG63SBFLUAR81GxnNLD+f2
	 FReAbKeWoe5YIbCAqviuFs91rEKKPCqGSdUMNOTsZdP+dpFA6DQ1uN11NjstZdhrojA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795455901;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=wjnzW4AkNebRLX32Od1ytfWiOGsb5QSUWsfOI4yrqJk=;
	b=UWTWW4ox1XcA188wCUGqyzYU0iWvvTrqAX8GDmf90jq3bD1U8jrS1+UFiH5ED5JbnwLT
	 Z0dbzkDhRrka8DvOppSZep5vxjeAPohRvdZFaw7TL2pqV33cC2ndI775mVbhl6qD/WYac
	 LQZ9N0s/3Ekp1y2SK7I8dcy4AAJAxw3Akk9rqkeQ5g+H/eUT6H8OJVbAtoV8JW1HpQfUl
	 yltec+Gdr6yit8vdyIL4y2eZBa57wd6wO34NTpgXn2WYJskvlBWd8Af8niRZkoJWec4o8
	 fCTwTZX+QSBtrpr63vw8JNIaB40UPQEKrWWzBEF5u3Tg7Isr2s3UluzSX/9V+qM2YjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eBPNp0af;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60445606A335;
	Mon, 23 Nov 2026 17:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eBPNp0af
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78B161F000F4;
	Mon, 23 Nov 2026 17:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795455901;
	bh=wjnzW4AkNebRLX32Od1ytfWiOGsb5QSUWsfOI4yrqJk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=eBPNp0afnYM2C+a0rSGhfPeklRhzCqVexhpHRDpPBLU7GsDmIe1bjKzTIdA9Vob++
	 hmhFE+OVO+W6rBn/yQpecxVldpKoserZAztnQ01RUqeWJvZgZG87gR1EX2Zgx0FwTn
	 Pxc56L6TGVOB2KsdQ8lB8CZfpyA46W+BACS70fwZFBqlrRJpYOVIq7k+oGsOYz70My
	 U6lvkCsouxMQsIyHaBvTwb5b7+qek65rSLCPxoolkphowBC/k6fsuAyDjkzY37y7zA
	 8NOpkGPJRo2LHu3blpaob6klLzPZeb3NSbxTNYyf8GrogaT60G1uE0mH3WdRGCPxv2
	 Z5OaFJLYUjOfA==
Subject: Re: [PATCH net-next] net: dsa: report a deleted FDB entry as no
 longer offloaded
From: netdev-bot+sashiko@kernel.org
To: julius@bairaktaris.de
Cc: andrew@lunn.ch, olteanv@gmail.com, razor@blackwall.org, idosch@nvidia.com,
 netdev@vger.kernel.org, bridge@lists.linux.dev, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Date: Mon, 23 Nov 2026 17:44:59 +0000
Message-ID: <179545589967.3135.15910184280641420924@kernel.org>
In-Reply-To: <20261122174434.975426-1-julius@bairaktaris.de>
References: <20261122174434.975426-1-julius@bairaktaris.de>
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Use-after-free of a foreign bridge port's net_device in the new
  deletion report.
- [Low] The commit message describes a user-visible defect: 'bridge fdb
  show' keeps the offload flag, and 'bridge fdb flush ... offloaded'…
- [Low] The new offloaded=false report is a delayed, per-port message
  meaning 'DSA's copy of (addr, vid) towards orig_dev is gone'.
- [Low] The new DEL path reports offloaded=false whenever the deletion
  returns 0, but for refcounted entries 0 does not mean the entry left…

--

net: dsa: report a deleted FDB entry as no longer offloaded

After a successful FDB deletion requested by the bridge,
dsa_user_switchdev_event_work() now reports SWITCHDEV_FDB_OFFLOADED with
offloaded=false. The bridge then clears BR_FDB_OFFLOADED on entries the
switch no longer holds. Deletions replayed for a single port that leaves a
bridge or LAG (ctx != NULL) are not reported.

> The addition has been reported since commit c9eb3e0f8701 ("net: dsa: Add
> support for learning FDB through notification"); a deletion never was.

[ ... ]

> Signed-off-by: Julius Bairaktaris <julius@bairaktaris.de>

[Severity: Low]
This isn't a bug, but should this have a Fixes: tag?

The message names the origin commit in the text. It also describes a
defect users can see in "bridge fdb show" and
"bridge fdb flush ... offloaded". The prerequisite is sent as
[PATCH net]. However, the only trailer is Signed-off-by.

> diff --git a/net/dsa/user.c b/net/dsa/user.c
> index 041f9060c8ef0..fdeb1c68c2f4b 100644
> --- a/net/dsa/user.c
> +++ b/net/dsa/user.c

[ ... ]

> @@ -3628,13 +3629,14 @@ static int dsa_user_netdevice_event(struct notifier_block *nb,
>  }
>  
>  static void
> -dsa_fdb_offload_notify(struct dsa_switchdev_event_work *switchdev_work)
> +dsa_fdb_offload_notify(struct dsa_switchdev_event_work *switchdev_work,
> +		       bool offloaded)
>  {
>  	struct switchdev_notifier_fdb_info info = {};
>  
>  	info.addr = switchdev_work->addr;
>  	info.vid = switchdev_work->vid;
> -	info.offloaded = true;
> +	info.offloaded = offloaded;
>  	call_switchdev_notifiers(SWITCHDEV_FDB_OFFLOADED,
>  				 switchdev_work->orig_dev, &info.info, NULL);
>  }

[ ... ]

> @@ -3681,8 +3683,13 @@ static void dsa_user_switchdev_event_work(struct work_struct *work)
>  			dev_err(ds->dev,
>  				"port %d failed to delete %pM vid %d from fdb: %d\n",
>  				dp->index, addr, vid, err);
> +			break;
>  		}
> -
> +		/* A deletion replayed for this port alone, as it leaves the
> +		 * bridge or a LAG, can leave the entry held for other ports
> +		 */
> +		if (!switchdev_work->replayed)
> +			dsa_fdb_offload_notify(switchdev_work, false);

[Severity: High]
Can this call use a freed net_device?

Before this patch, the DEL branch only used switchdev_work->dev.
dsa_flush_workqueue() in dsa_port_pre_bridge_leave() keeps that device
alive.

The DEL branch now calls dsa_fdb_offload_notify(), which passes
switchdev_work->orig_dev to call_switchdev_notifiers().
dsa_user_fdb_event() stores orig_dev without netdev_hold() or dev_hold():

    switchdev_work->orig_dev = orig_dev;

orig_dev can be a foreign bridge port such as a veth. Suppose that port
has FDB entries DSA offloaded, either static or learned with
ds->assisted_learning_on_cpu_port, and it is then deleted:

ip link del veth0
  br_del_if()
    del_nbp()
      br_fdb_cleanup_by_dst()
        br_switchdev_fdb_notify()     /* SWITCHDEV_FDB_DEL_TO_DEVICE */
          __switchdev_handle_fdb_event_to_device()
            dsa_user_fdb_event()      /* ctx == NULL, replayed == false */
              dsa_schedule_work()
      netdev_upper_dev_unlink()

Nothing flushes dsa_owq when a foreign device unregisters.
dsa_user_netdevice_event() has no NETDEV_UNREGISTER case, and
dsa_flush_workqueue() only runs when DSA ports or LAGs leave the bridge.

So netdev_run_todo() and free_netdev() can free veth0 while these works
are still queued, for example behind slow MDIO or SPI port_fdb_del calls.
The work then runs:

dsa_user_switchdev_event_work()
  dsa_fdb_offload_notify(switchdev_work, false)
    call_switchdev_notifiers(SWITCHDEV_FDB_OFFLOADED, orig_dev, ...)
      br_switchdev_event()
        p = br_port_get_rtnl_rcu(dev);     /* dev already freed */

The existing ADD report has the same lifetime gap, but only through a
narrow race with unregistration. Here, the teardown of orig_dev is what
generates the DEL report.

The note below the '---' line says this depends on "net: dsa: hold the
device a queued FDB event is reported to". That patch is not in this
tree, and git am drops the note.

Could the two go in as a series, or could the dependency be recorded in
the commit message itself? Otherwise this patch could be applied or
backported without it.

[Severity: Low]
Does a return value of 0 here mean the entry has left the switch?

Host addresses on CPU and DSA ports are refcounted, and so are LAG
entries. dsa_port_do_fdb_del() returns 0 when only the refcount drops:

net/dsa/switch.c:dsa_port_do_fdb_del() {
    ...
	if (!refcount_dec_and_test(&a->refcount)) {
		trace_dsa_fdb_del_drop(dp, addr, vid, &db, &a->refcount);
		goto out;
	}

	err = ds->ops->port_fdb_del(ds, port, addr, vid, db);
	...
	if (err) {
		refcount_set(&a->refcount, 1);
		goto out;
	}
    ...
}

Take a host address X added for DSA user ports A and B, giving a refcount
of 2 on the CPU port:

- A's DEL drops the refcount to 1 and reports false.
- B's DEL then fails in port_fdb_del(). The refcount is restored to 1 and
  nothing is reported.

The last report the bridge received is false, but the switch still holds
X.

The same thing can happen if the GFP_ATOMIC allocation in
dsa_user_fdb_event() fails for B. __switchdev_handle_fdb_event_to_device()
stops at the first error other than -EOPNOTSUPP:

	if (err && err != -EOPNOTSUPP)
		return err;

Doesn't that contradict this line in the commit message: "the last one
for an entry gives the state the switch was left in"?

[Severity: Low]
Can this report reach a different bridge than the one the deletion was
for?

The report goes to the orig_dev captured at queue time. However,
br_switchdev_event() finds the bridge from orig_dev's current bridge port
when the work runs. br_fdb_offloaded_set() also ignores p and matches
only addr and vid:

net/bridge/br_fdb.c:br_fdb_offloaded_set() {
    ...
	fdb = br_fdb_find(br, addr, vid);
	if (fdb && offloaded != test_bit(BR_FDB_OFFLOADED, &fdb->flags))
		change_bit(BR_FDB_OFFLOADED, &fdb->flags);
    ...
}

Suppose foreign port V leaves bridge B1, so del_nbp() queues DSA DEL
works with orig_dev = V. V then joins bridge B2 before dsa_owq runs those
works.

Would the report then clear BR_FDB_OFFLOADED on B2's (addr, vid) entry?
One example is V's own local address added again in B2, even if another
switchdev driver in B2 offloaded it.

The commit message covers the same-bridge case ("a deletion still queued
here can clear the flag that driver set on an entry re-created on one of
its ports"). It does not cover this cross-bridge case.

br_fdb_cleanup_by_dst() keeps ext-learned entries only while
BR_FDB_OFFLOADED is clear:

			if (test_bit(BR_FDB_STATIC, &f->flags) ||
			    (test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &f->flags) &&
			     !test_bit(BR_FDB_OFFLOADED, &f->flags))) {

So a wrongly cleared flag in either case also changes which entries those
flushes delete.

>  		break;
>  	}
>  

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261122174434.975426-1-julius%40bairaktaris.de
