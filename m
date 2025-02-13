Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD781EF08E
	for <bridge@lists.linux.dev>; Thu, 13 Feb 2025 08:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739435803; cv=none; b=R2isVppMCU9wlJm0pcDA1cpN9h6t0Vrh1bP28R6ZxasQtIU2yHz5y+qtVUlqnA99tLnmM8fMsL+Nx7Vcq2KbPgIog/T/jQgB9/dV6YbgihPhaQhBl1ftHlxn11FvTKrVBeEJrSFlCyXsOnRu8f4FzajMuXpBlxc00+9vlMR923A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739435803; c=relaxed/simple;
	bh=tlbb2csC6KUltjhzwmihFO7uJRUrwtFdmIctqTsBzaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dNJSfOMOCBqbxfPV+LpIxA4Zz2PYr2zI7mlia71XLckBdgZ7bJdkNvBB357+UIPFrg1/s3RDOv+X+M8mmWQb0w40rSiRnLlPFiBpdFcsydG4Ir6osGrSEiW5ygv0wll0jQ9GllKvXXqxIhrF8/dnkKBUfr+P3B5UKCjcqsCNSes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iAwd6+xf; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iAwd6+xf"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4394a823036so6475215e9.0
        for <bridge@lists.linux.dev>; Thu, 13 Feb 2025 00:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739435800; x=1740040600; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lEMTU9K2wwIY9JpwBI5RzgY3pZNF2c520syU90CJZKI=;
        b=iAwd6+xf1G6XpxRtdWgUPxALVg8upNY4JSiHMQMhJJnuW1QU+XeP76SjRJwN5xXit5
         ZvmDfGXHJ04HKwbCHyzj7k8n0ufVxWu3fPo1jRdrpzbxijr/VXjYKh74bftXMoHyEz3t
         Tq4rZZPlutbk6QK3CWwILYzD0xJN2edMN5fUrkm8/iWzVfe5E/WsRA8uYlv6uR94/6c7
         EUwNs1BXN868qc4LHgob0uKEUkY0+0AS6ZVBTLcL6xXTV+1rMU3DNAMRRjzAlPWUPjpK
         g+XdyoyUJpWP2ZWOpEv8RXKpC0onVp3WdLmzKvOF8KZQRVdY2SUks/C/engTXvxSA+0d
         cQsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739435800; x=1740040600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lEMTU9K2wwIY9JpwBI5RzgY3pZNF2c520syU90CJZKI=;
        b=F1mWKsIwiB9++dg6VLQggW3ZgkqUppF8RVCS9+Uv4XSLpHY/6VC7xx3hIjMzaq9a7t
         a/vjF7cASFhkJlA1ar98FE13OOBC9m/kcs7SXxoBBGnws7wrPewkTpJE2JTVKCqrI6d4
         j5tkG1+uY6yNFWizM6ovNNI1hEM28219RUkBbrw+hccoKQfINJGJ1FBPaOaIcjvJI/BH
         tNJmce4wfTAF3Ar5I5Wymyy8Im1/1UJGLVzPlIhj3A5NgaxSQ7jFfomdX/ENC9YcfJUJ
         Gpk1Lfb3QUBBSdl5jDLeAxjJRriVLXhCtjZ7Vv7AuBOz2UMJmenRyn6e3PiV4oYUkoEG
         AV8w==
X-Forwarded-Encrypted: i=1; AJvYcCWjeY/EsqzZxcOtaOpiMTMbAuOE/FOiTqBa4L9m3ojPECGqXUEcXrZ/q7MHwpPk+yMhGcKixwU=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz+JdeKgYHseEmFHEpUapRfXFiQB9HEXOWefDT8AZMd60nj/5Ab
	wFHqk1Hfdt2BZayj/CjFkU3IhCyEA5o65dW/r5u+uaUcuLciol9BNzjc9mTCha3hltK4bKyPHlO
	biLXJWCgrPuuNqw213jRaRMjbNtY=
X-Gm-Gg: ASbGncvROVMxVzK+A9k8197fzq5uER1Rofr6VQNE+vMmh6QXeLqxdT6iimK9Xk7DgGW
	4KknfRfkJSVW2EJxDIINAZewGaCfne7rpLSUeiRwZ2OPxA+52EMhGQ+Ua12uSUU7GZMccyG8=
