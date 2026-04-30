Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F0E2D7814
	for <bridge@lists.linux.dev>; Thu, 30 Apr 2026 17:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777569025; cv=pass; b=rrmNqzbk+dTjfdlJfI1PzpTLJLrsHCIuPbJgFFfb1B5He+JzDdytKjOpGs9lWVQzWi4Oc7JjkE6SO6tWKn5meqL3RLfw50w+Z3WZAnt9PHBNwia5FhqPjnQc4iJYfVQvfdtmKpXpkAAygszxSPt84VQK4HoppCBbK35JfAQG970=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777569025; c=relaxed/simple;
	bh=DNVlnakk13aUrg/hD2oRV2j1tPfuGQFYLjetu4lriIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DbQhIvqaC+tHsbjX+Eb5N/IAerpz17OvHCHdAa1+SU8hEwHOi10OHs5vX/Z2K1V6pZdNVaiyFnE7rI/Nrm/XEYpLJgyhArDtLA8m5jCOU7tW0xE2HOrEeMeiIcZfNR46bfTjJaQwhnZYyjFqY+DTCtKzTNgYZxgDo2SIXVhlfoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cQ6i47Wm; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cQ6i47Wm"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-50fb1932b62so7767301cf.2
        for <bridge@lists.linux.dev>; Thu, 30 Apr 2026 10:10:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777569022; cv=none;
        d=google.com; s=arc-20240605;
        b=McTAlvBcWtb6hisMzVPwAIwqipnq3/VkMvos/d3XhT41viUuA6SjLcJCUus3qcJgj4
         mnj8muxnCJ18k+UNg8A2CXkTk6HC+GL+ni91ioysWqb3E7znYLzIIXFyTiW32hUW3Uxk
         097nGrLGbrEiroGrf/CATfFWlFG3m63cK4PkPjB0rO0iJQJ5QEwQ/5doK5azwB7irmNV
         b276z8SarvJ/d2ytcsdx8c0kglm6PeYMRc+J+tGXt3XaC9Tc+l/NPkpSWiCLqEK2fXal
         0r1ahElnAir3FD57IyT6rFuE4jna4DhtbgSKWBvxTr28y6ENbyuWEwX8+oQg8Rm6JCZz
         dVnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yrzguIxjvs/dYwgMGJK74KZhhZt3RDq4c7p/kIBoyEs=;
        fh=CLoTgENu6xFEcTp6gy+UCZjflp2Dy6shQdDOfI9dKAs=;
        b=VAelamuHCA3R+5490tpYGoDkIEiPL8RPAzIi9+zf4DNkovJSHWpkAnqmwy3XT4vvp0
         9VDdwjFr22DhSLiN9hp7OHoVZRefrBDWD/BM4u8vgEAj5UGu4GxliwpvVWy/F5iKyr4b
         qoWsH3o49/Mxz5ToG0nGf9FonSctk7OVea49JJWLeBQWqUZ92zLNMwaqZwICkxTWdPIi
         gC/6+ZLjSoEPNZ29/yErCkpRNVWq1PS3guCVIpR8oDeDhcgdmqyBE27wQp3s7N7wiqYs
         IxA8xb1ObLfGSdxrK74VsZMB07me1/2smTI1UVTRvQX0cK93ekj91NFKLTR5KDSCW7uE
         ruKw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777569022; x=1778173822; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yrzguIxjvs/dYwgMGJK74KZhhZt3RDq4c7p/kIBoyEs=;
        b=cQ6i47WmNyyVdqAfTPqKxsTcFR/NWRwmGHcq8LbKewMcXMKO+XNAXtNw81/DDQcRP8
         3wF0cXHD5RMpMHeKeb10bPaUfsLl8t20UY/tZ543JdUevkW/xdQe9GYNCWxW/vwx03gH
         O8WygozribROR0Tf/7almIeIbqYScKVWeLEf90FTiNyUJtBVkDSIrg/XzRUvxniQtV7Z
         fQTBPsEs/YiTiZyEhFGw31ebZAlpX94MuqmzV8EFPiXrTKboHyEwzy0sXVCKEi7UCCZd
         GLD790FuBf0spI8kPyQuU//w4D2kjWAFA/3jpijb/cAgY3fr1Vpi7Vfs05LDY4F3JUmQ
         ch4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777569022; x=1778173822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yrzguIxjvs/dYwgMGJK74KZhhZt3RDq4c7p/kIBoyEs=;
        b=bZ/aUaxqAiGX1rw12qE4pUoQWKnFzD3NEQK5eizMpdauNenSZMde+mrYlxp0IifhJB
         ivqlxx0uEQIcXYMDrhRth48F0g2lHY+2Y0vrNKx9df0ddsabb7aAYEBdhPtoBuADBUVU
         mUMf8Q6+fU0Gea7rPgahyXrq7Iu7rC99XRfJCA1nEwZo+YSBoxCwWJyeg7wqCqvetFmu
         8foWX26Wm0K16ilfbEFziA/rRbWE5nvynoLcoaYYQJ3pEyU/jAAXK1PowGKGyFYA2X8k
         vT8ks/0FS7gAIW8IYBhwKLAbHPoeyxCnH2R4LVtD5JTZeNn47r89Qf94XmfW2MVqGMVA
         RgwQ==
