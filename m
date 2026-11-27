Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795767876;
	b=oNiRHNhYsOuaGwPDAP1Gf8OGdJ+nNW42/K4mIHjCGq8vDihV1JsAZqH1IvAziQflWYIv
	 Tp1b7+1nhAh5V0e3c78adt3DYCJZZBUxyDX9ankjMmqexlN5jrIHk9l2QDWPQDrouekJo
	 4O7TH1r19WUEzI1wFydVTSMZ4ljQ8Mk5BFLzZldKjLFPQZMSS7J0eaFoEJGgSaMWfapko
	 +Wcl4wI90vVRGzjADiKFLLX5/Gq090faYlA2nzunzY+v2yHdHfbtI8OiywZRQMcK/w89d
	 EVRBe9Te3NgJJLDDNZDy9zKueSPF3OiRthPC/pOi18Jpy2mST9lAWZISiNVQW0XHTXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795767876;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=MlOHk0M8kwtp5u/zTni7+wcFytDELTmVJD3AV1zqGes=;
	b=TP2bHfwphh+11pAv1TWh/dcRvs5/ljWduouM2ITpqiT+qhQUMD1r1dXAUliqkcQy2c6q
	 DK3nRG5Btc3lfQkBvjSAiJ6oP4jSSKKd3YnXj1cOc5l0nuwQC7raX+sevdXzJdQnF6WdS
	 4blKWXSj8j3u4GBna5Q51xsqu50kP4l+RYT8mTmc4lwHSsPNFZP3zRlSQkHxKbYbClqNC
	 f2EnZ18/htW5xw/llC2p+mE68xUg9EzkgY5zKuDO06Po/xy0pqv1kwt+nLM9Wo+N4cwYe
	 TS3lkakFXT2vjZ6e6YOhcTc8kiPNPXCs2b7M7OYIbB7xI0qzJ1J29tnjrYu1AUJN9Sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WbNoY0RT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A59606A687;
	Fri, 27 Nov 2026 08:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WbNoY0RT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD3E51F00893;
	Fri, 27 Nov 2026 08:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795767875;
	bh=MlOHk0M8kwtp5u/zTni7+wcFytDELTmVJD3AV1zqGes=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WbNoY0RTpM3bhTHwvJlotlaOmwBq0Ssd1yvP+wWglFLXIB7JFu/NPTAtFh3bHvQP6
	 2napRyq10+ZHln6yr6iRxvGV7vo7hWbZH2I4O1KYUIMnp13Djqa3rscuBW10ON1dcQ
	 ZQYtHBnTV/iCYpqPeR6WZ/GfeCn9BcW+vfn+1dew5F2ZV6+4yMKZBTHQPoV8TC6xOq
	 057CTkxgyorNOHyF1+4BY8/7WlOX98jFztCitdRpz5/ySKpln61wVtSq7fV24/a1wT
	 AzHJnc3vmvISwhWOrGvvnU1U74t1rbiIA29ij+TNjtXUxvI0Zi9rwd6eXkGmsS8zkV
	 ZCeEsv5JZZkNg==
Subject: Re: [PATCH net-next 3/5] net: dsa: microchip: ksz9477: do not learn
 addresses on the CPU port
From: netdev-bot+sashiko@kernel.org
To: o.rempel@pengutronix.de
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, f.fainelli@gmail.com,
 razor@blackwall.org, idosch@nvidia.com, netdev@vger.kernel.org,
 bridge@lists.linux.dev, kernel@pengutronix.de
Date: Fri, 27 Nov 2026 08:24:34 +0000
Message-ID: <179576787449.3135.11974599854572162575@kernel.org>
In-Reply-To: <20261126-ksz-stp-link-local-v1-3-39aed15f6271@pengutronix.de>
References: <20261126-ksz-stp-link-local-v1-3-39aed15f6271@pengutronix.de>
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

- [Medium] This patch causes an HSR offload regression on KSZ9477.

--

net: dsa: microchip: ksz9477: do not learn addresses on the CPU port

This patch turns off address learning on the CPU port of the KSZ9477
family and LAN937x. It sets ds->assisted_learning_on_cpu_port instead, so
DSA installs the addresses the bridge learns outside the switch as static
entries on the CPU port. This prepares for software forwarding of trapped
link-local frames.

> diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
> index 98211d9835734..8271bc742ddc5 100644
> --- a/drivers/net/dsa/microchip/ksz9477.c
> +++ b/drivers/net/dsa/microchip/ksz9477.c

[ ... ]

> @@ -1792,13 +1791,15 @@ static int ksz9477_setup(struct dsa_switch *ds)
>  	if (ret < 0)
>  		return ret;
>  
> -	/* Start with learning disabled on standalone user ports, and enabled
> -	 * on the CPU port. In lack of other finer mechanisms, learning on the
> -	 * CPU port will avoid flooding bridge local addresses on the network
> -	 * in some cases.
> +	/* Ask DSA to add the addresses that the bridge learns on ports
> +	 * outside the switch as static entries on the CPU port. The CPU
> +	 * port itself does not learn: when the bridge forwards a frame in
> +	 * software between two ports of the switch, the switch would learn
> +	 * the sender on the CPU port. p->learning is never set for the CPU
> +	 * port, so ksz_port_stp_state_set() disables learning when DSA sets
> +	 * the port to forwarding.
>  	 */
> -	p = &dev->ports[dev->cpu_port];
> -	p->learning = true;
> +	ds->assisted_learning_on_cpu_port = true;

[Severity: Medium]
Does this cause a regression for HSR offload on KSZ9477? Unicast frames
addressed to the local HSR node now seem to be forwarded to the other ring
port as well.

Before this change, the CPU port learned the HSR MAC from frames the host
sent. That learned entry sent unicast with DA == HSR MAC to the CPU only.
Now dsa_port_enable_rt() moves the CPU port to BR_STATE_FORWARDING, and
p->learning is false, so ksz_port_stp_state_set() disables learning there:

ksz_port_stp_state_set() {
    ...
	case BR_STATE_FORWARDING:
		data |= (PORT_TX_ENABLE | PORT_RX_ENABLE);
		if (!p->learning)
			data |= PORT_LEARN_DISABLE;
    ...
}

The replacement doesn't seem to cover HSR, because HSR ports are not in a
bridge:

dsa_user_fdb_event() {
    ...
	if (!dp->bridge)
		return 0;
    ...
}

dsa_switch_supports_uc_filtering() needs ds->fdb_isolation, which the
microchip drivers don't set, so standalone host address filtering doesn't
add the entry either.

ksz9477_hsr_join() doesn't install a static ALU entry for the HSR MAC.
ksz_switch_macaddr_get() only programs the self-address filter register.
ksz9477_hsr_join() also makes the two ring ports and the CPU members of
each other's forwarding set:

ksz9477_hsr_join() {
    ...
		hsr_ports |= BIT(dsa_upstream_port(ds, port));
		dsa_hsr_foreach_port(hsr_dp, ds, hsr)
			ksz9477_cfg_port_member(dev, hsr_dp->index, hsr_ports);
    ...
		data |= HSR_DUPLICATE_DISCARD;
		data &= ~HSR_NODE_UNICAST;
    ...
}

ksz9477 never programs unknown unicast control (REG_SW_LUE_UNK_UCAST_CTRL__4
is unused). Unicast to this node would then miss in the ALU and flood to
the other ring port and the CPU. It would keep going around the ring until
the sender's self-address filter drops it.

The hardware meaning of HSR_NODE_UNICAST is not documented in the tree.
If clearing that bit made the switch deliver node-addressed unicast only
to the host, this flooding would not happen. The note below the --- line
reaches the same conclusion, that the frames are flooded.

That note is dropped when the patch is applied. The commit message doesn't
mention this behavior change, and nothing in the series changes the HSR
join/leave path.

Could ksz9477_hsr_join() add a static ALU entry for hsr->dev_addr on the
CPU port, with ksz9477_hsr_leave() removing it? Another option is to keep
CPU port learning enabled while dev->hsr_ports is non-zero.

>  
>  	if (dev->irq > 0) {
>  		ret = ksz_girq_setup(dev);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261126-ksz-stp-link-local-v1-0-39aed15f6271%40pengutronix.de
