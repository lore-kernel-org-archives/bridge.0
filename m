Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795767879;
	b=utMKijw7Qnv5OTQH/VKYlrMQPg4Vei4FVNx0ZL+fugosVn763WhTiCgO9Xoz4g17WCGP
	 kKKR++qhjC0p2Qj7TXQehEEtZ++87tSpHbXXJAQjNBXrne9/9XAube6hnbUTb1b/nj5uV
	 TurN6i0NsEwG+FZ62Zrj3MLmMLDtNWAy1WX0hcOsHxE4/Vy+DzmjCjXuhuFlkhxdHqKx2
	 nl8hhnBxxuWmrmoQG+3ZCI6bZfuvY57eOg6LF6gDqWKZljatmZYEULbRjEiWPHOiNTQ6e
	 VRVFOv6lJFsBwO4HCwjPmJA2so3wdUC/Nal7TH/fZtXypsH34nNIDptYMgPgXoc8msw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795767879;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=lr72VQlYLYbse8xMFCEioYSpY2HCt7DiUlyT7B5FkDE=;
	b=eKeGN7EenaoqIdgZEisDBpf+3D6V8tcysmBNM72dGuKNUAQ9OP2kNvoatwWE1PTnKeIn
	 eM+TftcDGJTsl8Zgod+eTaoaySOCPafRF2qZjxsWGvb8NvJhIa1usqKPapSe+bCPGwAIK
	 d2W/xMMbPoP4mT3tI9GE7ZUXnnDY1FEHFO7YF+Z6AxUaJfvtvqL15tHNRvQv2CYMds39Q
	 g8VYi0JBWlLe0qvTr5LJL39sOuNiDkBJRtaoijvItx+SuTWGh3AIVTHU2TfqBE6xuK6gT
	 ZP6un1Lte6uSqTyb9Ft9j/G9Pyv2EOVuOzDTv9qrX6wBzfCVw/VNZWfM7LN1lfKuB1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EtV7nIJC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A2B606A339;
	Fri, 27 Nov 2026 08:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EtV7nIJC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A72961F00897;
	Fri, 27 Nov 2026 08:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795767879;
	bh=lr72VQlYLYbse8xMFCEioYSpY2HCt7DiUlyT7B5FkDE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=EtV7nIJCbAPmwBnhnOyspX486wPWX6+speOesWu5b6OJrUo1FpCtiDQVlnfK2lCqr
	 v1dHSpeD+pX+IsxO0MguAS8ipq9PAs8Wga/yCxUHB89Fpmeu2czKDSQpjxpoXnXOqn
	 Lo7MYUmMIgij3QgJNJMq6WkYem4f+sM/tvGPqPRqqy6BVRf6QgkjHi4lsRfrUuzZ0E
	 +IJ0mZVUQuhD19U8gw3UTHpIZpU7aPrlbw5PdsP9ZTACxLhtkfDjA1LBOZajs339Na
	 GzH4rp1kyvBqce/vLygFFXKbDynCBbzZgzIpdNzgAtF4m93WYjqqJUMxKgYWPMDzlH
	 sxB3RVM9Esq6w==
Subject: Re: [PATCH net-next 5/5] net: dsa: microchip: ksz9477: report the
 trapped link-local groups
From: netdev-bot+sashiko@kernel.org
To: o.rempel@pengutronix.de
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, f.fainelli@gmail.com,
 razor@blackwall.org, idosch@nvidia.com, netdev@vger.kernel.org,
 bridge@lists.linux.dev, kernel@pengutronix.de
Date: Fri, 27 Nov 2026 08:24:38 +0000
Message-ID: <179576787826.3135.3667519531673258618@kernel.org>
In-Reply-To: <20261126-ksz-stp-link-local-v1-5-39aed15f6271@pengutronix.de>
References: <20261126-ksz-stp-link-local-v1-5-39aed15f6271@pengutronix.de>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] On a bridge with STP disabled, which is the default for a new
  Linux bridge, this patch changes how STP BPDUs are handled.

--

net: dsa: microchip: ksz9477: report the trapped link-local groups

The KSZ9477 family and LAN937x drivers now copy dev->link_local_to_cpu
into the tagger data from their connect_tag_protocol callbacks. As a
result, the tagger stops setting offload_fwd_mark on link-local frames
that the switch traps to the CPU, and the bridge can forward those frames
in software.

> The tagger then no longer marks these frames as
> forwarded in hardware (offload_fwd_mark). The bridge applies
> group_fwd_mask and the STP state to them and can forward them to the
> other ports of the switch.
>
> Tested on a KSZ9893: with the group_fwd_mask bit for 01:80:C2:00:00:0E
> set, the bridge relayed 20 of 20 frames to that group from lan1 to lan2
> with this change, and 0 of 20 without it.

[ ... ]

> diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
> index 7b96d110b1f64..1f96b91016fcf 100644
> --- a/drivers/net/dsa/microchip/ksz_common.h
> +++ b/drivers/net/dsa/microchip/ksz_common.h

[ ... ]

> +static inline void ksz_tagger_set_link_local_to_cpu(struct dsa_switch *ds)
> +{
> +	struct ksz_device *dev = ds->priv;
> +
> +	ksz_tagger_data(ds)->link_local_to_cpu = dev->link_local_to_cpu;

[Severity: Low]
This isn't a bug, but should the commit message mention what this does to
STP BPDUs on a bridge with STP disabled? That is the default for a new
Linux bridge.

ksz9477_enable_stp_addr() programs group 0 (01:80:C2:00:00:00) as
CPU-only, so BIT(0) is always set in the bitmap copied here:

drivers/net/dsa/microchip/ksz9477.c:ksz9477_enable_stp_addr() {
    ...
		if (update == BIT(dev->cpu_port))
			link_local_to_cpu |= ksz9477_resv_mcast_link_local[i];
    ...
}

Once the bitmap reaches the tagger, ksz_common_rcv() skips
dsa_default_offload_fwd_mark() for BPDUs:

net/dsa/tag_ksz.c:ksz_common_rcv() {
    ...
	if (!ksz_link_local_trapped(skb->dev, eth_hdr(skb)->h_dest))
		dsa_default_offload_fwd_mark(skb);
    ...
}

br_handle_frame() then forwards group 0 frames when STP is off:

net/bridge/br_input.c:br_handle_frame() {
    ...
		case 0x00:	/* Bridge Group Address */
			/* If STP is turned off,
			   then must forward to keep loop detection */
			if (p->br->stp_enabled == BR_NO_STP ||
			    fwd_mask & (1u << dest[5]))
				goto forward;
    ...
}

Without offload_fwd_mark, nbp_switchdev_allowed_egress() no longer stops
these frames from egressing the other ports of the same switch.

So a KSZ9477/KSZ9893/LAN937x bridge with stp_state 0 now relays BPDUs
received on one switch port to every other switch port. Before this
change they were dropped between those ports.

External STP switches attached to different KSZ ports will now see each
other's BPDUs. That can change root election and cause ports to be
blocked.

The new behaviour matches the software bridge and the br_input.c comment,
so it looks intended. It is still a visible change in the default
configuration. The message only says "The bridge applies group_fwd_mask
and the STP state to them and can forward them to the other ports of the
switch", and the reported test covers only 01:80:C2:00:00:0E.

Could the message state that BPDUs are now forwarded on bridges with STP
disabled?

> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261126-ksz-stp-link-local-v1-0-39aed15f6271%40pengutronix.de
