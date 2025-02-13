Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3343520B209
	for <bridge@lists.linux.dev>; Thu, 13 Feb 2025 08:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739435281; cv=none; b=a6HwnK7Kh9KwsNwt+64cL7o5SbjLahuymQFZYY35YgzUV3iuZQ+sp65UVBRaINaDOvWbAj58aqBocPCIPmzu9+UF2J/AziyKUS3MLsDVaI+QclR86wHsYE/YipYV0X/CfDE8oAadxYSCRXsmWEYTABp7TidsrSmig677gdyGopg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739435281; c=relaxed/simple;
	bh=SyjaIWe3i0tkwC2EB8hBIa5rxw02yA5yYTi3aTzBhxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nFJ9PxK9Ocrl2InyN32M57ftpwC5DqcePItvU3hPL+AZUvpE3GXkurpWEVJJGwazzmq8bqKzil/6zvl7X6N8gA2NPmunkOaBW7gtG1fK6wtjmqYgGSjqnIL1H3MG6V0NuQ0Opar/+PtTnUBfM6HX1LQnWey3obHjpYLpp1f8YfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=la9sxyeU; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="la9sxyeU"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-436ce2ab251so3704355e9.1
        for <bridge@lists.linux.dev>; Thu, 13 Feb 2025 00:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739435278; x=1740040078; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CYDCewrdvYreNRJlqbHeSMs4C/POtyIRcHlnfcP0ZCY=;
        b=la9sxyeUOILQG726mIjwDeT0+xmer8uO2JxZQ/y/3VhWHa6F9f7rn+GOFJ/9nFdG6i
         xsbKhdiliiXqpnwhJkdpb+b/SpBFPnB2IyscLO85cO+vpilpcoAHSopt+z+/jYnM3Nm+
         Oyjow54j99Nx9V9YaVVKk9WAB1X3ZYrUVTrclMd4HwmTGtcmDVkdogUe0BhkWOmcIULY
         XfRGE3NK1WkuJ9yLHa/AkekQkOxZyv9p1kg3ThlfzXqUI5vg0mwMZRTBlcZGFy6wC6SP
         W3gC/eeMu4GMkjzsxrkfZarSEraCrG8M3aeLR9sZ1ls6CHebF9Js7tA08t9Ffwkcc1Hq
         CJbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739435278; x=1740040078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CYDCewrdvYreNRJlqbHeSMs4C/POtyIRcHlnfcP0ZCY=;
        b=rGo4oKe3M8pMFwEFEKMFF01+X5Npc2xWt7Y8G95ztPRVPCVb0bPEDiRStiagwXU06s
         03N55lmZ+HFkmIB4xUeriOhO+/dNGMCdFs6cg02bamTTTgnEtty1ff66Ux1j1aTWolps
         X6b5Jmzf3QOXozsNE4fo1V7KptMag+7GPgp3sMgCMp+pfh6Yxun6I23EyThZV6tycZNJ
         ROI5cXXzvjq7CuDM3ONIz79kYavujKGOdWxMcYWZSmqNHyzzdM9C1en9a5XsiebOu+12
         2SHUzQMxCbwtxUW5ppjqABXaB6WQjQcjv5TjQSR/ehUuUyufFUdQVmVTyopXoQQ+hg7Q
         SS4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXVMcv5WwgYJXmeIYjz8cok6h+koNmNuV3xlGyqCaPKUJM6iOuKPSgGiv5FoIxuHgY7Pt1bIvM=@lists.linux.dev
X-Gm-Message-State: AOJu0YykxfcuEP9+6Y/hPxsCms1mKo1ros+6w03YBUZcCrV1bl0ewMTx
	0LLecyNTggz0QuVN4rE3q2lrzQPJf0l/ksE/vqbTgBLBhgFCXfyYoEHLxqrcnoAAm3EdjqIcCnm
	NltvJL+7tVQUoAFv0hELT8/ZMkA8=
X-Gm-Gg: ASbGncstxUIh4CFar8UwTPmIIpPPWDw8qd+ODlkqgVt35O89MPh03i+XUwzOE57Ma19
	vV6x54iqXjR2APR9GVP52qcdQFLRUc2mn8QKpq8UTknuOxa45+5kYUWuuDbXGlX5wNXewPH8=
