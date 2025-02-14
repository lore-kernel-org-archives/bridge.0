Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B661E502
	for <bridge@lists.linux.dev>; Fri, 14 Feb 2025 09:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739524989; cv=none; b=gSSXQ8apqnM4Tm6SMkEQ2zsKf+Tgd0e89+oYpDqvNnS27tZeXLZiYDAToGIfyNAb5rAxPSgceUinM6eR5ecZ+CJHpFBSja8mV3Rk2GgF6OqHD9XfDXUpFRoTIWlxYC6l+gDgDjD91FKIJ9+QWUF+4k4/Niz4ZRaSMRWq3V4+aqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739524989; c=relaxed/simple;
	bh=+h2GkDj+OoeHXnuD3ME91MATvB8iz1ermwPdmsLVLQg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jHtPFM3/1qY4pRfIWbNR7TJ95kJXF97jommWMs0YaJx2tWN/kDtzeIv5ViB1HdXIBYYojA07hLiVLmwPXaOMtF71hwzobu4KEeT0af1IeF/D/h6PqPD+vg28sQme/fntyLcGX00o93A+h443IEg052mRSEQnxg2LaK4vUxITZrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K39OfkxO; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K39OfkxO"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-38dd91c313bso1035073f8f.3
        for <bridge@lists.linux.dev>; Fri, 14 Feb 2025 01:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739524986; x=1740129786; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k7BNqikEMUFZIk3bGCtvMWc4aGoto03Aq8Yw25jOfXg=;
        b=K39OfkxO/9rkoHasormyxXrgfBBK7r2e1fcb1nSEs2RvkUb+Mb4D9RvXnRNyl72Df7
         GjaMfjY4LtOptwBljvtSaDHtJT/bo+yuFnbo7pbuVWFqlFJ78Wxc0c1CoS1ZEShV9mDw
         MIniS9vmeEVHrXi5N9x8GFouzb0e7nODfXGWbAfulSeHdo/YZLODDzOLB0l5D2uk/TtP
         fZdTTtwP0Nm0BPNVaaRf3y9LmC/aRb0O1qMNj/vGZ3NsbvFHs3t7wLk6t7z9qVG4QB1l
         gwIiJZwjIDybQtPSd1WHS/Z1+tu+zWHfartS06z5A6BZzqvJBiDyoPZMLpqso0FmwFiR
         SVow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739524986; x=1740129786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k7BNqikEMUFZIk3bGCtvMWc4aGoto03Aq8Yw25jOfXg=;
        b=qcw/yryGJs+CIqYq5tGE7z8wPg3PByx71X5yHfzgDkLvdVFuNvtUB+j7U3fyf8ZWqI
         C1L+e4a2+VXn2QP9lCpa+xnxmsORCr9PUKQ7shKM545NmnXrzKh2YCf30QpEv8cRwqoB
         WJkJI6Zjpqbs8tBvIfywdtERAEUx2K+hNBQzeCjE3dMT964lV0477krjxrwEVdGrJnA7
         j7xTyDg0rb89zI9XOu90EGbioX7tsbXh2V/qBfEaeFGCUA90oCOtjL668zZeEXowyqm0
         PraJQHbXz8INyK5cdfzG1EyDH4OoLNlQCLqU719XrTdjEpojqrfV29TuBw4JPIEkJQt1
         Wt3g==
X-Forwarded-Encrypted: i=1; AJvYcCW1hCn/e3rUQOZJDnmvj0BPfY1mpTG1aTr106m1wNs1PGaIpMsE7pUCqqDTwFUcScX0iiEPjtY=@lists.linux.dev
X-Gm-Message-State: AOJu0YyCfC64/zs5JXMG8RpnJwhNfxJQ70hm8XWcdaBwoAGPxJP4XSo6
	c3CfH5i1dffmrmzD9YiFq2SJdyyni9wohNuGjs14toke/T3bUJH2sh2KfgltXvW2S849sNabNRR
	xDBmagrzAGSb8/yJyvNkmlmmIC2I=
X-Gm-Gg: ASbGncuEwzKXn7vMSpe280JcmC8JNRygeQ2tUDGdQIEspRFiyqZpEwebC7kaSNtziS9
	yzR28RPWv1K2Z9eXMMJ2wcd7q1DtEjqzwzVdxcixKVvezyKPdQmmdhkX4MIS0WU574bhhr0A=
