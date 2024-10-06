Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AA7101F2
	for <bridge@lists.linux.dev>; Sun,  6 Oct 2024 17:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728235487; cv=none; b=ml+H0uij98adKn1f0SALXmJyZu+5Q50q67KKhHcJDpRh0N68j/0xPpnd0GWSMEH4RfeZT1cbcYdcSHOncQujbFehtAy3Ef+L2jbyHWSDh0X7ib9AL8YIu2JLqOhzcxDvWLqAbJOBMt5ksTa6fnRFiq07KSpgFzGVeZml0B4LxRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728235487; c=relaxed/simple;
	bh=2fGz3KDCfRGPhSy/5QFDgAdl2Tf/XHGIHJZ5BSKta64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CWg84jblvpg/LSv4Tv7GbgY01ktJOpwixNBnY4sFyCTHm7WwYDRtCIo4EjJ0pZl2sosGj/2dAS44+8qXv6hcbVMq+YgHTFeEootuYcAn8u3YOy5solHJjn3MjXIu1h2AKOPIw/5bno8QD6esg39RV8NKHJO6P9Uahuzh92bQ9FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ilevdz3R; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ilevdz3R"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2e199b1d157so2676380a91.2
        for <bridge@lists.linux.dev>; Sun, 06 Oct 2024 10:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728235486; x=1728840286; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xbYAwkvWDSG9D9+tHniJsFSvQn8xIlp1Sld5HghW6Ws=;
        b=Ilevdz3RQ0LhyscCdOs5WZUmpWIrFXWDg736WScPKcTuuDfIo2fYWf1ysoTqryHPsW
         yzGQVdmqSI6ObfA8MSt64yJhhoGSk3hnQG7CCI89NVm9FmUz22fLJcLIkwH8tDhb4LBt
         WvHAdpbM94RLysvki7v5qfjWTl/4OkZJBA4psAtBsQaKH52Mj2UKCi0Yha2IN1jxmxcz
         N72ZdKOb8Z4niDkKBJgM1D8oA1nrYzBFjVPzriYasLUPHwC9sPjAFWKAZ2YdekJdTEjF
         Kr0Aa4DvUKBnsgkIeqPfLU2gJh0E8JtPk4x1S8pT08pOSQh40s+FUHAzCLKkj0ph/LJy
         tsgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728235486; x=1728840286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xbYAwkvWDSG9D9+tHniJsFSvQn8xIlp1Sld5HghW6Ws=;
        b=dHMHOW+PsgwSDAQR2hBdw5a1WJeEHiMXTS2oiLyLz5NWxsPMMWcKCfskQKvXd+2OdM
         XhOhhmUri//pDhGR8Uv4MOAw2NP0DwNiiq63pR7j0GmOumR24UcqHpnrUVPeCYuAWk6x
         gDGjLCDhIi967oZk29VALf4Ys4UVwB6lItdqkMjQ4PYtDbN68sNI2IpD4XPAMzm711OG
         //cIgI6GBIVYycxnZcmvaYTll+XpKg5V7C5rrWkb+XCfBuFbLLmN6cRTXd+kZXpkwJ1f
         7c9YawgrFPPgcAIcct+Bi5/kwev/FT5FZqUAlUc6khZHatCTScVQScc+IMIwhIX8Tzpz
         Q6sw==
X-Forwarded-Encrypted: i=1; AJvYcCXQe/RM97P9CM/HOSapNRz3PRuipesaLwwkd+b+LjpkSAkjy5lbutHQpCydf6YkLKD4671Fbzw=@lists.linux.dev
X-Gm-Message-State: AOJu0YwvHzv4fSmQBrHSsVuq1xEchtexb54or8mn2J91kHZsNQM3VHNm
	f6b71EZ6BhR/dhOGIO756iyil3ZOpAjN6zUwsZ0EJ720cmWCyugFv2FXQm0DbYL5AE97O6iOIFO
	10s1ojuU2iUycFVubLyPVRiqgFx4=