X-Google-Smtp-Source: AGHT+IEezeJ/RlI8/fvqsCpwdXF55uEWmtOYc3P4zBx3ojP1z2I7SGCdQ1/EUaOR3dd1EY2OITuGZF4nnmEaOHg8QZ0=
X-Received: by 2002:a05:600c:19c8:b0:439:55fc:81a9 with SMTP id
 5b1f17b1804b1-4395816f13dmr68016965e9.7.1739435800139; Thu, 13 Feb 2025
 00:36:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250210133002.883422-3-shaw.leon@gmail.com> <20250213065348.8507-1-kuniyu@amazon.com>
In-Reply-To: <20250213065348.8507-1-kuniyu@amazon.com>
From: Xiao Liang <shaw.leon@gmail.com>
Date: Thu, 13 Feb 2025 16:36:02 +0800
X-Gm-Features: AWEUYZncbGUNO7oNcYsuGlVcwlKbEKWZpPvVt5uCQTeloMATtiMLOZ95K2VoEX4
Message-ID: <CABAhCOTw+CpiwwRGNtDS3gntTQe7XESNzzi6RXd9ju1xO_a5Hw@mail.gmail.com>
Subject: Re: [PATCH net-next v9 02/11] rtnetlink: Pack newlink() params into struct
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

On Thu, Feb 13, 2025 at 2:54=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
[...]
> > diff --git a/include/linux/if_macvlan.h b/include/linux/if_macvlan.h
> > index 523025106a64..0f7281e3e448 100644
> > --- a/include/linux/if_macvlan.h
> > +++ b/include/linux/if_macvlan.h
> > @@ -59,8 +59,10 @@ static inline void macvlan_count_rx(const struct mac=
vlan_dev *vlan,
> >
> >  extern void macvlan_common_setup(struct net_device *dev);
> >
> > -extern int macvlan_common_newlink(struct net *src_net, struct net_devi=
ce *dev,
> > -                               struct nlattr *tb[], struct nlattr *dat=
a[],
> > +struct rtnl_newlink_params;
>
> You can just include <net/rtnetlink.h> and remove it from .c
> files, then this forward declaration will be unnecessary.

OK. Was not sure if it's desirable to include include/net files from
include/linux.

>
>
> > +
> > +extern int macvlan_common_newlink(struct net_device *dev,
> > +                               struct rtnl_newlink_params *params,
> >                                 struct netlink_ext_ack *extack);
> >
> >  extern void macvlan_dellink(struct net_device *dev, struct list_head *=
head);
>
>
> [...]
> > diff --git a/include/net/rtnetlink.h b/include/net/rtnetlink.h
> > index bc0069a8b6ea..00c086ca0c11 100644
> > --- a/include/net/rtnetlink.h
> > +++ b/include/net/rtnetlink.h
> > @@ -69,6 +69,42 @@ static inline int rtnl_msg_family(const struct nlmsg=
hdr *nlh)
> >               return AF_UNSPEC;
> >  }
> >
> > +/**
> > + *   struct rtnl_newlink_params - parameters of rtnl_link_ops::newlink=
()
>
> The '\t' after '*' should be single '\s'.
>
> Same for lines below.
>

This is copied from other structs in the same file. Should I change it?

>
> > + *
> > + *   @net: Netns of interest
> > + *   @src_net: Source netns of rtnetlink socket
> > + *   @link_net: Link netns by IFLA_LINK_NETNSID, NULL if not specified
> > + *   @peer_net: Peer netns
> > + *   @tb: IFLA_* attributes
> > + *   @data: IFLA_INFO_DATA attributes
> > + */
> > +struct rtnl_newlink_params {
>
> [...]
> > +/* Get effective link netns from newlink params. Generally, this is li=
nk_net
> > + * and falls back to src_net. But for compatibility, a driver may * ch=
oose to
> > + * use dev_net(dev) instead.
> > + */
> > +static inline struct net *rtnl_newlink_link_net(struct rtnl_newlink_pa=
rams *p)
> > +{
> > +     return p->link_net ? : p->src_net;
> > +}
> > +
> > +/* Get peer netns from newlink params. Fallback to link netns if peer =
netns is
> > + * not specified explicitly.
> > + */
> > +static inline struct net *rtnl_newlink_peer_net(struct rtnl_newlink_pa=
rams *p)
> > +{
> > +     return p->peer_net ? : rtnl_newlink_link_net(p);
> > +}
>
> These helpers should belong to patch 2 ?

I was trying to split API and driver changes. Can move this to
next patch if it's better.