X-Forwarded-Encrypted: i=1; AFNElJ/2Rsmymhird1VIRJ8e4CjAnYq+hqp2Wfn2ZjmT1FulH9Ydc/krAFUQQjwxW3wXGTsOGBJrW/4=@lists.linux.dev
X-Gm-Message-State: AOJu0YwOVQ8m2/TN6Z5R84a1sRQU0Jd6xLjTW8tvz6ZEHvDQOF1/0Mks
	9btsG9YCPidHnqkR6/At4Ah/27TxtNfPhOoX8dk71DCQbGuwN3otEtUZlVbxO09+v0G80UinMaF
	ZSA/ZEgvr1Js0wFHvuH8rxZgp5W5xNjjuetba7Jk6
X-Gm-Gg: AeBDiev0ENTgcelfYMQFW9vHS2w9NU9pM8olITksCoVV2lBv6Q4tMCUQ9K8UYWQ4gWx
	dR+2Ce9RTQm2VikWRG4E5ErJewgcMXZ6S4ka/cn81WvcJlwqahkVdWJQFmVBkqdDB5VlFwmShHM
	jtKt6UUTj1kR90ZwNHnjYm/uDd+/KUTV69rV61cdCEhC6sm3ZOsg7kXy1BFIhtiVUIqre/+9cSH
	tdfiDpuT5A7vXsJTiWRDN4yNH2ExH16wFFrLZlj3tiS0ZCBhL3J4peKfb+UUTi7nROOxMNa/WDN
	8azAig+H9J9VIiYoNyx8JhWQ9DSppp8ee02oF1hP5BoR5ZeYWwYp9e2YLARMc/oruHhjCJiWLif
	BA3fDywEuEcsBAPHWfkD0AMggJVf8sSq+cUKPa5TT
X-Received: by 2002:a05:622a:1f09:b0:50d:a1c4:e154 with SMTP id
 d75a77b69052e-5102ae1da7fmr52716511cf.36.1777569021888; Thu, 30 Apr 2026
 10:10:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260430162604.1043756-1-idosch@nvidia.com>
In-Reply-To: <20260430162604.1043756-1-idosch@nvidia.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 30 Apr 2026 10:10:10 -0700
X-Gm-Features: AVHnY4Ji_7uVCqMoljL0LD076ahF-xWJc3AxPt1g7gzVMrU55PPMiMUJ5ew-Guo
Message-ID: <CANn89iJ5-rBLtsOZoAfbeF+X29VrpLCXQaLi2fio30_F81+9_Q@mail.gmail.com>
Subject: Re: [PATCH net v2] bridge: mcast: Fix a false positive lockdep splat
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux.dev, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, razor@blackwall.org, horms@kernel.org, 
	herbert@gondor.apana.org.au, linus.luessing@c0d3.blue, petrm@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2026 at 9:27=E2=80=AFAM Ido Schimmel <idosch@nvidia.com> wr=