X-Google-Smtp-Source: AGHT+IEKWiJBjLKDIaFaOkfEDPUqRHlD/TfcUp548Ta0mblv55/mAWH4xtREyw4zmdXVZiry7Yu1PYw8VwIpPFTooZw=
X-Received: by 2002:a17:90a:bc92:b0:2e0:9147:7db5 with SMTP id
 98e67ed59e1d1-2e1e63bf552mr10986428a91.38.1728235485708; Sun, 06 Oct 2024
 10:24:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241005014514.1541240-1-ingamedeo@gmail.com> <c06d9227-dcac-4131-9c2d-83dace086a5d@blackwall.org>
In-Reply-To: <c06d9227-dcac-4131-9c2d-83dace086a5d@blackwall.org>
From: Amedeo Baragiola <ingamedeo@gmail.com>
Date: Sun, 6 Oct 2024 10:24:34 -0700
Message-ID: <CAK_HC7bOe2KhVnDiG4Z3tpkodiCkewEct7r2gXanjGBC8WwFsQ@mail.gmail.com>
Subject: Re: [PATCH] bridge: use promisc arg instead of skb flags
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Roopa Prabhu <roopa@nvidia.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	bridge@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Pablo Neira Ayuso <pablo@netfilter.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I agree, just patch actually changes the behaviour when a BR_FDB_LOCAL
dst is found and drops the traffic because promisc is *always* set to
false when a BR_FDB_LOCAL dst is found in br_handle_frame_finish().
I guess the problem I was trying to solve was that since the
introduction of the promisc flag we still use brdev->flags &
IFF_PROMISC in br_pass_frame_up() which is essentially the value of
promisc (except in the BR_FDB_LOCAL case above) instead of promisc
itself.

Amedeo


On Sat, Oct 5, 2024 at 7:06=E2=80=AFAM Nikolay Aleksandrov <razor@blackwall=
.org> wrote:
>
> On 05/10/2024 04:44, Amedeo Baragiola wrote:
> > Since commit 751de2012eaf ("netfilter: br_netfilter: skip conntrack inp=
ut hook for promisc packets")
> > a second argument (promisc) has been added to br_pass_frame_up which
> > represents whether the interface is in promiscuous mode. However,
> > internally - in one remaining case - br_pass_frame_up checks the device
> > flags derived from skb instead of the argument being passed in.
> > This one-line changes addresses this inconsistency.
> >
> > Signed-off-by: Amedeo Baragiola <ingamedeo@gmail.com>
> > ---
> >  net/bridge/br_input.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
> > index ceaa5a89b947..156c18f42fa3 100644
> > --- a/net/bridge/br_input.c
> > +++ b/net/bridge/br_input.c
> > @@ -50,8 +50,7 @@ static int br_pass_frame_up(struct sk_buff *skb, bool=
 promisc)
> >        * packet is allowed except in promisc mode when someone
> >        * may be running packet capture.
> >        */
> > -     if (!(brdev->flags & IFF_PROMISC) &&
> > -         !br_allowed_egress(vg, skb)) {
> > +     if (!promisc && !br_allowed_egress(vg, skb)) {
> >               kfree_skb(skb);
> >               return NET_RX_DROP;
> >       }
>
> This is subtle, but it does change behaviour when a BR_FDB_LOCAL dst
> is found it will always drop the traffic after this patch (w/ promisc) if=
 it
> doesn't pass br_allowed_egress(). It would've been allowed before, but cu=
rrent
> situation does make the patch promisc bit inconsistent, i.e. we get
> there because of BR_FDB_LOCAL regardless of the promisc flag.
>
> Because we can have a BR_FDB_LOCAL dst and still pass up such skb because=
 of
> the flag instead of local_rcv (see br_br_handle_frame_finish()).
>
> CCing also Pablo for a second pair of eyes and as the original patch
> author. :)
>
> Pablo WDYT?
>
> Just FYI we definitely want to see all traffic if promisc is set, so
> this patch is a no-go.
>
> Cheers,
>  Nik



--=20
Thanks,
Amedeo
