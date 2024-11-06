Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF1C1DF97D
	for <bridge@lists.linux.dev>; Wed,  6 Nov 2024 11:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730894293; cv=none; b=nNuIg1eFw+EuIJgRkjIm76UE1auoAq+MLph6GMPEh0Ep2cTaDRiSm8ZU+/fZb3W+x7L0+7Wq0RoChqhNvNJrMksbNSuWAJys4KpR7hOqOz5RUBEj5tvINS1WIH7QqNdxga/VmJX++tIMfADZaTLb6N9urFtQOx9EpLc5OkybUSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730894293; c=relaxed/simple;
	bh=lPtdyFjSX7/UnqsyuM5h54naOd6rYeJQC1kkvUSDPdg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C+MktolMKXMqHgoJ+yU6S8/UMWHahDlaOqsbdZ8LCCoYr7wGpIbqmo28XVDLH6xkOXSXtBJ4PFwlqsEcHUwROKETRc3mQLdchG7SWdEqeb07UuMJs1+G5c1lbwlTsgBTsoEOWQSoi8ncKfU8T9Zb8N0Q7lKdPUDKPsQPwWIblwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ihin67up; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ihin67up"
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-6ea053b5929so54932497b3.0
        for <bridge@lists.linux.dev>; Wed, 06 Nov 2024 03:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730894290; x=1731499090; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VAqjHxmUrO89VjVjpuY++87pz4fEOVeyoRet1eIwJ2o=;
        b=ihin67up/yZrfT/YOp8mD5/AVZAM5a2Vt1m0G8QS3mjDDqQdqkHfKrCbAeh9mt3qBm
         Rp621whd+F6AHoHGtjAOfbaDBkGmLRYA0M3FmOkcpmV1lgwVIMfcmeAlDNe1q27xBHr+
         jl8g+eFxKdyaea0KfXFr/mAv4k+c6VXjWh3vnKUwEzm4m0yenNoyCRn55HSc0lusaQZO
         gHCffsfmpwVWxUi1cOI4H0YwV+1HgJz/uTCqf11fdzJ50K1NILhfPPotEt2tHp2Ch0Jq
         KSTLrTP4ov+FVjFp+bMFvB53V61aiwUJF/oRmmNVlOJoH73OQ5juu+VTkdtDuuJ+jH8e
         g3vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730894290; x=1731499090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VAqjHxmUrO89VjVjpuY++87pz4fEOVeyoRet1eIwJ2o=;
        b=U3yDrqkazBZPvkYJBkPW14IykqOYKL58JEjMlAaKjk8wPBy4Kf6vhVN7ByAl0UtgHH
         cCAdIzv9w8c8nqtn5ILH+K7BSOYkTwVGvCkrUJ3De6O3G6donmJxDXg4d+K6ZmxhvhPv
         wIqbaVBXiXb0bKTwlAsyfyEdGC/GsGQzphwa1PgqVbsw+1HG1hvb93GQna56G7F9y+lz
         RPDdvUQEQQjWQ7EfdIPI7s8mfNeYFoiQkKrsDxid5e2Q+eaLVtq4NSUlqzqb2t0q94Dp
         ZZ8qk3L90+utyKlVTsCg/XLLR3IYiPgRJhTKiI4uhtOb1kl5HoTDxWNrEkd3FYT4QjeJ
         ysKQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6Yh5993k/ipfs/SJCeqkwQkmJf23gZ5w1+CXD7TlVAifApUpLgYcNCvCsiX7+4L6ZZWS0qXo=@lists.linux.dev
X-Gm-Message-State: AOJu0YycR82zXuuuWF6JKnU0KUD4Dcotr/X7wWXm4cZevsVgCgHyENT5
	4NCGEACfqSXsGqtgAMXjQIZLYfYk/SCbSPyCbhrIPT/qHgHcI4y3EMUllx4VXxWlcoF4u2Bx2Zr
	nb66AcEmNJTt1c6q+jceaimM2ciU=
