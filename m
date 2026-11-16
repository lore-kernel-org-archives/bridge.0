Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794804213;
	b=KxEMvgeAt+GuylStM9+NcvB73jiM1zcpqOHLu6O7W9ldjGKoL9I1GCfCW8bAPac/2XM8
	 cDzMHoLe3ZPe4Ny1Q24kH4I5iwRr+sbUtHOq0eH4PJYqHbGQPe7TH3fNy0pPI6oLpIgLD
	 gCA0NZSibgtOzZUP8Xz8B2jOqd4jvd9wSFIlvjgkYIzJyowsHbQ9a0OI0XQQYS4a5yPjh
	 fSEtWzwqqM4Ihp8yTpxASmNpu4NsNIaDoMRtfbvH4O3dcGO1MMU9WU9mMu0m+BRj6FR4k
	 /5irTXSfPMc7rRTNqmxU5Dk+aD4EJIbJdnAx3NqOxMracpZeUJsUiu9soJ21fna8miA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794804213;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=0GGSnSDNRCIbI3O6bCi+KGfcF/rbTcqhD4BZuP/VmsE=;
	b=z1UmqCwHqYafewRdKRMic2i6xOCRoIPTfx4o8QZeTpuPPVDrgEYI2CrmUsH9DWs9TN82
	 A+reh5GiXDiNQPyY8ck2oAeDedADNqjh0b8YZyGEH1iieUyHzNvFJXrN0ymBSQT704rM8
	 A+//U0IxZ57ASJ6eHd3kbTiR5VJzXrVUaSJa1X2LGEgppJylmhocaQZvjSag8cz4Omv9r
	 bLPy/4xQBWvi4B+lJsNSLHSc4jkpnmdMHF1vnwWjqyk7GGtqaUHQ0+jlxUtkHczvHHe+v
	 SKSXuB2FoF7zCSMRxTIkx2jRLbgZCAciBEeoWXmqp+Azjvee1DFahK84GucHQjx11tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bCAn06U8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66632606A890;
	Mon, 16 Nov 2026 04:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bCAn06U8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6045B1F000CB;
	Mon, 16 Nov 2026 04:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794804213;
	bh=0GGSnSDNRCIbI3O6bCi+KGfcF/rbTcqhD4BZuP/VmsE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bCAn06U8J4Zu4qRhV8YueidKJTk+IOyBvIKwYRXflzGvcbB35geChiRODPrJlpFTh
	 +TuHitFV3u5yhXAhtlvGylppx5cIvffe+CqXHO6bup5oVjEkxuJfKlYWi+5DGMj0kS
	 J9UZnrvGsb0VwnpSfDkj6TfDiUQj1HNURW7Z8m67oLuj0jhbwN0+QHj91FdfvRXbkK
	 zcjwNXF4WMzu90pEYu5AdCau2BqrAoZa2WzD9kJGhE5FJ+S4v31pn7t0nb7ijrQt0i
	 yyIV33ZVB0q/2B9wtqxAugn3qVGZlLmDxNtI5lCBa1ZIn5RatUvOMhn22b6UzxgWUM
	 pKoMFBHU4J0Ew==
Subject: Re: [PATCH net-next v2 1/2] net: bridge: switchdev: add
 br_switchdev_fdb_find_port()
From: netdev-bot+sashiko@kernel.org
To: julius@bairaktaris.de
Cc: razor@blackwall.org, idosch@nvidia.com, andrew+netdev@lunn.ch,
 olteanv@gmail.com, netdev@vger.kernel.org, bridge@lists.linux.dev,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 16 Nov 2026 04:43:31 +0000
Message-ID: <179480421183.3136.1759261843920553958@kernel.org>
In-Reply-To: <ce6ea6a96b66c70b882832a07c36caf12193c6c2.1794696609.git.julius@bairaktaris.de>
References: <ce6ea6a96b66c70b882832a07c36caf12193c6c2.1794696609.git.julius@bairaktaris.de>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] br_switchdev_fdb_find_port() (net/bridge/br_switchdev.c)
  decides that an entry "was learned by a switchdev driver, whose…
- [Low] br_switchdev_fdb_find_port() reads f->flags several times with
  separate test_bit() calls, under RCU only.

--

net: bridge: switchdev: add br_switchdev_fdb_find_port()

This adds an exported RCU lookup, br_switchdev_fdb_find_port(). It
returns the device that br_switchdev_fdb_notify() reports an FDB entry
on, or NULL for entries whose addition is not reported to switchdev. The
existing notify filter moves into a shared helper,
br_switchdev_fdb_notifies(), and the next patch uses the lookup from DSA.

> diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
> index 10f3aea6a1f82..f832657c0c22e 100644
> --- a/net/bridge/br_switchdev.c
> +++ b/net/bridge/br_switchdev.c

[ ... ]

