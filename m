Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4912E39B971
	for <bridge@lists.linux.dev>; Wed,  1 Jul 2026 06:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782886279; cv=pass; b=KJ9Y/tp/dGTh+iCZ2n6IHIhRvsUMCLdf/S3bejW9HLbgccS/i1B8fJKsKFXaSsVzFiMTr6WQCUUJBabWI/j8v2LdOpNRH45txPYTMjB4IxWfTeMcN9OTnUKpHM3afBkiA09QwFutL6wN36oDkkfvo+YUNrwg2ch/aHZTPyYHopk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782886279; c=relaxed/simple;
	bh=ZxkEpGcaUnz5Szq84cetN2qcBNkJY5vj6Uao31D6ZxY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c8UhMm51qXHpMcXAj6Fi9iPDtMDRRYpD1sH1vm9l+QpkAe6syO5vGyrMWtFLZAAsfxYJQQGVq62HDFCumeR98LFgihAqJnhS3fSRAS+mR1OPxC/D/XWU04WPcGvPdCvjqhkQBXmm+KUhI1FHNsNf9l3Xjfnwkr0jsdWRtzZ9sb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U+AFCSxb; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+AFCSxb"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c125fbfbae0so28336866b.1
        for <bridge@lists.linux.dev>; Tue, 30 Jun 2026 23:11:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782886277; cv=none;
        d=google.com; s=arc-20260327;
        b=ZxGyq0mutjV0EJW3T8voz0xTDg3Lxc2FDTQ05oBrkhFUhO6D0EK3Jy0wKvuk7Od+m4
         tJ8cDOrRLnMjUbn9TDFNvMLtG6vmSGUh5wkg9zPEv9TSyMT6ZaELUX0FfDKc4sEcJ5NC
         07hFj8QA4EW47VCBNTPnAYgD0BSASjt72aQl0wb+nSMJccRiT4POTev/YMTzYN0xkJy6
         Pa8kpMIpGNJmxkyvDgP3oMqRoR2Z3E0ENaiFs/Ia3/B7KjRa2VhiwqmH2SJAwfZ2VJAa
         l80eQxnWCGhs9h01glpIBIOhYemBP7cS8y8T7L0mefTQlRumHKwQ6r4scOa+RTNYOXwH
         iwOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CWhVhD5eLCMV4lXuEV0ZYaY1wQTvatZLeKGOm+NJE/g=;
        fh=SW16llvAuPUVbT8ISYUn42YlWXR2vaJ0e0QmyySLrEk=;
        b=FH3te4YsS7hg9SAyap8tcJfeV2S4D9eT/N/mSM1bifQaZjNSvd4PIVIULo9Rid8wka
         qNxT1LpaeBZHBTvuFqW6vyu9aDdkl5KcrkGDKGjoZnUhw954eH7bZNNHfSeQta0drisy
         WwDmC9J7tQrnbRPpMC3ku81gDCgNcZbhqUOyKLa/T+IkxXyftg0ey0BzZtB63ie4Ib8v
         KFmcUuuEiuqtWc1kA/161OpfWC5VR/PGpVFofvs5ZdAvpq1Iv/01d6pJXAxm24wZYyuZ
         jta5Kp8NMWyuKHCtxslYcF/F8dktJ8FUHACpFHv/na4EAp2UZqeC6mRWOPu5QfiOhaNp
         S/dQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782886277; x=1783491077; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CWhVhD5eLCMV4lXuEV0ZYaY1wQTvatZLeKGOm+NJE/g=;
        b=U+AFCSxb5rEORNuIiga8jMgZgNKG1eDkX6lyR4NaYuxiOv7HFg3ADobXvEc9CHyCwC
         8Q+beVruJKtAelEa9utSrxm4slnyMEW1P2g2B/dBWu9udXDHiy3toz+cqg5FVsEQJ3kX
         v09SvU4OzoHjfSWZQUl0WRMHm2eeo4t7d3yWO0K1/hxrSpo2KJrxh1Qnttni4LJCATsW
         9CU1b/wdBz3lqX7uUAOSdrK27spWv6hsBrOsiZQT5PD32ylMHc6QQ5V8UaACzPL4pvEE
         ddtDTmFhTeu+wX79hQbxFAu43ZFDQc4ZPExGMCDhO+LiJYP+Fe9BsqVMRev41f5ZwTLM
         yxXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782886277; x=1783491077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CWhVhD5eLCMV4lXuEV0ZYaY1wQTvatZLeKGOm+NJE/g=;
        b=jentiU2TKMyPsy4l7evbZyWtFbOwf8TvNKWmDzKd2ayh3ub5mE3KbdmRUUJ1ApvdPA
         PDcxnZZzNV799p0ud5mDrF6ZRHGu3yQaIl2yfNuIdW/WNyRRssjKhHkatlX0taqpd4wT
         Pa0oVWeAlOa5AIazvtgYPUqhyvuBQOaUwC0fEyge1MMTpWtooAWIyTe4P5TnZ4ODIiiH
         q6YV+Yb9B7oezwzBQ4uh33e1eIiIc+VeKD+3DlMPVjta/iyLJFH65OI523fOaWRGM5NC
         dq0lX+HPZWjoBHPpbn+lgGBaK6NnaG/f4wwUXnLWJ4GB/02kbFsvfiJe+ANHJw5+cXLy
         uCVg==
