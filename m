Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9E020F06D
	for <bridge@lists.linux.dev>; Thu, 13 Feb 2025 09:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739440573; cv=none; b=c4LlaQvLugNNyEdlLp19Z8cwLTzLYWVCfKvgqNIbrG2dQad3UB6AS8Cr7BrSWx8gegVd3BQrGwpfKOciiOmWOUjZJFW2szS0tqt7QZFVIrAZams60lQMDU5GchFVddRh3XEJgW04UxdvXRZeyaPwHNwDLuit1EAXtbZ1F6oJ5dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739440573; c=relaxed/simple;
	bh=jA7SlTyYhz1+j8HlAbKGMC97RbplB7cAQ05gjyR9wTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ljFqXsZBz/cCTXvyiELCRwK8Yn0EReMcoyN7t180HYamxX/vT5gWOq4RjoU1fRkopJ1nz6dLl9iHFWpoRj24quZLzMxTDM/knz14elGADkUeH92zbQJAAufL0KXGYSm6sBAVHCAG0iixTQSIOgHzqQZjssAP6X2E8IIju0+bN6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZMZD+z42; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZMZD+z42"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43690d4605dso4118975e9.0
        for <bridge@lists.linux.dev>; Thu, 13 Feb 2025 01:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739440570; x=1740045370; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6VgtMhO6+jJX1RjKLdoncmTjEAD+6FhglRm1uezg6DA=;
        b=ZMZD+z42dVGVkNpSZsBHzT/lOH7fXxRoohYalBodzONqb8dzVie863OfJXu5Pbn4Kq
         UHzkqnWW7DS4l1SpODVaFEnUj40Cj51WR0w4uxOvpZw6Y+49xcihZzt6QZNOUm3Pa1km
         oqt439lwCaMIh71KENISMJkpO2fspouzY96V9TVAHKrCIG8PBjTp51gSljn1xHJB4DY3
         atIuk1wRquXCJiPJC3BWpYENma7HktvXvKRqLa0A5RWYfYczES6uG9gF/ESPE19Rh3l5
         Q82icXkhUcgdq/QMwzGPBe20F/gqwSLTXN/9XUmUqyQ+iOEcKaEMKHvCDMETaV8DXIc/
         N+Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739440570; x=1740045370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6VgtMhO6+jJX1RjKLdoncmTjEAD+6FhglRm1uezg6DA=;
        b=Z94S5xN2JAjsD4ZrU1oh+ejMH/IyACfONoSMpBrd98AqdOXzu44C5fZcGXdX8EHeZP
         yt2sBQfFT6ywvfxuJbBzOm9H4BQJhq9rIWhS8QZKgJmn0a9lCUiqCjDhPFTbT6m4pBRR
         BG4Df6NUwPA66Rkid3cwkDvMcaUbIA6T3f6KJphTCo/Ke4AGWxLcHy/0M17bhS449HGS
         DUwjIL6UhmDBkigWwaD6LdSDaTk7oOkk+vlFG9LwBeyuFN2leQzp76XziJM6fNm+wD4L
         GWeg/gV+w1qQ/eDYCY8fOVP+sb6nlm5K85LgIgU+b+ym4BOxZB1nXwwoKE4qLe5PMlkn
         2Ukw==
X-Forwarded-Encrypted: i=1; AJvYcCWLiGowgDzrkAsKZXni7q1zyu/gqffLhCh606hE9vXbVlSGpql0c4RC2fMl+pXe2Vu88kWbZkE=@lists.linux.dev
X-Gm-Message-State: AOJu0YyrPldj9k9bB6bEMU5Au9Ll0gVWjf3DI0L22tKsirCsc7mfM3Gf
	XAYwV57IowisvAGGxPtZqdYQG95Wf2z3aG6i/mtE+x3o7iYIOLMwoSV/sIveqVUWXyjO/OebvPJ
	RYgwbCE61hpNWq0lRkIcScgtfA1Y=
X-Gm-Gg: ASbGncvUYPVgicBz9lYtrc6d6hUcUZAaEnNm9ui7J87E2Y13kx0lMnc0Zk+kaNcxc15
	H+0QD3YoU3W+VdN2TKOgvWUKm6Fbg2iXijLhsj/l7mYVn1FiHhbuPmF41plbSInMHy7ZCnr8=
