Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2317E2BB09
	for <bridge@lists.linux.dev>; Tue, 22 Oct 2024 08:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729586817; cv=none; b=S6AF5Vxc0TJGkYpCaPDHJT4eNErRZcTVGwgCzQGEeh2AhoJrAft3pMJgEhq9QJif+WyCDJiac+0DysJW1Z038uaf/FVRdfaL9zUL1L3cv09J3iCx5TKKmb3PCyvkOti5njmcqi0XSwL072SLiaQyh/Bt4GKxZAR/dtZMoTA7sGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729586817; c=relaxed/simple;
	bh=KoxzzeJo6etocqx2b/o+OlOXOv6uNN7rqTozMtP8LX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZEd5JBzbFyduy/ee3uvUW0eH+8AuEuZdONDvsCB2D2sR0LeBwD1UihB1CaUqmWRqHiMKTOE9SD2gF+JTyJKLDzN2FPgMm7iQchtEACxMwu9V3ZJZqLrgrkSZDrc++oAI3ANIgHLFoSxFPjuxx6auN4VPA5DumJkbSrD8wMm49Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XSRGt1i0; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XSRGt1i0"
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-6e3d7e6f832so51499407b3.0
        for <bridge@lists.linux.dev>; Tue, 22 Oct 2024 01:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729586815; x=1730191615; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UUFrYT1eNOid4dqFuQyZap0oTpnRGPS1wGDonRnbV+Y=;
        b=XSRGt1i03s3lkXlTti6R5WJAv4Jqnn2BryV0vznGS9kNUE6jtiEZqhgxvA7PH5CvTj
         3kas0+i6dnhyBZDUoAGn0FM/HY4tAjy4TjWcSQpmUPsqLECLeskgVdQhllJIVVyiJTeo
         c++rLF8PZs7K4NgOxor+/EFh+bLIaCty9dxKkRU6cPPW0RsmCcIfSU8Xf3Ae3+AUoWIN
         tUbxLMv2nI0q56G7WbGahNsFyy+gYcKojIu7u3C/0nHbl1mCNKgFmQnx7lU00xmOtk7U
         aNHHI0rN//aTEJqK+NgqlL2iIPqCOfEeSR5OcBJG8KQSTK4J2vqEsx+uWDc9gRYF+5Fy
         QG8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729586815; x=1730191615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UUFrYT1eNOid4dqFuQyZap0oTpnRGPS1wGDonRnbV+Y=;
        b=avMQ63YEQ+m7TED0O+M+nWEtZkie1NzzZ+tU3CARYiLYC2531z5ku6V3YdHfBCRYMB
         W3H1soMlE6M6j5mW+vTf0b6mc96hWPXR+zeDUQ+V7pEM6aMJzg1IFCGL1+i9p7oEDZmY
         4wEw/7n8JZb1XWwGoL8WSBwBbIBoVN2zh39D13n8vF9xTaH6PuAzSBGrUaFoYMTGTLIu
         55MUIN1VbTxmUIoR6LcWWpitH4RWM9Hu6P4SZnZxflggfQeSWNfxydP+pBg993iqQB4C
         0CRYr7ud6lnpeN6uPVa5kYgCmX8j65yRUQWl67+SCoPxdxeXHr/a0MWafa2w3oinAC3z
         btQA==
X-Forwarded-Encrypted: i=1; AJvYcCWhHSiDxw0ZUKhyRyp378nmUyXj4lXGj0y/BJgb2goORhTI/WrUwAFvcpLF9GXTp1I0CF03e/c=@lists.linux.dev
X-Gm-Message-State: AOJu0YzDl9V1N00LZZ7uAgbzfG9MQXFt6qYXJL9fFO53UaNSJZhmLh45
	Dl9qAVfhP2trdzkUdqhd6PaaVlSZh2snxlDN7ytq7sYQp3/55AdBiwWdZhX2UhrpoCXxLaKQ6XK
	dp4TwbzuC9YlBnO+6BqNX/+dMuItLOcktnlo=