X-Forwarded-Encrypted: i=1; AHgh+Ro5shPprl1RGResmGrceRV4x7f/bfJw4mvI3TyApA/VKY8Lk+bZxojVrg6Vt/cqFPGqxnJTr6k=@lists.linux.dev
X-Gm-Message-State: AOJu0YxXK+OOZpJs4j0+4ZfkMmSBCW1n+hy1q5P17UBbgnOR9bhwl676
	qdFfYwgXY+IrOLjpNq9YSInRlyth6MOebFllr7fO+OY7/dE89E5Z9TGmELfCb5XhnFnxS1hnRQx
	+ShGEdaV5vQO9zSlZcyAtanzR+0tVjNM=
X-Gm-Gg: AfdE7cl06TeTBD6374/cjBWhZ5vBSDF5UEY5OlcmFx4k19oOm7rZJ+gTuexKaPm82Ml
	0sg0iNdTPTEiKry4fVCivjQyzgp3289hKi2or/JD8od+Nxx32eTwRfPUQcBPxjjIkOTR7G3VGs5
	yztef2XBBbYgZUlyTFziGYMdepl0q64yaI88jLclna241PFv8GlkGYWW5cVxIRtTNWw5v/qyhjC
	tKGXpZ6F7xKHOa3WAL6M7HHrsi6PIEX0Emh3xE/cnYyaiNOg9jCOxH89SpJqYmAhLkPKudmRq+K
	Ju2XUVM=
X-Received: by 2002:a17:907:3e18:b0:c12:a330:b92b with SMTP id
 a640c23a62f3a-c12aa14aac6mr6173366b.40.1782886276371; Tue, 30 Jun 2026
 23:11:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260630065735.3341614-1-pawlik.dan@gmail.com> <akOCJI-2kAAwOQzz@chamomile>
In-Reply-To: <akOCJI-2kAAwOQzz@chamomile>
From: Daniel Pawlik <pawlik.dan@gmail.com>
Date: Wed, 1 Jul 2026 08:11:05 +0200
X-Gm-Features: AVVi8CfA9uhypD8RuUIaiCQhrLk2tdtBO915kC01GwUewd1n6TYEXO1SRl3IXQQ
Message-ID: <CALC2ApjGZFFPXr4d-r+4VNCpQO1N3Z4NOiBXwYU307jm-626OA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] netfilter: nf_flow_table_path: L2 bridge offload
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org, netdev@vger.kernel.org, 
	bridge@lists.linux.dev, coreteam@netfilter.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Florian, Pablo,

I'll leave it up to you - if `br_netfilter` isn't the right approach
in this case, then we can drop that series.

Before your reply, I wasn't familiar with Eric Woudstra's
"bridge-fastpath" series - thanks for the tip.
I'll take a look at it and try to build on those patches.

Thanks, and best regards,
Dan


