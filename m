Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795461806;
	b=WNWorlOmYQnhWrj1p4w23JxHfobkUMq3fUMX70LzMDpZdi+RAhijm88r2JzezspXxsIN
	 mPkkVRub78bLbLZnKU4OYFeCFD15WIQbjUyXq8ZBME9DxrJUlOClFmGA6J4oVo1UUniuk
	 734jobwZW/v+kcHdALLHe1izHpwydbnkYWo3A2G1u7p56G3K5dKrdjpzZeyPr67darAS5
	 baANkiTIH/nTHg3zSMsfkGpE61eMu9/lcKX//4osO446JxwIpuiSHoyV8F1+daOG/1Tn1
	 qiYlZQZvH5VceDE91Cfd1UGFmBY1F9hQtyD5BVGc9cfssfTn1t8WDbzD7OUQsVQkFxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795461806;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=2FASoa1vEglgVFuA3JUwSekEBLuZRvSl3QGz4VTG3T4=;
	b=mnRLP7Iett+TGiUtlcIMPnTzvmhKvwENLCmGqb8RUssSgJg9XCV9aduV1mvEJVyM8nm1
	 43BCGwD9ZestsQ/v3WBd1jiR1vbX4RySW7+I3J5xdPin7YqulQqj/xTqygjPFXiUIP6tD
	 rNeKdw8oAMo8aG75BpLSGfK+eOEZNfcPVEcSS406dFG6PV0GQCOA77IUii4/58kkyrQyb
	 +nZDR/tq4bhdTjtZVFfKuJST4pffoHFwFVzYubv6MMwj9kSVW/Y32HPCi8p4npCImti+B
	 JyIWlEfvWuncPw3wrVJgAcECN9ACYegXswarSSxKUu6Tl+USugoPBxi4492kKTVGZPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mg1jfK5e;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9DB606A326;
	Mon, 23 Nov 2026 19:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mg1jfK5e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9B261F000CF;
	Mon, 23 Nov 2026 19:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795461805;
	bh=2FASoa1vEglgVFuA3JUwSekEBLuZRvSl3QGz4VTG3T4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mg1jfK5e37ljeM8EVICIYfInGrpJ+YJ4MrA3xub2rdG68dQCGsBeWT3gABO8KLey6
	 OZAQpBwa7G7pzvc52uRJH0EI3Do+XtMGYHV1v5Qw7V6tvrgbjPIHRfHaYkRSDnq+8V
	 mcQ8MaVkvfJHmGKz6vDVyKKg15MbT/cuCjMi7uJPyfvjxcf4y0wS04SoYlW9KqvGJJ
	 YPGG007gKWfI2OcePG0VWT8Y6BnYNGsqUu8SMAY2b5dekh2rl0fpst7Bmbs4ODSFjm
	 br/IFekHZQkeb5SO3e6tGyDoAATU9CCwNQygJleSCxgBUIqw9D7Z8WXIc2KOezns5X
	 i/+ORLrWWgShQ==
Subject: Re: [PATCH net-next v2 2/2] net: bridge: clear the offloaded flag of
 an fdb entry that roams
From: netdev-bot+sashiko@kernel.org
To: julius@bairaktaris.de
Cc: razor@blackwall.org, idosch@nvidia.com, netdev@vger.kernel.org,
 bridge@lists.linux.dev, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, olteanv@gmail.com,
 vladimir.oltean@nxp.com, jbrandeb@kernel.org
Date: Mon, 23 Nov 2026 19:23:24 +0000
Message-ID: <179546180446.3135.1475958862197579079@kernel.org>
In-Reply-To: <20261122192118.1204290-3-julius@bairaktaris.de>
References: <20261122192118.1204290-3-julius@bairaktaris.de>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new clear_bit() in __fdb_update()
  (net/bridge/br_fdb.c:1034) is not ordered against offload reports from…
- [Low] The patch fixes a user-visible defect: after a roam in
  __fdb_update(), the entry is shown with NTF_OFFLOADED and matched by…
- [Low] The commit message body, above the `---` line, says: "Found by an
  LLM review of __fdb_update() while patch 1 was reworked after the…

--

net: bridge: clear the offloaded flag of an fdb entry that roams

When an entry roams to another port, this patch clears BR_FDB_OFFLOADED
in __fdb_update() right after the switchdev deletion for the old port is
sent. The goal is that the entry is no longer shown as offloaded, or
matched by "bridge fdb flush ... offloaded", when the new port does not
hold it.