X-Google-Smtp-Source: AGHT+IGa70DbIzj17jnQMKvxrqZzKAIwpBsupiT5kH056AnnXaak0bg1EodNANRT8iYvRLR4hMiz9fU4XeAZxEwSSaU=
X-Received: by 2002:a05:690c:f8f:b0:6d3:f9a6:e29c with SMTP id
 00721157ae682-6e5bf9a0846mr134520257b3.12.1729586814908; Tue, 22 Oct 2024
 01:46:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241015140800.159466-1-dongml2@chinatelecom.cn>
 <20241015140800.159466-3-dongml2@chinatelecom.cn> <71a20e24-10e8-42a8-8509-7e704aff9c5c@redhat.com>
In-Reply-To: <71a20e24-10e8-42a8-8509-7e704aff9c5c@redhat.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Tue, 22 Oct 2024 16:47:50 +0800
Message-ID: <CADxym3b6gat7Xs20oN12xsYNSGM3zaJkGirzGv57jA-+Kyr7+A@mail.gmail.com>
Subject: Re: [PATCH net-next v3 02/10] net: ip: make fib_validate_source()
 return drop reason
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	dsahern@kernel.org, pablo@netfilter.org, kadlec@netfilter.org, 
	roopa@nvidia.com, razor@blackwall.org, gnault@redhat.com, 
	bigeasy@linutronix.de, idosch@nvidia.com, ast@kernel.org, 
	dongml2@chinatelecom.cn, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	bridge@lists.linux.dev, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 6:20=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 10/15/24 16:07, Menglong Dong wrote:
> > diff --git a/include/net/ip_fib.h b/include/net/ip_fib.h
> > index 90ff815f212b..b3f7a1562140 100644
> > --- a/include/net/ip_fib.h
> > +++ b/include/net/ip_fib.h
> > @@ -452,13 +452,16 @@ int __fib_validate_source(struct sk_buff *skb, __=
be32 src, __be32 dst,
> >                         dscp_t dscp, int oif, struct net_device *dev,
> >                         struct in_device *idev, u32 *itag);
> >
> > -static inline int
> > +static inline enum skb_drop_reason
> >  fib_validate_source(struct sk_buff *skb, __be32 src, __be32 dst,
> >                   dscp_t dscp, int oif, struct net_device *dev,
> >                   struct in_device *idev, u32 *itag)
> >  {
> > -     return __fib_validate_source(skb, src, dst, dscp, oif, dev, idev,
> > -                                  itag);
> > +     int err =3D __fib_validate_source(skb, src, dst, dscp, oif, dev, =
idev,
> > +                                     itag);
> > +     if (err < 0)
> > +             return -err;
> > +     return SKB_NOT_DROPPED_YET;
> >  }
>
> It looks like the code churn in patch 1 is not needed??? You could just
> define here a fib_validate_source_reason() helper doing the above, and
> replace fib_validate_source with the the new helper as needed. Would
> that work?
>

Of course, that works fine. I'm just trying to find a graceful way
for this part. Defining a fib_validate_source_reason() here looks
nice too, and we can ignore the 1st patch. I'll do it this way in
the next version.

Thanks!
Menglong Dong

> > @@ -1785,9 +1785,10 @@ static int __mkroute_input(struct sk_buff *skb, =
const struct fib_result *res,
> >               return -EINVAL;
> >       }
> >
> > -     err =3D fib_validate_source(skb, saddr, daddr, dscp, FIB_RES_OIF(=
*res),
> > -                               in_dev->dev, in_dev, &itag);
> > +     err =3D __fib_validate_source(skb, saddr, daddr, dscp, FIB_RES_OI=
F(*res),
> > +                                 in_dev->dev, in_dev, &itag);
> >       if (err < 0) {
> > +             err =3D -EINVAL;
> >               ip_handle_martian_source(in_dev->dev, in_dev, skb, daddr,
> >                                        saddr);
>
> I'm sorry for not noticing this issue before, but must preserve (at
> least) the -EXDEV error code from the unpatched version or RP Filter MIB
> accounting in ip_rcv_finish_core() will be fooled.
>
> Thanks,
>
> Paolo
>
