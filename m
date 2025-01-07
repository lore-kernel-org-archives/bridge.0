Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4231EB9F9
	for <bridge@lists.linux.dev>; Tue,  7 Jan 2025 10:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736246841; cv=none; b=pyRWEDK2wiFIh3IVu5N7rYE14MO8mUGuW52OS0sKt4FIIyUPh32rftlzmW3rckwoNp7YNeyne1xUqWMRF4fD/8mc+PaevvXSwvjcwyLAjfKQTtz6gp9bN9LSppg+MfUYQyLJxgjMVlRwjsRPpyVkuFx10CxA1VRoe+eUYTSjIDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736246841; c=relaxed/simple;
	bh=rmV+IrFXiYRmJO8m/Th28rKjbiFt6MRkkO4Sbqpe3Gw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YBU1NpQL9doS3GS0vM+HjT8HIXj/wApJp1jH0NPgjGGM6ZZR7xIpgjwnXt/HteQl+1I/SDSOCK37CBdTj/7PifmX0qYoXnpqMzQX2Ir7MzKOLCozhy7N7ygROngv/hms9hvMXW09Ir9OdSIh4GAAGiTr1ogNokALtwlMsvv7f9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f0jj8hJW; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f0jj8hJW"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43634b570c1so109966565e9.0
        for <bridge@lists.linux.dev>; Tue, 07 Jan 2025 02:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736246836; x=1736851636; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fh0AFKuAKxAUWXpt7kGI1qVooHVbo7SNiy/9flSEnaA=;
        b=f0jj8hJWqUTdyPxq+eRB4XCSXu6rgytp2fF5QiAc1CgvC80kPgqUH1KGzLC2zoO0b4
         NOv05s61TeNEzmhfdt//V8svqTOLz2ZyO7pZ+1xvSLnIQbtYq/8FJ2M0qAcZDogj9PI3
         RCamQTrwJMs3rB8kk45KJ7Kve/VD2fHfFaw24/MQ6Mp3MRUaHncvK7a3FC8OaKVEJ2fq
         mFYoDPYjUImEqoqPBsnHf7+DakZR7DVxyzYjI70/CTWkucGdS7gAxDiRlulwstXUqadX
         X1dU1R7e90SwvgUpOy9O9kA5eCZKrBZZhoKclp0WEWMrTgzlXQzqaxA41wHZynIy7+Ez
         B0jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736246836; x=1736851636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fh0AFKuAKxAUWXpt7kGI1qVooHVbo7SNiy/9flSEnaA=;
        b=lPOtTiohCLECcIJQDLBC99N83fQI4wrfxY7wUqAxzrf3K9LMeR5VLS1Q7AuaN3HKMk
         rFbzcm0uZS7N1aDZZvihPwtDaE5asMKAHX5JtHsw9AuTmT0rOlx+Ic7o1tRUh8GVNyo7
         zQopfEwsp6qmx8kWz9uPs2BXVbtLfIFcf+4tngfNY6/cNpex92mN0UP2nOpgLTvNfHnf
         NwZHVIEP2L+3gTJ4JyC4/Kk8DiD1Gxq/tZwWVJuYucmu/UC80qWSZm/G7EtRvvMzVssF
         EicW49ocUwc9/12EqKNQx4QRGcjG37OUtA2q8wggw88CHYHoKVROi5awXy8Vshxiyyf/
         gGOw==
X-Forwarded-Encrypted: i=1; AJvYcCXALujt6KAwyNi1tFBSbeu3XKAVWRUlv/fybD5tXDynJmEAEd7aM+O/FtMo1PyIK1DSDmXLsAo=@lists.linux.dev
X-Gm-Message-State: AOJu0YzJ16kFsrY9ckgOT28nCbppvFYgzVkmgBklI9gUYtv7KQqoiLY9
	1dVIAe1JZuXdSaxRu6AfBPyhf3yRC1osyPQ2tCI7gnRJR9pdR7cUjrgP72Nznd8i5zKaxcmal8p
	B0ClwLgAuzpDntu2jVD81haxGmNA=
X-Gm-Gg: ASbGncveUDP+atfMqtqE/j32Fw+b03i2ZD/6P6c5O6U2uauENh5x+xYdtGuriF7NHK3
	AfwE6h7x7UHwPpUemVY6BJtm8tEqxPKTjgMh8