X-Google-Smtp-Source: AGHT+IEicBeNuuKcBuxj8PHbVAzeh5q36ut7RhJLw1zsm8LW4+5N2cnbcMPl7qD+TVVga0oNtp2Xo5uEhULkgazh6rI=
X-Received: by 2002:a05:690c:6c88:b0:6e3:3dbc:ca60 with SMTP id
 00721157ae682-6ea64a9f24bmr191545627b3.8.1730894290438; Wed, 06 Nov 2024
 03:58:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241030014145.1409628-1-dongml2@chinatelecom.cn>
 <20241030014145.1409628-10-dongml2@chinatelecom.cn> <8f83725e-1ea9-438f-8ab1-ff528ca761fb@redhat.com>
In-Reply-To: <8f83725e-1ea9-438f-8ab1-ff528ca761fb@redhat.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Wed, 6 Nov 2024 19:59:18 +0800
Message-ID: <CADxym3YK5QYHs8oFwY8FQdcpuQSSY5N=Pj8N40U+vaUdi4er-w@mail.gmail.com>
Subject: Re: [PATCH RESEND net-next v4 9/9] net: ip: make ip_route_use_hint()
 return drop reasons
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	horms@kernel.org, dsahern@kernel.org, pablo@netfilter.org, 
	kadlec@netfilter.org, roopa@nvidia.com, razor@blackwall.org, 
	gnault@redhat.com, bigeasy@linutronix.de, hawk@kernel.org, idosch@nvidia.com, 
	dongml2@chinatelecom.cn, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	bridge@lists.linux.dev, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 7:28=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On 10/30/24 02:41, Menglong Dong wrote:
> > diff --git a/net/ipv4/route.c b/net/ipv4/route.c
> > index e248e5577d0e..7f969c865c81 100644
> > --- a/net/ipv4/route.c
> > +++ b/net/ipv4/route.c
> > @@ -2142,28 +2142,34 @@ ip_mkroute_input(struct sk_buff *skb, struct fi=
b_result *res,
> >   * assuming daddr is valid and the destination is not a local broadcas=
t one.
> >   * Uses the provided hint instead of performing a route lookup.
> >   */
> > -int ip_route_use_hint(struct sk_buff *skb, __be32 daddr, __be32 saddr,
> > -                   dscp_t dscp, struct net_device *dev,
> > -                   const struct sk_buff *hint)
> > +enum skb_drop_reason
> > +ip_route_use_hint(struct sk_buff *skb, __be32 daddr, __be32 saddr,
> > +               dscp_t dscp, struct net_device *dev,
> > +               const struct sk_buff *hint)
> >  {
> > +     enum skb_drop_reason reason =3D SKB_DROP_REASON_NOT_SPECIFIED;
> >       struct in_device *in_dev =3D __in_dev_get_rcu(dev);
> >       struct rtable *rt =3D skb_rtable(hint);
> >       struct net *net =3D dev_net(dev);
> > -     enum skb_drop_reason reason;
> > -     int err =3D -EINVAL;
> >       u32 tag =3D 0;
> >
> >       if (!in_dev)
> > -             return -EINVAL;
> > +             return reason;
> >
> > -     if (ipv4_is_multicast(saddr) || ipv4_is_lbcast(saddr))
> > +     if (ipv4_is_multicast(saddr) || ipv4_is_lbcast(saddr)) {
> > +             reason =3D SKB_DROP_REASON_IP_INVALID_SOURCE;
> >               goto martian_source;
> > +     }
> >
> > -     if (ipv4_is_zeronet(saddr))
> > +     if (ipv4_is_zeronet(saddr)) {
> > +             reason =3D SKB_DROP_REASON_IP_INVALID_SOURCE;
> >               goto martian_source;
> > +     }
> >
> > -     if (ipv4_is_loopback(saddr) && !IN_DEV_NET_ROUTE_LOCALNET(in_dev,=
 net))
> > +     if (ipv4_is_loopback(saddr) && !IN_DEV_NET_ROUTE_LOCALNET(in_dev,=
 net)) {
> > +             reason =3D IP_LOCALNET;
> >               goto martian_source;
> > +     }
> >
> >       if (rt->rt_type !=3D RTN_LOCAL)
> >               goto skip_validate_source;
>
> Please explicitly replace also the
>
>         return 0;
>
> with
>
>         return SKB_NOT_DROPPED_YET;
>
> So that is clear the drop reason is always specified.

Okay!

Thanks!
Menglong Dong


> Thanks,
>
> Paolo
>
