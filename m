Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795767878;
	b=TN6hX/ueYzYow9j50eQrx9pFmjPGU3Gw8u7BqvO9gbwkqqImcQz9rh2R0c6i/QIyxO5A
	 lLT7S4vJR1Lbv+SCV6mnjMesGUXSj3VoWQ9dXLV359F6YnDmvKPVGwMtPoz3j71t89WAE
	 jZXsNEPK71pQRRZgnk2qXIBIdt4ObzzvD+tPIARxnUlZ4+Xret0nXesb8vybBas2Y2k0U
	 dLVtgiUBiv9B/xoiJ02vLs4WsHiYGrLh8wLg3JGFVaVNX5GLSfbpn/rbOef81qDBfWAHW
	 P5/bqolmK4fXdQRgAWgWGbvFM2msRXmQp6znudmbvbe/LVOOJgvInNNJYQi87Qy625w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795767878;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=46phQw8FEZgAtpTIWQKwjc+7z6357PRApUqqLPPOPl4=;
	b=cBuoYTAVDVpNBG4AgX9nUAQmMo+sFKu0WI4EPYUKMXwRFHccG/a7z2WfixaxbvWr2kXx
	 LfjTjy2d+0l7Fqlz0UTdo/lbpl1hcwWA+quMnALNtVNbTaCA9CtW3P1Nzpq/BHVi/br40
	 Op02KnKtYEhqs4CNBClOfYZQN+37gcgsA8MDnuu3Hlvd8hx/q1QTLuZjOt1zKla32CHVe
	 Q35vWZAG3TwfN+ESzG8v69nubtwr4PMXT9jWrhOiMNwjqDBCuWtugse+2DpnwYlx+D0kt
	 IKz1dh0ibPHm7bfVIcvJeVRQsTVlWMLzztLjaJlUd9Jzf+8F/2OXtEAaSulNx8JFPlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="b6t2fGK/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E863C606A32F;
	Fri, 27 Nov 2026 08:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b6t2fGK/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA2821F00898;
	Fri, 27 Nov 2026 08:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795767877;
	bh=46phQw8FEZgAtpTIWQKwjc+7z6357PRApUqqLPPOPl4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=b6t2fGK/zC+9+ejA4oPu2ZR2eoKnnbvpMzDCk3HctR2cYCo5qeHf8HG68Sxxn1xu/
	 yITIU7JznKTs3fn6qnd/Hh+VEVH8VP6tfb2/XL/wJ5Acw3ZY38/pGiGl3RpzXrGaQU
	 6aIAl+dAO38w75O/P8QC2ssR/uajeLrJib4EWlWASed0Eic3pq+yiF5SeSUfBeWmvu
	 oP1tguYHzCKH0+xp1YZG69pWMiHT0YUC1ly+gbf8ajoVxI976mAUEq0TQSShJz+wLl
	 gxJb1iHXVVVNzIzle7M0+sa8a+Avye5tVM+trm4bmc8WO1Bw/a5lkmfB6OEt12ksA9
	 KndY2KAHgZgBA==
Subject: Re: [PATCH net-next 4/5] net: dsa: microchip: ksz9477: refuse FDB/MDB
 entries for trapped groups
From: netdev-bot+sashiko@kernel.org
To: o.rempel@pengutronix.de
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, f.fainelli@gmail.com,
 razor@blackwall.org, idosch@nvidia.com, netdev@vger.kernel.org,
 bridge@lists.linux.dev, kernel@pengutronix.de
Date: Fri, 27 Nov 2026 08:24:36 +0000
Message-ID: <179576787624.3135.13299340815507040998@kernel.org>
In-Reply-To: <20261126-ksz-stp-link-local-v1-4-39aed15f6271@pengutronix.de>
References: <20261126-ksz-stp-link-local-v1-4-39aed15f6271@pengutronix.de>
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

- [Low] The commit message describes user-visible failures that this
  patch fixes, but the patch has no Fixes: tag and does not say whether…
- [Low] The subject and body describe the change as KSZ9477-family only,
  and the test results are for KSZ9893 only.
- [Low] ksz9477_enable_stp_addr() collects the trapped-group bitmap in a
  local variable and only copies it to dev->link_local_to_cpu after all…

--

net: dsa: microchip: ksz9477: refuse FDB/MDB entries for trapped groups

The reserved multicast table traps some link-local groups to the CPU.
This patch makes ksz9477_fdb_add() and ksz9477_mdb_add() refuse entries
for those groups: they return -EOPNOTSUPP on user ports and 0 on CPU and
DSA ports. A new dev->link_local_to_cpu bitmap, filled in by
ksz9477_enable_stp_addr(), records which groups are trapped.

> The KSZ9477 family looks up a destination address in the address
> lookup table (learned and static FDB entries), the static address table
> (MDB entries) and the reserved multicast table. The driver traps the
> link-local groups with the reserved multicast table: it sends
> 01:80:C2:00:00:00 to :0F to the CPU only, except :01 (PAUSE frames),
> which it drops. On a KSZ9893, an FDB or MDB entry for a trapped group
> overrides that rule.

