Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795767874;
	b=Y2Qy2pnf0ViuP52DYZhrmch365cmNtFO4hPVUbWMMAeub6PCEmZTjSyBCurCDRVWiFah
	 nGh22wOp8ziFEN/guhaCwjuTYAFGJ469DVeJFIKDlQzX7DeQIxd0Z9+P23W8hpbETuwDo
	 NCrPBVw5qweHuNHYNGFbICRP9xgMmVeg7qlyL8odlwnFmzyYcbktJs+EcW5lugSVBmctT
	 oQB67YBcwCbIY7nBn9AXrzoG18Zd6N9dw31fupPPpmsQPvHLnasEVFGoWIQjBQ+o4mzhF
	 ksWyPdHJ3rZwXq4eH34zBRUk6kt3c+vRjVFURrG2BzFN4A6PHgaq6HmKeiwx1gwr3tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795767874;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=clCUkJmrvj16kl83LPMA6kvCuKRRhj6JejeF30H3Ws4=;
	b=Eo9ZlZZWYtRUqsI5mm9k4QbxzrqUqAYM9DvzG89JMwTOvo0qWoMpxz9U26041Pngod+0
	 +Qi9DVaNf0YHlircKxmGY64H9ekyWkOWuerQWaC30ZhuRunNUwN7ypCZZrsTQ/X7WyOZo
	 rB0ofkP4x/jK480lpH8bKwfB2UJzT86/ZPDUVqDhQ6mmZq5doV5ZwRQ00KiESteQDXJ/4
	 0Ki8Tu3XftoigLZhMDbZuljxPoF32BSaXYHnzhR2oJ7VzhO3vLXYXgNp3bODyMS+60aaY
	 4Yy7AmVWLnUkN1FfBHkkLVVsJOUjXVlWDv5UV5GQZvjgUKpwtCZN5uEfReroZwamEag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FPk8Fzhq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438CF606A323;
	Fri, 27 Nov 2026 08:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FPk8Fzhq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0251A1F00897;
	Fri, 27 Nov 2026 08:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795767873;
	bh=clCUkJmrvj16kl83LPMA6kvCuKRRhj6JejeF30H3Ws4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FPk8Fzhqmz3lsVmKocfY/zbgpLEKVAQOrHmdMFxLCKTS8+7/G9XflNl0RadA4MZg8
	 ufxqpi3z1DFUSwT3+Vu+yv+iSk0dzo04W4D39RfqBYuIg94jNmUiz/LUsUwP+2vj+3
	 b+jZUMTAzBhmslZwrLUrsa5mpuxOKNPvVH3ROtw2yC8pfCvz/9mVVxoZOFIZfX4gUU
	 8xtXE6cPq5+TsbphFZhp+WhfewnPzSF5M3jXxTvMg+MNlTFldJUQvtN3M41N4GMKLM
	 HI4L70BxHHLw4/nrPOI4ukUcPdwxO6TrlE1V1ONuv2x/tBdskujF1QSJDcAWoVvK7i
	 500W+x5t/DGIg==
Subject: Re: [PATCH net-next 2/5] net: dsa: microchip: ksz9477: do not keep
 the learned port in FDB entries
From: netdev-bot+sashiko@kernel.org
To: o.rempel@pengutronix.de
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, f.fainelli@gmail.com,
 razor@blackwall.org, idosch@nvidia.com, netdev@vger.kernel.org,
 bridge@lists.linux.dev, kernel@pengutronix.de
Date: Fri, 27 Nov 2026 08:24:32 +0000
Message-ID: <179576787253.3135.17885676621555467617@kernel.org>
In-Reply-To: <20261126-ksz-stp-link-local-v1-2-39aed15f6271@pengutronix.de>
References: <20261126-ksz-stp-link-local-v1-2-39aed15f6271@pengutronix.de>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix covers only part of the bug its commit message
  describes.

--

net: dsa: microchip: ksz9477: do not keep the learned port in FDB entries

This patch changes ksz9477_fdb_add() so that a static FDB entry no longer
inherits the port map of a learned ALU entry for the same address. If the
ALU entry found for the address is not already static, its port map is
cleared before the requested port is set.

> diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
> index 972703fe7454f..98211d9835734 100644
> --- a/drivers/net/dsa/microchip/ksz9477.c
> +++ b/drivers/net/dsa/microchip/ksz9477.c
> @@ -800,6 +800,13 @@ int ksz9477_fdb_add(struct dsa_switch *ds, int port,
>  	/* read ALU entry */
>  	ksz9477_read_table(dev, alu_table);
>  
> +	/* The ALU table holds learned and static entries. If the entry is
> +	 * not static (learned, or none found), clear its port map, so that
> +	 * the static entry lists only this port.
> +	 */
> +	if (!(alu_table[0] & ALU_V_STATIC_VALID))
> +		alu_table[1] &= ~ALU_V_PORT_MAP;
> +
>  	/* update ALU entry */
>  	alu_table[0] = ALU_V_STATIC_VALID;
>  	alu_table[1] |= BIT(port);

[Severity: High]
Can the stale static entry from the commit message still be created when
the existing ALU entry is already static?

When ALU_V_STATIC_VALID is set, the port map is kept, and the
alu_table[1] |= BIT(port) adds the new port to the old one.

For a user replace, the bridge does not tell the driver about the old
port. fdb_add_entry()->fdb_update_dst() in net/bridge/br_fdb.c only
rewrites the destination:

net/bridge/br_fdb.c:fdb_update_dst() {
    ...
	br_fdb_dst_write(fdb, dst);
	return true;
}

Only RTM_NEWNEIGH is then sent for the new port. That differs from learned
migration in br_fdb_update(), which first sends a delete for the old
port:

	if (source != old_port) {
		br_switchdev_fdb_notify(br, fdb, RTM_DELNEIGH);
		br_fdb_dst_write(fdb, dst);

So in the replace case, port_fdb_add is the only notice the driver gets
that the address moved. Take this sequence:

  bridge fdb add H dev lan1 master static      -> ALU static {lan1}
  bridge fdb replace H dev lan2 master static  -> ALU static {lan1, lan2}
  bridge fdb del H dev lan2 master static

After the replace, the bridge has H only on lan2. ksz9477_fdb_del() then
clears only the deleted port:

	/* clear forwarding port */
	alu_table[1] &= ~BIT(port);

That leaves a static {lan1} entry. The bridge no longer tracks it, and it
never ages out. This is the same result the commit message describes:

  "The entry stays static and still points to lan1. Static entries never
  age out. So the switch keeps sending frames for H to lan1, even after H
  has moved."

Would it be better to always set the unicast port map to exactly BIT(port),
by clearing ALU_V_PORT_MAP unconditionally instead of only for non-static
entries? mv88e6xxx_port_db_load_purge() already does this for unicast
static entries:

	if (state == MV88E6XXX_G1_ATU_DATA_STATE_UC_STATIC)
		entry.portvec = BIT(port);

Multicast uses the separate static table in ksz9477_mdb_add(), so it does
not seem to go through this path.

The note below the --- line already mentions this gap:

  "If bridge fdb replace moves an existing static entry to another port,
  the entry still keeps the old port. This patch does not change that."

That text does not end up in git history, though. The commit carries a
Fixes: tag, so the commit log does not show that the bug is only partly
fixed. The following ksz9477 change sets ds->assisted_learning_on_cpu_port,
which creates more static entries on the CPU port that this OR-merge can
act on.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261126-ksz-stp-link-local-v1-0-39aed15f6271%40pengutronix.de