X-Google-Smtp-Source: AGHT+IF4vz9ZMNWiLlURtMBrw7f64+VQaaApf4FQsQ85yq8rGSoIhlhaKmw+1l1LVh0uOeuQn3pwG9KU0hl60Rc/heo=
X-Received: by 2002:a5d:5889:0:b0:38f:24f9:8bac with SMTP id
 ffacd0b85a97d-38f24f9912fmr1885857f8f.23.1739440569419; Thu, 13 Feb 2025
 01:56:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250210133002.883422-7-shaw.leon@gmail.com> <20250213070533.9926-1-kuniyu@amazon.com>
 <CABAhCOT8sCV4RgBWwfYjCw2xoZbdiYG8yuWReigx-u5DibTaiA@mail.gmail.com>
In-Reply-To: <CABAhCOT8sCV4RgBWwfYjCw2xoZbdiYG8yuWReigx-u5DibTaiA@mail.gmail.com>
From: Xiao Liang <shaw.leon@gmail.com>
Date: Thu, 13 Feb 2025 17:55:32 +0800
X-Gm-Features: AWEUYZkW9l6r7KSPGBGbQx_PCRCw6eQRHHUgG_KYRCauok2SpPFULcU0b728Vqw
Message-ID: <CABAhCORgi7Jqu=Aigs6Fc8ewG5OshFvcunye03R43C+Z0ojZyw@mail.gmail.com>
Subject: Re: [PATCH net-next v9 06/11] net: ipv6: Use link netns in newlink()
 of rtnl_link_ops
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: alex.aring@gmail.com, andrew+netdev@lunn.ch, 
	b.a.t.m.a.n@lists.open-mesh.org, bpf@vger.kernel.org, bridge@lists.linux.dev, 
	davem@davemloft.net, donald.hunter@gmail.com, dsahern@kernel.org, 
	edumazet@google.com, herbert@gondor.apana.org.au, horms@kernel.org, 
	kuba@kernel.org, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-ppp@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-wpan@vger.kernel.org, miquel.raynal@bootlin.com, netdev@vger.kernel.org, 
	osmocom-net-gprs@lists.osmocom.org, pabeni@redhat.com, shuah@kernel.org, 
	stefan@datenfreihafen.org, steffen.klassert@secunet.com, 
	wireguard@lists.zx2c4.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 4:37=E2=80=AFPM Xiao Liang <shaw.leon@gmail.com> wr=
ote:
>
> On Thu, Feb 13, 2025 at 3:05=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.=
com> wrote:
> >
> [...]
> > > diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
> > > index 863852abe8ea..108600dc716f 100644
> > > --- a/net/ipv6/ip6_gre.c
> > > +++ b/net/ipv6/ip6_gre.c
> > > @@ -1498,7 +1498,8 @@ static int ip6gre_tunnel_init_common(struct net=
_device *dev)
> > >       tunnel =3D netdev_priv(dev);
> > >
> > >       tunnel->dev =3D dev;
> > > -     tunnel->net =3D dev_net(dev);
> > > +     if (!tunnel->net)
> > > +             tunnel->net =3D dev_net(dev);
> >
> > Same question as patch 5 for here and other parts.
> > Do we need this check and assignment ?
> >
> > ip6gre_newlink_common
> > -> nt->net =3D dev_net(dev)
> > -> register_netdevice
> >   -> ndo_init / ip6gre_tunnel_init()
> >     -> ip6gre_tunnel_init_common
> >       -> tunnel->net =3D dev_net(dev)
>
> Will remove this line.

However, fb tunnel of ip6_tunnel, ip6_vti and sit can have
tunnel->net =3D=3D NULL here. Take ip6_tunnel for example:

ip6_tnl_init_net()
    -> ip6_fb_tnl_dev_init()
    -> register_netdev()
        -> register_netdevice()
            -> ip6_tnl_dev_init()

This code path (including ip6_fb_tnl_dev_init()) doesn't set
tunnel->net. But for ip6_gre, ip6gre_fb_tunnel_init() does.
