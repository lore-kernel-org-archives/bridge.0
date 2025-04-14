Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA29318FDD8
	for <bridge@lists.linux.dev>; Mon, 14 Apr 2025 12:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744632693; cv=none; b=ndQ5C0AFefD5OAx0YzzJ+KTNIBQhwDIpebsdKEGNXqzedOsasPqiV2eYNQF8d/ms3vYwImW/NjT+QEYUC5w7bcxg/slHeSORNQx+UeLVejpGYcMT8S6DuMTJrQBikJPbRs5SDvB9w5l6W9VPsRAV5ypedj6w4LYGi+1TAB670Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744632693; c=relaxed/simple;
	bh=yjklxsIZi4G/0FrM8nYOnD6uKZbJXa2YOYpp1NX6HXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mqb28Txd8K7olAf/rr5NpyeDVvLLa2GLLd4fYY81hytJ9gPT8B7/Iqo9i9/nB4GqLXR2MxtdyR7blQEFga/ECeQdrlyIOqnpTotsy/PFJ5ozKi/sazUxa+BYPg4GILic+yv4xJoBSTToToVfqqnL8DNKPZNmJXcs5LzxT228rGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LLmvqvLp; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LLmvqvLp"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e6df1419f94so3373407276.0
        for <bridge@lists.linux.dev>; Mon, 14 Apr 2025 05:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744632690; x=1745237490; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q4nw7PbrtgjL7S19J+yVLhjLNTYkyI+7kVEtkH7yzDc=;
        b=LLmvqvLp1roGpXjdsQBvou9IX0F2JzB7k82A0O2IY9xVhdRyBrDmFA0nKN5GPDTOcR
         UWSAzxphaFgftz2KEFMzH5ehoibx6nAIwo854i+zKeTPK/yYRH9Q5lBj9oSlFuPKNocO
         qYQcZj0PKQesRbJi0LY25YBVI1OgtWkyOZi4Jut/Xa6w54IG2+GMq01qeFYiEzfMybDm
         pTui7f6d1AKtFWgGj80zPL2jMSRMoP4ZY1+fA5stFOweag3t3BMUcKZuTemVicJlmUoG
         3LXQ6FOgWc6UNuyR0exCmVpZWN+mcdJn9+63vvuhvPtiM3JmWbpPLRpQGhsyNTJ3ZGkx
         TX7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744632690; x=1745237490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q4nw7PbrtgjL7S19J+yVLhjLNTYkyI+7kVEtkH7yzDc=;
        b=i3ueUZaea30COeHMtd/5aZVpPKyoS/YrnysCWI2HQG62W4bZ2DEGBSP3ZCO+MJSQWd
         W5EFOV7vmm19lUhybazZZKjY9eqxYtsPnmq5KboSc6hrDKbHtaI/RX4BVzAfU3gum5DI
         E24A+u9Lyk+HjARN+S2qNr1qebBT1exi0jW82rnCdER/GSTc0qvUPuFEYvyx3UhRHcbH
         Lr5frkGBPz4wIZrMum907cLb1TtmmR3E5Uf0LUsgfYnxPjMJ2g3og13Dtl16mvpLFve4
         n9/rRfTiC/9vH7MUmOY5mJTwDZS3EUOO6tfrUo1SASokW6WSFov683gGl0KuKXVcaYlN
         PiQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcQBj6SIAsYO7tjo/K8xXn/+AoKh7Fu7YEAyXBm5e6r9e4wSwBst/RZuCwaK0/xPoW0MeGOlQ=@lists.linux.dev
X-Gm-Message-State: AOJu0YxjP8YwqVYJTJCSndGreA4+azHoGeBKyqrhwpqr880HtDevyvdB
	/6jtz0PjwsIYduuwMscfL4XY6wK4mvpgnE7AfFUD9nvYZ/Wvw6isSywPajnHJfQamj1fdDR2Dj1
	rfvxS24udvjG67wbLDiaH+fQiBds=
X-Gm-Gg: ASbGncvzwafsp1Ex1H08VWFm+Pzg1cufsy6mg6dj5JmHrm7sJneFE7EWmhVLfY9Atrx
	onZy0m4EhgFSgJ/zTVwVkNBmM8LgdeWOd+3MvChXkkPh5OlNh5Wa5P5INcNPCRpzOSVP9egg47v
	h4A6AhW6IGtbU1cY+GTc0i
X-Google-Smtp-Source: AGHT+IGyRMgKNo0PrJaG9tIFBBWyclUfl5rSOD+CS6dgifaFt95O2XZhtFABT7IeajvldSLSfs+2pFRydG5JKaDclIs=
X-Received: by 2002:a05:6902:2e0b:b0:e6d:ea22:f32b with SMTP id
 3f1490d57ef6-e704dfa92c2mr20588206276.28.1744632690454; Mon, 14 Apr 2025
 05:11:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250412122428.108029-2-jonas.gorski@gmail.com> <20250414113926.vpy3gvck6etkscmu@skbuf>