X-Google-Smtp-Source: AGHT+IHp1K2L48YKiIQv0pwnQlZPYX8cMCBbRBU/fwg+IEmnnlA8QF5/odQWLMrNcSpCZK0F/LO3cHqTWVNEZ39orXM=
X-Received: by 2002:a05:6000:480a:b0:386:1cd3:89fa with SMTP id
 ffacd0b85a97d-38a221fa8c6mr57843141f8f.33.1736246835555; Tue, 07 Jan 2025
 02:47:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250104125732.17335-1-shaw.leon@gmail.com> <20250107085646.42302-1-kuniyu@amazon.com>
In-Reply-To: <20250107085646.42302-1-kuniyu@amazon.com>
From: Xiao Liang <shaw.leon@gmail.com>
Date: Tue, 7 Jan 2025 18:46:38 +0800
Message-ID: <CABAhCOQAqspiaFO-486UtZpEWsua51f+1f6-LocNhHVfAqW=NQ@mail.gmail.com>
Subject: Re: [PATCH net-next v7 00/11] net: Improve netns handling in rtnetlink
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: andrew+netdev@lunn.ch, b.a.t.m.a.n@lists.open-mesh.org, 
	bpf@vger.kernel.org, bridge@lists.linux.dev, davem@davemloft.net, 
	donald.hunter@gmail.com, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, idosch@nvidia.com, jiri@resnulli.us, kuba@kernel.org, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-ppp@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-wpan@vger.kernel.org, liuhangbin@gmail.com, netdev@vger.kernel.org, 
	osmocom-net-gprs@lists.osmocom.org, pabeni@redhat.com, shuah@kernel.org, 
	wireguard@lists.zx2c4.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 7, 2025 at 4:57=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.com=
> wrote:
>
> From: Xiao Liang <shaw.leon@gmail.com>
> Date: Sat,  4 Jan 2025 20:57:21 +0800
[...]
> > - In amt_newlink() drivers/net/amt.c:
> >
> >     amt->net =3D net;
> >     ...
> >     amt->stream_dev =3D dev_get_by_index(net, ...
> >
> >   Uses net, but amt_lookup_upper_dev() only searches in dev_net.
> >   So the AMT device may not be properly deleted if it's in a different
> >   netns from lower dev.
>
> I think you are right, and the upper device will be leaked
> and UAF will happen.
>
> amt must manage a list linked to a lower dev.
>
> Given no one has reported the issue, another option would be
> drop cross netns support in a short period.

Yes. I also noticed AMT sets dev->netns_local to prevent netns
change. Probably it also assumes the same netns during creation.

[...]
> >
> > - In gtp_newlink() in drivers/net/gtp.c:
> >
> >     gtp->net =3D src_net;
> >     ...
> >     gn =3D net_generic(dev_net(dev), gtp_net_id);
> >     list_add_rcu(&gtp->list, &gn->gtp_dev_list);
> >
> >   Uses src_net, but priv is linked to list in dev_net. So it may not be
> >   properly deleted on removal of link netns.
>
> The device is linked to a list in the same netns, so the
> device will not be leaked.  See gtp_net_exit_batch_rtnl().
>
> Rather, the problem is the udp tunnel socket netns could be
> freed earlier than the dev netns.

Yes, you're right. Actually I mean the netns of the socket by "link netns"
(there's some clarification about this in patch 02).

[...]
> >
> > - In pfcp_newlink() in drivers/net/pfcp.c:
> >
> >     pfcp->net =3D net;
> >     ...
> >     pn =3D net_generic(dev_net(dev), pfcp_net_id);
> >     list_add_rcu(&pfcp->list, &pn->pfcp_dev_list);
> >
> >   Same as above.
>
> I haven't tested pfcp but it seems to have the same problem.
>
> I'll post patches for gtp and pfcp.
>

It would be nice.

>
> >
> > - In lowpan_newlink() in net/ieee802154/6lowpan/core.c:
> >
> >     wdev =3D dev_get_by_index(dev_net(ldev), nla_get_u32(tb[IFLA_LINK])=
);
> >
> >   Looks for IFLA_LINK in dev_net, but in theory the ifindex is defined
> >   in link netns.
>
> I guess you mean the ifindex is defined in src_net instead.
> Not sure if it's too late to change the behaviour.

Yes, it's source net for lowpan. I think it depends on whether
the interpretation of IFLA_LINK should be considered as part API
provided by rtnetlink core, or something customizable by driver.
In the former case, this can be considered as a bug.

Thanks.
