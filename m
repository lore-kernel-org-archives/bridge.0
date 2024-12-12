Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377D5213247
	for <bridge@lists.linux.dev>; Thu, 12 Dec 2024 12:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734007307; cv=none; b=neTuPauLB0pk+QoxGjbF1ryRuAmRfhPUe8gnk6Bb+4BSLyUhW6HE++kzk5bXg/j5cHU4e7XapQ7l+Cy5COx5PxuduaQ5WRVe3ZyrB1pihGyMMrmHUANxjkq3AKL8Klx/nhjlmJrjk9Pq8MQ3cyoAG8xW24PBUZEAvieftVYEVZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734007307; c=relaxed/simple;
	bh=jo2gukOfLEvouFNhtdX1Kl6/D7IkbXWRkgRk3E64PLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iRa8uGyxizZveQWF+8FoGjgTUxIErxcudlV7T2ajHb+N6qFHRBvSM4ZTZVm4hGGVFqHVgycC+DWFea6KwIDvaevIclyJGhbD3aE4P7/SYhlkLO8W34IEDOB5h4eryoOCysRrVUzKXMtK8ATlDeXYq0NBu+0l754xfjc67azAhbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YxNtb9nX; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YxNtb9nX"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4361f664af5so6070655e9.1
        for <bridge@lists.linux.dev>; Thu, 12 Dec 2024 04:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734007303; x=1734612103; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UdqXBrFz+MhhB28jjWBHlFWKaOr9dT3/Vp6X30ps4DU=;
        b=YxNtb9nXJ1W0gjI8LtK2VPnPqYnUR6mnLE+Ev5ja3PZ8P+WJz7+4O5SsiZDEnFszXW
         BG7kkOy4hVKh302Wi4OrSjEk3SuzI+sU67MDcbKUJtb5Dgo8MVTgeKcN8ASe+h+VliMR
         eD1bF7bBXw/nLhzhtbUAO1jmEUAIAmgBYMRmFUWhxuommOgQ8kQjp0bcD1kXxuKUEFJX
         5U7rrBvcDAqYzji9eeWT2QQKLJ6YiCs7z+S72nEcb+/mhboGKQWaJ4mLqZZQVHBa/GGQ
         ShTDhFtroI7+qq4Zgr8S6+dOUWlqBdockZYROTPKMwfIDEfWM3vcMdVQbaUxnHT/VPVL
         k/tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734007303; x=1734612103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UdqXBrFz+MhhB28jjWBHlFWKaOr9dT3/Vp6X30ps4DU=;
        b=bJA/6SjChgRU1N+GlPqxF1eRY41tG2gWY5TR3FdUbLgWTuYdLbro+qgeVEwpY5C9be
         0WJe48CH3Ti4tvGGeShJeMn9jBJMkju9FzYfDXXQxesccvYbDsqgRauV2WnoNH97FGuO
         pK9jEV8tJoX3srStjkw98YNMdIzqBhE0pKpAWt7Dzt7hPthdlpj77SnG8VSuF57W/ZKn
         GAcFOIY+MLfpKqRM+hdpHl6XN2yJvX9q28eFkHYWtJfc8Xm+oPZQRdGwaUlG23DkJLrL
         paHTWbm30VJ/AookDc27zRNura9hfEQSYMpmeKigQ/mZWPFtdCqWCJ78i2Z8WrQrDTw0
         m6Jw==
X-Forwarded-Encrypted: i=1; AJvYcCVCdbV20zcBeyb4DHAXtoLKDMIi5R0Bt/fpk3YMWGFDi/xW0Szsp9S7aP6geLGsvICw7J8RcRM=@lists.linux.dev
X-Gm-Message-State: AOJu0YwvU0jSQMuZ9kxvtFsSbj9EZb3V9CGfcnBdeGCxrAG3CySu9dnQ
	p3t8iouHwo/0rX2m64NVv+cLuaNybCOhM9NiI03NNCyrvZ/UithJE1UASXdDjeEjPxwElyQBZt2
	9tA0u4GYXOHz2p00S5jeMFNUBB/4=
X-Gm-Gg: ASbGncsoUy4E9bgtx4CGe+iL3APpXvyUyO7+WsIrJOjwtEjWngU0ov8/gMHAc4Ui9Ue
	dXU5F+tBLb7a0Pd74bIvrLYTVyqP3+g8yceUE
X-Google-Smtp-Source: AGHT+IFqFk9dpKGWg1iKfKEea53yF0KmGIqYqHw17PI/mHu0HdGMd6qhUvlxmt/ZCzWy1qtAEPF2qQKT7Apiv7Ssc/8=
X-Received: by 2002:a05:6000:a0b:b0:385:f44a:a68 with SMTP id
 ffacd0b85a97d-3878769805bmr3014357f8f.35.1734007303234; Thu, 12 Dec 2024
 04:41:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241209140151.231257-1-shaw.leon@gmail.com> <20241209140151.231257-4-shaw.leon@gmail.com>
 <2b89667d-ccd6-40b7-b355-1c71e159d14f@redhat.com>
