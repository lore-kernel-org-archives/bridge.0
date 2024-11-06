Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FDE1D9A63
	for <bridge@lists.linux.dev>; Wed,  6 Nov 2024 09:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730885951; cv=none; b=d7j8iMvscRwW9EK8IgPPLY1E18wMCFkTex5xYRYnr08nUIORLGoWSrGtbuSv9BgIuDzI6cM1Zi9W38BPeQjrI6Xoe8/YJVXE7dOV6XnUdzJ+MUX9ZpAEn/CNiEXo5jCpkIduY/1jHbHIEc0LO4ulhvjHQrLzfSjsam/ohxzTEFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730885951; c=relaxed/simple;
	bh=xFq6H5Gss2PaZCwqeYcPrMJ1Mp9+Lm1NpbULI16e1Nc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jir7OxL5Q2ZqOzvhxMBl4wSJ7d8mjyhr5EE2EGdl/DSEu8NlhKUACxn23k36MB8SuN2a3N5onzt31cn/n0TDuV9EitPYUGPIuo8koN4tl1Vf+fXg4LOzC93NnQONyVBi6ores8AsM/UEGvnajV3/mLwa0ltjdaZOgwYZFPopDQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N6tbPCMi; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N6tbPCMi"
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-6e390d9ad1dso53204577b3.3
        for <bridge@lists.linux.dev>; Wed, 06 Nov 2024 01:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730885949; x=1731490749; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oinRG9+NhYdFlC3tEh227zzGakOwtuLOqwW6sGXxLbc=;
        b=N6tbPCMiaqtslCD0W9LIsGcfuzkS071KinipXfOHiO62/oW2IsLHxBnvulqXb9m5Wz
         bIqTV54NgPxxPKtaX787BuA0BStu4RVfnBdV+9wKTVnmChorFrx83BJBSWXKu3Tm6pvi
         ZifjSLvcevItZrkFrkbaVnyKThX4Xd7e7I+kFPxZWR9ScoXzgYyDDwea02ddlTnxwwxs
         wrC/nkAfdE6TI8jyEG8rL1rgGn9uKkDhzBuQHE8tkkfjdwPSc8vDGBa0S6i912Gusnj6
         VA/puIx7Eg+sevSDm6ASIwgMMzLIgiWoDwvlYFy7JX1l3BAUXlyWO/ET49EbPfOx2P2b
         maFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730885949; x=1731490749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oinRG9+NhYdFlC3tEh227zzGakOwtuLOqwW6sGXxLbc=;
        b=LMYoF9QcZwx5aolrTRfo5aJdmf4qOMR8ZRMTt+NZvIA7TN+cVwItFC1uo4JbuFR8TZ
         0W2cV/N2DE8zQ/VljsZ6NhKKAxhlyD03E450iWxQ/kT6dl74CVovbcwpi99qzEVcvBg6
         0xMok6FjZ6bssaWvZm/PE2zOTsWWPzpDPuNPeMHC9NY8gscvCjGKXrWIWrQNtClaKeLK
         aVoTw9e8wSGpZe3gmterAam44cwz96R5ieO5skyqv04ABgR/7OWzxn7wz5Dyrv1ZgXmf
         zcHZ2TBt0/PWtYGygd3wpnq1Z/YR5dcfAKHTEKGB0cyuqi7BttxzCKcu/RLI2PSl/Plr
         XOhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBTvl1t4XvOqh2/TJMJSlRInx8Ysd6NnFIsG2FgJotXDpLn/IpXTcWcl/738ym7mjKwnrSxLE=@lists.linux.dev
X-Gm-Message-State: AOJu0YzQfejW/sG76ga13Az5Dr9ysP2eRTeDx5HBucjdU9wZqNaz2KRL
	k5uTuEZ4DVb/tJrn0gTM90qdS0Nojr3o6JYT7BsS/aJJQuYoYzbcVdYroNl2rxk6seh7kfWpN2X
	B60jWZb8becVt1qcCwY3L8h5of4w=
X-Google-Smtp-Source: AGHT+IG/bK8cqy34pOh5Zq5wDFPLa4wQ66r575ctEahwLJo1FJD3pLmUhRA44FtaVQRpsttX0rv0AKr6C/8eLs3MBlw=
X-Received: by 2002:a05:690c:dd2:b0:6dd:d5b7:f35d with SMTP id
 00721157ae682-6ea52525cebmr213814677b3.30.1730885948671; Wed, 06 Nov 2024
 01:39:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241030014145.1409628-1-dongml2@chinatelecom.cn>
 <20241030014145.1409628-7-dongml2@chinatelecom.cn> <62773e8f-884c-4bfe-b412-97ad976f9cb8@redhat.com>
In-Reply-To: <62773e8f-884c-4bfe-b412-97ad976f9cb8@redhat.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Wed, 6 Nov 2024 17:40:16 +0800
Message-ID: <CADxym3adJA1rEHc1GVCmA0_CvuBvMyEF8GOJjm_69uvXhgu9GQ@mail.gmail.com>
Subject: Re: [PATCH RESEND net-next v4 6/9] net: ip: make ip_route_input_noref()
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

On Tue, Nov 5, 2024 at 7:22=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> Hi,
>
> On 10/30/24 02:41, Menglong Dong wrote:
> > @@ -175,10 +175,12 @@ static void ip_expire(struct timer_list *t)
> >
> >       /* skb has no dst, perform route lookup again */
> >       iph =3D ip_hdr(head);
> > -     err =3D ip_route_input_noref(head, iph->daddr, iph->saddr, ip4h_d=
scp(iph),
> > -                                head->dev);
> > -     if (err)
> > +     reason =3D ip_route_input_noref(head, iph->daddr, iph->saddr,
> > +                                   ip4h_dscp(iph), head->dev);
> > +     if (reason)
> >               goto out;
> > +     else
> > +             reason =3D SKB_DROP_REASON_FRAG_REASM_TIMEOUT;
>
> I think the else branch above is confusing - and unneeded.

Yeah, that makes sense.

> Please move the assignment after the comment below, so it's clear why we
> get a TIMEOUT drop reason.

Okay!

Thanks!
Menglong Dong

>
> Thanks,
>
> Paolo
>