X-Google-Smtp-Source: AGHT+IGZE6zJIuhM6pmlASWXo0USdC2hFnASTias2WRNOVzNleb2xd7k0p6fviBFvki3FKkZ15YNMXus/cLozeOxCp8=
X-Received: by 2002:a5d:598e:0:b0:38f:21ce:aa28 with SMTP id
 ffacd0b85a97d-38f21ceb0famr3670345f8f.36.1739435278200; Thu, 13 Feb 2025
 00:27:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250210133002.883422-6-shaw.leon@gmail.com> <20250213062031.4547-1-kuniyu@amazon.com>
In-Reply-To: <20250213062031.4547-1-kuniyu@amazon.com>
From: Xiao Liang <shaw.leon@gmail.com>
Date: Thu, 13 Feb 2025 16:27:21 +0800
X-Gm-Features: AWEUYZkYMDLgFWGQwQihDPwSk4qrLNJu_sLyRJOyUa3GWsERW-M3HJO2WaC6w5g
Message-ID: <CABAhCOSqruMoMTg_=6Apo=gvnfe1j2fptADzoi=Gb8cdJqhgVw@mail.gmail.com>
Subject: Re: [PATCH net-next v9 05/11] net: ip_tunnel: Use link netns in
 newlink() of rtnl_link_ops
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

On Thu, Feb 13, 2025 at 2:20=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> From: Xiao Liang <shaw.leon@gmail.com>
> Date: Mon, 10 Feb 2025 21:29:56 +0800
> > When link_net is set, use it as link netns instead of dev_net(). This
> > prepares for rtnetlink core to create device in target netns directly,
> > in which case the two namespaces may be different.
> >
> > Convert common ip_tunnel_newlink() to accept an extra link netns
> > argument. Don't overwrite ip_tunnel.net in ip_tunnel_init().
>
> Why... ?  see a comment below.
>
>
> [...]
> > diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
> > index 1fe9b13d351c..26d15f907551 100644
> > --- a/net/ipv4/ip_gre.c
> > +++ b/net/ipv4/ip_gre.c
> > @@ -1413,7 +1413,8 @@ static int ipgre_newlink(struct net_device *dev,
> >       err =3D ipgre_netlink_parms(dev, data, tb, &p, &fwmark);
> >       if (err < 0)
> >               return err;
> > -     return ip_tunnel_newlink(dev, tb, &p, fwmark);
> > +     return ip_tunnel_newlink(params->link_net ? : dev_net(dev), dev, =
tb, &p,
>
> This is duplicate at all call sites, let's move it into
> ip_tunnel_newlink() by passing params.
>

Existing tunnels use `params->link_net ? : dev_net(dev)` for
backward compatibility. But I think we can leave the choice of netns
to future tunnel drivers because rtnl_newlink_link_net() is preferred
in general.

>
> > +                              fwmark);
> >  }
> >
> >  static int erspan_newlink(struct net_device *dev,
> >
> >
> > diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
> > index 09b73acf037a..618a50d5c0c2 100644
> > --- a/net/ipv4/ip_tunnel.c
> > +++ b/net/ipv4/ip_tunnel.c
> > @@ -1213,11 +1213,11 @@ void ip_tunnel_delete_nets(struct list_head *ne=
t_list, unsigned int id,
> >  }
> >  EXPORT_SYMBOL_GPL(ip_tunnel_delete_nets);
> >
> > -int ip_tunnel_newlink(struct net_device *dev, struct nlattr *tb[],
> > -                   struct ip_tunnel_parm_kern *p, __u32 fwmark)
> > +int ip_tunnel_newlink(struct net *net, struct net_device *dev,
> > +                   struct nlattr *tb[], struct ip_tunnel_parm_kern *p,
> > +                   __u32 fwmark)
> >  {
> >       struct ip_tunnel *nt;
> > -     struct net *net =3D dev_net(dev);
> >       struct ip_tunnel_net *itn;
> >       int mtu;
> >       int err;
> > @@ -1326,7 +1326,9 @@ int ip_tunnel_init(struct net_device *dev)
> >       }
> >
> >       tunnel->dev =3D dev;
> > -     tunnel->net =3D dev_net(dev);
> > +     if (!tunnel->net)
> > +             tunnel->net =3D dev_net(dev);
>
> Isn't tunnel->net always non-NULL ?
>
> ip_tunnel_newlink
> -> netdev_priv(dev)->net =3D net
> -> register_netdevice(dev)
>   -> dev->netdev_ops->ndo_init(dev)
>     -> ip_tunnel_init(dev)
>       -> netdev_priv(dev)->net =3D dev_net(dev)

Didn't find a path that can leave tunnel->net to NULL either.
I think we can remove this.

Thanks.
