Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481ED1C3BE1
	for <bridge@lists.linux.dev>; Tue, 14 Jan 2025 09:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736845401; cv=none; b=BygcYA6lcXsNrc+kynMFv6O38AymJHE9B+Ba+JGaJAptQBeUdGXf2miOD9D7rHTO75POeSrPhNkMFuHE5f7Ib9KtMtgx/C+XJpoKDKSdQfxkLqn03Ky5b3xip9YF0XEiPDxCM+tcPUaYzTzyXYB0dCO6QunvoV2LludDoLaIFvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736845401; c=relaxed/simple;
	bh=QNvuh5EDJiuoHdaCpoRHoR7O5EvfHOckuuZ644v9d00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i5PGQvG4AyzcthDOwLJZnzzuNX3QB/MpzTtvxsUJA6itDrLlypMjPloxfVyRoR+Lc9KID0gAwmhVqPc5ExHygGkNwmnIXcmeVtErjyyMQ4Qc0xnEnV4dKYzxAND395Rx6eLTwX4cwLPSkaxltotcEJW9soal3tsC3FlpgJe4loo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xq7N25ND; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xq7N25ND"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4361c705434so37001205e9.3
        for <bridge@lists.linux.dev>; Tue, 14 Jan 2025 01:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736845398; x=1737450198; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RJdpc5af8GraPbTvgj2FYJk8F44uMY7sTK/kVSc+LHs=;
        b=Xq7N25ND3QYPUMoDz9fbhdpLPJoqZml/BwwwPQLN67DzYQA6/nojUMZ5ThXq+8bQI+
         82lMGiaOTKnzEbZrzBbS5vTHgzQSZ+5HswsQidKiRQi0LsEALnzXtVXvFNlOREzs7qNm
         aaEryv2YGbkDGvLJ5EKMzhBJylNsZJWZwg591yKiEPCMo4f1JDhzrFjwsulIk55aznKO
         rC+Guuq8b2K1D6hJ6Ky3uMIJEiAttm6gWIEmLFOnqYSR70XYcp01EbX5TSx5F3fPhLz4
         H75tTGDPf+IA13ENghFqZR308jf3tqxbAZxhQEQkL9YSg7HZOSkpwzbDq6O845HDm39j
         Ecnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736845398; x=1737450198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RJdpc5af8GraPbTvgj2FYJk8F44uMY7sTK/kVSc+LHs=;
        b=WriI3OTNASInA+VGPA0y+oxWPv8S9EujrGxmVrW+lr1OUM2S+aMrx1vqQtWcN8jMSa
         4uWersyg4Q5Wv8QYU/TsG64C9rmAbnJELuJuvtTmbEEoYV4CA0poI27t3z3sGhq25Prx
         lBEm1U76A2iLAMJHVN9nwp5ighfad2pbPSb+vgIiggKKiBcD75JsuUnOd4jX5hlrgdDq
         p2rdTgHJw2qvD2MIfgxY9gtz0syICcrBXm+Wo5C3kPDTnX+AMOOGD/LoyuFhaZR07DLP
         Qmt2HdIJwrvWItS83I4MgY6Hio5p3p2C2wGR15aN/3k5IiDbCQzpPy7JUCxO989UUJ3n
         jDrA==
X-Forwarded-Encrypted: i=1; AJvYcCX4lLjJfU6asRLuZwHhUSwD5q8ytgYgIDfmcsbHn2iytjiJzt9ynllm3bRVCn+1sBlQwhX8P+Q=@lists.linux.dev
X-Gm-Message-State: AOJu0Yygw4oRbwckF0yBTIgcJuC02iA21UdM29yUdgDYqb3a/TGqsk7l
	RmMAm0LUHEn0Pqk6opmacWSP5iorNXDutyYwCE9S0PDvckZTl7lXZ5ImtuNbIUv0WjQHJVu1aH3
	09kG8t5t8q1CNAWAuqa/V+TFVHGQ=
X-Gm-Gg: ASbGncuZrok2SHOYQKRBDo4TywAKSRC0CAjBgkT+P+6YJJAISkaIqP7/P54bpKBL9cp
	iN9Lbb8Dow7fs8fsRLP8TEpy+YPD0D7SpeDQq
X-Google-Smtp-Source: AGHT+IE8ZeqfL/AgiOHI7JzByaRH/gCmdKgPWO5Hj9zc39/ATmbh/1nt9GKO3Q2GNRNSP3Oe53/t8se7t847Ok8yve4=
X-Received: by 2002:a05:600c:1ca9:b0:435:136:75f6 with SMTP id
 5b1f17b1804b1-436e2551d7bmr233515785e9.0.1736845397493; Tue, 14 Jan 2025
 01:03:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250113143719.7948-3-shaw.leon@gmail.com> <20250114044935.26418-1-kuniyu@amazon.com>
In-Reply-To: <20250114044935.26418-1-kuniyu@amazon.com>
From: Xiao Liang <shaw.leon@gmail.com>
Date: Tue, 14 Jan 2025 17:02:40 +0800
X-Gm-Features: AbW1kvbnYf6XKcEPFQ7StR4SBvDI6u3mnWVP_-_JSDczC5xWtD3eG1aBQEYey8A
Message-ID: <CABAhCOQy-qw8pY+8XjHGPVz7jWZ7wqnadPXZrF-enAO0AEgXyQ@mail.gmail.com>
Subject: Re: [PATCH net-next v8 06/11] net: ipv6: Use link netns in newlink()
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