[Severity: Low]
This change also applies to LAN937x, but the message doesn't mention it.
Is that intended? And has the override been seen on LAN937x hardware?

lan937x_switch_ops in lan937x_main.c uses the same handlers:

	.port_fdb_add		= ksz9477_fdb_add,
	.port_fdb_del		= ksz9477_fdb_del,
	.port_mdb_add           = ksz9477_mdb_add,
	.port_mdb_del           = ksz9477_mdb_del,

Also, lan937x_setup() calls ksz9477_enable_stp_addr(dev), which now fills
dev->link_local_to_cpu.

So on LAN937x, FDB and MDB entries for trapped link-local groups on user
ports are now refused with -EOPNOTSUPP too. Until the later tagger patch,
LAN937x also gets the gap where frames to a group with a refused MDB entry
are not forwarded between switch ports.

Other patches in this series name LAN937x explicitly. One example is
"LAN937x uses the same code" in "net: dsa: microchip: ksz9477: do not keep
the learned port in FDB entries". Could this commit message do the same?

> A later patch makes the tagger stop marking these frames as already
> forwarded by the switch. This patch comes first, so that the switch and
> the bridge never both forward such a frame. Until then, frames to a
> group with a refused MDB entry are not forwarded between switch ports
> at all.

[Severity: Low]
The commit message describes failures that users can see. In one of them,
a Blocking port stops passing BPDUs to the CPU and the bridge moves it to
Listening. There is no Fixes: tag and nothing about stable, though. Is a
backport intended?

The earlier patch in this series, "net: dsa: microchip: ksz9477: do not
keep the learned port in FDB entries", carries a Fixes tag, so this patch
is handled differently.

The right Fixes target is not clear. The group 0 (STP) trap in
ksz9477_enable_stp_addr() goes back to 331d64f752bb. The 8-entry
reprogramming loop came from 96baf482ca1f.

Before 96baf482ca1f only entry 0 was written. The hardware default for
group 6 forwards to the last port, and on KSZ9893 the last port is the
CPU port. So the :0E trap likely existed there before that commit too.

What happens if this is backported alone, without "net: dsa: microchip:
ksz9477: report the trapped link-local groups"? Wouldn't stable kernels
get the gap described above, where frames to a group with a refused MDB
entry are not forwarded between switch ports at all?

Could the message name the commit that introduced the problem and the
series dependency, or say explicitly that no backport is intended?

> diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
> index 8271bc742ddc5..b972c9fab55c1 100644
> --- a/drivers/net/dsa/microchip/ksz9477.c
> +++ b/drivers/net/dsa/microchip/ksz9477.c

[ ... ]

> @@ -1621,6 +1669,14 @@ int ksz9477_enable_stp_addr(struct ksz_device *dev)
>  			update = ports;
>  			break;
>  		}
> +
> +		/* Record the link-local addresses of group i if the switch
> +		 * sends it to the CPU only. Group 1 keeps its drop default and
> +		 * does not match.
> +		 */
> +		if (update == BIT(dev->cpu_port))
> +			link_local_to_cpu |= ksz9477_resv_mcast_link_local[i];
> +
>  		if (update != ports || override) {
>  			data &= ~dev->port_mask;
>  			data |= update;
> @@ -1650,6 +1706,8 @@ int ksz9477_enable_stp_addr(struct ksz_device *dev)
>  		}
>  	}
>  
> +	dev->link_local_to_cpu = link_local_to_cpu;
> +

[Severity: Low]
Can dev->link_local_to_cpu get out of sync with the hardware here?

The first iteration of the loop writes group 0 (01:80:C2:00:00:00, CPU
only, with override). If a later iteration fails, the function returns
before this assignment and dev->link_local_to_cpu stays 0. This early
return in the loop is one example:

		ret = ksz_write32(dev, REG_SW_ALU_STAT_CTRL__4, data);
		if (ret < 0)
			return ret;

A ksz_read32() or ksz9477_wait_alu_sta_ready() failure returns early in
the same way.

Both callers ignore the return value:

ksz9477_setup()
    ksz9477_enable_stp_addr(dev);

lan937x_setup()
    ksz9477_enable_stp_addr(dev);

So setup completes while the hardware already traps :00 to the CPU.

>From then on, ksz9477_link_local_is_trapped() returns false for :00. Then
ksz9477_fdb_add() and ksz9477_mdb_add() write an entry that overrides the
STP trap. That is the bypass this patch is meant to block.

The callers ignored the return value before this patch, but the new
bitmap is what can now disagree with the hardware. Should the bitmap be
updated as each group is programmed, so that it matches what has already
been written?

>  	return 0;
>  }
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261126-ksz-stp-link-local-v1-0-39aed15f6271%40pengutronix.de