wt., 30 cze 2026 o 10:45 Pablo Neira Ayuso <pablo@netfilter.org> napisa=C5=
=82(a):
>
> Hi,
>
> On Tue, Jun 30, 2026 at 08:57:30AM +0200, Daniel Pawlik wrote:
> > This series adds L2 bridge offload support to nft_flow_offload, allowin=
g
> > bridged IPv4/IPv6 flows to be accelerated by the flowtable fast path
> > without requiring L3 routing.
> >
> > Background
> > ----------
> > Hardware flow offload engines (e.g. MediaTek PPE) can accelerate bridge=
d
> > traffic but require that nft_flow_offload detect and handle bridged flo=
ws
> > differently from routed ones: no routing table lookup, MAC addresses fr=
om
> > the Ethernet header, and VLAN context pre-populated from the bridge por=
t.
> >
> > v2: Fix missing Returns: tags in kernel-doc comments for the three new
> >     bridge helpers (br_fdb_has_forwarding_entry_rcu,
> >     br_vlan_get_offload_info_rcu, br_vlan_is_enabled_rcu).
> >
> > Patches
> > -------
> > 1/5  net: export __dev_fill_forward_path
> >      Refactors dev_fill_forward_path() to expose __dev_fill_forward_pat=
h()
> >      which accepts a caller-supplied net_device_path_ctx, needed to
> >      pre-populate VLAN state before the forward path walk.
> >
> > 2/5  net: bridge: add flow offload helpers
> >      Adds br_fdb_has_forwarding_entry_rcu(), br_vlan_get_offload_info_r=
cu()
> >      and br_vlan_is_enabled_rcu() to expose bridge state to nft_flow_of=
fload
> >      without requiring inclusion of net/bridge/br_private.h.
> >
> > 3/5  netfilter: nf_flow_table_path: add L2 bridge offload
> >      Core of the series. Adds nft_flow_offload_is_bridging() detection,
> >      nft_flow_route_bridging() which avoids nf_route() (fails for
> >      bridged-only subnets), MAC/VLAN pre-population for bridged flows,
> >      and a dst leak fix. nft_flow_route() becomes a thin dispatcher.
> >
> > 4/5  netfilter: nf_flow_table_path: handle DEV_PATH_MTK_WDMA in path in=
fo
> >      Fixes zero-source-MAC in PPE entries when a bridged flow traverses
> >      MT7996/MT7915 WiFi WDMA hardware.
> >
> > 5/5  netfilter: nf_flow_table_path: add VLAN passthrough support
> >      Records VLAN encap info for passthrough-mode bridge ports so hardw=
are
> >      offload entries include the correct VLAN tag.
> >
> > Rebase note
> > -----------
> > Originally developed against OpenWrt pending-6.18 patches by Ryan Chen
> > <rchen14b@gmail.com> and Bo-Cun Chen <bc-bocun.chen@mediatek.com>.
> > Rebased to current upstream: path discovery infrastructure moved to
> > nf_flow_table_path.c in commit 93d7a7ed0734 ("netfilter: flowtable: mov=
e
> > path discovery infrastructure to its own file"), so all netfilter chang=
es
> > now land in that file rather than nft_flow_offload.c.
> >
> > How to enable bridge offload
> > -----------------------------
> > 1. Load kmod-br-netfilter so that bridged IP traffic traverses the
> >    netfilter forward chain.
> >
> > 2. Enable netfilter hooks on the bridge:
> >      echo 1 > /sys/class/net/<br>/bridge/nf_call_iptables
> >      echo 1 > /sys/class/net/<br>/bridge/nf_call_ip6tables
>
> This requires br_netfilter which is a no go.
>
> Sorry, but we should really target at the native nf_conntrack_bridge
> support.
>
> > 3. Register bridge member interfaces in the nft flowtable:
> >      table inet filter {
> >          flowtable f {
> >              hook ingress priority filter
> >              devices =3D { eth0, wlan0 }
> >          }
> >          chain forward {
> >              type filter hook forward priority filter
> >              meta l4proto { tcp, udp } flow add @f
> >          }
> >      }
>
> Yes, but br_netfilter makes no sense for nftables.
>
> br_netfilter was made to fill gap at the time ebtables was lagging a
> lot behind iptables in terms of features. And getting ebtables on pair
> with iptables in functionality was not feasible either, because it
> required many new extensions that were specific of the bridge family,
> which probably was not a big deal, but it also required to get
> the ebtables command line tool on pair with iptables userspace, which
> has received more development attention/effort that the bridge tool.
>
> All of this does not stand true anymore with nftables, where the
> bridge family capabilities are at pair with the inet families.
>
> I am looking now at the native flowtable bridge support, I will get
> back to you with updates.