ote:
>
> Connecting two bridges on the same system [1] can result in a lockdep
> splat [2].
>
> The report is a false positive. Multicast queries are built and
> transmitted under the bridge multicast lock. When the outgoing port of
> one bridge is configured on top of another bridge, the transmit path
> re-enters bridge code and acquires the other bridge's multicast lock in
> order to snoop the query. Both lock instances share a single lockdep
> class, so lockdep flags the nested acquisition as an AA deadlock.
>
> Giving each bridge its own lock class will not solve the problem: the
> reverse topology would produce an ABBA splat with the same pair of
> classes. It also consumes a lockdep key per bridge.
>
> Instead, fix the problem by deferring the transmission of the queries to
> a workqueue. Build the skb and update querier state under the lock as
> before, then enqueue the skb on a per multicast context queue and
> schedule the work.
>
> Flush the work when the multicast context is de-initialized. At this
> stage the work cannot be requeued. There is no need to take a reference
> on skb->dev since the work cannot outlive the bridge or the bridge port.
>
> Use the high priority workqueue to reduce the delay between the enqueue
> time and the transmission time. With default settings (i.e., querier
> interval - 255 seconds, query interval - 125 seconds) the extra delay
> should not be a problem.
>
> Avoid the unlikely case of the queue growing endlessly by limiting it to
> 1,000 skbs. Use this number for the simple reason that this is the
> default Tx queue length.
>
> [1]
> ip link add name br1 up type bridge mcast_snooping 1 mcast_querier 1
> ip link add name br0 up type bridge mcast_snooping 1 mcast_querier 1
> ip link add link br0 name br0.10 up master br1 type vlan id 10
>
> [2]
> WARNING: possible recursive locking detected
> 7.0.0-virtme-gb50c64a58a90 #1 Not tainted
> [...]
> ip/339 is trying to acquire lock:
> ffff888104f0b480 (&br->multicast_lock){+.-.}-{3:3}, at: br_ip6_multicast_=
query (net/bridge/br_multicast.c:3584)
>
> but task is already holding lock:
> ffff888104f03480 (&br->multicast_lock){+.-.}-{3:3}, at: br_multicast_port=
_query_expired (net/bridge/br_multicast.c:1904)
>
> [...]
>
> Call Trace:
> [...]
> br_ip6_multicast_query (net/bridge/br_multicast.c:3584)
> br_multicast_ipv6_rcv (net/bridge/br_multicast.c:3988)
> br_dev_xmit (net/bridge/br_device.c:98 (discriminator 1))
> dev_hard_start_xmit (./include/linux/netdevice.h:5343 ./include/linux/net=
device.h:5352 net/core/dev.c:3888 net/core/dev.c:3904)
> __dev_queue_xmit (./include/linux/netdevice.h:3619 net/core/dev.c:4871)
> vlan_dev_hard_start_xmit (net/8021q/vlan_dev.c:131 (discriminator 1))
> dev_hard_start_xmit (./include/linux/netdevice.h:5343 ./include/linux/net=
device.h:5352 net/core/dev.c:3888 net/core/dev.c:3904)
> __dev_queue_xmit (./include/linux/netdevice.h:3619 net/core/dev.c:4871)
> br_dev_queue_push_xmit (net/bridge/br_forward.c:60)
> __br_multicast_send_query (net/bridge/br_multicast.c:1811 (discriminator =
1))
> br_multicast_send_query (net/bridge/br_multicast.c:1889)
> br_multicast_port_query_expired (./include/linux/spinlock.h:390 net/bridg=
e/br_multicast.c:1914)
> call_timer_fn (./arch/x86/include/asm/jump_label.h:37 ./include/trace/eve=
nts/timer.h:127 kernel/time/timer.c:1749)
> [...]
>
> Fixes: eb1d16414339 ("bridge: Add core IGMP snooping support")
> Reported-by: syzbot+d7b7f1412c02134efa6d@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/000000000000c4c9d405f2643e01@googl=
e.com/
> Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
> v2:
>   - Limit the queue to 1,000 skbs.
>   - Edit the trace to avoid checkpatch errors.
> v1: https://lore.kernel.org/netdev/20260426133435.207006-1-idosch@nvidia.=
com/
> ---
>  net/bridge/br_multicast.c | 47 +++++++++++++++++++++++++++++++++++----
>  net/bridge/br_private.h   |  4 ++++
>  2 files changed, 47 insertions(+), 4 deletions(-)
>
> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
> index 881d866d687a..e9f5fe01ff95 100644
> --- a/net/bridge/br_multicast.c
> +++ b/net/bridge/br_multicast.c
> @@ -1776,6 +1776,30 @@ static void br_multicast_select_own_querier(struct=
 net_bridge_mcast *brmctx,
>  #endif
>  }
>
> +static void br_multicast_port_query_queue_work(struct work_struct *work)
> +{
> +       struct net_bridge_mcast_port *pmctx;
> +       struct sk_buff *skb;
> +
> +       pmctx =3D container_of(work, struct net_bridge_mcast_port,
> +                            query_queue_work);
> +       while ((skb =3D skb_dequeue(&pmctx->query_queue)))
> +               NF_HOOK(NFPROTO_BRIDGE, NF_BR_LOCAL_OUT, dev_net(skb->dev=
),
> +                       NULL, skb, NULL, skb->dev, br_dev_queue_push_xmit=
);
> +}
> +
> +static void br_multicast_query_queue_work(struct work_struct *work)
> +{
> +       struct net_bridge_mcast *brmctx;
> +       struct sk_buff *skb;
> +
> +       brmctx =3D container_of(work, struct net_bridge_mcast, query_queu=
e_work);
> +       while ((skb =3D skb_dequeue(&brmctx->query_queue)))
> +               netif_rx(skb);
> +}

These two functions could loop forever under flood.

Perhaps use skb_queue_splice_init() to limit each round to the ~1,000
limit you have mentioned in the changelog.

And return after the spliced list has been processed.

Bonus: no more spinlock acquisition for each skb_dequeue()