In-Reply-To: <20250414113926.vpy3gvck6etkscmu@skbuf>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Mon, 14 Apr 2025 14:11:18 +0200
X-Gm-Features: ATxdqUHCD9GlyKIfgeBXNV_bmQRQFLMswkNjKtvjsnGrbL_Adgi9g8DQ-gPBprU
Message-ID: <CAOiHx=kRUE8_-4q6wOytrZObyyeSBMTHRMhaFGWDAJ-KBq5vFA@mail.gmail.com>
Subject: Re: [PATCH RFC net 1/2] net: bridge: switchdev: do not notify new
 brentries as changed
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew@lunn.ch>, bridge@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2025 at 1:39=E2=80=AFPM Vladimir Oltean <vladimir.oltean@nx=
p.com> wrote:
>
> On Sat, Apr 12, 2025 at 02:24:27PM +0200, Jonas Gorski wrote:
> > When adding a bridge vlan that is pvid or untagged after the vlan has
> > already been added to any other switchdev backed port, the vlan change
> > will be propagated as changed, since the flags change.
> >
> > This causes the vlan to not be added to the hardware for DSA switches,
> > since the DSA handler ignores any vlans for the CPU or DSA ports that
> > are changed.
> >
> > E.g. the following order of operations would work:
> >
> > $ ip link add swbridge type bridge vlan_filtering 1 vlan_default_pvid 1

as mentioned for the cover letter, I will fix the example to use
default_pvid 0 to have a "working" example.

> > $ ip link set lan1 master swbridge
> > $ bridge vlan add dev swbridge vid 1 pvid untagged self
> > $ bridge vlan add dev lan1 vid 1 pvid untagged
> >
> > but this order would brake:
>
> nitpick: s/brake/break/

Thanks, :set spell clearly didn't help here.

> > $ ip link add swbridge type bridge vlan_filtering 1 vlan_default_pvid 1
> > $ ip link set lan1 master swbridge
> > $ bridge vlan add dev lan1 vid 1 pvid untagged
> > $ bridge vlan add dev swbridge vid 1 pvid untagged self
> >
> > Additionally, the vlan on the bridge itself would become undeletable:
> >
> > $ bridge vlan
> > port              vlan-id
> > lan1              1 PVID Egress Untagged
> > swbridge          1 PVID Egress Untagged
> > $ bridge vlan del dev swbridge vid 1 self
> > $ bridge vlan
> > port              vlan-id
> > lan1              1 PVID Egress Untagged
> > swbridge          1 Egress Untagged
> >
> > since the vlan was never added to DSA's vlan list, so deleting it will
> > cause an error, causing the bridge code to not remove it.
> >
> > Fix this by checking if flags changed only for vlans that are already
> > brentry and pass changed as false for those that become brentries, as
> > these are a new vlan (member) from the switchdev point of view.
> >
> > Fixes: 8d23a54f5bee ("net: bridge: switchdev: differentiate new VLANs f=
rom changed ones")
> > Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
> > ---
> >  net/bridge/br_vlan.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
> > index d9a69ec9affe..939a3aa78d5c 100644
> > --- a/net/bridge/br_vlan.c
> > +++ b/net/bridge/br_vlan.c
> > @@ -715,8 +715,8 @@ static int br_vlan_add_existing(struct net_bridge *=
br,
> >                               u16 flags, bool *changed,
> >                               struct netlink_ext_ack *extack)
> >  {
> > -     bool would_change =3D __vlan_flags_would_change(vlan, flags);
> >       bool becomes_brentry =3D false;
> > +     bool would_change =3D false;
> >       int err;
> >
> >       if (!br_vlan_is_brentry(vlan)) {
> > @@ -725,6 +725,8 @@ static int br_vlan_add_existing(struct net_bridge *=
br,
> >                       return -EINVAL;
> >
> >               becomes_brentry =3D true;
> > +     } else {
> > +             would_change =3D __vlan_flags_would_change(vlan, flags);
> >       }
> >
> >       /* Master VLANs that aren't brentries weren't notified before,
> > --
> > 2.43.0
> >
>
> You might want to mention that "bool *changed" is used later in
> br_process_vlan_info() to make a decision whether to call
> br_vlan_notify(RTM_NEWVLAN) or not. We want to notify switchdev with
> changed=3Dfalse, but we want to keep notifying the change to rtnetlink.
>
> The rtnetlink notification still happens even if we don't set
> would_change here, because it depends on this code snippet:
>
>         if (becomes_brentry) {
>                 ...
>                 *changed =3D true;
>                 ...
>         }
>
> and not on this one:
>
>         if (would_change)
>                 *changed =3D true;
>
> That was my only concern with this change (I had missed the first snippet
> when initially reading the code), and I didn't see in the commit log
> some sort of attention paid to this detail.

Will add it. And I did check that, even considered shortly to merge this to

        if (becomes_brentry || would_change)
                *changed =3D true;

but then considered that a refactoring too much.

>
> With that:
>
> Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Thank you!