> @@ -156,9 +152,67 @@ br_switchdev_fdb_notify(struct net_bridge *br,
>  	 * Drivers don't know how to deal with these, so don't notify them to
>  	 * avoid confusing them.
>  	 */
> -	if (test_bit(BR_FDB_ADDED_BY_USER, &fdb->flags) &&
> -	    !test_bit(BR_FDB_STATIC, &fdb->flags) &&
> -	    !test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags))
> +	return !test_bit(BR_FDB_ADDED_BY_USER, &fdb->flags) ||
> +	       test_bit(BR_FDB_STATIC, &fdb->flags) ||
> +	       test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags);
> +}
> +
> +/**
> + * br_switchdev_fdb_find_port - find the device a switchdev entry is reported on

[ ... ]

> + * Return: the device that br_switchdev_fdb_notify() reports the entry for
> + * @addr and @vid on: its port, or @br_dev for a local entry. NULL if there is
> + * no such entry, or if it is locked, was added with "master dynamic", or was
> + * learned by a switchdev driver, whose addition br_switchdev_fdb_notify()
> + * does not report.
> + */
> +struct net_device *br_switchdev_fdb_find_port(struct net_device *br_dev,
> +					      const unsigned char *addr,
> +					      u16 vid, bool *added_by_user)
> +{

[ ... ]

> +	f = br_fdb_find_rcu(netdev_priv(br_dev), addr, vid);
> +	if (!f || !br_switchdev_fdb_notifies(f))
> +		return NULL;
> +
> +	by_user = test_bit(BR_FDB_ADDED_BY_USER, &f->flags);
> +	if (!by_user && test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &f->flags))
> +		return NULL;

[Severity: Medium]
Can this check hide entries whose ADD was already reported to switchdev?
The flags don't record whether an ADD was actually sent.

Take an entry that the software bridge learns first on port P:

br_fdb_update()
  fdb_create()                      /* USER and EXT_LEARN clear */
  fdb_notify(br, fdb, RTM_NEWNEIGH, true)
    br_switchdev_fdb_notify()       /* FDB_ADD_TO_DEVICE sent on P */

Then the switchdev driver of P learns the same MAC in hardware and sends
SWITCHDEV_FDB_ADD_TO_BRIDGE:

br_switchdev_event()
  br_fdb_external_learn_add(br, p, addr, vid, locked, false)

br_fdb_external_learn_add() takes the existing-entry branch:

		if (test_and_set_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags)) {
		...
		if (swdev_notify)
			set_bit(BR_FDB_ADDED_BY_USER, &fdb->flags);

After this the entry has EXT_LEARN set and USER clear, and no switchdev
event goes out.

>From then on, br_switchdev_fdb_find_port() returns NULL for this entry.
br_switchdev_fdb_notifies() still accepts it, though, because USER is
clear. So the DEL is still reported on P, either from fdb_delete(br, f,
true) in the user delete and port flush paths, or from the roaming
branch of __fdb_update():

		if (source != old_port) {
			br_switchdev_fdb_notify(br, fdb, RTM_DELNEIGH);

Doesn't this contradict the kernel-doc ("the device that
br_switchdev_fdb_notify() reports the entry ... on") and the commit
message ("does not find the entries whose addition the bridge does not
notify to switchdev")?

The next patch in the series uses this helper from
dsa_user_bridge_host_fdb_wanted(). Consider an assisted-learning DSA
switch bridged with a foreign port that learns in hardware.

If the queued host_addr ADD work runs after the hardware learn, the
helper returns NULL and the host address is never installed. If the work
ran before it, the address is installed. Before the series the address
was always installed.

Is this timing-dependent result intended? When the address is missing,
traffic from DSA user ports to that MAC is flooded instead of being
forwarded to the CPU.

> +
> +	if (added_by_user)
> +		*added_by_user = by_user;

[Severity: Low]
Can by_user disagree with the decision br_switchdev_fdb_notifies() just
made?

The flags are read several times with separate test_bit() calls, under
RCU only. Some writers change these bits without hash_lock. One is the
NTF_USE path of __fdb_update(), reached from br_fdb_update() under
rcu_read_lock():

	if (unlikely(test_bit(BR_FDB_ADDED_BY_USER, &flags))) {
		set_bit(BR_FDB_ADDED_BY_USER, &fdb->flags);

The roaming branch of __fdb_update() also clears
BR_FDB_ADDED_BY_EXT_LEARN and BR_FDB_LOCKED.

For a dynamically learned entry:

CPU0                                 CPU1
br_switchdev_fdb_notifies()
  sees USER == 0, passes
                                     __fdb_update() with NTF_USE
                                       set_bit(BR_FDB_ADDED_BY_USER)
by_user = test_bit(...) == 1
returns port, *added_by_user = true

With USER clear the answer would be (port, false). With USER set the
entry is "master dynamic" and the answer would be NULL. The pair (port,
true) matches neither state.

Would reading f->flags once with READ_ONCE() and testing the local copy
avoid this?

> +
> +	if (test_bit(BR_FDB_LOCAL, &f->flags))
> +		return br_dev;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1794696608.git.julius%40bairaktaris.de