X-Google-Smtp-Source: AGHT+IFc4q5LtCR4oH56B/JnsUWjOnr2P8qnhLaQaAQF/xsTMWgc84lPizP0lboCQWCd1BP4FsSRkQxEWx0I5MF+EcM=
X-Received: by 2002:a05:6000:18ae:b0:38f:23bc:c19e with SMTP id
 ffacd0b85a97d-38f23bcc233mr9719529f8f.29.1739524985787; Fri, 14 Feb 2025
 01:23:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CABAhCORgi7Jqu=Aigs6Fc8ewG5OshFvcunye03R43C+Z0ojZyw@mail.gmail.com>
 <20250213110004.38415-1-kuniyu@amazon.com>
In-Reply-To: <20250213110004.38415-1-kuniyu@amazon.com>
From: Xiao Liang <shaw.leon@gmail.com>
Date: Fri, 14 Feb 2025 17:22:28 +0800
X-Gm-Features: AWEUYZmC-_4d4WbO4zj0CDnf9myDuv_5df2UqBnW8RiGwAq7tiZ7QonxxL4s5P4
Message-ID: <CABAhCOSsZqzrsqct+c613TVhGJdubv+_wTDxmjH8z6-PL1Mu2A@mail.gmail.com>
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

On Thu, Feb 13, 2025 at 7:00=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> From: Xiao Liang <shaw.leon@gmail.com>
> Date: Thu, 13 Feb 2025 17:55:32 +0800
> > On Thu, Feb 13, 2025 at 4:37=E2=80=AFPM Xiao Liang <shaw.leon@gmail.com=
> wrote:
> > >
> > > On Thu, Feb 13, 2025 at 3:05=E2=80=AFPM Kuniyuki Iwashima <kuniyu@ama=
zon.com> wrote:
> > > >
> > > [...]
> > > > > diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
> > > > > index 863852abe8ea..108600dc716f 100644
> > > > > --- a/net/ipv6/ip6_gre.c
> > > > > +++ b/net/ipv6/ip6_gre.c
> > > > > @@ -1498,7 +1498,8 @@ static int ip6gre_tunnel_init_common(struct=
 net_device *dev)
> > > > >       tunnel =3D netdev_priv(dev);
> > > > >
> > > > >       tunnel->dev =3D dev;
> > > > > -     tunnel->net =3D dev_net(dev);
> > > > > +     if (!tunnel->net)
> > > > > +             tunnel->net =3D dev_net(dev);
> > > >
> > > > Same question as patch 5 for here and other parts.
> > > > Do we need this check and assignment ?
> > > >
> > > > ip6gre_newlink_common
> > > > -> nt->net =3D dev_net(dev)
> > > > -> register_netdevice
> > > >   -> ndo_init / ip6gre_tunnel_init()
> > > >     -> ip6gre_tunnel_init_common
> > > >       -> tunnel->net =3D dev_net(dev)
> > >
> > > Will remove this line.
> >
> > However, fb tunnel of ip6_tunnel, ip6_vti and sit can have
> > tunnel->net =3D=3D NULL here. Take ip6_tunnel for example:
> >
> > ip6_tnl_init_net()
> >     -> ip6_fb_tnl_dev_init()
> >     -> register_netdev()
> >         -> register_netdevice()
> >             -> ip6_tnl_dev_init()
> >
> > This code path (including ip6_fb_tnl_dev_init()) doesn't set
> > tunnel->net. But for ip6_gre, ip6gre_fb_tunnel_init() does.
>
> Ah, okay.  Then, let's set net in a single place, which would
> be better than spreading net assignment and adding null check
> in ->ndo_init(), and maybe apply the same to IPv4 tunnels ?

Tunnels are created in three ways: a) rtnetlink newlink,
b) ioctl SIOCADDTUNNEL and c) during per netns init (fb).
The code paths don't have much in common, and refactoring
to set net in a single place is somewhat beyond the scope
of this series. But for now I think we could put a general rule:
net should be set prior to register_netdevice().

For IPv4 tunnels, tunnel->net of a) is set in ip_tunnel_newlink().
b) and c) are set in __ip_tunnel_create():
ip_tunnel_init_net() -> __ip_tunnel_create()
ip_tunnel_ctl() -> ip_tunnel_create() -> __ip_tunnel_create()
So net has already been initialized when register_netdevice()
is called.

But it varies for IPv6 tunnels. Some set net for a) or c) while
some don't. This patch has "fixed" for a). As for c) we can
adopt the way of ip6_gre - setting net in *_fb_tunnel_init(),
then remove the check in ndo_init().

Is it reasonable?

Thanks.