In-Reply-To: <2b89667d-ccd6-40b7-b355-1c71e159d14f@redhat.com>
From: Xiao Liang <shaw.leon@gmail.com>
Date: Thu, 12 Dec 2024 20:41:06 +0800
Message-ID: <CABAhCOTv1tDOXBEE56CL1-S_J6ADZTcvso5GHtkarzJMqOC4xQ@mail.gmail.com>
Subject: Re: [PATCH net-next v5 3/5] rtnetlink: Decouple net namespaces in rtnl_newlink_create()
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Jakub Kicinski <kuba@kernel.org>, 
	Donald Hunter <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Ido Schimmel <idosch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Jiri Pirko <jiri@resnulli.us>, 
	Hangbin Liu <liuhangbin@gmail.com>, linux-rdma@vger.kernel.org, 
	linux-can@vger.kernel.org, osmocom-net-gprs@lists.osmocom.org, 
	bpf@vger.kernel.org, linux-ppp@vger.kernel.org, wireguard@lists.zx2c4.com, 
	linux-wireless@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, 
	bridge@lists.linux.dev, linux-wpan@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 5:27=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 12/9/24 15:01, Xiao Liang wrote:
> > There are 4 net namespaces involved when creating links:
> >
> >  - source netns - where the netlink socket resides,
> >  - target netns - where to put the device being created,
> >  - link netns - netns associated with the device (backend),
> >  - peer netns - netns of peer device.
> >
> > Currently, two nets are passed to newlink() callback - "src_net"
> > parameter and "dev_net" (implicitly in net_device). They are set as
> > follows, depending on netlink attributes.
> >
> >  +------------+-------------------+---------+---------+
> >  | peer netns | IFLA_LINK_NETNSID | src_net | dev_net |
> >  +------------+-------------------+---------+---------+
> >  |            | absent            | source  | target  |
> >  | absent     +-------------------+---------+---------+
> >  |            | present           | link    | link    |
> >  +------------+-------------------+---------+---------+
> >  |            | absent            | peer    | target  |
> >  | present    +-------------------+---------+---------+
> >  |            | present           | peer    | link    |
> >  +------------+-------------------+---------+---------+
> >
> > When IFLA_LINK_NETNSID is present, the device is created in link netns
> > first. This has some side effects, including extra ifindex allocation,
> > ifname validation and link notifications. There's also an extra step to
> > move the device to target netns. These could be avoided if we create it
> > in target netns at the beginning.
> >
> > On the other hand, the meaning of src_net is ambiguous. It varies
> > depending on how parameters are passed. It is the effective link or pee=
r
> > netns by design, but some drivers ignore it and use dev_net instead.
> >
> > This patch refactors netns handling by packing newlink() parameters int=
o
> > a struct, and passing source, link and peer netns as is through this
> > struct. Fallback logic is implemented in helper functions -
> > rtnl_newlink_link_net() and rtnl_newlink_peer_net(). If is not set, pee=
r
> > netns falls back to link netns, and link netns falls back to source net=
ns.
> > rtnl_newlink_create() now creates devices in target netns directly,
> > so dev_net is always target netns.
> >
> > For drivers that use dev_net as fallback of link_netns, current behavio=
r
> > is kept for compatibility.
> >
> > Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
>
> I must admit this patch is way too huge for me to allow any reasonable
> review except that this has the potential of breaking a lot of things.
>
> I think you should be splitted to make it more palatable; i.e.
> - a patch just add the params struct with no semantic changes.
> - a patch making the dev_change_net_namespace() conditional on net !=3D
> tge_net[1]
> - many per-device patches creating directly the device in the target
> namespace.
> - a patch reverting [1]
>
> Other may have different opinions, I'd love to hear them.

Thanks. I understand your concern. Since the device is created in common
code, how about splitting the patch this way:

 1) make the params struct contain both current src_net and other netns:
        struct rtnl_newlink_params {
                struct net *net;        // renamed from current src_net
                struct net *src_net;    // real src_net
                struct net *link_net;
                ...
        };
 2) convert each driver to use the accurate netns,
 3) remove "net", which is not used now, from params struct,
 4) change rtnl_newlink_create() to create device in target netns
    directly.

So 1) will be a big one but has no semantic changes.
And I will send Patch 1 in this series to the net tree instead.

>
> > diff --git a/drivers/net/amt.c b/drivers/net/amt.c
> > index 98c6205ed19f..2f7bf50e05d2 100644
> > --- a/drivers/net/amt.c
> > +++ b/drivers/net/amt.c
> > @@ -3161,14 +3161,17 @@ static int amt_validate(struct nlattr *tb[], st=
ruct nlattr *data[],
> >       return 0;
> >  }
> >
> > -static int amt_newlink(struct net *net, struct net_device *dev,
> > -                    struct nlattr *tb[], struct nlattr *data[],
> > -                    struct netlink_ext_ack *extack)
> > +static int amt_newlink(struct rtnl_newlink_params *params)
> >  {
> > +     struct net_device *dev =3D params->dev;
> > +     struct nlattr **tb =3D params->tb;
> > +     struct nlattr **data =3D params->data;
> > +     struct netlink_ext_ack *extack =3D params->extack;
> > +     struct net *link_net =3D rtnl_newlink_link_net(params);
> >       struct amt_dev *amt =3D netdev_priv(dev);
> >       int err =3D -EINVAL;
>
> Minor nit: here and and many other places, please respect the reverse
> xmas tree order.

Will fix this.
