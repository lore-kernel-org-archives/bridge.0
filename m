Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2901B21AD
	for <bridge@lists.linux.dev>; Thu, 13 Feb 2025 10:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739440901; cv=none; b=YEJLmg9TA2rik98iwx8sv8a8qvUu4P2Y+DXJN6GjjC9owxga4QWhFAxMUU7XJ8UoD5MIN9EwTzSSvtKeZA8PvV8h0GDFa8xZt1+v+VSED3X5CQmRp2nHvc52a03pBK3u1nypJACL8tO0oPqo0rZZXwrU1nNi7MiOgLpQ6XX7+/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739440901; c=relaxed/simple;
	bh=iBDt2glmR7cHZRLk9T83XH+ffn4f88bkjS2lrtyqh/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JR9UU+8MbQLKO4dtmkRZZrRmPzy5O3dzfAioqxon5feqjXNXsNda4uChAvOo0vSrrzFq86j08XYn94bQEQC3Is/scJoc05/gmETs8Bg2qLOayRABLVtJ7xmB5t+3f8U7hEIPfkuMLFZXrTzd/a46sR97M8oeDQ32ZpR2TQDA7ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MvzI7jfg; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MvzI7jfg"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-38dd935a267so503812f8f.1
        for <bridge@lists.linux.dev>; Thu, 13 Feb 2025 02:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739440897; x=1740045697; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QzLT98ZLU5P2fWKiTUzwgsTrlPg66ER6fTAj9aLF8fM=;
        b=MvzI7jfg5q+AHaJUndMvuVfmmcxg85vyPDZ2GGTSitPLtR1IFe048fWXGOiQKzhK6E
         VuDsjK0FKlo1ijF3QtJf6dbhfxu1o1mFoXrTEosj2fv0e2vck1TzS0MIXhnRCMedZB4m
         8Qos5dcDumb5sHPHgYfsylssGe5o42JRiFuXZx6G1bsv7mvNG5U35Yli8V4W5yPV8qve
         LV2H+UBixhynbrxYlGttftByxd/iJB0z6rD7aF0sJxTTsxjEfDq//puABSNtUNnKIyUW
         Gryt3EQwfDyw+x/buf7hAzgS8ygrpZK7cWi/+ABrkm4mtTliVbHTiQiidE6SdmwMp2bn
         fH2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739440897; x=1740045697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QzLT98ZLU5P2fWKiTUzwgsTrlPg66ER6fTAj9aLF8fM=;
        b=mxToA8GIlGkIgLaZDkLgU4cbK3XIFp5ZguEPEQFAcUM/M5wdioQnw9eaN1xbGuPPVe
         x+lCjbEVZX5t3FiZ0kSY8GHGMHQtOgl1PYiwrC0D5B9Mv9o1rqjVk9RcxP92ITZ5BiYl
         8EmElZ4pi+ad6v7NNwzGmY8pmmFEgF5mrNBDCBEN19Cs2nf+CKcDzStypnYJyNi8yz/C
         w9ofKs8Bswm55DYELEkgdzl2+ibP7TesG48owXiAVMcF9gbXH1/lOEWYNUaSSchS0wRK
         YmV9jgpHAyyj6mXFd6lUjA+XsE4Hpk+hbyxReltox1f5fRJdvLAgmxquW4wYa5kFVI7b
         7TlA==
X-Forwarded-Encrypted: i=1; AJvYcCXCNFuDebRh1sO0CzUITfUzKR8gy0UyOxBQOoeo1899VGh6JB0mNCWMY1ezxIdYDKNq0fHKO4E=@lists.linux.dev
X-Gm-Message-State: AOJu0YzfRW9pG6J7ZdN0l/0iykymKYonMehQArT8LamsgKHm6kvxERaj
	WWpoji7KP0aehLSggzqnJjUWGCq6TEQ2M3uuWA+jHnMLBu/00VOETqIVyvleEChxgiUxRuZHSYZ
	2rx7fGet2aj+wlP4h10X6rwuWoMo=
X-Gm-Gg: ASbGncuLfrJ4HLExbO7Izidj4tqRdz3IaOj2WZl3/udOjtcGwU1fFf5w5zzvV4NbIDZ
	xn0MwkZTn+qQBbncG2GNJ5+4kSaxfTgcKKcMAh/OBB32tuXnwVOyhuGTGyRZIaafvkbUWpjU=