[ ... ]

> Found by an LLM review of __fdb_update() while patch 1 was
> reworked after the review of its v1.

[Severity: Low]
This isn't a bug, but "patch 1" and "v1" won't mean anything once this
is in git history.

Could the dependency be named by its subject instead? That would be
"net: bridge: withdraw the switchdev entry of an fdb entry made dynamic",
which provides the roamed variable used in this hunk. Version history
could go below the --- line or in the cover letter.

[ ... ]

> Signed-off-by: Julius Bairaktaris <julius@bairaktaris.de>

[Severity: Low]
Should this have a Fixes: tag? The roam-time withdrawal that left
BR_FDB_OFFLOADED set seems to come from:

commit 90dc8fd36078 ("net: bridge: notify switchdev of disappearance of
old FDB entry upon migration")

Commit 6eb38bf8eb90 only added the br argument to that
br_switchdev_fdb_notify() call, so it doesn't look like the right target.

The message also doesn't say whether this is meant for net or net-next.
The hunk depends on the roamed variable from "net: bridge: withdraw the
switchdev entry of an fdb entry made dynamic". Could that dependency be
recorded for backports?

> diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
> index 4af091c192449..8bb40645bd6b3 100644
> --- a/net/bridge/br_fdb.c
> +++ b/net/bridge/br_fdb.c
> @@ -1031,6 +1031,7 @@ static void __fdb_update(struct net_bridge *br,
>  		      !test_bit(BR_FDB_STICKY, &fdb->flags)))) {
>  		if (source != old_port) {
>  			br_switchdev_fdb_notify(br, fdb, RTM_DELNEIGH);
> +			clear_bit(BR_FDB_OFFLOADED, &fdb->flags);

[Severity: Medium]
Can a late offload report from the old port set the flag again after
this clear?

DSA programs FDB entries from its workqueue. After the hardware add, it
reports the offload using the orig_dev that was saved when the work was
queued:

net/dsa/user.c:dsa_fdb_offload_notify() {
    ...
	info.offloaded = true;
	call_switchdev_notifiers(SWITCHDEV_FDB_OFFLOADED,
				 switchdev_work->orig_dev, &info.info, NULL);
}

br_switchdev_event() gets the port p from orig_dev and passes it to
br_fdb_offloaded_set(). That function looks up the entry by {addr, vid}
only and never checks p against the entry's current dst port:

net/bridge/br_fdb.c:br_fdb_offloaded_set() {
    ...
	fdb = br_fdb_find(br, addr, vid);
	if (fdb)
		assign_bit(BR_FDB_OFFLOADED, &fdb->flags, offloaded);
    ...
}

With the setup from the commit message, this sequence looks possible:

1. The address is learned on veth. fdb_notify() sends
   SWITCHDEV_FDB_ADD_TO_DEVICE. DSA treats it as a host address and
   queues the work. The bit is still clear.

2. Before the work runs, a frame with the same source address arrives on
   the DSA user port. __fdb_update() sends RTM_DELNEIGH, which is queued
   behind the ADD. This clear_bit() does nothing because the bit is not
   set yet, and dst becomes the user port. DSA ignores the NEWNEIGH for
   its own user port.

3. The worker runs the ADD and calls dsa_fdb_offload_notify() with
   orig_dev = veth. br_fdb_offloaded_set() then sets BR_FDB_OFFLOADED on
   the entry, which now points at the user port.

4. The worker runs the DEL. DSA doesn't report offloaded=false on delete,
   so the flag stays set until the entry ages out or changes.

The entry is then shown as offloaded and matched by "bridge fdb flush
... offloaded" while nothing holds it in hardware. That is the state this
patch is meant to remove. With MAC flapping between two ports, each roam
queues another ADD/DEL pair.

The commit message says:

    A roam that races a driver reporting the address as learned on
    another port can still leave the flag wrong

This case is different: it is a deferred SWITCHDEV_FDB_OFFLOADED report
from the old port, not a learned report.

Does br_fdb_offloaded_set() also need to ignore reports whose p no longer
matches the entry's dst port?

>  			br_fdb_dst_write(fdb, dst);
>  			fdb_modified = true;
>  			roamed = true;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261122192118.1204290-1-julius%40bairaktaris.de