On Tue, Jan 14, 2025 at 12:49=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.c=
om> wrote:
>
> From: Xiao Liang <shaw.leon@gmail.com>
> Date: Mon, 13 Jan 2025 22:37:14 +0800
> > diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/b=
ond_netlink.c
> > index 2a6a424806aa..ac5e402c34bc 100644
> > --- a/drivers/net/bonding/bond_netlink.c
> > +++ b/drivers/net/bonding/bond_netlink.c
> > @@ -564,10 +564,12 @@ static int bond_changelink(struct net_device *bon=
d_dev, struct nlattr *tb[],
> >       return 0;
> >  }
> >
> > -static int bond_newlink(struct net *src_net, struct net_device *bond_d=
ev,
> > -                     struct nlattr *tb[], struct nlattr *data[],
> > +static int bond_newlink(struct net_device *bond_dev,
> > +                     struct rtnl_newlink_params *params,
> >                       struct netlink_ext_ack *extack)
> >  {
> > +     struct nlattr **data =3D params->data;
> > +     struct nlattr **tb =3D params->tb;
> >       int err;
> >
> >       err =3D bond_changelink(bond_dev, tb, data, extack);
>
> Note that IFLA_BOND_ACTIVE_SLAVE uses dev_net(dev) for
> __dev_get_by_index().

That's true. Bond devices have no "link-netns", and a slave
device must be in the same namespace of the main dev.

> [...]
> > diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
> > index fed4fe2a4748..0c496aa1f706 100644
> > --- a/drivers/net/macvlan.c
> > +++ b/drivers/net/macvlan.c
> > @@ -1565,11 +1565,12 @@ int macvlan_common_newlink(struct net *src_net,=
 struct net_device *dev,
> >  }
> >  EXPORT_SYMBOL_GPL(macvlan_common_newlink);
> >
> > -static int macvlan_newlink(struct net *src_net, struct net_device *dev=
,
> > -                        struct nlattr *tb[], struct nlattr *data[],
> > +static int macvlan_newlink(struct net_device *dev,
> > +                        struct rtnl_newlink_params *params,
> >                          struct netlink_ext_ack *extack)
> >  {
> > -     return macvlan_common_newlink(src_net, dev, tb, data, extack);
> > +     return macvlan_common_newlink(params->net, dev, params->tb,
> > +                                   params->data, extack);
>
> Pass params as is as you did for ipvlan_link_new().
>
> Same for macvtap_newlink().

OK.

> [...]
> > diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
> > index 1e1b00756be7..1e9eadc77da2 100644
> > --- a/drivers/net/netkit.c
> > +++ b/drivers/net/netkit.c
> > @@ -327,10 +327,13 @@ static int netkit_validate(struct nlattr *tb[], s=
truct nlattr *data[],
> >
> >  static struct rtnl_link_ops netkit_link_ops;
> >
> > -static int netkit_new_link(struct net *peer_net, struct net_device *de=
v,
> > -                        struct nlattr *tb[], struct nlattr *data[],
> > +static int netkit_new_link(struct net_device *dev,
> > +                        struct rtnl_newlink_params *params,
> >                          struct netlink_ext_ack *extack)
> >  {
> > +     struct nlattr **data =3D params->data;
> > +     struct net *peer_net =3D params->net;
> > +     struct nlattr **tb =3D params->tb;
>
> nit: please keep the reverse xmas tree order.
>
>
> >       struct nlattr *peer_tb[IFLA_MAX + 1], **tbp =3D tb, *attr;
>
> you can define *tbp here and initialise it later.
>
>         struct nlattr *peer_tb[IFLA_MAX + 1], **tbp, *attr;
>
> >       enum netkit_action policy_prim =3D NETKIT_PASS;
> >       enum netkit_action policy_peer =3D NETKIT_PASS;
>
>
> [...]
> > @@ -1064,6 +1067,11 @@ static void wwan_create_default_link(struct wwan=
_device *wwandev,
> >       struct net_device *dev;
> >       struct nlmsghdr *nlh;
> >       struct sk_buff *msg;
> > +     struct rtnl_newlink_params params =3D {
> > +             .net =3D &init_net,
> > +             .tb =3D tb,
> > +             .data =3D data,
> > +     };
>
> nit: Reverse xmas tree order
>
>
> [...]
> > diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> > index ec98349b9620..7ff5e96f6ba7 100644
> > --- a/net/core/rtnetlink.c
> > +++ b/net/core/rtnetlink.c
> > @@ -3766,6 +3766,14 @@ static int rtnl_newlink_create(struct sk_buff *s=
kb, struct ifinfomsg *ifm,
> >       struct net_device *dev;
> >       char ifname[IFNAMSIZ];
> >       int err;
> > +     struct rtnl_newlink_params params =3D {
>
> nit: Reverse xmas tree order
>
>
> > +             .net =3D net,
>
> Use sock_net(skb->sk) directly here and remove net defined above,
> which is no longer used in this function.
>
> ---8<---
>         unsigned char name_assign_type =3D NET_NAME_USER;
>         struct rtnl_newlink_params params =3D {
>                 .net =3D sock_net(skb->sk),
>                 .src_net =3D net,
>                 .link_net =3D link_net,
>                 .peer_net =3D peer_net,
>                 .tb =3D tb,
>                 .data =3D data,
>         };
>         u32 portid =3D NETLINK_CB(skb).portid;
> ---8<---
>
>
> [...]
> > @@ -1698,6 +1702,10 @@ struct net_device *gretap_fb_dev_create(struct n=
et *net, const char *name,
> >       LIST_HEAD(list_kill);
> >       struct ip_tunnel *t;
> >       int err;
> > +     struct rtnl_newlink_params params =3D {
> > +             .net =3D net,
> > +             .tb =3D tb,
> > +     };
> >
> >       memset(&tb, 0, sizeof(tb));
>
> nit: Reverse xmas tree

Will fix the style issues mentioned above in the next version.

Thanks.