X-Google-Smtp-Source: AGHT+IGNZlywLnJxQSbfEuVU5lxBk1mvVT9ugQLIpGpywWHBNNSM0YY4phrOkk812RGul4zBJlRkLm/hRcXNfYkCEHg=
X-Received: by 2002:a5d:64e2:0:b0:38f:21eb:5d02 with SMTP id
 ffacd0b85a97d-38f21eb5f2dmr4477949f8f.22.1739440897336; Thu, 13 Feb 2025
 02:01:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250210133002.883422-3-shaw.leon@gmail.com> <20250213065348.8507-1-kuniyu@amazon.com>
 <CABAhCOTw+CpiwwRGNtDS3gntTQe7XESNzzi6RXd9ju1xO_a5Hw@mail.gmail.com> <2c294c0a-26c4-4ec5-992d-a2fd98829b16@redhat.com>
In-Reply-To: <2c294c0a-26c4-4ec5-992d-a2fd98829b16@redhat.com>
From: Xiao Liang <shaw.leon@gmail.com>
Date: Thu, 13 Feb 2025 18:01:00 +0800
X-Gm-Features: AWEUYZkc6f7IS5VLx0dDxpZ4gB9UzsINfw32PuUeMd1tOC9C9cBZAvSRCBGNkQM
Message-ID: <CABAhCOQLHgiwkydm9vQAkVYZRyrCCu=E9Nh=wwkWFXox0x5uvQ@mail.gmail.com>
Subject: Re: [PATCH net-next v9 02/11] rtnetlink: Pack newlink() params into struct
To: Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, alex.aring@gmail.com, andrew+netdev@lunn.ch, 
	b.a.t.m.a.n@lists.open-mesh.org, bpf@vger.kernel.org, bridge@lists.linux.dev, 
	davem@davemloft.net, donald.hunter@gmail.com, dsahern@kernel.org, 
	edumazet@google.com, herbert@gondor.apana.org.au, horms@kernel.org, 
	kuba@kernel.org, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-ppp@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-wpan@vger.kernel.org, miquel.raynal@bootlin.com, netdev@vger.kernel.org, 
	osmocom-net-gprs@lists.osmocom.org, shuah@kernel.org, 
	stefan@datenfreihafen.org, steffen.klassert@secunet.com, 
	wireguard@lists.zx2c4.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 5:17=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 2/13/25 9:36 AM, Xiao Liang wrote:
> > On Thu, Feb 13, 2025 at 2:54=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazo=
n.com> wrote:
> > [...]
> >>> diff --git a/include/linux/if_macvlan.h b/include/linux/if_macvlan.h
> >>> index 523025106a64..0f7281e3e448 100644
> >>> --- a/include/linux/if_macvlan.h
> >>> +++ b/include/linux/if_macvlan.h
> >>> @@ -59,8 +59,10 @@ static inline void macvlan_count_rx(const struct m=
acvlan_dev *vlan,
> >>>
> >>>  extern void macvlan_common_setup(struct net_device *dev);
> >>>
> >>> -extern int macvlan_common_newlink(struct net *src_net, struct net_de=
vice *dev,
> >>> -                               struct nlattr *tb[], struct nlattr *d=
ata[],
> >>> +struct rtnl_newlink_params;
> >>
> >> You can just include <net/rtnetlink.h> and remove it from .c
> >> files, then this forward declaration will be unnecessary.
> >
> > OK. Was not sure if it's desirable to include include/net files from
> > include/linux.
>
> I think we are better of with the forward declaration instead of adding
> more intra header dependencies, which will slow down the build and will
> produces artifacts in the CI runs (increases of reported warning in the
> incremental build, as any warns from the included header will be
> 'propagated' to more files).
>
> >>> +extern int macvlan_common_newlink(struct net_device *dev,
> >>> +                               struct rtnl_newlink_params *params,
> >>>                                 struct netlink_ext_ack *extack);
> >>>
> >>>  extern void macvlan_dellink(struct net_device *dev, struct list_head=
 *head);
> >>
> >>
> >> [...]
> >>> diff --git a/include/net/rtnetlink.h b/include/net/rtnetlink.h
> >>> index bc0069a8b6ea..00c086ca0c11 100644
> >>> --- a/include/net/rtnetlink.h
> >>> +++ b/include/net/rtnetlink.h
> >>> @@ -69,6 +69,42 @@ static inline int rtnl_msg_family(const struct nlm=
sghdr *nlh)
> >>>               return AF_UNSPEC;
> >>>  }
> >>>
> >>> +/**
> >>> + *   struct rtnl_newlink_params - parameters of rtnl_link_ops::newli=
nk()
> >>
> >> The '\t' after '*' should be single '\s'.
> >>
> >> Same for lines below.
> >
> > This is copied from other structs in the same file. Should I change it?
>
> https://elixir.bootlin.com/linux/v6.13.2/source/Documentation/process/mai=
ntainer-netdev.rst#L376
>
> In this series, just use the good formatting for the new code.

Got it. Thanks.

>
> Thanks,
>
> Paolo
>
